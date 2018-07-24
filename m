From: inki.dae@samsung.com (Inki Dae)
Date: Tue, 24 Jul 2018 16:49:11 +0900
Subject: [PATCH v3 1/9] drm/exynos: rename "bridge_node" to
 "mic_bridge_node"
In-Reply-To: <1529396370-18761-2-git-send-email-m.purski@samsung.com>
References: <1529396370-18761-1-git-send-email-m.purski@samsung.com>
 <CGME20180619081957eucas1p2d2b9075a9b7a90837b40e4529ab31888@eucas1p2.samsung.com>
 <1529396370-18761-2-git-send-email-m.purski@samsung.com>
Message-ID: <20180724074912epcas1p2e47dba6793b91a90b183e6cd809200bb~EPo3hWbma0369303693epcas1p2F@epcas1p2.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2018? 06? 19? 17:19? Maciej Purski ?(?) ? ?:
> When adding support for peripheral out bridges, the "bridge" name
> becomes imprecise as it refers to a different device than the
> "out_bridge".

Could you give me more details? I'm afriad that I don't understand what you say.

And in case of Exynos5433 SoC, SMIES(Samsung Mobile Image Enhancement System) can be located between DECON and MIPI-DSI devices also.
Therefore, having specific name isn't reasonable.

Thanks,
Inki Dae

> 
> Signed-off-by: Maciej Purski <m.purski@samsung.com>
> ---
>  drivers/gpu/drm/exynos/exynos_drm_dsi.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> index eae44fd..9599e6b 100644
> --- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> +++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
> @@ -279,7 +279,7 @@ struct exynos_dsi {
>  	struct list_head transfer_list;
>  
>  	const struct exynos_dsi_driver_data *driver_data;
> -	struct device_node *bridge_node;
> +	struct device_node *mic_bridge_node;
>  };
>  
>  #define host_to_dsi(host) container_of(host, struct exynos_dsi, dsi_host)
> @@ -1631,7 +1631,7 @@ static int exynos_dsi_parse_dt(struct exynos_dsi *dsi)
>  	if (ret < 0)
>  		return ret;
>  
> -	dsi->bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
> +	dsi->mic_bridge_node = of_graph_get_remote_node(node, DSI_PORT_IN, 0);
>  
>  	return 0;
>  }
> @@ -1642,7 +1642,7 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>  	struct drm_encoder *encoder = dev_get_drvdata(dev);
>  	struct exynos_dsi *dsi = encoder_to_dsi(encoder);
>  	struct drm_device *drm_dev = data;
> -	struct drm_bridge *bridge;
> +	struct drm_bridge *mic_bridge;
>  	int ret;
>  
>  	drm_encoder_init(drm_dev, encoder, &exynos_dsi_encoder_funcs,
> @@ -1661,10 +1661,10 @@ static int exynos_dsi_bind(struct device *dev, struct device *master,
>  		return ret;
>  	}
>  
> -	if (dsi->bridge_node) {
> -		bridge = of_drm_find_bridge(dsi->bridge_node);
> -		if (bridge)
> -			drm_bridge_attach(encoder, bridge, NULL);
> +	if (dsi->mic_bridge_node) {
> +		mic_bridge = of_drm_find_bridge(dsi->mic_bridge_node);
> +		if (mic_bridge)
> +			drm_bridge_attach(encoder, mic_bridge, NULL);
>  	}
>  
>  	return mipi_dsi_host_register(&dsi->dsi_host);
> @@ -1783,7 +1783,7 @@ static int exynos_dsi_remove(struct platform_device *pdev)
>  {
>  	struct exynos_dsi *dsi = platform_get_drvdata(pdev);
>  
> -	of_node_put(dsi->bridge_node);
> +	of_node_put(dsi->mic_bridge_node);
>  
>  	pm_runtime_disable(&pdev->dev);
>  
> 
