From: a.hajda@samsung.com (Andrzej Hajda)
Date: Tue, 14 Mar 2017 13:05:32 +0100
Subject: [PATCH v2] drm/rockchip: Refactor the component match logic.
In-Reply-To: <1489488349-3053-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1489488349-3053-1-git-send-email-jeffy.chen@rock-chips.com>
 <CGME20170314120534eucas1p20601e44f6552db2b4b3f65d8ab6b4720@eucas1p2.samsung.com>
Message-ID: <9352c2e4-5394-4725-f247-ff98318cd3d4@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffy,

On 14.03.2017 11:45, Jeffy Chen wrote:
> Currently we are adding all components from the dts, if one of their
> drivers been disabled, we would not be able to bring up others.
> 
> Refactor component match logic, follow exynos drm.
> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Below few nitpicks.

(...)

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index b360e62..b6bccfc 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -356,34 +356,52 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
>  				rockchip_drm_sys_resume)
>  };
>  
> -static int compare_of(struct device *dev, void *data)
> -{
> -	struct device_node *np = data;
> +static struct platform_driver *rockchip_drm_comp_drvs[] = {
> +	&vop_platform_driver,
> +#ifdef CONFIG_ROCKCHIP_ANALOGIX_DP
> +	&rockchip_dp_driver,
> +#endif
> +#ifdef CONFIG_ROCKCHIP_CDN_DP
> +	&cdn_dp_driver,
> +#endif
> +#ifdef CONFIG_ROCKCHIP_DW_HDMI
> +	&dw_hdmi_rockchip_pltfm_driver,
> +#endif
> +#ifdef CONFIG_ROCKCHIP_DW_MIPI_DSI
> +	&dw_mipi_dsi_driver,
> +#endif
> +#ifdef CONFIG_ROCKCHIP_INNO_HDMI
> +	&inno_hdmi_driver,
> +#endif
> +};

To avoid #ifdefs, you can use DRV_PTR [1], but it depends what do you
hate more? ifdefs or macro magic :)

[1]:
http://lxr.free-electrons.com/source/drivers/gpu/drm/exynos/exynos_drm_drv.c#L472

>  
> -	return dev->of_node == np;
> +static int compare_dev(struct device *dev, void *data)
> +{
> +	return dev == (struct device *)data;
>  }
>  
> -static void rockchip_add_endpoints(struct device *dev,
> -				   struct component_match **match,
> -				   struct device_node *port)
> +static struct component_match *rockchip_drm_match_add(struct device *dev)
>  {
> -	struct device_node *ep, *remote;
> +	struct component_match *match = NULL;
> +	int i;
>  
> -	for_each_child_of_node(port, ep) {
> -		remote = of_graph_get_remote_port_parent(ep);
> -		if (!remote || !of_device_is_available(remote)) {
> -			of_node_put(remote);
> -			continue;
> -		} else if (!of_device_is_available(remote->parent)) {
> -			dev_warn(dev, "parent device of %s is not available\n",
> -				 remote->full_name);
> -			of_node_put(remote);
> -			continue;
> -		}
> +	for (i = 0; i < ARRAY_SIZE(rockchip_drm_comp_drvs); i++) {
> +		struct platform_driver *drv = rockchip_drm_comp_drvs[i];
> +		struct device *p = NULL, *d;
>  
> -		drm_of_component_match_add(dev, match, compare_of, remote);
> -		of_node_put(remote);
> +		do {
> +			d = bus_find_device(&platform_bus_type, p, &drv->driver,
> +					    (void *)platform_bus_type.match);
> +			put_device(p);
> +			p = d;
> +
> +			if (!d)
> +				break;
> +			component_match_add(dev, &match, compare_dev, d);
> +		} while (true);
>  	}
> +
> +	return match ?: ERR_PTR(-ENODEV);
>  }
>  
>  static const struct component_master_ops rockchip_drm_ops = {
> @@ -391,21 +409,16 @@ static const struct component_master_ops rockchip_drm_ops = {
>  	.unbind = rockchip_drm_unbind,
>  };
>  
> -static int rockchip_drm_platform_probe(struct platform_device *pdev)
> +static int rockchip_drm_platform_of_probe(struct device *dev)
>  {
> -	struct device *dev = &pdev->dev;
> -	struct component_match *match = NULL;
>  	struct device_node *np = dev->of_node;
>  	struct device_node *port;
> +	bool found = false;
>  	int i;
>  
>  	if (!np)
>  		return -ENODEV;
> -	/*
> -	 * Bind the crtc ports first, so that
> -	 * drm_of_find_possible_crtcs called from encoder .bind callbacks
> -	 * works as expected.
> -	 */
> +
>  	for (i = 0;; i++) {
>  		struct device_node *iommu;
>  
> @@ -429,9 +442,9 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
>  			is_support_iommu = false;
>  		}
>  
> +		found = true;
> +
>  		of_node_put(iommu);
> -		drm_of_component_match_add(dev, &match, compare_of,
> -					   port->parent);
>  		of_node_put(port);
>  	}
>  
> @@ -440,27 +453,27 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
>  		return -ENODEV;
>  	}
>  
> -	if (!match) {
> +	if (!found) {
>  		dev_err(dev, "No available vop found for display-subsystem.\n");
>  		return -ENODEV;
>  	}
> -	/*
> -	 * For each bound crtc, bind the encoders attached to its
> -	 * remote endpoint.
> -	 */
> -	for (i = 0;; i++) {
> -		port = of_parse_phandle(np, "ports", i);
> -		if (!port)
> -			break;
>  
> -		if (!of_device_is_available(port->parent)) {
> -			of_node_put(port);
> -			continue;
> -		}
> +	return 0;
> +}
>  
> -		rockchip_add_endpoints(dev, &match, port);
> -		of_node_put(port);
> -	}
> +static int rockchip_drm_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct component_match *match = NULL;
> +	int ret;
> +
> +	ret = rockchip_drm_platform_of_probe(dev);
> +	if (ret)
> +		return ret;
> +
> +	match = rockchip_drm_match_add(dev);
> +	if (IS_ERR(match))
> +		return PTR_ERR(match);
>  
>  	return component_master_add_with_match(dev, &rockchip_drm_ops, match);
>  }
> @@ -488,7 +501,60 @@ static struct platform_driver rockchip_drm_platform_driver = {
>  	},
>  };
>  
> -module_platform_driver(rockchip_drm_platform_driver);
> +static void rockchip_drm_unregister_drivers(void)
> +{
> +	int i;
> +
> +	for (i = ARRAY_SIZE(rockchip_drm_comp_drvs) - 1; i >= 0; i--)
> +		platform_driver_unregister(rockchip_drm_comp_drvs[i]);
> +}
> +
> +static int rockchip_drm_register_drivers(void)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(rockchip_drm_comp_drvs); i++) {
> +		ret = platform_driver_register(rockchip_drm_comp_drvs[i]);
> +		if (ret)
> +			goto err_unreg;
> +	}
> +
> +	return 0;
> +
> +err_unreg:
> +	for (; i--; )
> +		platform_driver_unregister(rockchip_drm_comp_drvs[i]);

