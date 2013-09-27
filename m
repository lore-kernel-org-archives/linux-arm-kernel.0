From: galak@codeaurora.org (Kumar Gala)
Date: Fri, 27 Sep 2013 10:47:14 -0500
Subject: [PATCH v7 3/4] drivers: of: add initialization code for dma
 reserved memory
In-Reply-To: <1377527959-5080-4-git-send-email-m.szyprowski@samsung.com>
References: <1377527959-5080-1-git-send-email-m.szyprowski@samsung.com>
 <1377527959-5080-4-git-send-email-m.szyprowski@samsung.com>
Message-ID: <AD54F66C-31F0-46DF-AEDA-D1E6CC5A5A2A@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Aug 26, 2013, at 9:39 AM, Marek Szyprowski wrote:

> +/**
> + * of_reserved_mem_device_init() - assign reserved memory region to given device
> + *
> + * This function assign memory region pointed by "memory-region" device tree
> + * property to the given device.
> + */
> +void of_reserved_mem_device_init(struct device *dev)
> +{
> +	struct reserved_mem *region = get_dma_memory_region(dev);
> +	if (!region)
> +		return;
> +
> +	if (region->cma) {
> +		dev_set_cma_area(dev, region->cma);
> +		pr_info("Assigned CMA %s to %s device\n", region->name,
> +			dev_name(dev));
> +	} else {

I don't think its a reasonable assumption that a 'reserved-memory-region' is necessary dma coherent if its not cma.

> +		if (dma_declare_coherent_memory(dev, region->base, region->base,
> +		    region->size, DMA_MEMORY_MAP | DMA_MEMORY_EXCLUSIVE) != 0)
> +			pr_info("Declared reserved memory %s to %s device\n",
> +				region->name, dev_name(dev));
> +	}
> +}
> +

- k

-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
