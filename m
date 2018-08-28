From: hjc@rock-chips.com (Sandy Huang)
Date: Tue, 28 Aug 2018 20:20:13 +0800
Subject: [PATCH v5 2/2] drm/rockchip: Add support for Rockchip Soc RGB
 output interface
In-Reply-To: <2164089.bDJbLuhFGU@phil>
References: <1535443954-38806-1-git-send-email-hjc@rock-chips.com>
 <1535443954-38806-3-git-send-email-hjc@rock-chips.com>
 <2164089.bDJbLuhFGU@phil>
Message-ID: <c203e409-d2e4-e534-7855-27c3503a78b1@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi hieko,

? 2018/8/28 16:31, Heiko Stuebner ??:
> Hi Sandy,
> 
> Am Dienstag, 28. August 2018, 10:12:34 CEST schrieb Sandy Huang:
>> Some Rockchip CRTCs, like rv1108 and px30, can directly output parallel
>> and serial RGB data to panel or conversion chip, so we add this driver
>> to probe encoder and connector.
>>
>> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
>> Reviewed-by: Sean Paul <seanpaul@chromium.org>
>> Reviewed-by: Mark Yao <mark.yao@rock-chips.com>
>> Link: https://patchwork.freedesktop.org/patch/msgid/1509522851-128181-1-git-send-email-hjc at rock-chips.com
> 
> This does not really address, Rob's concern about not being an actual
> hardware block related to the devicetree node you are using.
> 
> I see your reply to my mail, but I guess you didn't see the alternative
> approach I described a bit below in that mail?
> 
> Actual (unfinished) code included below. (2 patches)
> 
> Heiko
> 
> 
yes,i didn't see the behind described:(
As you said devicetree describes hardware blocks,
I think you implement driver for rgb output interface is more 
reasonable,  i will adjust this driver refer to your implementation, 
thanks:)


> 
> ---- 8< -----
> From: Heiko Stuebner <heiko@sntech.de>
> Date: Sat, 25 Aug 2018 19:05:21 +0200
> Subject: [PATCH 1/2] drm/tockchip: add function to check if endpoint is a
>   subdriver
> 
> To be able to have both internal subdrivers and external bridge
> drivers as output endpoints of vops, add a function to be able
> to distinguish these.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.c | 27 +++++++++++++++++++++
>   drivers/gpu/drm/rockchip/rockchip_drm_drv.h |  1 +
>   2 files changed, 28 insertions(+)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> index 1d9c4a9201c8..d18f7f85aa23 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.c
> @@ -24,6 +24,7 @@
>   #include <linux/pm_runtime.h>
>   #include <linux/module.h>
>   #include <linux/of_graph.h>
> +#include <linux/of_platform.h>
>   #include <linux/component.h>
>   #include <linux/console.h>
>   #include <linux/iommu.h>
> @@ -267,6 +268,32 @@ static const struct dev_pm_ops rockchip_drm_pm_ops = {
>   static struct platform_driver *rockchip_sub_drivers[MAX_ROCKCHIP_SUB_DRIVERS];
>   static int num_rockchip_sub_drivers;
>   
> +/*
> + * check if a vop output-endpoint is a subdriver or bridge.
> + */
> +bool rockchip_drm_endpoint_is_subdriver(struct device_node *ep)
> +{
> +	struct device_node *node = of_graph_get_remote_port_parent(ep);
> +	struct platform_device *pdev;
> +	int i;
> +
> +	if (!node)
> +		return false;
> +
> +	pdev = of_find_device_by_node(node);
> +	if (!pdev)
> +		return false;
> +
> +	for (i = 0; i < num_rockchip_sub_drivers; i++) {
> +		struct device_driver *drv = pdev->dev.driver;
> +
> +		if (rockchip_sub_drivers[i] == to_platform_driver(drv))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static int compare_dev(struct device *dev, void *data)
>   {
>   	return dev == (struct device *)data;
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> index d67ad0a3cf36..305b4858c522 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_drv.h
> @@ -64,6 +64,7 @@ void rockchip_drm_dma_detach_device(struct drm_device *drm_dev,
>   				    struct device *dev);
>   int rockchip_drm_wait_vact_end(struct drm_crtc *crtc, unsigned int mstimeout);
>   
> +bool rockchip_drm_endpoint_is_subdriver(struct device_node *ep);
>   extern struct platform_driver cdn_dp_driver;
>   extern struct platform_driver dw_hdmi_rockchip_pltfm_driver;
>   extern struct platform_driver dw_mipi_dsi_driver;
> 
> 
> 
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
> 
