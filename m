From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 12 Aug 2016 13:43:45 +0100
Subject: [PATCH v3 4/4] arm64: apply __ro_after_init to some objects
In-Reply-To: <1470988871-2799-5-git-send-email-jszhang@marvell.com>
References: <1470988871-2799-1-git-send-email-jszhang@marvell.com>
 <1470988871-2799-5-git-send-email-jszhang@marvell.com>
Message-ID: <20160812124344.GB21484@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There are still a few missing includes as of this patch, and I have a
small nit about one file as commented below.

Please fix up the includes.

On Fri, Aug 12, 2016 at 04:01:11PM +0800, Jisheng Zhang wrote:
> diff --git a/arch/arm64/kernel/cpu_ops.c b/arch/arm64/kernel/cpu_ops.c
> index c7cfb8f..6d32d1a 100644
> --- a/arch/arm64/kernel/cpu_ops.c
> +++ b/arch/arm64/kernel/cpu_ops.c
> @@ -28,7 +28,7 @@ extern const struct cpu_operations smp_spin_table_ops;
>  extern const struct cpu_operations acpi_parking_protocol_ops;
>  extern const struct cpu_operations cpu_psci_ops;
>  
> -const struct cpu_operations *cpu_ops[NR_CPUS];
> +const struct cpu_operations *cpu_ops[NR_CPUS] __ro_after_init;

This file is missing a <linux/cache.h> include for __ro_after_init.

>  static const struct cpu_operations *dt_supported_cpu_ops[] __initconst = {
>  	&smp_spin_table_ops,
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 8ebabc4..93c47e1 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -20,7 +20,7 @@
>  #include <asm/pgtable.h>
>  #include <asm/sections.h>
>  
> -u64 module_alloc_base __read_mostly;
> +u64 module_alloc_base __ro_after_init;

Likewise.

>  u16 memstart_offset_seed __initdata;
>  
>  static __init u64 get_kaslr_seed(void *fdt)
> diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> index 10ad8ab..c1ff7c2 100644
> --- a/arch/arm64/kernel/vdso.c
> +++ b/arch/arm64/kernel/vdso.c
> @@ -19,6 +19,7 @@
>   */
>  
>  #include <linux/kernel.h>
> +#include <linux/cache.h>
>  #include <linux/clocksource.h>
>  #include <linux/elf.h>
>  #include <linux/err.h>

Nit: Could you please sort this list? Everything but <linux/kernel.h> is
already in order.

> diff --git a/arch/arm64/mm/dma-mapping.c b/arch/arm64/mm/dma-mapping.c
> index c4284c4..59d44e7 100644
> --- a/arch/arm64/mm/dma-mapping.c
> +++ b/arch/arm64/mm/dma-mapping.c
> @@ -30,7 +30,7 @@
>  
>  #include <asm/cacheflush.h>
>  
> -static int swiotlb __read_mostly;
> +static int swiotlb __ro_after_init;

This file is missing a <linux/cache.h> include for __ro_after_init.

>  
>  static pgprot_t __get_dma_pgprot(unsigned long attrs, pgprot_t prot,
>  				 bool coherent)
> diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
> index bbb7ee7..e8b81ea 100644
> --- a/arch/arm64/mm/init.c
> +++ b/arch/arm64/mm/init.c
> @@ -55,8 +55,8 @@
>   * executes, which assigns it its actual value. So use a default value
>   * that cannot be mistaken for a real physical address.
>   */
> -s64 memstart_addr __read_mostly = -1;
> -phys_addr_t arm64_dma_phys_limit __read_mostly;
> +s64 memstart_addr __ro_after_init = -1;
> +phys_addr_t arm64_dma_phys_limit __ro_after_init;

Likewise.

>  #ifdef CONFIG_BLK_DEV_INITRD
>  static int __init early_initrd(char *p)
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 4989948..6029bed 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -46,7 +46,7 @@
>  
>  u64 idmap_t0sz = TCR_T0SZ(VA_BITS);
>  
> -u64 kimage_voffset __read_mostly;
> +u64 kimage_voffset __ro_after_init;

Likewise.

Thanks,
Mark.
