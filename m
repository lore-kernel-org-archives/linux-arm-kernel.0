From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 3 Apr 2017 10:24:49 +0200
Subject: [PATCH v3 05/11] drm/sun4i: abstract a mixer type
In-Reply-To: <20170329194613.55548-6-icenowy@aosc.io>
References: <20170329194613.55548-1-icenowy@aosc.io>
 <20170329194613.55548-6-icenowy@aosc.io>
Message-ID: <20170403082449.kyf5dq35nkupd2r7@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

That's much better thanks, but I have a bunch of (minor) comments.

On Thu, Mar 30, 2017 at 03:46:07AM +0800, Icenowy Zheng wrote:
> diff --git a/drivers/gpu/drm/sun4i/sun4i_crtc.c b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> index 33854ee7f636..938dfe7188ff 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_crtc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_crtc.c
> @@ -25,11 +25,10 @@
>  
>  #include <video/videomode.h>
>  
> -#include "sun4i_backend.h"
>  #include "sun4i_crtc.h"
>  #include "sun4i_drv.h"
> -#include "sun4i_layer.h"
>  #include "sunxi_layer.h"
> +#include "sunxi_mixer.h"
>  #include "sun4i_tcon.h"
>  
>  static void sun4i_crtc_atomic_begin(struct drm_crtc *crtc,
> @@ -57,7 +56,7 @@ static void sun4i_crtc_atomic_flush(struct drm_crtc *crtc,
>  
>  	DRM_DEBUG_DRIVER("Committing plane changes\n");
>  
> -	sun4i_backend_commit(scrtc->backend);
> +	scrtc->mixer_ops->commit(scrtc->mixer);

The caller would also have to care about whether that pointer is NULL
or not. This is not really a big deal in the commit case that I expect
to always be filled, but it might be for the color correction.

How about defining some inline functions that would check the
mixer_ops pointer and return if it's NULL?

>  	if (event) {
>  		crtc->state->event = NULL;
> @@ -135,8 +134,8 @@ static const struct drm_crtc_funcs sun4i_crtc_funcs = {
>  	.disable_vblank		= sun4i_crtc_disable_vblank,
>  };
>  
> -struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
> -				   struct sun4i_backend *backend,
> +struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm, void *mixer,
> +				   const struct sunxi_mixer_ops *mixer_ops,
>  				   struct sun4i_tcon *tcon)
>  {
>  	struct sun4i_crtc *scrtc;
> @@ -146,11 +145,12 @@ struct sun4i_crtc *sun4i_crtc_init(struct drm_device *drm,
>  	scrtc = devm_kzalloc(drm->dev, sizeof(*scrtc), GFP_KERNEL);
>  	if (!scrtc)
>  		return ERR_PTR(-ENOMEM);
> -	scrtc->backend = backend;
> +	scrtc->mixer = mixer;
> +	scrtc->mixer_ops = mixer_ops;
>  	scrtc->tcon = tcon;
>  
>  	/* Create our layers */
> -	scrtc->layers = (void **)sun4i_layers_init(drm, scrtc);
> +	scrtc->layers = mixer_ops->layers_init(drm, scrtc);

I don't really see why we need the mixer and ops in the CRTC, we
already have it in sun4i_drv, don't we? Can't we just use that
instead?

That would allow just like in the previous patch to loosen the
relationship between the CRTC and what's before it, which will make
our life easier down the road.

> diff --git a/drivers/gpu/drm/sun4i/sunxi_mixer.h b/drivers/gpu/drm/sun4i/sunxi_mixer.h
> new file mode 100644
> index 000000000000..11bdd20269ef
> --- /dev/null
> +++ b/drivers/gpu/drm/sun4i/sunxi_mixer.h
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright (C) 2017 Icenowy Zheng <icenowy@aosc.xyz>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + */
> +
> +#ifndef _SUNXI_MIXER_H_
> +#define _SUNXI_MIXER_H_
> +
> +struct sun4i_crtc;
> +
> +struct sunxi_mixer_ops {
> +	void **(*layers_init)(struct drm_device *drm, struct sun4i_crtc *crtc);
> +	void (*apply_color_correction)(void *mixer);
> +	void (*disable_color_correction)(void *mixer);
> +	void (*commit)(void *mixer);
> +};
> +
> +#endif /* _SUNXI_MIXER_H_ */

I don't really like the "mixer" name here, and backend doesn't seem
appropriate either.

What about "engine"? It sounds more like it covers both cases.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170403/dfb6220d/attachment-0001.sig>
