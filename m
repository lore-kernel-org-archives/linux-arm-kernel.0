From: james.morse@arm.com (James Morse)
Date: Fri, 18 Mar 2016 18:08:30 +0000
Subject: [PATCH v15 15/20] arm64: kdump: reserve memory for crash dump
 kernel
In-Reply-To: <1083d7e4a6285c39d2955fb99dc9fa4c345d00fa.1457977403.git.geoff@infradead.org>
References: <cover.1457977401.git.geoff@infradead.org>
 <1083d7e4a6285c39d2955fb99dc9fa4c345d00fa.1457977403.git.geoff@infradead.org>
Message-ID: <56EC441E.2040606@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 14/03/16 17:48, Geoff Levand wrote:
> From: AKASHI Takahiro <takahiro.akashi@linaro.org>
> 
> On the startup of primary kernel, the memory region used by crash dump
> kernel must be specified by "crashkernel=" kernel parameter.
> reserve_crashkernel() will allocate and reserve the region for later use.
> 
> User space tools, like kexec-tools, will be able to find that region marked
> as "Crash kernel" in /proc/iomem.

[NB: Re-ordered diff hunks ]

> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index 7802f21..4edf181 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -171,6 +229,8 @@ void __init arm64_memblock_init(void)
>  		memblock_reserve(__virt_to_phys(initrd_start), initrd_end - initrd_start);
>  #endif
>
> +	reserve_crashkernel();
> +
>  	early_init_fdt_scan_reserved_mem();
>
>  	/* 4GB maximum for 32-bit only capable devices */
>


This is 'nit' territory, but if you were to make this:
>	if (IS_ENABLED(CONFIG_KEXEC_CORE))
>		reserve_crashkernel();

then the #ifdefs around reserve_crashkernel() can go, and the compiler will work
out that this static function can be optimised out. It also means the
compiler performs its checks, even if CONFIG_KEXEC_CORE isn't selected. The same
trick can be applied in patch 18 (around reserve_elfcorehdr()).


> @@ -66,6 +67,63 @@ static int __init early_initrd(char *p)
>  early_param("initrd", early_initrd);
>  #endif
>  
> +#ifdef CONFIG_KEXEC_CORE
> +/*
> + * reserve_crashkernel() - reserves memory for crash kernel
> + *
> + * This function reserves memory area given in "crashkernel=" kernel command
> + * line parameter. The memory reserved is used by dump capture kernel when
> + * primary kernel is crashing.
> + */
> +static void __init reserve_crashkernel(void)
> +{
> +	unsigned long long crash_size = 0, crash_base = 0;
> +	int ret;
> +
> +	ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +				&crash_size, &crash_base);
> +	if (ret)
> +		return;
> +
> +	if (crash_base == 0) {
> +		crash_base = memblock_find_in_range(0,
> +				MEMBLOCK_ALLOC_ACCESSIBLE, crash_size, 1 << 21);
> +		if (crash_base == 0) {
> +			pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> +				crash_size);
> +			return;
> +		}
> +		memblock_reserve(crash_base, crash_size);
> +
> +	} else {
> +		/* User specifies base address explicitly. */
> +		if (!memblock_is_region_memory(crash_base, crash_size) ||
> +			memblock_is_region_reserved(crash_base, crash_size)) {
> +			pr_warn("crashkernel has wrong address or size\n");
> +			return;
> +		}
> +
> +		if (crash_base & ((1 << 21) - 1)) {
> +			pr_warn("crashkernel base address is not 2MB aligned\n");
> +			return;
> +		}
> +
> +		memblock_reserve(crash_base, crash_size);
> +	}
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
> +}
> +#endif /* CONFIG_KEXEC_CORE */
> +
>  /*
>   * Return the maximum physical address for ZONE_DMA (DMA_BIT_MASK(32)). It
>   * currently assumes that for memory starting above 4G, 32-bit devices will


Thanks,

James
