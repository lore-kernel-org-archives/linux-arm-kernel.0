From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 24 May 2016 16:45:17 +0100
Subject: [RFC 5/9] drivers: platform: Configure dma operations at probe
 time
In-Reply-To: <1461599894-1969-6-git-send-email-sricharan@codeaurora.org>
References: <1461599894-1969-1-git-send-email-sricharan@codeaurora.org>
 <1461599894-1969-6-git-send-email-sricharan@codeaurora.org>
Message-ID: <5744770D.9090303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/04/16 16:58, Sricharan R wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
>
> Configuring DMA ops at probe time will allow deferring device probe when
> the IOMMU isn't available yet.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>   drivers/base/platform.c | 13 +++++++++++++
>   drivers/of/platform.c   |  7 +++----
>   2 files changed, 16 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index f437afa..17e64a4 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -557,6 +557,12 @@ static int platform_drv_probe(struct device *_dev)
>   	if (ret < 0)
>   		return ret;
>
> +	if (of_have_populated_dt()) {
> +		ret = of_dma_configure_ops(_dev, _dev->of_node);
> +		if (ret < 0)
> +			goto done;
> +	}
> +
>   	ret = dev_pm_domain_attach(_dev, true);
>   	if (ret != -EPROBE_DEFER) {
>   		if (drv->probe) {
> @@ -569,6 +575,11 @@ static int platform_drv_probe(struct device *_dev)
>   		}
>   	}
>
> +	if (of_have_populated_dt()) {
> +		if (ret)
> +			of_dma_deconfigure(_dev);
> +	}
> +done:
>   	if (drv->prevent_deferred_probe && ret == -EPROBE_DEFER) {
>   		dev_warn(_dev, "probe deferral not supported\n");
>   		ret = -ENXIO;
> @@ -591,6 +602,8 @@ static int platform_drv_remove(struct device *_dev)
>   	if (drv->remove)
>   		ret = drv->remove(dev);
>   	dev_pm_domain_detach(_dev, true);
> +	if (of_have_populated_dt())
> +		of_dma_deconfigure(_dev);
>
>   	return ret;
>   }
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 17ee8d5..12bbc8e1 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -180,11 +180,9 @@ static struct platform_device *of_platform_device_create_pdata(
>   	dev->dev.bus = &platform_bus_type;
>   	dev->dev.platform_data = platform_data;
>   	of_dma_configure_masks(&dev->dev, dev->dev.of_node);
> -	of_dma_configure_ops(&dev->dev, dev->dev.of_node);
>   	of_msi_configure(&dev->dev, dev->dev.of_node);
>
>   	if (of_device_add(dev) != 0) {
> -		of_dma_deconfigure(&dev->dev);
>   		platform_device_put(dev);
>   		goto err_clear_flag;
>   	}
> @@ -481,11 +479,12 @@ static int of_platform_device_destroy(struct device *dev, void *data)
>   	if (dev->bus == &platform_bus_type)
>   		platform_device_unregister(to_platform_device(dev));
>   #ifdef CONFIG_ARM_AMBA
> -	else if (dev->bus == &amba_bustype)
> +	else if (dev->bus == &amba_bustype) {
>   		amba_device_unregister(to_amba_device(dev));
> +		of_dma_deconfigure(dev);
> +	}

Note that we definitely need this to happen properly on other buses, 
too. I had something for the AMBA bus back when I last looked at 
this[0], but since then we now have PCI devices going through the 
of_dma_configure() path as well (hence 226d89cbb242).

There's also now some initial ACPI code in flight[1], so it's probably 
about time to take another closer look at how this can be properly 
generalised, but I'm not necessarily averse to starting with a 
DT-focused solution that gets at least half way, then building on top of 
that.

Robin.

[0]:http://www.linux-arm.org/git?p=linux-rm.git;a=commitdiff;h=1f38b62b05e17ccbfcc68e4229c69fee74922e2a
[1]:http://thread.gmane.org/gmane.linux.kernel.iommu/13046

>   #endif
>
> -	of_dma_deconfigure(dev);
>   	of_node_clear_flag(dev->of_node, OF_POPULATED);
>   	of_node_clear_flag(dev->of_node, OF_POPULATED_BUS);
>   	return 0;
>
