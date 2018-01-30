From: architt@codeaurora.org (Archit Taneja)
Date: Tue, 30 Jan 2018 19:39:26 +0530
Subject: [PATCH v2 2/2] drm/bridge/synopsys: dsi: Fix dsi_host_transfer()
 return value
In-Reply-To: <20180126004628.fbrady7twf7ys2qx@ban.mtv.corp.google.com>
References: <20180125103800.1999-1-philippe.cornu@st.com>
 <20180125103800.1999-3-philippe.cornu@st.com>
 <20180126004628.fbrady7twf7ys2qx@ban.mtv.corp.google.com>
Message-ID: <70cae8dd-ee9e-0313-6518-504ee5ec32ca@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01/26/2018 06:16 AM, Brian Norris wrote:
> On Thu, Jan 25, 2018 at 11:38:00AM +0100, Philippe Cornu wrote:
>> The dw_mipi_dsi_host_transfer() must return the number of
>> bytes transmitted/received on success instead of 0.
>> Note: As the read feature is not implemented, only the
>> transmitted number of bytes is returned for the moment.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> Assuming we're going with the current documented semantics (where we
> return # of TX bytes for writes), then:
> 
> Reviewed-by: Brian Norris <briannorris@chromium.org>
> 
> I believe Archit was suggesting maybe changing that sometime, but that's
> no excuse for not matching documentation now.

Queued to drm-misc-next.

Thanks,
Archit

> 
>> ---
>>   drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> index 72ecaeb40822..090bf62d1ea8 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>> @@ -419,7 +419,16 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>>   
>>   	dw_mipi_message_config(dsi, msg);
>>   
>> -	return dw_mipi_dsi_write(dsi, &packet);
>> +	ret = dw_mipi_dsi_write(dsi, &packet);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * TODO Only transmitted size is returned as actual driver does
>> +	 * not support dcs/generic reads. Please update return value when
>> +	 * delivering the read feature.
>> +	 */
>> +	return packet.size;
> 
> You're really holding my hand here, I see :) Thanks I guess.
> 
>>   }
>>   
>>   static const struct mipi_dsi_host_ops dw_mipi_dsi_host_ops = {
>> -- 
>> 2.15.1
>>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
