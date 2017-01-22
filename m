From: zyw@rock-chips.com (Chris Zhong)
Date: Sun, 22 Jan 2017 14:42:30 +0800
Subject: [PATCH v2 07/26] drm/rockchip: dw-mipi-dsi: avoid out-of-bounds
 read on tx_buf
In-Reply-To: <20170121163128.22240-8-john@metanate.com>
References: <20170121163128.22240-1-john@metanate.com>
 <20170121163128.22240-8-john@metanate.com>
Message-ID: <58845456.2040501@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John

Reviewed-by: Chris Zhong <zyw@rock-chips.com>

On 01/22/2017 12:31 AM, John Keeping wrote:
> As a side-effect of this, encode the endianness explicitly rather than
> casting a u16.
>
> Signed-off-by: John Keeping <john@metanate.com>
> ---
> Unchanged in v2
> ---
>   drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index 4be1ff3a42bb..2e6ad4591ebf 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -572,8 +572,13 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>   static int dw_mipi_dsi_dcs_short_write(struct dw_mipi_dsi *dsi,
>   				       const struct mipi_dsi_msg *msg)
>   {
> -	const u16 *tx_buf = msg->tx_buf;
> -	u32 val = GEN_HDATA(*tx_buf) | GEN_HTYPE(msg->type);
> +	const u8 *tx_buf = msg->tx_buf;
> +	u32 val = GEN_HTYPE(msg->type);
> +
> +	if (msg->tx_len > 0)
> +		val |= GEN_HDATA(tx_buf[0]);
> +	if (msg->tx_len > 1)
> +		val |= GEN_HDATA(tx_buf[1] << 8);
>   
>   	if (msg->tx_len > 2) {
>   		dev_err(dsi->dev, "too long tx buf length %zu for short write\n",
