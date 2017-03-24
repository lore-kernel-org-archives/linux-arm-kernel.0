From: seanpaul@chromium.org (Sean Paul)
Date: Fri, 24 Mar 2017 15:38:16 -0400
Subject: [PATCH v8] drm/rockchip: Refactor the component match logic.
In-Reply-To: <1490152880-21855-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1490152880-21855-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <20170324193816.kq53voymwuet3yfu@art_vandelay>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 11:21:20AM +0800, Jeffy Chen wrote:
> Currently we are adding all components from the dts, if one of their
> drivers been disabled, we would not be able to bring up others.
> 
> Refactor component match logic, follow exynos drm.

Applied to drm-misc

Thanks,

Sean

> 
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
> Acked-by: Mark Yao <mark.yao@rock-chips.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> ---
> 
> Changes in v8:
> Address Sean Paul <seanpaul@chromium.org>'s comments.
> 
> Changes in v7:
> Add Heiko Stuebner <heiko@sntech.de>'s Tested-by.
> 
> Changes in v6:
> Add Mark Yao <mark.yao@rock-chips.com>'s Acked-by.
> 
> Changes in v5:
> Fix compile error reported by Heiko Stuebner <heiko@sntech.de>.
> 
> Changes in v4:
> Use platform_driver helpers to register/unregister drivers.
> Fix null pointer error reported by Heiko Stuebner <heiko@sntech.de>.
> 
> Changes in v3:
> Address Andrzej Hajda <a.hajda@samsung.com>'s comments.
> 
> Changes in v2:
> Address Sean Paul <seanpaul@chromium.org>'s comments.
> 
>  drivers/gpu/drm/rockchip/Kconfig                |  10 +-
>  drivers/gpu/drm/rockchip/Makefile               |  16 +--
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c |   9 +-
>  drivers/gpu/drm/rockchip/cdn-dp-core.c          |   8 +-
>  drivers/gpu/drm/rockchip/dw-mipi-dsi.c          |   8 +-
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c     |  10 +-
>  drivers/gpu/drm/rockchip/inno_hdmi.c            |  10 +-
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.c     | 141 ++++++++++++++++--------
>  drivers/gpu/drm/rockchip/rockchip_drm_drv.h     |   6 +
>  drivers/gpu/drm/rockchip/rockchip_vop_reg.c     |   8 +-
>  10 files changed, 118 insertions(+), 108 deletions(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/Kconfig b/drivers/gpu/drm/rockchip/Kconfig
> index 0e4eb84..50c41c0 100644
> --- a/drivers/gpu/drm/rockchip/Kconfig
> +++ b/drivers/gpu/drm/rockchip/Kconfig
> @@ -13,7 +13,7 @@ config DRM_ROCKCHIP
>  	  IP found on the SoC.
>  
>  config ROCKCHIP_ANALOGIX_DP
> -	tristate "Rockchip specific extensions for Analogix DP driver"
> +	bool "Rockchip specific extensions for Analogix DP driver"
>  	depends on DRM_ROCKCHIP
>  	select DRM_ANALOGIX_DP
>  	help
> @@ -22,7 +22,7 @@ config ROCKCHIP_ANALOGIX_DP
>  	  on RK3288 based SoC, you should selet this option.
>  
>  config ROCKCHIP_CDN_DP
> -        tristate "Rockchip cdn DP"
> +        bool "Rockchip cdn DP"
>          depends on DRM_ROCKCHIP
>  	depends on EXTCON
>  	select SND_SOC_HDMI_CODEC if SND_SOC
> @@ -33,7 +33,7 @@ config ROCKCHIP_CDN_DP
>  	  option.
>  
>  config ROCKCHIP_DW_HDMI
> -        tristate "Rockchip specific extensions for Synopsys DW HDMI"
> +        bool "Rockchip specific extensions for Synopsys DW HDMI"
>          depends on DRM_ROCKCHIP
>          select DRM_DW_HDMI
>          help
> @@ -43,7 +43,7 @@ config ROCKCHIP_DW_HDMI
>  	  option.
>  
>  config ROCKCHIP_DW_MIPI_DSI
> -	tristate "Rockchip specific extensions for Synopsys DW MIPI DSI"
> +	bool "Rockchip specific extensions for Synopsys DW MIPI DSI"
>  	depends on DRM_ROCKCHIP
>  	select DRM_MIPI_DSI
>  	help
> @@ -53,7 +53,7 @@ config ROCKCHIP_DW_MIPI_DSI
>  	 option.
>  
>  config ROCKCHIP_INNO_HDMI
> -	tristate "Rockchip specific extensions for Innosilicon HDMI"
> +	bool "Rockchip specific extensions for Innosilicon HDMI"
>  	depends on DRM_ROCKCHIP
>  	help
>  	  This selects support for Rockchip SoC specific extensions
> diff --git a/drivers/gpu/drm/rockchip/Makefile b/drivers/gpu/drm/rockchip/Makefile
> index c931e2a..fa8dc9d 100644
> --- a/drivers/gpu/drm/rockchip/Makefile
> +++ b/drivers/gpu/drm/rockchip/Makefile
> @@ -3,14 +3,14 @@
>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
>  
>  rockchipdrm-y := rockchip_drm_drv.o rockchip_drm_fb.o \
> -		rockchip_drm_gem.o rockchip_drm_psr.o rockchip_drm_vop.o
> +		rockchip_drm_gem.o rockchip_drm_psr.o \
> +		rockchip_drm_vop.o rockchip_vop_reg.o
>  rockchipdrm-$(CONFIG_DRM_FBDEV_EMULATION) += rockchip_drm_fbdev.o
>  
> -obj-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
> -obj-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp.o
> -cdn-dp-objs := cdn-dp-core.o cdn-dp-reg.o
> -obj-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
> -obj-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
> -obj-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
> +rockchipdrm-$(CONFIG_ROCKCHIP_ANALOGIX_DP) += analogix_dp-rockchip.o
> +rockchipdrm-$(CONFIG_ROCKCHIP_CDN_DP) += cdn-dp-core.o cdn-dp-reg.o
> +rockchipdrm-$(CONFIG_ROCKCHIP_DW_HDMI) += dw_hdmi-rockchip.o
> +rockchipdrm-$(CONFIG_ROCKCHIP_DW_MIPI_DSI) += dw-mipi-dsi.o
> +rockchipdrm-$(CONFIG_ROCKCHIP_INNO_HDMI) += inno_hdmi.o
>  
> -obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o rockchip_vop_reg.o
> +obj-$(CONFIG_DRM_ROCKCHIP) += rockchipdrm.o
> diff --git a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> index 8548e82..91ebe5c 100644
> --- a/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/analogix_dp-rockchip.c
> @@ -507,7 +507,7 @@ static const struct of_device_id rockchip_dp_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, rockchip_dp_dt_ids);
>  
> -static struct platform_driver rockchip_dp_driver = {
> +struct platform_driver rockchip_dp_driver = {
>  	.probe = rockchip_dp_probe,
>  	.remove = rockchip_dp_remove,
>  	.driver = {
> @@ -516,10 +516,3 @@ static struct platform_driver rockchip_dp_driver = {
>  		   .of_match_table = of_match_ptr(rockchip_dp_dt_ids),
>  	},
>  };
> -
> -module_platform_driver(rockchip_dp_driver);
> -
> -MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
> -MODULE_AUTHOR("Jeff chen <jeff.chen@rock-chips.com>");
> -MODULE_DESCRIPTION("Rockchip Specific Analogix-DP Driver Extension");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> index fd79a70..e1796d0 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
> @@ -1243,7 +1243,7 @@ static const struct dev_pm_ops cdn_dp_pm_ops = {
>  				cdn_dp_resume)
>  };
>  
> -static struct platform_driver cdn_dp_driver = {
> +struct platform_driver cdn_dp_driver = {
>  	.probe = cdn_dp_probe,
>  	.remove = cdn_dp_remove,
>  	.shutdown = cdn_dp_shutdown,
> @@ -1254,9 +1254,3 @@ static struct platform_driver cdn_dp_driver = {
>  		   .pm = &cdn_dp_pm_ops,
>  	},
>  };
> -
> -module_platform_driver(cdn_dp_driver);
> -
> -MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
> -MODULE_DESCRIPTION("cdn DP Driver");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> index f84f9ae..9360250 100644
> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
> @@ -1304,7 +1304,7 @@ static int dw_mipi_dsi_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_driver dw_mipi_dsi_driver = {
> +struct platform_driver dw_mipi_dsi_driver = {
>  	.probe		= dw_mipi_dsi_probe,
>  	.remove		= dw_mipi_dsi_remove,
>  	.driver		= {
> @@ -1312,9 +1312,3 @@ static struct platform_driver dw_mipi_dsi_driver = {
>  		.name	= DRIVER_NAME,
>  	},
>  };
> -module_platform_driver(dw_mipi_dsi_driver);
> -
> -MODULE_DESCRIPTION("ROCKCHIP MIPI DSI host controller driver");
> -MODULE_AUTHOR("Chris Zhong <zyw@rock-chips.com>");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:" DRIVER_NAME);
> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index a6d4a02..976ea79 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -326,7 +326,7 @@ static int dw_hdmi_rockchip_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct platform_driver dw_hdmi_rockchip_pltfm_driver = {
> +struct platform_driver dw_hdmi_rockchip_pltfm_driver = {
>  	.probe  = dw_hdmi_rockchip_probe,
>  	.remove = dw_hdmi_rockchip_remove,
>  	.driver = {
> @@ -334,11 +334,3 @@ static struct platform_driver dw_hdmi_rockchip_pltfm_driver = {
>  		.of_match_table = dw_hdmi_rockchip_dt_ids,
>  	},
>  };
> -
> -module_platform_driver(dw_hdmi_rockchip_pltfm_driver);
> -
> -MODULE_AUTHOR("Andy Yan <andy.yan@rock-chips.com>");
> -MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
> -MODULE_DESCRIPTION("Rockchip Specific DW-HDMI Driver Extension");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:dwhdmi-rockchip");
> diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
> index 006260d..7d9b75e 100644
> --- a/drivers/gpu/drm/rockchip/inno_hdmi.c
> +++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
> @@ -923,7 +923,7 @@ static const struct of_device_id inno_hdmi_dt_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(of, inno_hdmi_dt_ids);
>  
> -static struct platform_driver inno_hdmi_driver = {
> +struct platform_driver inno_hdmi_driver = {
>  	.probe  = inno_hdmi_probe,
>  	.remove = inno_hdmi_remove,
>  	.driver = {
> @@ -931,11 +931,3 @@ static struct platform_driver inno_hdmi_driver = {
>  		.of_match_table = inno_hdmi_dt_ids,
>  	},
>  };
> -
> -module_platform_driver(inno_hdmi_driver);
> -
> -MODULE_AUTHOR("Zheng Yang <zhengyang@rock-chips.com>");
> -MODULE_AUTHOR("Yakir Yang <ykk@rock-chips.com>");
> -MODULE_DESCRIPTION("Rockchip Specific INNO-HDMI Driver");
> -MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform:innohdmi-rockchip");
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index ccf4569..cd7d02e1 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -304,34 +304,37 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
>  				rockchip_drm_sys_resume)
>  };
>  
> -static int compare_of(struct device *dev, void *data)
> -{
> -	struct device_node *np = data;
> +#define MAX_ROCKCHIP_SUB_DRIVERS 16
> +static struct platform_driver *rockchip_sub_drivers[MAX_ROCKCHIP_SUB_DRIVERS];
> +static int num_rockchip_sub_drivers;
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
> +	for (i = 0; i < num_rockchip_sub_drivers; i++) {
> +		struct platform_driver *drv = rockchip_sub_drivers[i];
> +		struct device *p = NULL, *d;
> +
> +		do {
> +			d = bus_find_device(&platform_bus_type, p, &drv->driver,
> +					    (void *)platform_bus_type.match);
> +			put_device(p);
> +			p = d;
>  
> -		drm_of_component_match_add(dev, match, compare_of, remote);
> -		of_node_put(remote);
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
> @@ -339,21 +342,16 @@ static const struct component_master_ops rockchip_drm_ops = {
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
> @@ -377,9 +375,9 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
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
> @@ -388,27 +386,27 @@ static int rockchip_drm_platform_probe(struct platform_device *pdev)
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
> @@ -436,7 +434,54 @@ static struct platform_driver rockchip_drm_platform_driver = {
>  	},
>  };
>  
> -module_platform_driver(rockchip_drm_platform_driver);
> +#define ADD_ROCKCHIP_SUB_DRIVER(drv, cond) { \
> +	if (IS_ENABLED(cond) && \
> +	    !WARN_ON(num_rockchip_sub_drivers >= MAX_ROCKCHIP_SUB_DRIVERS)) \
> +		rockchip_sub_drivers[num_rockchip_sub_drivers++] = &drv; \
> +}
> +
> +static int __init rockchip_drm_init(void)
> +{
> +	int ret;
> +
> +	num_rockchip_sub_drivers = 0;
> +	ADD_ROCKCHIP_SUB_DRIVER(vop_platform_driver, CONFIG_DRM_ROCKCHIP);
> +	ADD_ROCKCHIP_SUB_DRIVER(rockchip_dp_driver,
> +				CONFIG_ROCKCHIP_ANALOGIX_DP);
> +	ADD_ROCKCHIP_SUB_DRIVER(cdn_dp_driver, CONFIG_ROCKCHIP_CDN_DP);
> +	ADD_ROCKCHIP_SUB_DRIVER(dw_hdmi_rockchip_pltfm_driver,
> +				CONFIG_ROCKCHIP_DW_HDMI);
> +	ADD_ROCKCHIP_SUB_DRIVER(dw_mipi_dsi_driver,
> +				CONFIG_ROCKCHIP_DW_MIPI_DSI);
> +	ADD_ROCKCHIP_SUB_DRIVER(inno_hdmi_driver, CONFIG_ROCKCHIP_INNO_HDMI);
> +
> +	ret = platform_register_drivers(rockchip_sub_drivers,
> +					num_rockchip_sub_drivers);
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
> +	platform_unregister_drivers(rockchip_sub_drivers,
> +				    num_rockchip_sub_drivers);
> +	return ret;
> +}
> +
> +static void __exit rockchip_drm_fini(void)
> +{
> +	platform_driver_unregister(&rockchip_drm_platform_driver);
> +
> +	platform_unregister_drivers(rockchip_sub_drivers,
> +				    num_rockchip_sub_drivers);
> +}
> +
> +module_init(rockchip_drm_init);
> +module_exit(rockchip_drm_fini);
>  
>  MODULE_AUTHOR("Mark Yao <mark.yao@rock-chips.com>");
>  MODULE_DESCRIPTION("ROCKCHIP DRM Driver");
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> index 8aca219..a48fcce 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> @@ -65,4 +65,10 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
>  int rockchip_drm_wait_line_flag(struct drm_crtc *crtc, unsigned int line_num,
>  				unsigned int mstimeout);
>  
> +extern struct platform_driver cdn_dp_driver;
> +extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
> +extern struct platform_driver dw_mipi_dsi_driver;
> +extern struct platform_driver inno_hdmi_driver;
> +extern struct platform_driver rockchip_dp_driver;
> +extern struct platform_driver vop_platform_driver;
>  #endif /* _ROCKCHIP_DRM_DRV_H_ */
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
> -- 
> 2.1.4
> 
> 

-- 
Sean Paul, Software Engineer, Google / Chromium OS
