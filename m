From: afzal.mohd.ma@gmail.com (Afzal Mohammed)
Date: Thu, 19 Jan 2017 18:51:48 +0530
Subject: [PATCH 1/4] ARM: mmu: decouple VECTORS_BASE from Kconfig
In-Reply-To: <20170118203739.6400-1-afzal.mohd.ma@gmail.com>
References: <20170118203525.6246-1-afzal.mohd.ma@gmail.com>
 <20170118203739.6400-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170119132148.GA3954@afzalpc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Marvell Berlin SoC maintainers - Sebastian, Jisheng

On Thu, Jan 19, 2017 at 02:07:39AM +0530, afzal mohammed wrote:
> For MMU configurations, VECTORS_BASE is always 0xffff0000, a macro
> definition will suffice.
> 
> Once exception address is handled dynamically for no-MMU also (this
> would involve taking care of region setup too), VECTORS_BASE can be
> removed from Kconfig.
> 
> Suggested-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
> 
> Though there was no build error without inclusion of asm/memory.h, to
> be on the safer side it has been added, to reduce chances of build
> breakage in random configurations.
> 
>  arch/arm/include/asm/memory.h  | 2 ++
>  arch/arm/mach-berlin/platsmp.c | 3 ++-
>  arch/arm/mm/dump.c             | 5 +++--
>  arch/arm/mm/init.c             | 4 ++--
>  4 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 76cbd9c674df..9cc9f1dbc88e 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -83,6 +83,8 @@
>  #define IOREMAP_MAX_ORDER	24
>  #endif
>  
> +#define VECTORS_BASE		0xffff0000
> +
>  #else /* CONFIG_MMU */
>  
>  /*
> diff --git a/arch/arm/mach-berlin/platsmp.c b/arch/arm/mach-berlin/platsmp.c
> index 93f90688db18..578d41031abf 100644
> --- a/arch/arm/mach-berlin/platsmp.c
> +++ b/arch/arm/mach-berlin/platsmp.c
> @@ -15,6 +15,7 @@
>  
>  #include <asm/cacheflush.h>
>  #include <asm/cp15.h>
> +#include <asm/memory.h>
>  #include <asm/smp_plat.h>
>  #include <asm/smp_scu.h>
>  
> @@ -75,7 +76,7 @@ static void __init berlin_smp_prepare_cpus(unsigned int max_cpus)
>  	if (!cpu_ctrl)
>  		goto unmap_scu;
>  
> -	vectors_base = ioremap(CONFIG_VECTORS_BASE, SZ_32K);
> +	vectors_base = ioremap(VECTORS_BASE, SZ_32K);
>  	if (!vectors_base)
>  		goto unmap_scu;
>  
> diff --git a/arch/arm/mm/dump.c b/arch/arm/mm/dump.c
> index 9fe8e241335c..21192d6eda40 100644
> --- a/arch/arm/mm/dump.c
> +++ b/arch/arm/mm/dump.c
> @@ -18,6 +18,7 @@
>  #include <linux/seq_file.h>
>  
>  #include <asm/fixmap.h>
> +#include <asm/memory.h>
>  #include <asm/pgtable.h>
>  
>  struct addr_marker {
> @@ -31,8 +32,8 @@ static struct addr_marker address_markers[] = {
>  	{ 0,			"vmalloc() Area" },
>  	{ VMALLOC_END,		"vmalloc() End" },
>  	{ FIXADDR_START,	"Fixmap Area" },
> -	{ CONFIG_VECTORS_BASE,	"Vectors" },
> -	{ CONFIG_VECTORS_BASE + PAGE_SIZE * 2, "Vectors End" },
> +	{ VECTORS_BASE,	"Vectors" },
> +	{ VECTORS_BASE + PAGE_SIZE * 2, "Vectors End" },
>  	{ -1,			NULL },
>  };
>  
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 370581aeb871..cf47f86f79ed 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -27,6 +27,7 @@
>  #include <asm/cp15.h>
>  #include <asm/mach-types.h>
>  #include <asm/memblock.h>
> +#include <asm/memory.h>
>  #include <asm/prom.h>
>  #include <asm/sections.h>
>  #include <asm/setup.h>
> @@ -521,8 +522,7 @@ void __init mem_init(void)
>  			"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
>  			"       .bss : 0x%p" " - 0x%p" "   (%4td kB)\n",
>  
> -			MLK(UL(CONFIG_VECTORS_BASE), UL(CONFIG_VECTORS_BASE) +
> -				(PAGE_SIZE)),
> +			MLK(UL(VECTORS_BASE), UL(VECTORS_BASE) + (PAGE_SIZE)),
>  #ifdef CONFIG_HAVE_TCM
>  			MLK(DTCM_OFFSET, (unsigned long) dtcm_end),
>  			MLK(ITCM_OFFSET, (unsigned long) itcm_end),
> -- 
> 2.11.0
