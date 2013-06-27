From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 27 Jun 2013 15:58:12 +0200
Subject: [PATCH v3 2/2] drivers: dma-contiguous: add initialization from
 device tree
In-Reply-To: <1372254009-25307-3-git-send-email-m.szyprowski@samsung.com>
References: <1372254009-25307-1-git-send-email-m.szyprowski@samsung.com>
 <1372254009-25307-3-git-send-email-m.szyprowski@samsung.com>
Message-ID: <2966873.p8mY1Kzr6i@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

FWIW overall the patch looks good to me, few minor nits below.

On Wednesday, June 26, 2013 03:40:09 PM Marek Szyprowski wrote:
> Add device tree support for contiguous memory regions defined in device
> tree. Initialization is done in 2 steps. First, the contiguous memory is
> reserved, what happens very early when only flattened device tree is
> available. Then on device initialization the corresponding cma regions are
> assigned to each device structure.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  .../devicetree/bindings/contiguous-memory.txt      |   94 ++++++++++++++
>  arch/arm/boot/dts/skeleton.dtsi                    |    7 +-
>  drivers/base/dma-contiguous.c                      |  132 ++++++++++++++++++++
>  3 files changed, 232 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/contiguous-memory.txt
> 
> diff --git a/Documentation/devicetree/bindings/contiguous-memory.txt b/Documentation/devicetree/bindings/contiguous-memory.txt
> new file mode 100644
> index 0000000..a733df2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/contiguous-memory.txt
> @@ -0,0 +1,94 @@
> +*** Contiguous Memory binding ***
> +
> +The /chosen/contiguous-memory node provides runtime configuration of
> +contiguous memory regions for Linux kernel. Such regions can be created
> +for special usage by various device drivers. A good example are
> +contiguous memory allocations or memory sharing with other operating
> +system(s) on the same hardware board. Those special memory regions might
> +depend on the selected board configuration and devices used on the target
> +system.
> +
> +Parameters for each memory region can be encoded into the device tree
> +with the following convention:
> +
> +contiguous-memory {
> +
> +	(name): region@(base-address) {
> +		reg = <(baseaddr) (size)>;
> +		(linux,default-contiguous-region);
> +		device = <&device_0 &device_1 ...>
> +	};
> +};
> +
> +name:		an name given to the defined region;
> +base-address:	the base address of the defined region;
> +size:		the size of the memory region (bytes);
> +linux,default-contiguous-region: property indicating that the region
> +		is the default region for all contiguous memory
> +		allocations, Linux specific (optional);
> +device:		array of phandles to the client device nodes, which
> +		will use the defined contiguous region.
> +
> +Each defined region must use unique name. It is optional to specify the
> +base address, so if one wants to use autoconfiguration of the base
> +address, he must specify the '0' as base address in the 'reg' property
> +and assign ann uniqe name to such regions, following the convention:
> +'region at 0', 'region at 1', 'region at 2', ...
> +
> +
> +*** Example ***
> +
> +This example defines a memory configuration containing 2 contiguous
> +regions for Linux kernel, one default of all device drivers (named
> +contig_mem, autoconfigured at boot time, 64MiB) and one dedicated to the
> +framebuffer device (named display_mem, placed at 0x78000000, 64MiB). The
> +display_mem region is then assigned to fb at 12300000, scaller at 12500000 and
> +codec at 12600000 devices for contiguous memory allocation with Linux
> +kernel drivers.
> +
> +The reason for creating a separate region for framebuffer device is to
> +match the framebuffer base address to the one configured by bootloader,
> +so once Linux kernel drivers starts no glitches on the displayed boot
> +logo appears. Scaller and codec drivers should share the memory
> +allocations with framebuffer driver.
> +
> +/ {
> +	/* ... */
> +
> +	chosen {
> +		bootargs = /* ... */
> +
> +		contiguous-memory {
> +
> +			/*
> +			 * global autoconfigured region
> +			 * for contiguous allocations
> +			 */
> +			contig_mem: region at 0 {
> +				reg = <0x0 0x4000000>;
> +				linux,default-contiguous-region;
> +			};
> +
> +			/*
> +			 * special region for framebuffer and
> +			 * multimedia processing devices
> +			 */
> +			display_mem: region at 78000000 {
> +				reg = <0x78000000 0x4000000>;
> +				device = <&fb0 &scaller &codec>;
> +			};
> +		};
> +	};
> +
> +	/* ... */
> +
> +	fb0: fb at 12300000 {
> +		status = "okay";
> +	};
> +	scaller: scaller at 12500000 {
> +		status = "okay";
> +	};
> +	codec: codec at 12600000 {
> +		status = "okay";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/skeleton.dtsi b/arch/arm/boot/dts/skeleton.dtsi
> index b41d241..cadc3b9 100644
> --- a/arch/arm/boot/dts/skeleton.dtsi
> +++ b/arch/arm/boot/dts/skeleton.dtsi
> @@ -7,7 +7,12 @@
>  / {
>  	#address-cells = <1>;
>  	#size-cells = <1>;
> -	chosen { };
> +	chosen {
> +		contiguous-memory {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +		};
> +	};
>  	aliases { };
>  	memory { device_type = "memory"; reg = <0 0>; };
>  };
> diff --git a/drivers/base/dma-contiguous.c b/drivers/base/dma-contiguous.c
> index 01fe743..ce5f5d1 100644
> --- a/drivers/base/dma-contiguous.c
> +++ b/drivers/base/dma-contiguous.c
> @@ -24,6 +24,9 @@
>  
>  #include <linux/memblock.h>
>  #include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_platform.h>
>  #include <linux/mm.h>
>  #include <linux/mutex.h>
>  #include <linux/page-isolation.h>
> @@ -37,6 +40,7 @@ struct cma {
>  	unsigned long	base_pfn;
>  	unsigned long	count;
>  	unsigned long	*bitmap;
> +	char		full_name[32];
>  };
>  
>  static DEFINE_MUTEX(cma_mutex);
> @@ -133,6 +137,52 @@ static __init int cma_activate_area(struct cma *cma)
>  	return 0;
>  }
>  
> +/*****************************************************************************/
> +
> +#ifdef CONFIG_OF

> +int __init cma_fdt_scan(unsigned long node, const char *uname,
> +				int depth, void *data)

It can be made static.

Also some documentation to this function on why it always returns 0
would be nice because it is not obvious (even if device tree description
for one memory base contains errors or fails dma_contiguous_reserve_area()
init the function will still try to parse descriptions for all other
memory bases).

> +{
> +	static int level;
> +	phys_addr_t base, size;
> +	unsigned long len;
> +	struct cma *cma;
> +	__be32 *prop;
> +	int ret;
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
> +	prop = of_get_flat_dt_prop(node, "reg", &len);
> +	if (!prop || (len != 2 * sizeof(unsigned long)))
> +		return 0;

Maybe it would be good to print an error on hitting this condition.

> +	base = be32_to_cpu(prop[0]);
> +	size = be32_to_cpu(prop[1]);

I'm not sure whether this is correct on 64-bit architectures which would
want to use 64-bit base and size (of_get_flat_dt_prop() returns void *
not __be32 *). 

Shouldn't it be something like:

	if (sizeof(unsigned long) == 4) {
		base = be32_to_cpu(prop[0]);
		size = be32_to_cpu(prop[1]);
	} else {
		base = be64_to_cpu(prop[0]);
		size = be64_to_cpu(prop[1]);
	}

?

> +	pr_info("Found %s, memory base %lx, size %ld MiB\n", uname,
> +		(unsigned long)base, (unsigned long)size / SZ_1M);
> +
> +	ret = dma_contiguous_reserve_area(size, base, 0, &cma);
> +	if (ret == 0) {
> +		strcpy(cma->full_name, uname);
> +		if (of_get_flat_dt_prop(node, "linux,default-contiguous-region", NULL))
> +			dma_contiguous_default_area = cma;
> +	}
> +	return 0;
> +}
> +#endif
> +
>  /**
>   * dma_contiguous_reserve() - reserve area(s) for contiguous memory handling
>   * @limit: End address of the reserved memory (optional, 0 for any).
> @@ -149,6 +199,10 @@ void __init dma_contiguous_reserve(phys_addr_t limit)
>  
>  	pr_debug("%s(limit %08lx)\n", __func__, (unsigned long)limit);
>  
> +#ifdef CONFIG_OF
> +	of_scan_flat_dt(cma_fdt_scan, NULL);
> +#endif
> +
>  	if (size_cmdline != -1) {
>  		sel_size = size_cmdline;
>  	} else {
> @@ -265,6 +319,80 @@ int __init dma_contiguous_add_device(struct device *dev, struct cma *cma)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +
> +#define MAX_CMA_MAPS	64
> +
> +static struct cma_map {
> +	struct cma *cma;
> +	struct device_node *node;
> +} cma_maps[MAX_CMA_MAPS];
> +static unsigned cma_map_count;
> +
> +static void cma_assign_device_from_dt(struct device *dev)
> +{
> +	int i;
> +	for (i = 0; i < cma_map_count; i++) {
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

It can be made:

static void __init scan_cma_nodes(void)

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
> +		for (i = 0; i < cma_area_count; i++) {
> +			char *p = strrchr(child->full_name, '/') + 1;
> +			if (strcmp(p, cma_areas[i].full_name) == 0)
> +				cma = &cma_areas[i];
> +		}
> +		if (!cma)
> +			continue;
> +
> +		for (i = 0;; i++) {
> +			struct device_node *node;
> +			node = of_parse_phandle(child, "device", i);
> +			if (!node)
> +				break;
> +
> +			if (cma_map_count < MAX_CMA_MAPS) {
> +				cma_maps[cma_map_count].cma = cma;
> +				cma_maps[cma_map_count].node = node;
> +				cma_map_count++;
> +			} else {
> +				pr_err("CMA error: too many devices defined\n");
> +			}
> +		}
> +	}
> +}
> +#endif
> +
>  static int __init cma_init_reserved_areas(void)
>  {
>  	int i;
> @@ -275,6 +403,10 @@ static int __init cma_init_reserved_areas(void)
>  			return ret;
>  	}
>  
> +#ifdef CONFIG_OF
> +	scan_cma_nodes();
> +	bus_register_notifier(&platform_bus_type, &cma_dev_init_nb);
> +#endif
>  	return 0;
>  }
>  core_initcall(cma_init_reserved_areas);

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
