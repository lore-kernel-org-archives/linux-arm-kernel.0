From: seanpaul@chromium.org (Sean Paul)
Date: Mon, 30 Jan 2017 10:26:11 -0500
Subject: [PATCH v3 24/24] drm/rockchip: dw-mipi-dsi: support read commands
In-Reply-To: <20170129132444.25251-25-john@metanate.com>
References: <20170129132444.25251-1-john@metanate.com>
 <20170129132444.25251-25-john@metanate.com>
Message-ID: <20170130152611.GA20076@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 29, 2017 at 01:24:44PM +0000, John Keeping wrote:
> I haven't found any method for getting the length of a response, so this
> just uses the requested rx_len
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> v3:
> - Fix checkpatch warnings
> Unchanged in v2
> 
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 56 ++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index cf3ca6b0cbdb..cc58ada75425 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -678,6 +678,56 @@ static int dw_mipi_dsi_dcs_long_write(struct dw_mipi_dsi *dsi,
>  	return dw_mipi_dsi_gen_pkt_hdr_write(dsi, hdr_val);
>  }
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
> +	dsi_write(dsi, DSI_GEN_HDR,
> +		  GEN_HDATA(tx_buf[0]) | GEN_HTYPE(msg->type));
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
> +
> +		while (i < msg->rx_len) {
> +			rx_buf[i] = pld & 0xff;
> +			pld >>= 8;
> +			i++;
> +		}
> +	}

AFAICT, the outer for loop just initializes i and ensures msg->rx_len is
non-zero? 

I think the following would be easier to read (and safe against the case where
msg->rx_len > sizeof(pld) (even though this shouldn't happen according to DCS
spec)).

if (msg->rx_len > 0) {
        u32 pld = dsi_read(dsi, DSI_GEN_PLD_DATA);
        memcpy(rx_buf, &pld, MIN(msg->rx_len, sizeof(pld));
}


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
>  static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>  					 const struct mipi_dsi_msg *msg)
>  {
> @@ -695,6 +745,12 @@ static ssize_t dw_mipi_dsi_host_transfer(struct mipi_dsi_host *host,
>  	case MIPI_DSI_DCS_LONG_WRITE:
>  		ret = dw_mipi_dsi_dcs_long_write(dsi, msg);
>  		break;
> +	case MIPI_DSI_DCS_READ:
> +		ret = dw_mipi_dsi_set_max_return_packet_size(dsi, msg->rx_len);
> +		if (ret < 0)
> +			return ret;
> +		ret = dw_mipi_dsi_dcs_read(dsi, msg);
> +		break;
>  	default:
>  		dev_err(dsi->dev, "unsupported message type 0x%02x\n",
>  			msg->type);
> -- 
> 2.11.0.197.gb556de5.dirty
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Sean Paul, Software Engineer, Google / Chromium OS
