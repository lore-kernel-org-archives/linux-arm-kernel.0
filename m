From: zyw@rock-chips.com (Chris Zhong)
Date: Sun, 22 Jan 2017 11:08:53 +0800
Subject: [PATCH v2 26/26] drm/rockchip: dw-mipi-dsi: support read commands
In-Reply-To: <20170121163128.22240-27-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
 <20170121163128.22240-27-john@metanate.com>
Message-ID: <58842245.6000103@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John

On 01/22/2017 12:31 AM, John Keeping wrote:
> I haven't found any method for getting the length of a response, so this
> just uses the requested rx_len
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> Unchanged in v2
> ---
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 54 ++++++++++++++++++++++++++++++++++
>   1 file changed, 54 insertions(+)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index f780401e8b5e..f0cb005c6d76 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -675,6 +675,54 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
>   	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, hdr_val);
>   }
>   
> +static int dw_mipi_dsi_dcs_read(struct dw_mipi_dsi *dsi,
> +				const struct mipi_dsi_msg *msg)
> +{
> +	const u8 *tx_buf = msg->tx_buf;
> +	u8 *rx_buf = msg->rx_buf;
> +	size_t i;
> +	int ret, val;
> +
> +	dsi_write(dsi, DSI_PCKHDL_CFG, EN_CRC_RX | EN_ECC_RX | EN_BTA);
> +	dsi_write(dsi, DSI_GEN_HDR, GEN_HDATA(tx_buf[0]) | GEN_HTYPE(msg->type));

WARNING: line over 80 characters

> +
> +	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
> +				 val, !(val & GEN_RD_CMD_BUSY), 1000,
> +				 CMD_PKT_STATUS_TIMEOUT_US);
> +	if (ret < 0) {
> +		dev_err(dsi->dev, "failed to read command response\n");
> +		return ret;
> +	}
> +
> +	for (i = 0; i < msg->rx_len;) {
> +		u32 pld = dsi_read(dsi, DSI_GEN_PLD_DATA);
> +		while (i < msg->rx_len) {
> +			rx_buf[i] = pld & 0xff;
> +			pld >>= 8;
> +			i++;
> +		}
> +	}
> +
> +	return msg->rx_len;
> +}
> +
> +static int dw_mipi_dsi_set_max_return_packet_size(struct dw_mipi_dsi *dsi,
> +						  size_t len)
> +{
> +	u8 val[] = { len & 0xff, (len >> 8) & 0xff };
> +	struct mipi_dsi_msg msg = {
> +		.channel = dsi->channel,
> +		.type = MIPI_DSI_SET_MAXIMUM_RETURN_PACKET_SIZE,
> +		.tx_buf = val,
> +		.tx_len = 2,
> +	};
> +
> +	if (len > 0xffff)
> +		return -EINVAL;
> +
> +	return dw_mipi_dsi_dcs_short_write(dsi, &msg);
> +}
> +
>   static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>   					 const struct mipi_dsi_msg *msg)
>   {
> @@ -692,6 +740,12 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>   	case MIPI_DSI_DCS_LONG_WRITE:
>   		ret = dw_mipi_dsi_dcs_long_write(dsi, msg);
>   		break;
> +	case MIPI_DSI_DCS_READ:
> +		ret = dw_mipi_dsi_set_max_return_packet_size(dsi, msg->rx_len);
> +		if (ret < 0)
> +			return ret;
> +		ret = dw_mipi_dsi_dcs_read(dsi, msg);
> +		break;
>   	default:
>   		dev_err(dsi->dev, "unsupported message type 0x%02x\n",
>   			msg->type);
