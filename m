From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 11 Apr 2013 10:56:02 -0700
Subject: [RFC/PATCH v2 2/2] drivers: dma-contiguous: add initialization
 from device tree
In-Reply-To: <1365679330-2514-3-git-send-email-m.szyprowski@samsung.com>
References: <1365679330-2514-1-git-send-email-m.szyprowski@samsung.com>
 <1365679330-2514-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <5166F932.9000003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 4/11/2013 4:22 AM, Marek Szyprowski wrote:
...
> +
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 01fe743..6a8abab 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -24,6 +24,9 @@
>
>   #include <linux/memblock.h>
>   #include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_platform.h>
>   #include <linux/mm.h>
>   #include <linux/mutex.h>
>   #include <linux/page-isolation.h>
> @@ -37,6 +40,7 @@ struct cma {
>   	unsigned long	base_pfn;
>   	unsigned long	count;
>   	unsigned long	*bitmap;
> +	char		full_name[32];
>   };
>
>   static DEFINE_MUTEX(cma_mutex);
> @@ -133,6 +137,53 @@ static __init int cma_activate_area(struct cma *cma)
>   	return 0;
>   }
>
> +/*****************************************************************************/
> +
> +#ifdef CONFIG_OF
> +int __init cma_fdt_scan(unsigned long node, const char *uname,
> +				int depth, void *data)
> +{
> +	static int level;
> +	phys_addr_t base, size;
> +	unsigned long len;
> +	struct cma *cma;
> +	__be32 *prop;
> +
> +	if (depth == 1 && strcmp(uname, "chosen") == 0) {
> +		level = depth;
> +		return 0;
> +	}
> +
> +	if (depth == 2 && strcmp(uname, "contiguous-memory") == 0) {
> +		level = depth;
> +		return 0;
> +	}
> +
> +	if (level != 2 || depth != 3 || strncmp(uname, "region@", 7) != 0)
> +		return 0;
> +

Requiring the region@ label does not work if you want two dynamically 
placed regions (i.e. two region at 0). The devicetree will take the last 
region at 0 entry and ignore all the other ones

> +	prop = of_get_flat_dt_prop(node, "reg", &len);
> +	if (!prop || (len != 2 * sizeof(unsigned long)))
> +		return 0;
> +
> +	base = be32_to_cpu(prop[0]);
> +	size = be32_to_cpu(prop[1]);
> +
> +	pr_info("Found %s, memory base %lx, size %ld MiB\n", uname,
> +		(unsigned long)base, (unsigned long)size / SZ_1M);
> +
> +	dma_contiguous_reserve_area(size, base, 0, &cma);
> +

Need to check the return of dma_contiguous_reserve_area, else there is 
an abort when trying to access cma->name on an error

> +	strcpy(cma->full_name, uname);
> +
> +	if (of_get_flat_dt_prop(node, "linux,default-contiguous-region", NULL)) {
> +
> +		dma_contiguous_default_area = cma;
> +	}
> +	return 0;
> +}
> +#endif
> +
>   /**
>    * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
>    * @limit: End address of the reserved memory (optional, 0 for any).


if the contiguous region isn't set via devicetree, 
default_area->full_name needs to be set in dma_contiguous_reserve, else 
we get wrong associations in scan_cma_node.

> @@ -149,6 +200,10 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>
>   	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
>
> +#ifdef CONFIG_OF
> +	of_scan_flat_dt(cma_fdt_scan, NULL);
> +#endif
> +
>   	if (size_cmdline != -1) {
>   		sel_size = size_cmdline;
>   	} else {
> @@ -265,6 +320,71 @@ int __init dma_contiguous_add_device(struct device *dev, struct cma *cma)
>   	return 0;
>   }
>
> +#ifdef CONFIG_OF
> +static struct cma_map {
> +	struct cma *cma;
> +	struct device_node *node;
> +} cma_maps[MAX_CMA_AREAS];
> +static unsigned cma_map_count;
> +
> +static void cma_assign_device_from_dt(struct device *dev)
> +{
> +	int i;
> +	for (i=0; i<cma_map_count; i++) {
> +		if (cma_maps[i].node == dev->of_node) {
> +			dev_set_cma_area(dev, cma_maps[i].cma);
> +			pr_info("Assigned CMA %s to %s device\n",
> +				cma_maps[i].cma->full_name,
> +				dev_name(dev));
> +		}
> +	}
> +}
> +
> +static int cma_device_init_notifier_call(struct notifier_block *nb,
> +					 unsigned long event, void *data)
> +{
> +	struct device *dev = data;
> +	if (event == BUS_NOTIFY_ADD_DEVICE && dev->of_node)
> +		cma_assign_device_from_dt(dev);
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block cma_dev_init_nb = {
> +	.notifier_call = cma_device_init_notifier_call,
> +};
> +
> +void scan_cma_nodes(void)
> +{
> +	struct device_node *parent = of_find_node_by_path("/chosen/contiguous-memory");
> +	struct device_node *child;
> +
> +	if (!parent)
> +		return;
> +
> +	for_each_child_of_node(parent, child) {
> +		struct cma *cma = NULL;
> +		int i;
> +
> +		for (i=0; i<cma_area_count; i++)
> +			if (strstr(child->full_name, cma_areas[i].full_name))
> +				cma = &cma_areas[i];

break out of the loop once the area is found?

Also, how will the code deal with region names that are substrings of 
each other e.g.

region at 1000000
region at 10000000

> +		if (!cma)
> +			continue;
> +
> +		for (i=0;; i++) {
> +			struct device_node *node;
> +			node = of_parse_phandle(child, "device", i);
> +			if (!node)
> +				break;
> +
> +			cma_maps[cma_map_count].cma = cma;
> +			cma_maps[cma_map_count].node = node;
> +			cma_map_count++;

Bounds check cma_map_count against MAX_CMA_AREAS?

> +		}
> +	}
> +}
> +#endif
> +
>   static int __init cma_init_reserved_areas(void)
>   {
>   	int i;
> @@ -275,6 +395,10 @@ static int __init cma_init_reserved_areas(void)
>   			return ret;
>   	}
>
> +#ifdef CONFIG_OF
> +	scan_cma_nodes();
> +	bus_register_notifier(&platform_bus_type, &cma_dev_init_nb);
> +#endif
>   	return 0;
>   }
>   core_initcall(cma_init_reserved_areas);
>

Thanks,
Laura

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
