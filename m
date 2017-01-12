From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 12 Jan 2017 15:09:26 +0000
Subject: [PATCH v29 3/9] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20161228043605.27470-2-takahiro.akashi@linaro.org>
References: <20161228043347.27358-1-takahiro.akashi@linaro.org>
 <20161228043605.27470-2-takahiro.akashi@linaro.org>
Message-ID: <20170112150926.GA12249@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

As a general note, I must apologise for my minimial review of the series
until this point. Judging by the way the DT parts are organised. I'm
very concerned with the way the DT parts are organised, and clearly I
did not communicate my concerns and suggestions effectively in prior
rounds of review.

On Wed, Dec 28, 2016 at 01:36:00PM +0900, AKASHI Takahiro wrote:
> "crashkernel=" kernel parameter specifies the size (and optionally
> the start address) of the system ram used by crash dump kernel.
> reserve_crashkernel() will allocate and reserve the memory at the startup
> of primary kernel.
> 
> This memory range will be exported to userspace via:
> 	- an entry named "Crash kernel" in /proc/iomem, and
> 	- "linux,crashkernel-base" and "linux,crashkernel-size" under
> 	  /sys/firmware/devicetree/base/chosen

> +#ifdef CONFIG_KEXEC_CORE
> +static unsigned long long crash_size, crash_base;
> +static struct property crash_base_prop = {
> +	.name = "linux,crashkernel-base",
> +	.length = sizeof(u64),
> +	.value = &crash_base
> +};
> +static struct property crash_size_prop = {
> +	.name = "linux,crashkernel-size",
> +	.length = sizeof(u64),
> +	.value = &crash_size,
> +};
> +
> +static int __init export_crashkernel(void)
> +{
> +	struct device_node *node;
> +	int ret;
> +
> +	if (!crash_size)
> +		return 0;
> +
> +	/* Add /chosen/linux,crashkernel-* properties */
> +	node = of_find_node_by_path("/chosen");
> +	if (!node)
> +		return -ENOENT;
> +
> +	/*
> +	 * There might be existing crash kernel properties, but we can't
> +	 * be sure what's in them, so remove them.
> +	 */
> +	of_remove_property(node, of_find_property(node,
> +				"linux,crashkernel-base", NULL));
> +	of_remove_property(node, of_find_property(node,
> +				"linux,crashkernel-size", NULL));
> +
> +	ret = of_add_property(node, &crash_base_prop);
> +	if (ret)
> +		goto ret_err;
> +
> +	ret = of_add_property(node, &crash_size_prop);
> +	if (ret)
> +		goto ret_err;
> +
> +	return 0;
> +
> +ret_err:
> +	pr_warn("Exporting crashkernel region to device tree failed\n");
> +	return ret;
> +}
> +late_initcall(export_crashkernel);

I very much do not like this.

I don't think we should be modifying the DT exposed to userspace in this
manner, in the usual boot path, especially given that the kernel itself
does not appear to be a consumer of this property. I do not think that
it is right to use the DT exposed to userspace as a communication
channel solely between the kernel and userspace.

So I think we should drop the above, and for arm64 have userspace
consistently use /proc/iomem (or perhaps a new kexec-specific file) to
determine the region reserved for the crash kernel, if it needs to know
this.

I'll have further comments on this front in the binding patch.

> +/*
> + * reserve_crashkernel() - reserves memory for crash kernel
> + *
> + * This function reserves memory area given in "crashkernel=" kernel command
> + * line parameter. The memory reserved is used by dump capture kernel when
> + * primary kernel is crashing.
> + */
> +static void __init reserve_crashkernel(void)
> +{
> +	int ret;
> +
> +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +				&crash_size, &crash_base);
> +	/* no crashkernel= or invalid value specified */
> +	if (ret || !crash_size)
> +		return;
> +
> +	if (crash_base == 0) {
> +		/* Current arm64 boot protocol requires 2MB alignment */
> +		crash_base = memblock_find_in_range(0, ARCH_LOW_ADDRESS_LIMIT,
> +				crash_size, SZ_2M);
> +		if (crash_base == 0) {
> +			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> +				crash_size);
> +			return;
> +		}
> +	} else {
> +		/* User specifies base address explicitly. */
> +		if (!memblock_is_region_memory(crash_base, crash_size) ||
> +			memblock_is_region_reserved(crash_base, crash_size)) {
> +			pr_warn("crashkernel has wrong address or size\n");
> +			return;
> +		}
> +
> +		if (!IS_ALIGNED(crash_base, SZ_2M)) {
> +			pr_warn("crashkernel base address is not 2MB aligned\n");
> +			return;
> +		}
> +	}
> +	memblock_reserve(crash_base, crash_size);

This will mean that the crash kernel will have a permanent alias in the linear
map which is vulnerable to being clobbered. There could also be issues
with mismatched attributes in future.

We're probably ok for now, but in future we'll likely want to fix this
up to remove the region (or mark it nomap), and only map it temporarily
when loading things into the region.

> +
> +	pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> +		crash_size >> 20, crash_base >> 20);
> +
> +	crashk_res.start = crash_base;
> +	crashk_res.end = crash_base + crash_size - 1;
> +}
> +#else
> +static void __init reserve_crashkernel(void)
> +{
> +	;

Nit: the ';' line can go.

> +}
> +#endif /* CONFIG_KEXEC_CORE */
> +
>  /*
>   * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
>   * currently assumes that for memory starting above 4G, 32-bit devices will
> @@ -331,6 +438,9 @@ void __init arm64_memblock_init(void)
>  		arm64_dma_phys_limit = max_zone_dma_phys();
>  	else
>  		arm64_dma_phys_limit = PHYS_MASK + 1;
> +
> +	reserve_crashkernel();
> +
>  	dma_contiguous_reserve(arm64_dma_phys_limit);
>  
>  	memblock_allow_resize();
> -- 
> 2.11.0

Other than my comments regarding the DT usage above, this looks fine to
me.

Thanks,
Mark.
