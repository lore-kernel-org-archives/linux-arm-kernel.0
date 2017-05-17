From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Wed, 17 May 2017 22:14:35 +0200
Subject: [linux-sunxi] [RFC PATCH 06/11] drm: sun4i: add color space
 correction support for DE2 mixer
In-Reply-To: <20170517164354.16399-7-icenowy@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170517164354.16399-7-icenowy@aosc.io>
Message-ID: <3168098.MulOhl7Yb4@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne sreda, 17. maj 2017 ob 18:43:49 CEST je Icenowy Zheng napisal(a):
> The DE2 mixer can do color space correction needed by TV Encoder with
> its DCSC sub-engine.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 35
> +++++++++++++++++++++++++++++++++++ drivers/gpu/drm/sun4i/sun8i_mixer.h | 
> 6 +++++-
>  2 files changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> b/drivers/gpu/drm/sun4i/sun8i_mixer.c index d658a3a8159a..65f86641eca3
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> @@ -29,6 +29,14 @@
>  #include "sun8i_layer.h"
>  #include "sunxi_engine.h"
> 
> +static const u32 sun8i_rgb2yuv_coef[12] = {
> +	0x00000107, 0x00000204, 0x00000064, 0x00004200,
> +	0x00001f68, 0x00001ed6, 0x000001c2, 0x00020200,
> +	0x000001c2, 0x00001e87, 0x00001fb7, 0x00020200,
> +};
> +
> +static const u32 sun8i_rgb2yuv_dcsc_alpha = 0x00020200;
> +

There is no need to set/use alpha. BSP code doesn't set it and 0x00020200 
value is default.

Best regards,
Jernej

>  static void sun8i_mixer_commit(struct sunxi_engine *engine)
>  {
>  	DRM_DEBUG_DRIVER("Committing changes\n");
> @@ -37,6 +45,31 @@ static void sun8i_mixer_commit(struct sunxi_engine
> *engine) SUN8I_MIXER_GLOBAL_DBUFF_ENABLE);
>  }
> 
> +static void sun8i_mixer_apply_color_correction(struct sunxi_engine *engine)
> +{
> +	int i;
> +
> +	DRM_DEBUG_DRIVER("Applying RGB to YUV color correction\n");
> +
> +	/* Set color correction */
> +	regmap_write(engine->regs, SUN8I_MIXER_DCSC_EN, 1);
> +
> +	for (i = 0; i < 12; i++)
> +		regmap_write(engine->regs, SUN8I_MIXER_DCSC_COEF_REG(i),
> +			     sun8i_rgb2yuv_coef[i]);
> +
> +	regmap_write(engine->regs, SUN8I_MIXER_DCSC_COEF_ALPHA,
> +		     sun8i_rgb2yuv_dcsc_alpha);
> +}
> +
> +static void sun8i_mixer_disable_color_correction(struct sunxi_engine
> *engine) +{
> +	DRM_DEBUG_DRIVER("Disabling color correction\n");
> +
> +	/* Disable color correction */
> +	regmap_write(engine->regs, SUN8I_MIXER_DCSC_EN, 0);
> +}
> +
>  void sun8i_mixer_layer_enable(struct sun8i_mixer *mixer,
>  				int layer, bool enable)
>  {
> @@ -229,6 +262,8 @@ int sun8i_mixer_update_layer_buffer(struct sun8i_mixer
> *mixer, static const struct sunxi_engine_ops sun8i_engine_ops = {
>  	.commit		= sun8i_mixer_commit,
>  	.layers_init	= sun8i_layers_init,
> +	.apply_color_correction		= sun8i_mixer_apply_color_correction,
> +	.disable_color_correction	= sun8i_mixer_disable_color_correction,
>  };
> 
>  static struct regmap_config sun8i_mixer_regmap_config = {
> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> b/drivers/gpu/drm/sun4i/sun8i_mixer.h index 4785ac090b8c..d7f7513898b6
> 100644
> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.h
> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.h
> @@ -88,6 +88,11 @@
>  #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_FBFMT_RGB888	(8 << 8)
>  #define SUN8I_MIXER_CHAN_UI_LAYER_ATTR_ALPHA_DEF	(0xff << 24)
> 
> +/* The DCSC sub-engine is used to do color space conversation */
> +#define SUN8I_MIXER_DCSC_EN			0xb0000
> +#define SUN8I_MIXER_DCSC_COEF_REG(x)		(0xb0010 + 0x4 * x)
> +#define SUN8I_MIXER_DCSC_COEF_ALPHA		0xb0040
> +
>  /*
>   * These sub-engines are still unknown now, the EN registers are here only
> to * be used to disable these sub-engines.
> @@ -102,7 +107,6 @@
>  #define SUN8I_MIXER_PEAK_EN			0xa6000
>  #define SUN8I_MIXER_ASE_EN			0xa8000
>  #define SUN8I_MIXER_FCC_EN			0xaa000
> -#define SUN8I_MIXER_DCSC_EN			0xb0000
> 
>  struct sun8i_mixer_cfg {
>  	int		vi_num;
> --
> 2.12.2
> 
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group. To unsubscribe from this group and stop receiving
> emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
