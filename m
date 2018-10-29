From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 10:22:27 +0100
Subject: [PATCH v3 12/25] drm/sun4i: sun6i_mipi_dsi: Add DSI hblk packet
 overhead
In-Reply-To: <20181026144344.27778-13-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-13-jagan@amarulasolutions.com>
Message-ID: <20181029092227.mdxgvg5aqzh22j72@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:13:31PM +0530, Jagan Teki wrote:
> Add 10 bytes packet overhead for hblk where blank is set using
> a blanking packet like (4 bytes + 4 bytes + payload + 2 bytes)
> 
> This is according to BSP code from BPI-M64-bsp
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> dsi_hblk = (ht-hspw)*dsi_pixel_bits[format]/8-(4+4+2);
> 
> So, add 10 bytes packet overhead for DSI hblk.
> 
> Tested on 2-lane, 4-lane MIPI-DSI LCD panels.
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v3:
> - new patch
> Changes for v2:
> - none
> 
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 596e560263bf..cf42be1f1ba1 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -461,7 +461,7 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>  {
>  	struct mipi_dsi_device *device = dsi->device;
>  	unsigned int Bpp = mipi_dsi_pixel_format_to_bpp(device->format) / 8;
> -	u16 hbp, hfp, hsa, hblk, vblk;
> +	u16 hbp, hfp, hsa, hblk_max, hblk, vblk;
>  	size_t bytes;
>  	u8 *buffer;
>  
> @@ -494,8 +494,13 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>  
>  	/*
>  	 * hblk seems to be the line + porches length.
> +	 * The blank is set using a blanking packet (4 bytes + 4 bytes +
> +	 * payload + 2 bytes). So minimal size is 10 bytes
>  	 */
> -	hblk = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
> +#define HBLK_PACKET_OVERHEAD	10
> +	hblk_max = (mode->htotal - (mode->hsync_end - mode->hsync_start)) * Bpp;
> +	hblk_max -= HBLK_PACKET_OVERHEAD;
> +	hblk = max((unsigned int)HBLK_PACKET_OVERHEAD, hblk_max);

I'd rather use the same convention than the other assignments done
before in that function.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/987f4c1a/attachment-0001.sig>
