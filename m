From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Thu, 19 Jan 2017 13:59:09 +0000
Subject: [PATCH 2/4] ARM: nommu: dynamic exception base address setting
In-Reply-To: <20170118203807.6467-1-afzal.mohd.ma@gmail.com>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
 <20170118203807.6467-1-afzal.mohd.ma@gmail.com>
Message-ID: <f47f7a48-12e9-7dd0-324d-b736eead3187@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 18/01/17 20:38, afzal mohammed wrote:
> No-MMU dynamic exception base address configuration on CP15
> processors. In the case of low vectors, decision based on whether
> security extensions are enabled & whether remap vectors to RAM
> CONFIG option is selected.
> 
> For no-MMU without CP15, current default value of 0x0 is retained.
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
>  arch/arm/mm/nommu.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index 2740967727e2..db8e784f20f3 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -11,6 +11,7 @@
>  #include <linux/kernel.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/cp15.h>
>  #include <asm/sections.h>
>  #include <asm/page.h>
>  #include <asm/setup.h>
> @@ -22,6 +23,8 @@
>  
>  #include "mm.h"
>  
> +unsigned long vectors_base;
> +
>  #ifdef CONFIG_ARM_MPU
>  struct mpu_rgn_info mpu_rgn_info;
>  
> @@ -278,15 +281,72 @@ static void sanity_check_meminfo_mpu(void) {}
>  static void __init mpu_setup(void) {}
>  #endif /* CONFIG_ARM_MPU */
>  
> +#ifdef CONFIG_CPU_CP15
> +#ifdef CONFIG_CPU_HIGH_VECTOR
> +static unsigned long __init setup_vectors_base(void)
> +{
> +	unsigned long reg = get_cr();
> +
> +	set_cr(reg | CR_V);
> +	return 0xffff0000;
> +}
> +#else /* CONFIG_CPU_HIGH_VECTOR */
> +/*
> + * ID_PRF1 bits (CP#15 ID_PFR1)
> + */
> +#define ID_PFR1_SE (0x3 << 4)	/* Security extension enable bits */

This bitfiled is 4 bits wide.

> +
> +/* Read processor feature register ID_PFR1 */
> +static unsigned long get_id_pfr1(void)
> +{
> +	unsigned long val;
> +
> +	asm("mrc p15, 0, %0, c0, c1, 1" : "=r" (val) : : "cc");
> +	return val;
> +}
> +
> +/* Write exception base address to VBAR */
> +static void set_vbar(unsigned long val)
> +{
> +	asm("mcr p15, 0, %0, c12, c0, 0" : : "r" (val) : "cc");
> +}
> +
> +static bool __init security_extensions_enabled(void)
> +{
> +	return !!(get_id_pfr1() & ID_PFR1_SE);
> +}
> +
> +static unsigned long __init setup_vectors_base(void)
> +{
> +	unsigned long base = 0, reg = get_cr();
> +
> +	set_cr(reg & ~CR_V);
> +	if (security_extensions_enabled()) {

You can use

    cpuid_feature_extract(CPUID_EXT_PFR1, 4)
    
and add a comment explaining what we are looking for and why.

> +		if (IS_ENABLED(CONFIG_REMAP_VECTORS_TO_RAM))
> +			base = CONFIG_DRAM_BASE;
> +		set_vbar(base);
> +	} else if (IS_ENABLED(CONFIG_REMAP_VECTORS_TO_RAM)) {
> +		if (CONFIG_DRAM_BASE != 0)
> +			pr_err("Security extensions not enabled, vectors cannot be remapped to RAM, vectors base will be 0x00000000\n");
> +	}
> +
> +	return base;
> +}
> +#endif /* CONFIG_CPU_HIGH_VECTOR */
> +#endif /* CONFIG_CPU_CP15 */
> +
>  void __init arm_mm_memblock_reserve(void)
>  {
>  #ifndef CONFIG_CPU_V7M
> +#ifdef CONFIG_CPU_CP15
> +	vectors_base = setup_vectors_base();
> +#endif

alternatively it can be

	unsigned long vector_base = IS_ENABLED(CONFIG_CPU_CP15) ? setup_vbar() : 0;


Thanks
Vladimir

>  	/*
>  	 * Register the exception vector page.
>  	 * some architectures which the DRAM is the exception vector to trap,
>  	 * alloc_page breaks with error, although it is not NULL, but "0."
>  	 */
> -	memblock_reserve(CONFIG_VECTORS_BASE, 2 * PAGE_SIZE);
> +	memblock_reserve(vectors_base, 2 * PAGE_SIZE);
>  #else /* ifndef CONFIG_CPU_V7M */
>  	/*
>  	 * There is no dedicated vector page on V7-M. So nothing needs to be
> @@ -310,7 +370,7 @@ void __init sanity_check_meminfo(void)
>   */
>  void __init paging_init(const struct machine_desc *mdesc)
>  {
> -	early_trap_init((void *)CONFIG_VECTORS_BASE);
> +	early_trap_init((void *)vectors_base);
>  	mpu_setup();
>  	bootmem_init();
>  }
> 
