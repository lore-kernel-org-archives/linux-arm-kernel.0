From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Nov 2014 11:12:33 +0000
Subject: [PATCH v4] arm: Support for the PXN CPU feature on ARMv7
In-Reply-To: <1417077724-15885-1-git-send-email-js07.lee@gmail.com>
References: <1417077724-15885-1-git-send-email-js07.lee@gmail.com>
Message-ID: <20141127111233.GC11511@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 08:42:04AM +0000, Jungseung Lee wrote:
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -52,6 +52,8 @@ EXPORT_SYMBOL(empty_zero_page);
>   */
>  pmd_t *top_pmd;
>  
> +pmdval_t user_pmd_table = _PAGE_USER_TABLE;
> +
>  #define CPOLICY_UNCACHED	0
>  #define CPOLICY_BUFFERED	1
>  #define CPOLICY_WRITETHROUGH	2
> @@ -537,6 +539,14 @@ static void __init build_mem_type_table(void)
>  	if (cpu_arch == CPU_ARCH_ARMv6)
>  		vecs_pgprot |= L_PTE_MT_VECTORS;
>  #endif
> +	/*
> +	 * Check is it with support for the PXN bit
> +	 * in the Short-descriptor translation table format descriptors.
> +	 */
> +	if (cpu_arch == CPU_ARCH_ARMv7 &&
> +		(read_cpuid_ext(CPUID_EXT_MMFR0) & 0xF) == 4) {
> +		user_pmd_table |= PMD_PXNTABLE;
> +	}

While user_pmd_table isn't used with LPAE, I would still add a
!IS_ENABLED(CONFIG_ARM_LPAE) to the conditions above (or include this
hunk in the above #ifndef .. #endif block). The reason is that someone
may later decide to use user_pmd_table for LPAE as well and we forgot
about this.

Otherwise:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
