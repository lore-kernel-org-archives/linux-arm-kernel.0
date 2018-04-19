From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 19 Apr 2018 15:31:54 +0200
Subject: [PATCH 3/6] drm/sun4i: tcon: Add dithering support for
 RGB565/RGB666 LCD panels
In-Reply-To: <20180419093225.614-4-wens@csie.org>
References: <20180419093225.614-1-wens@csie.org>
 <20180419093225.614-4-wens@csie.org>
Message-ID: <20180419133154.2w2obz2su4pfmk25@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 19, 2018 at 05:32:22PM +0800, Chen-Yu Tsai wrote:
> From: Jonathan Liu <net147@gmail.com>
> 
> The hardware supports dithering on TCON channel 0 which is used for LCD
> panels.
> 
> Dithering is a method of approximating a color from a mixture of other
> colors when the required color isn't available. It reduces color
> banding artifacts that can be observed when displaying gradients
> (e.g. grayscale gradients). This may occur when the image that needs
> to be displayed is 24-bit but the LCD panel is a lower bit depth and
> does not perform dithering on its own.
> 
> Signed-off-by: Jonathan Liu <net147@gmail.com>
> [wens at csie.org: check display_info.bpc first; handle LVDS and MIPI DSI]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> 
> Hi Maxime,
> 
> The dithering parameters used here are different from the ones you used
> in your MIPI DSI series. You might want to check if it still works for
> you.
> 
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 63 +++++++++++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 2bd53ef7d4b8..827518f4790e 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -12,6 +12,7 @@
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_connector.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_encoder.h>
> @@ -276,8 +277,59 @@ static void sun4i_tcon0_mode_set_common(struct sun4i_tcon *tcon,
>  		     SUN4I_TCON0_BASIC0_Y(mode->crtc_vdisplay));
>  }
>  
> +static void sun4i_tcon0_mode_set_dithering(struct sun4i_tcon *tcon,
> +					   const struct drm_connector *connector)
> +{
> +	u32 bus_format = 0;
> +	u32 val = 0;
> +
> +	/* XXX Would this ever happen? */
> +	if (!connector)
> +		return;
> +
> +	/*
> +	 * FIXME: Undocumented bits
> +	 *
> +	 * The whole dithering process and these parameters are not
> +	 * explained in the vendor documents or BSP kernel code.
> +	 */
> +	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_PR_REG, 0x11111111);
> +	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_PG_REG, 0x11111111);
> +	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_PB_REG, 0x11111111);
> +	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_LR_REG, 0x11111111);
> +	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_LG_REG, 0x11111111);
> +	regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED_LB_REG, 0x11111111);
> +	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL0_REG, 0x01010000);
> +	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL1_REG, 0x15151111);
> +	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL2_REG, 0x57575555);
> +	regmap_write(tcon->regs, SUN4I_TCON0_FRM_TBL3_REG, 0x7f7f7777);
> +
> +	/* Do dithering if panel only supports 6 bits per color */
> +	if (connector->display_info.bpc == 6)
> +		val |= SUN4I_TCON0_FRM_CTL_EN;
> +
> +	if (connector->display_info.num_bus_formats == 1)
> +		bus_format = connector->display_info.bus_formats[0];
> +
> +	/* Check the connection format */
> +	switch (bus_format) {
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +		/* R and B components are only 5 bits deep */
> +		val |= SUN4I_TCON0_FRM_CTL_MODE_R;
> +		val |= SUN4I_TCON0_FRM_CTL_MODE_B;
> +	case MEDIA_BUS_FMT_RGB666_1X18:
> +	case MEDIA_BUS_FMT_RGB666_1X7X3_SPWG:
> +		/* Fall through: enable dithering */
> +		val |= SUN4I_TCON0_FRM_CTL_EN;
> +		break;
> +	}
> +
> +	/* Write dithering settings */
> +	regmap_write(tcon->regs, SUN4I_TCON_FRM_CTL_REG, val);
> +}
> +
>  static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
> -				     struct drm_encoder *encoder,
> +				     const struct drm_encoder *encoder,

The whole serie looks good, but that should probbaly be part of the
first patch?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180419/4f651160/attachment-0001.sig>
