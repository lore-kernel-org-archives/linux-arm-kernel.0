From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 26 Sep 2017 11:56:03 +0200
Subject: [PATCH v2 03/13] drm/sun4i: tcon: Add support for demuxing TCON
 output on A31
In-Reply-To: <20170926065919.24446-4-wens@csie.org>
References: <20170926065919.24446-1-wens@csie.org>
 <20170926065919.24446-4-wens@csie.org>
Message-ID: <20170926095603.c67y4rytydya7kjd@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Sep 26, 2017 at 06:59:09AM +0000, Chen-Yu Tsai wrote:
> On systems with 2 TCONs such as the A31, it is possible to demux the
> output of the TCONs to one encoder.
> 
> Add support for this for the A31.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 61 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index e853dfe51389..770b843a6fa9 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -14,9 +14,12 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_encoder.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_of.h>
>  
> +#include <uapi/drm/drm_mode.h>
> +
>  #include <linux/component.h>
>  #include <linux/ioport.h>
>  #include <linux/of_address.h>
> @@ -109,11 +112,69 @@ void sun4i_tcon_enable_vblank(struct sun4i_tcon *tcon, bool enable)
>  }
>  EXPORT_SYMBOL(sun4i_tcon_enable_vblank);
>  
> +static struct sun4i_tcon *sun4i_get_first_tcon(struct drm_device *drm)
> +{
> +	struct sun4i_drv *drv = drm->dev_private;
> +	struct sun4i_tcon *tcon;
> +
> +	list_for_each_entry(tcon, &drv->tcon_list, list)
> +		if (tcon->id == 0)
> +			return tcon;
> +
> +	dev_warn(drm->dev,
> +		 "TCON0 not found, display output muxing may not work\n");
> +
> +	return tcon;
> +}
> +
> +static int _sun6i_tcon_set_mux(struct drm_encoder *encoder)
> +{
> +	struct sun4i_tcon *tcon = sun4i_get_first_tcon(encoder->dev);
> +	int tcon_id = drm_crtc_to_sun4i_crtc(encoder->crtc)->tcon->id;
> +	u32 shift;
> +
> +	DRM_DEBUG_DRIVER("Muxing encoder %s to CRTC %s (TCON %d)\n",
> +			 encoder->name, encoder->crtc->name, tcon_id);
> +
> +	/* Only 2 TCONs */
> +	if (tcon_id >= 2)
> +		return -EINVAL;
> +
> +	switch (encoder->encoder_type) {
> +	case DRM_MODE_ENCODER_TMDS:
> +		/* HDMI */
> +		shift = 8;
> +		break;
> +	case DRM_MODE_ENCODER_DSI:
> +		/* No MIPI DSI on A31s */
> +		if (of_device_is_compatible(tcon->dev->of_node,
> +					    "allwinner,sun6i-a31s-tcon"))

I'm not sure that test is needed.

We won't end up in that case if we don't have a connected DSI block,
which isn't going to be the case on the A31. And I guess we can tackle
DSI later (when I'll send my patches...).

> +			return -EINVAL;
> +		shift = 0;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	regmap_update_bits(tcon->regs, SUN4I_TCON_MUX_CTRL_REG,
> +			   0x3 << shift, tcon_id << shift);
> +
> +	return 0;
> +}
> +
>  void sun4i_tcon_set_mux(struct sun4i_tcon *tcon, int channel,
>  			struct drm_encoder *encoder)
>  {
> +	/* Get the device node of the display engine */
> +	struct device_node *node = encoder->dev->dev->of_node;
>  	u32 val;
>  
> +	if (of_device_is_compatible(node, "allwinner,sun6i-a31-display-engine") ||
> +	    of_device_is_compatible(node, "allwinner,sun6i-a31s-display-engine")) {
> +		_sun6i_tcon_set_mux(encoder);
> +		return;
> +	}
> +

I'd really like to avoid mix and matching the structure defined
behaviour and those of_device_is_compatible calls spread out
everywhere.

You can either add a flag or a function pointer.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170926/690f1229/attachment.sig>
