From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 29 Oct 2018 10:30:05 +0100
Subject: [PATCH v3 15/25] drm/sun4i: sun6i_mipi_dsi: Set proper vblk
 timing calculation
In-Reply-To: <20181026144344.27778-16-jagan@amarulasolutions.com>
References: <20181026144344.27778-1-jagan@amarulasolutions.com>
 <20181026144344.27778-16-jagan@amarulasolutions.com>
Message-ID: <20181029093005.6kg7pc5z63gi6lzb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2018 at 08:13:34PM +0530, Jagan Teki wrote:
> Unlike hblk, the vblk timings should follow an equation to compute
> the desired value for lane 4 devices and rest of devices it would be 0.
> 
> BSP code from BPI-M64-bsp is computing vblk as for 4-lane devices
> (in drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> tmp = (ht*dsi_pixel_bits[format]/8)*vt-(4+dsi_hblk+2);
> dsi_vblk = (lane-tmp%lane);
> 
> So, update the vblk timing calculation accordingly.
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
>  drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> index 20e330186b7f..42bd7506abaf 100644
> --- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> +++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
> @@ -511,8 +511,19 @@ static void sun6i_dsi_setup_timings(struct sun6i_dsi *dsi,
>  	 * Allwinner BSP is using a rather convoluted calculation
>  	 * there only for 4 lanes. However, using 0 (the !4 lanes
>  	 * case) even with a 4 lanes screen seems to work...

Since you're adding the support for 2 lanes DSI displays, that should
be removed.

> +	 *
> +	 * The vertical blank is set using a blanking packet (4 bytes +
> +	 * payload + 2 bytes). Its minimal size is therefore 6 bytes
>  	 */
> -	vblk = 0;
> +#define VBLK_PACKET_OVERHEAD	6
> +	if (device->lanes == 4) {
> +		int tmp;
> +
> +		tmp = (mode->htotal * Bpp) * mode->vtotal - (hblk + VBLK_PACKET_OVERHEAD);
> +		vblk =(device->lanes - tmp % device->lanes);

This generates a checkpatch warning. You should run all your patches
through checkpatch before sending them.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181029/55198e07/attachment.sig>
