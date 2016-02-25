From: stefan@agner.ch (Stefan Agner)
Date: Thu, 25 Feb 2016 10:26:40 -0800
Subject: [PATCH] arm: fixmap: Annotate page flags with pgprot
In-Reply-To: <1456422178-1371-1-git-send-email-suzuki.poulose@arm.com>
References: <1456422178-1371-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1b0356923b2008f3133580174abba4e8@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-02-25 09:42, Suzuki K Poulose wrote:
> With STRICT_MM_TYPECHECKS, the kernel build fails like :
> 
>   CC      mm/early_ioremap.o
> mm/early_ioremap.c: In function ?early_ioremap?:
> mm/early_ioremap.c:211:2: error: incompatible type for argument 3 of
> ?__early_ioremap?
> mm/early_ioremap.c:98:1: note: expected ?pgprot_t? but argument is of
> type ?long long unsigned int?
> mm/early_ioremap.c: In function ?early_memremap?:
> mm/early_ioremap.c:219:13: error: incompatible type for argument 3 of
> ?__early_ioremap?
> mm/early_ioremap.c:98:1: note: expected ?pgprot_t? but argument is of
> type ?long long unsigned int?
> mm/early_ioremap.c: In function ?early_memremap_ro?:
> mm/early_ioremap.c:225:2: error: incompatible type for argument 3 of
> ?__early_ioremap?
> mm/early_ioremap.c:98:1: note: expected ?pgprot_t? but argument is of
> type ?long long unsigned int?
> mm/early_ioremap.c:226:1: warning: control reaches end of non-void
> function [-Wreturn-type]
> mm/early_ioremap.c: In function ?early_memremap?:
> mm/early_ioremap.c:220:1: warning: control reaches end of non-void
> function [-Wreturn-type]
> mm/early_ioremap.c: In function ?early_ioremap?:
> mm/early_ioremap.c:212:1: warning: control reaches end of non-void
> function [-Wreturn-type]
> make[1]: *** [mm/early_ioremap.o] Error 1
> make: *** [mm] Error 2
> make: *** Waiting for unfinished jobs....
>   CC      arch/arm/mm/mmu.o
>   CC      arch/arm/kernel/patch.o
> arch/arm/kernel/patch.c: In function ?patch_map?:
> arch/arm/kernel/patch.c:39:2: error: incompatible type for argument 3
> of ?__set_fixmap?
> ./arch/arm/include/asm/fixmap.h:55:6: note: expected ?pgprot_t? but
> argument is of type ?long long unsigned int?
> make[1]: *** [arch/arm/kernel/patch.o] Error 1
> 
> Fixes Commit a5f4c561b ("ARM: 8415/1: early fixmap support for earlycon").
> 
> Annotate the page flags properly using __pgprot.

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> 
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: stable at vger.kernel.org	# v4.3+
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  arch/arm/include/asm/fixmap.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/include/asm/fixmap.h b/arch/arm/include/asm/fixmap.h
> index 5c17d2d..8d48d5a 100644
> --- a/arch/arm/include/asm/fixmap.h
> +++ b/arch/arm/include/asm/fixmap.h
> @@ -39,13 +39,13 @@ static const enum fixed_addresses __end_of_fixed_addresses =
>  	__end_of_fixmap_region > __end_of_early_ioremap_region ?
>  	__end_of_fixmap_region : __end_of_early_ioremap_region;
>  
> -#define FIXMAP_PAGE_COMMON	(L_PTE_YOUNG | L_PTE_PRESENT | L_PTE_XN |
> L_PTE_DIRTY)
> +#define FIXMAP_PAGE_COMMON	__pgprot(L_PTE_YOUNG | L_PTE_PRESENT |
> L_PTE_XN | L_PTE_DIRTY)
>  
> -#define FIXMAP_PAGE_NORMAL	(FIXMAP_PAGE_COMMON | L_PTE_MT_WRITEBACK)
> -#define FIXMAP_PAGE_RO		(FIXMAP_PAGE_NORMAL | L_PTE_RDONLY)
> +#define FIXMAP_PAGE_NORMAL	__pgprot(pgprot_val(FIXMAP_PAGE_COMMON) |
> L_PTE_MT_WRITEBACK)
> +#define FIXMAP_PAGE_RO		__pgprot(pgprot_val(FIXMAP_PAGE_NORMAL) | L_PTE_RDONLY)
>  
>  /* Used by set_fixmap_(io|nocache), both meant for mapping a device */
> -#define FIXMAP_PAGE_IO		(FIXMAP_PAGE_COMMON | L_PTE_MT_DEV_SHARED |
> L_PTE_SHARED)
> +#define FIXMAP_PAGE_IO		__pgprot(pgprot_val(FIXMAP_PAGE_COMMON) |
> L_PTE_MT_DEV_SHARED | L_PTE_SHARED)
>  #define FIXMAP_PAGE_NOCACHE	FIXMAP_PAGE_IO
>  
>  #define __early_set_fixmap	__set_fixmap
