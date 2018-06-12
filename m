From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 12 Jun 2018 16:34:49 +0200
Subject: [PATCH] drm/meson: Fix an un-handled error path in
 'meson_drv_bind_master()'
In-Reply-To: <20180611165335.24542-1-christophe.jaillet@wanadoo.fr>
References: <20180611165335.24542-1-christophe.jaillet@wanadoo.fr>
Message-ID: <b25b05d0-b192-1cf8-0c25-38b8bdb53b92@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/06/2018 18:53, Christophe JAILLET wrote:
> If 'platform_get_resource_byname()' fails, we should release some resources
> before leaving, as already done in the other error handling path of the
> function.
> 
> Fixes: acaa3f13b8dd ("drm/meson: Fix potential NULL dereference in meson_drv_bind_master()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/gpu/drm/meson/meson_drv.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/meson/meson_drv.c b/drivers/gpu/drm/meson/meson_drv.c
> index 32b1a6cdecfc..d3443125e661 100644
> --- a/drivers/gpu/drm/meson/meson_drv.c
> +++ b/drivers/gpu/drm/meson/meson_drv.c
> @@ -197,8 +197,10 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	priv->io_base = regs;
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hhi");
> -	if (!res)
> -		return -EINVAL;
> +	if (!res) {
> +		ret = -EINVAL;
> +		goto free_drm;
> +	}
>  	/* Simply ioremap since it may be a shared register zone */
>  	regs = devm_ioremap(dev, res->start, resource_size(res));
>  	if (!regs) {
> @@ -215,8 +217,10 @@ static int meson_drv_bind_master(struct device *dev, bool has_components)
>  	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dmc");
> -	if (!res)
> -		return -EINVAL;
> +	if (!res) {
> +		ret = -EINVAL;
> +		goto free_drm;
> +	}
>  	/* Simply ioremap since it may be a shared register zone */
>  	regs = devm_ioremap(dev, res->start, resource_size(res));
>  	if (!regs) {
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

I'll push it when rc1 is tagged.

Neil
