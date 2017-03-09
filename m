From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 9 Mar 2017 11:36:36 +0100
Subject: [PATCH 09/11] drm/sun4i: Support two display pipelines
In-Reply-To: <20170309100534.14023-10-wens@csie.org>
References: <20170309100534.14023-1-wens@csie.org>
 <20170309100534.14023-10-wens@csie.org>
Message-ID: <20170309103636.j5jtjhwjztzchr6u@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 09, 2017 at 06:05:32PM +0800, Chen-Yu Tsai wrote:
> Some Allwinner SoCs have two display pipelines (frontend -> backend ->
> tcon).
> 
> Previously we only supported one pipeline. This patch extends the
> current driver to support two. It extends the tcon and backend pointers
> in sun4i_drv into arrays, and makes the related bind functions store
> the pointer into said arrays based on the id fetched from the device
> tree. In the case of the tcons, it falls back to a first come order
> if no encoders that can be used for differentiating the tcons are
> defined. The driver's depth-first traversal of the of graph, coupled
> with the increasing address ordering of the of graph endpoints, and
> the fact that tcon0 should always be enabled for the tcon/encoder
> mux to be accessible, means that tcon1 would always come after tcon0.
> 
> Assignment of the device structure into sun4i_drv is moved to the end
> of the bind function, when all possible error checks have passed.
> 
> This patch also drops a trailing 0 in one of the backend probe messages.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/gpu/drm/sun4i/sun4i_backend.c |  9 +++++++--
>  drivers/gpu/drm/sun4i/sun4i_drv.c     |  2 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.h     |  6 ++++--
>  drivers/gpu/drm/sun4i/sun4i_tcon.c    | 25 +++++++++++++++++--------
>  4 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
> index f3c92d54c8e4..8d22efd5a9cc 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_backend.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
> @@ -350,12 +350,15 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
>  	if (!backend)
>  		return -ENOMEM;
>  	dev_set_drvdata(dev, backend);
> -	drv->backend = backend;
>  
>  	backend->id = sun4i_backend_of_get_id(dev->of_node);
>  	if (backend->id < 0)
>  		return backend->id;
>  
> +	/* We only support SUN4I_DRM_MAX_PIPELINES number of backends */
> +	if (backend->id >= SUN4I_DRM_MAX_PIPELINES)
> +		return -EINVAL;
> +
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	regs = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(regs))
> @@ -364,7 +367,7 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
>  	backend->regs = devm_regmap_init_mmio(dev, regs,
>  					      &sun4i_backend_regmap_config);
>  	if (IS_ERR(backend->regs)) {
> -		dev_err(dev, "Couldn't create the backend0 regmap\n");
> +		dev_err(dev, "Couldn't create the backend regmap\n");
>  		return PTR_ERR(backend->regs);
>  	}
>  
> @@ -413,6 +416,8 @@ static int sun4i_backend_bind(struct device *dev, struct device *master,
>  		}
>  	}
>  
> +	drv->backend[backend->id] = backend;
> +
>  	/* Reset the registers */
>  	for (i = 0x800; i < 0x1000; i += 4)
>  		regmap_write(backend->regs, i, 0);
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index 767bbadcc85d..c15ecb8343d7 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -271,7 +271,7 @@ static int sun4i_drv_probe(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	int i, count = 0;
>  
> -	for (i = 0;; i++) {
> +	for (i = 0; i < SUN4I_DRM_MAX_PIPELINES; i++) {
>  		struct device_node *pipeline = of_parse_phandle(np,
>  								"allwinner,pipelines",
>  								i);
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.h b/drivers/gpu/drm/sun4i/sun4i_drv.h
> index 5df50126ff52..ec1c08af47e1 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.h
> @@ -16,9 +16,11 @@
>  #include <linux/clk.h>
>  #include <linux/regmap.h>
>  
> +#define SUN4I_DRM_MAX_PIPELINES		2
> +
>  struct sun4i_drv {
> -	struct sun4i_backend	*backend;
> -	struct sun4i_tcon	*tcon;
> +	struct sun4i_backend	*backend[SUN4I_DRM_MAX_PIPELINES];
> +	struct sun4i_tcon	*tcon[SUN4I_DRM_MAX_PIPELINES];
>  
>  	struct drm_fbdev_cma	*fbdev;
>  };
> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> index b774c9a50c55..7749c3133f38 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> @@ -532,7 +532,6 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>  	if (!tcon)
>  		return -ENOMEM;
>  	dev_set_drvdata(dev, tcon);
> -	drv->tcon = tcon;
>  	tcon->drm = drm;
>  	tcon->dev = dev;
>  	tcon->quirks = of_device_get_match_data(dev);
> @@ -540,14 +539,22 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>  	/* This can fail if the DT does not have any downstream encoders. */
>  	tcon->id = sun4i_tcon_of_get_id(dev->of_node);
>  	if (tcon->id < 0) {
> -		/*
> -		 * TODO We currently support only 1 TCON, so we can
> -		 * safely set this to 0. This should be revisited
> -		 * when we add support for multiple pipelines.
> -		 */
> -		tcon->id = 0;
> +		int i;
> +
> +		/* find the first empty tcon in sun4i_drv */
> +		for (i = 0; i < SUN4I_DRM_MAX_PIPELINES; i++)
> +			if (!drv->tcon[i])
> +				tcon->id = i;
> +
> +		/* bail out if that failed */
> +		if (tcon->id < 0)
> +			return tcon->id;
>  	}
>  
> +	/* We only support SUN4I_DRM_MAX_PIPELINES number of tcons */
> +	if (tcon->id >= SUN4I_DRM_MAX_PIPELINES)
> +		return -EINVAL;
> +
>  	tcon->lcd_rst = devm_reset_control_get(dev, "lcd");
>  	if (IS_ERR(tcon->lcd_rst)) {
>  		dev_err(dev, "Couldn't get our reset line\n");
> @@ -588,7 +595,7 @@ static int sun4i_tcon_bind(struct device *dev, struct device *master,
>  		goto err_free_dotclock;
>  	}
>  
> -	tcon->crtc = sun4i_crtc_init(drm, drv->backend, tcon);
> +	tcon->crtc = sun4i_crtc_init(drm, drv->backend[tcon->id], tcon);

I'm not a big fan of those IDs. The heuristic seems to be a bit
fragile since we really never enforced any order in our bindings.

You seem to use it for two things:
 - to match a TCON to its backend in our code
 - to not step on each others' toes when registering the backends/tcons

I think the second could be easily addressed using a linked list, and
the first one by storing the of_node. Then we just need to follow the
OF graph to our input of_node, and then iterate through our registered
backend list to find the one with the same of_node.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170309/0a357d29/attachment.sig>
