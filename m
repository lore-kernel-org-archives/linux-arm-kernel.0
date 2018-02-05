From: philippe.cornu@st.com (Philippe CORNU)
Date: Mon, 5 Feb 2018 12:52:19 +0000
Subject: [PATCH] drm/bridge/synopsys: dsi: Add read feature
In-Reply-To: <81cb1f26-96f0-bdc6-28bc-4a7bda5a9459@samsung.com>
References: <CGME20180204213219epcas2p429434ba0c87a0544dc5294facd80529b@epcas2p4.samsung.com>
 <20180204213104.17834-1-philippe.cornu@st.com>
 <81cb1f26-96f0-bdc6-28bc-4a7bda5a9459@samsung.com>
Message-ID: <1fce104e-7cab-86a1-db49-5306e04d10b7@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,

And many thanks
Philippe :-)

On 02/05/2018 11:07 AM, Andrzej Hajda wrote:
> On 04.02.2018 22:31, Philippe Cornu wrote:
>> This patch adds the DCS/GENERIC DSI read feature.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> 
> If there will be no objections I will merge it at the end of the week.
> 
>  ?--
> Regards
> Andrzej
> 
>> ---
>> Extra notes:
>> DSI read tests have been performed with DCS & GENERIC, short & long
>> commands, on two different panels.
>> The maximum fifo size (32*32-bit = 128 bytes on stm32) has been
>> verified too.
>>
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 58 +++++++++++++++++++++------
>>   1 file changed, 45 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index e9422d05e897..65aeb3f78b48 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -397,18 +397,46 @@ static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
>>   	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, le32_to_cpu(word));
>>   }
>>   
>> +static int dw_mipi_dsi_read(struct dw_mipi_dsi *dsi,
>> +			    const struct mipi_dsi_msg *msg)
>> +{
>> +	int i, j, ret, len = msg->rx_len;
>> +	u8 *buf = msg->rx_buf;
>> +	u32 val;
>> +
>> +	/* Wait end of the read operation */
>> +	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>> +				 val, !(val & GEN_RD_CMD_BUSY),
>> +				 1000, CMD_PKT_STATUS_TIMEOUT_US);
>> +	if (ret) {
>> +		dev_err(dsi->dev, "Timeout during read operation\n");
>> +		return ret;
>> +	}
>> +
>> +	for (i = 0; i < len; i += 4) {
>> +		/* Read fifo must not be empty before all bytes are read */
>> +		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>> +					 val, !(val & GEN_PLD_R_EMPTY),
>> +					 1000, CMD_PKT_STATUS_TIMEOUT_US);
>> +		if (ret) {
>> +			dev_err(dsi->dev, "Read payload FIFO is empty\n");
>> +			return ret;
>> +		}
>> +
>> +		val = dsi_read(dsi, DSI_GEN_PLD_DATA);
>> +		for (j = 0; j < 4 && j + i < len; j++)
>> +			buf[i + j] = val >> (8 * j);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>   static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>   					 const struct mipi_dsi_msg *msg)
>>   {
>>   	struct dw_mipi_dsi *dsi = host_to_dsi(host);
>>   	struct mipi_dsi_packet packet;
>> -	int ret;
>> -
>> -	if (msg->rx_buf || msg->rx_len) {
>> -		/* TODO dw drv improvements: implement read feature */
>> -		dev_warn(dsi->dev, "read operations not yet implemented\n");
>> -		return -EINVAL;
>> -	}
>> +	int ret, nb_bytes;
>>   
>>   	ret = mipi_dsi_create_packet(&packet, msg);
>>   	if (ret) {
>> @@ -422,12 +450,16 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>   	if (ret)
>>   		return ret;
>>   
>> -	/*
>> -	 * TODO Only transmitted size is returned as actual driver does
>> -	 * not support dcs/generic reads. Please update return value when
>> -	 * delivering the read feature.
>> -	 */
>> -	return packet.size;
>> +	if (msg->rx_buf && msg->rx_len) {
>> +		ret = dw_mipi_dsi_read(dsi, msg);
>> +		if (ret)
>> +			return ret;
>> +		nb_bytes = msg->rx_len;
>> +	} else {
>> +		nb_bytes = packet.size;
>> +	}
>> +
>> +	return nb_bytes;
>>   }
>>   
>>   static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
> 
> 
