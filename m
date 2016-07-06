From: geoff@infradead.org (Geoff Levand)
Date: Wed, 06 Jul 2016 10:00:18 -0700
Subject: [PATCH v21 1/8] arm64: kdump: reserve memory for crash dump kernel
In-Reply-To: <20160706075226.27609-2-takahiro.akashi@linaro.org>
References: <20160706075226.27609-1-takahiro.akashi@linaro.org>
 <20160706075226.27609-2-takahiro.akashi@linaro.org>
Message-ID: <1467824418.8880.21.camel@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-07-06 at 16:52 +0900, AKASHI Takahiro wrote:
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
> +> 	> unsigned long long crash_size = 0, crash_base = 0;
> +> 	> int ret;
> +
> +> 	> ret = parse_crashkernel(boot_command_line, memblock_phys_mem_size(),
> +> 	> 	> 	> 	> &crash_size, &crash_base);
> +> 	> /* no crashkernel= or invalid value specified */
> +> 	> if (ret || !crash_size)
> +> 	> 	> return;
> +
> +> 	> if (crash_base == 0) {
> +> 	> 	> /* Current arm64 boot protocol requires 2MB alignment */
> +> 	> 	> crash_base = memblock_find_in_range(0,
> +> 	> 	> 	> 	> MEMBLOCK_ALLOC_ACCESSIBLE, crash_size, SZ_2M);
> +> 	> 	> if (crash_base == 0) {
> +> 	> 	> 	> pr_warn("Unable to allocate crashkernel (size:%llx)\n",
> +> 	> 	> 	> 	> crash_size);
> +> 	> 	> 	> return;
> +> 	> 	> }
> +> 	> 	> memblock_reserve(crash_base, crash_size);
> +
> +> 	> } else {
> +> 	> 	> /* User specifies base address explicitly. */
> +> 	> 	> if (!memblock_is_region_memory(crash_base, crash_size) ||
> +> 	> 	> 	> memblock_is_region_reserved(crash_base, crash_size)) {
> +> 	> 	> 	> pr_warn("crashkernel has wrong address or size\n");
> +> 	> 	> 	> return;
> +> 	> 	> }
> +
> +> 	> 	> if (!IS_ALIGNED(crash_base, SZ_2M)) {
> +> 	> 	> 	> pr_warn("crashkernel base address is not 2MB aligned\n");
> +> 	> 	> 	> return;
> +> 	> 	> }
> +
> +> 	> 	> memblock_reserve(crash_base, crash_size);
> +> 	> }
> +
> +> 	> pr_info("Reserving %lldMB of memory at %lldMB for crashkernel\n",
> +> 	> 	> crash_size >> 20, crash_base >> 20);
> +
> +> 	> crashk_res.start = crash_base;
> +> 	> crashk_res.end = crash_base + crash_size - 1;
> +}
> +#else
> +static void __init reserve_crashkernel(void)
> +{
> +> 	> ;
> +}
> +#endif /* CONFIG_KEXEC_CORE */
> +

I think it is a bit cleaner if you move this conditional
into the function and have something like:

static void __init reserve_crashkernel(void)
{
#ifdef CONFIG_KEXEC_CORE
#else
#endif
}

-Geoff
