From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 21:46:59 +0200
Subject: [PATCH] drm/sun4i: tcon: Add dithering support for RGB565/RGB666
 LCD panels
In-Reply-To: <20171017110946.18961-1-net147@gmail.com>
References: <20171017110946.18961-1-net147@gmail.com>
Message-ID: <20171017194659.5jaqjtgzemm76m6l@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 17, 2017 at 10:09:46PM +1100, Jonathan Liu wrote:
> Dithering is supported on TCON channel 0 which is used for LCD panels.

Expanding a bit the commit log would be great. What is dithering, why
is this needed in the first place, what is it trying to fix, etc.

> Signed-off-by: Jonathan Liu <net147@gmail.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 37 +++++++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun4i_tcon.h | 18 +++++++++++++++++-
>  2 files changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index 68751b999877..cf313ca858b3 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -12,11 +12,13 @@
>  
>  #include <drm/drmP.h>
>  #include <drm/drm_atomic_helper.h>
> +#include <drm/drm_connector.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
>  #include <drm/drm_encoder.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_of.h>
> +#include <drm/drm_panel.h>
>  
>  #include <uapi/drm/drm_mode.h>
>  
> @@ -168,7 +170,9 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
>  			  struct drm_display_mode *mode)
>  {
>  	unsigned int bp, hsync, vsync;
> +	u32 bus_format = 0;
>  	u8 clk_delay;
> +	struct drm_connector *connector = tcon->panel->connector;

You shouldn't access the connector directly, but instead use the
current state associated to the encoder.

>  	u32 val = 0;
>  
>  	/* Configure the dot clock */
> @@ -230,6 +234,39 @@ void sun4i_tcon0_mode_set(struct sun4i_tcon *tcon,
>  			   SUN4I_TCON0_IO_POL_HSYNC_POSITIVE | SUN4I_TCON0_IO_POL_VSYNC_POSITIVE,
>  			   val);
>  
> +	if (connector->display_info.num_bus_formats)
> +		bus_format = connector->display_info.bus_formats[0];
> +
> +	switch (bus_format) {
> +	case MEDIA_BUS_FMT_RGB565_1X16:
> +	case MEDIA_BUS_FMT_RGB666_1X18:

I guess that has more to do with the bit width than the actual media
bus.

I've created helper for both these two in my LVDS patch set, you might
want to rebase on top of it.

> +		/* Enable dithering */
> +		/* FIXME: Undocumented bits */
> +		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED0_REG, 0x11111111);
> +		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED1_REG, 0x11111111);
> +		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED2_REG, 0x11111111);
> +		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED3_REG, 0x11111111);
> +		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED4_REG, 0x11111111);
> +		regmap_write(tcon->regs, SUN4I_TCON0_FRM_SEED5_REG, 0x11111111);
> +		regmap_write(tcon->regs, SUN4I_TCON0_FRM_TAB0_REG, 0x01010000);
> +		regmap_write(tcon->regs, SUN4I_TCON0_FRM_TAB1_REG, 0x15151111);
> +		regmap_write(tcon->regs, SUN4I_TCON0_FRM_TAB2_REG, 0x57575555);
> +		regmap_write(tcon->regs, SUN4I_TCON0_FRM_TAB3_REG, 0x7f7f7777);
> +		val = SUN4I_TCON0_FRM_CTL_ENABLE;
> +
> +		if (bus_format == MEDIA_BUS_FMT_RGB565_1X16) {
> +			val |= SUN4I_TCON0_FRM_CTL_MODE_R;
> +			val |= SUN4I_TCON0_FRM_CTL_MODE_B;
> +		}

This can be moved to the first case in your switch, and just let it
fall through. You won't have to do a comparison twice then.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171017/3171b52a/attachment.sig>
