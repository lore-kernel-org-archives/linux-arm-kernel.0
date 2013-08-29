From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Aug 2013 23:48:25 +0100
Subject: [PATCH v7 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <1377527959-5080-4-git-send-email-m.szyprowski@samsung.com>
References: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
 <1377527959-5080-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <20130829224825.714F33E1222@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 26 Aug 2013 16:39:18 +0200, Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index e0a6514..eeca8a5 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -21,6 +21,7 @@
>  #include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  
>  const struct of_device_id of_default_bus_match_table[] = {
> @@ -218,6 +219,8 @@ struct platform_device *of_platform_device_create_pdata(
>  	dev->dev.bus = &platform_bus_type;
>  	dev->dev.platform_data = platform_data;
>  
> +	of_reserved_mem_device_init(&dev->dev);
> +

One more comment. This only covers platform devices. What about AMBA
devices?

>  	/* We do not fill the DMA ops for platform devices by default.
>  	 * This is currently the responsibility of the platform code
>  	 * to do such, possibly using a device notifier
> @@ -225,6 +228,7 @@ struct platform_device *of_platform_device_create_pdata(
>  
>  	if (of_device_add(dev) != 0) {
>  		platform_device_put(dev);
> +		of_reserved_mem_device_release(&dev->dev);
>  		return NULL;
>  	}
>  
> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> new file mode 100644
> index 0000000..c841282
> --- /dev/null
> +++ b/include/linux/of_reserved_mem.h
> @@ -0,0 +1,14 @@
> +#ifndef __OF_RESERVED_MEM_H
> +#define __OF_RESERVED_MEM_H
> +
> +#ifdef CONFIG_OF_RESERVED_MEM
> +void of_reserved_mem_device_init(struct device *dev);
> +void of_reserved_mem_device_release(struct device *dev);
> +void early_init_dt_scan_reserved_mem(void);
> +#else
> +static inline void of_reserved_mem_device_init(struct device *dev) { }
> +static inline void of_reserved_mem_device_release(struct device *dev) { }
> +static inline void early_init_dt_scan_reserved_mem(void) { }
> +#endif
> +
> +#endif /* __OF_RESERVED_MEM_H */
> -- 
> 1.7.9.5
> 
