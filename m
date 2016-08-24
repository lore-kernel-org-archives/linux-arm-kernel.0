From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 24 Aug 2016 07:55:56 +0200
Subject: [PATCH v2 3/4] gpu: drm: exynos_hdmi: Use consolidated function on
 binding DDC DT property
In-Reply-To: <1472005524-3489-4-git-send-email-woogyom.kim@gmail.com>
References: <1472005524-3489-1-git-send-email-woogyom.kim@gmail.com>
 <1472005524-3489-4-git-send-email-woogyom.kim@gmail.com>
Message-ID: <a6d2e6cc-d491-fdd4-8c76-5425ec42ba80@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/24/2016 04:25 AM, Milo Kim wrote:
> Handle legacy and raw 'ddc' parsing in single function.
> And it also removes goto condition.
>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: Seung-Woo Kim <sw0312.kim@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: dri-devel at lists.freedesktop.org
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  drivers/gpu/drm/exynos/exynos_hdmi.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> index 2275efe..6a636f2 100644
> --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> @@ -1760,7 +1760,7 @@ static const struct component_ops hdmi_component_ops = {
>  	.unbind = hdmi_unbind,
>  };
>  
> -static struct device_node *hdmi_legacy_ddc_dt_binding(struct device *dev)
> +static struct device_node *hdmi_ddc_dt_binding(struct device *dev)
>  {
>  	const char *compatible_str = "samsung,exynos4210-hdmiddc";
>  	struct device_node *np;
> @@ -1769,7 +1769,13 @@ static struct device_node *hdmi_legacy_ddc_dt_binding(struct device *dev)
>  	if (np)
>  		return of_get_next_parent(np);
>  
> -	return NULL;
> +	np = of_parse_phandle(dev->of_node, "ddc", 0);
> +	if (!np)
> +		return NULL;
> +
> +	of_node_put(dev->of_node);
This is mistake introduced  by other patch, of_node_put should be called on
np, after calling of_find_i2c_adapter_by_node. You can fix it in your
patch as well.
I think you can move of_find_i2c_adapter_by_node also to this function and
rename it to sth like hdmi_get_ddc_adapter, this way you will enclose
whole logic
of getting resource into one function.

Regards
Andrzej

> +
> +	return np;
>  }
>  
>  static struct device_node *hdmi_legacy_phy_dt_binding(struct device *dev)
> @@ -1811,18 +1817,12 @@ static int hdmi_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	ddc_node = hdmi_legacy_ddc_dt_binding(dev);
> -	if (ddc_node)
> -		goto out_get_ddc_adpt;
> -
> -	ddc_node = of_parse_phandle(dev->of_node, "ddc", 0);
> +	ddc_node = hdmi_ddc_dt_binding(dev);
>  	if (!ddc_node) {
>  		DRM_ERROR("Failed to find ddc node in device tree\n");
>  		return -ENODEV;
>  	}
> -	of_node_put(dev->of_node);
>  
> -out_get_ddc_adpt:
>  	hdata->ddc_adpt = of_find_i2c_adapter_by_node(ddc_node);
>  	if (!hdata->ddc_adpt) {
>  		DRM_ERROR("Failed to get ddc i2c adapter by node\n");
