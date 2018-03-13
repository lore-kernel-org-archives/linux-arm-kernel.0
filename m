From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 13 Mar 2018 10:36:03 +0100
Subject: [PATCH 3/3] drm/meson: Fix some error handling paths in
 'meson_drv_bind_master()'
In-Reply-To: <df47e03d36c2cf7bc37ec3105fc47c16555bd946.1520885192.git.christophe.jaillet@wanadoo.fr>
References: <cover.1520885192.git.christophe.jaillet@wanadoo.fr>
 <df47e03d36c2cf7bc37ec3105fc47c16555bd946.1520885192.git.christophe.jaillet@wanadoo.fr>
Message-ID: <ed8b162c-ac19-bdbb-4da9-e891a4855d2d@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2018 21:15, Christophe JAILLET wrote:
> If one of these functions fail, we whould free 'drm', as alreadry done in
> the other error handling paths, below and above.
> 
> Fixes: bbbe775ec5b5 ("drm: Add support for Amlogic Meson Graphic Controller")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 6ee3dd7fa450..3baceb744beb 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -189,35 +189,43 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "vpu");
>  	regs = devm_ioremap_resource(dev, res);
> -	if (IS_ERR(regs))
> -		return PTR_ERR(regs);
> +	if (IS_ERR(regs)) {
> +		ret = PTR_ERR(regs);
> +		goto free_drm;
> +	}
>  
>  	priv->io_base = regs;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
>  	/* Simply ioremap since it may be a shared register zone */
>  	regs = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!regs)
> -		return -EADDRNOTAVAIL;
> +	if (!regs) {
> +		ret = -EADDRNOTAVAIL;
> +		goto free_drm;
> +	}
>  
>  	priv->hhi = devm_regmap_init_mmio(dev, regs,
>  					  &meson_regmap_config);
>  	if (IS_ERR(priv->hhi)) {
>  		dev_err(&pdev->dev, "Couldn't create the HHI regmap\n");
> -		return PTR_ERR(priv->hhi);
> +		ret = PTR_ERR(priv->hhi);
> +		goto free_drm;
>  	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
>  	/* Simply ioremap since it may be a shared register zone */
>  	regs = devm_ioremap(dev, res->start, resource_size(res));
> -	if (!regs)
> -		return -EADDRNOTAVAIL;
> +	if (!regs) {
> +		ret = -EADDRNOTAVAIL;
> +		goto free_drm;
> +	}
>  
>  	priv->dmc = devm_regmap_init_mmio(dev, regs,
>  					  &meson_regmap_config);
>  	if (IS_ERR(priv->dmc)) {
>  		dev_err(&pdev->dev, "Couldn't create the DMC regmap\n");
> -		return PTR_ERR(priv->dmc);
> +		ret = PTR_ERR(priv->dmc);
> +		goto free_drm;
>  	}
>  
>  	priv->vsync_irq = platform_get_irq(pdev, 0);
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

Thanks,
Neil
