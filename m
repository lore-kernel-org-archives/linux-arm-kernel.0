From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 15 May 2017 11:20:01 +0200
Subject: [PATCH v7 05/13] drm/sun4i: abstract a engine type
In-Reply-To: <20170514163045.40366-6-icenowy@aosc.io>
References: <20170514163045.40366-1-icenowy@aosc.io>
 <20170514163045.40366-6-icenowy@aosc.io>
Message-ID: <20170515092001.ik7qrqmg5pgtp2ct@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 12:30:37AM +0800, Icenowy Zheng wrote:
> As we are going to add support for the Allwinner DE2 engine in sun4i-drm
> driver, we will finally have two types of display engines -- the DE1
> backend and the DE2 mixer. They both do some display blending and feed
> graphics data to TCON, and is part of the "Display Engine" called by
> Allwinner, so I choose to call them both "engine" here.
> 
> Abstract the engine type to a new struct with an ops struct, which contains
> functions that should be called outside the engine-specified code (in
> TCON, CRTC or TV Encoder code).
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Changes in v7:
> - Mention "Display Engine" for the name "engine".
> - Fixed some small issues found by Chen-Yu and added his ACK.
> Changes in v6:
> - Rebased on wens's multi-pipeline patchset.
> - Split out Makefile changes.

You also added a get_id callback here...

> +static const struct sunxi_engine_ops sun4i_backend_engine_ops = {
> +	.commit				= sun4i_backend_commit,
> +	.layers_init			= sun4i_layers_init,
> +	.apply_color_correction		= sun4i_backend_apply_color_correction,
> +	.disable_color_correction	= sun4i_backend_disable_color_correction,
> +};
> +

... that you don't populate ...

> @@ -477,7 +481,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>  	dev_set_drvdata(dev, tcon);
>  	tcon->drm = drm;
>  	tcon->dev = dev;
> -	tcon->id = backend->id;
> +	tcon->id = sunxi_engine_get_id(engine);

... that you call to fill the TCON ID ...

> +/**
> + * sunxi_engine_get_id - Get the ID of the engine.
> + * @engine:	pointer to the engine
> + *
> + * If the ID is not necessary, just do not implement it in sunxi_engine_ops,
> + * and a default -1 will be returned.
> + */
> +static inline int
> +sunxi_engine_get_id(struct sunxi_engine *engine)
> +{
> +	if (engine->ops && engine->ops->get_id)
> +		return engine->ops->get_id(engine);
> +
> +	return -1;

... and will return -1 if not populated, which essentially means that
instead of having 0 or 1, we're now having -1 as our id.

This is a regression, and I'm even wondering if we can't just store
the ID in the sunxi_engine structure. Is anything preventing us to do
that, instead of using a callback?

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170515/07f62b36/attachment.sig>