Strange placement of decremental in for, maybe sth like this would be
better:
	while (i-- > 0)
		platform_driver_unregister(rockchip_drm_comp_drvs[i]);


> +	return ret;
> +}
> +
> +static int __init rockchip_drm_init(void)
> +{
> +	int ret;
> +
> +	ret = rockchip_drm_register_drivers();
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&rockchip_drm_platform_driver);
> +	if (ret)
> +		goto err_unreg_drivers;
> +
> +	return 0;
> +
> +err_unreg_drivers:
> +	rockchip_drm_unregister_drivers();
> +	return ret;
> +}
> +
> +static void __exit rockchip_drm_fini(void)
> +{
> +	platform_driver_unregister(&rockchip_drm_platform_driver);
> +
> +	rockchip_drm_unregister_drivers();
> +}
> +
> +module_init(rockchip_drm_init);
> +module_exit(rockchip_drm_fini);
>  
>  MODULE_AUTHOR("Mark Yao <mark.yao@rock-chips.com>");
>  MODULE_DESCRIPTION("ROCKCHIP DRM Driver");
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> index adc3930..91812bd 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> @@ -79,4 +79,20 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
>  int rockchip_drm_wait_line_flag(struct drm_crtc *crtc, unsigned int line_num,
>  				unsigned int mstimeout);
>  
> +#ifdef CONFIG_ROCKCHIP_CDN_DP
> +extern struct platform_driver cdn_dp_driver;
> +#endif
> +#ifdef CONFIG_ROCKCHIP_DW_HDMI
> +extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
> +#endif
> +#ifdef CONFIG_ROCKCHIP_DW_MIPI_DSI
> +extern struct platform_driver dw_mipi_dsi_driver;
> +#endif
> +#ifdef CONFIG_ROCKCHIP_INNO_HDMI
> +extern struct platform_driver inno_hdmi_driver;
> +#endif
> +#ifdef CONFIG_ROCKCHIP_ANALOGIX_DP
> +extern struct platform_driver rockchip_dp_driver;
> +#endif
> +extern struct platform_driver vop_platform_driver;
>  #endif /* _ROCKCHIP_DRM_DRV_H_ */

I think gcc should be fine if you remove ifdefs. Unused extern
declarations are ignored, unless you use some paranoic static checker,
aren't they? But this is also matter of taste.


Regards
Andrzej


> diff --git a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> index 91fbc7b..0da4444 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_vop_reg.c
> @@ -404,7 +404,7 @@ static int vop_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_driver vop_platform_driver = {
> +struct platform_driver vop_platform_driver = {
>  	.probe = vop_probe,
>  	.remove = vop_remove,
>  	.driver = {
> @@ -412,9 +412,3 @@ static struct platform_driver vop_platform_driver = {
>  		.of_match_table = of_match_ptr(vop_driver_dt_match),
>  	},
>  };
> -
> -module_platform_driver(vop_platform_driver);
> -
> -MODULE_AUTHOR("Mark Yao <mark.yao@rock-chips.com>");
> -MODULE_DESCRIPTION("ROCKCHIP VOP Driver");
> -MODULE_LICENSE("GPL v2");
> 
