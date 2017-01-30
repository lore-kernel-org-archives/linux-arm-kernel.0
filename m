From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Jan 2017 14:03:26 +0000
Subject: [PATCH v2 3/4] ARM: nommu: display vectors base
In-Reply-To: <20170122032212.13456-1-afzal.mohd.ma@gmail.com>
References: <20170122031652.13074-1-afzal.mohd.ma@gmail.com>
 <20170122032212.13456-1-afzal.mohd.ma@gmail.com>
Message-ID: <20170130140326.GU27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 22, 2017 at 08:52:12AM +0530, afzal mohammed wrote:
> The exception base address is now dynamically estimated for no-MMU,
> display it. As it is the case, now limit VECTORS_BASE usage to MMU
> scenario.
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>

As I wrote elsewhere...

> diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
> index 0b5416fe7709..9ae474bf84fc 100644
> --- a/arch/arm/include/asm/memory.h
> +++ b/arch/arm/include/asm/memory.h
> @@ -83,6 +83,8 @@
>  #define IOREMAP_MAX_ORDER	24
>  #endif
>  
> +#define VECTORS_BASE		UL(0xffff0000)
> +
>  #else /* CONFIG_MMU */
>  
>  /*
> @@ -111,8 +113,6 @@
>  
>  #endif /* !CONFIG_MMU */
>  
> -#define VECTORS_BASE		UL(0xffff0000)

I think adding a definition for VECTORS_BASE in asm/memory.h for nommu:

extern unsigned long vectors_base;
#define VECTORS_BASE	vectors_base

> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 823e119a5daa..9c68e3aba87c 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -522,7 +522,12 @@ void __init mem_init(void)
>  			"      .data : 0x%p" " - 0x%p" "   (%4td kB)\n"
>  			"       .bss : 0x%p" " - 0x%p" "   (%4td kB)\n",
>  
> +#ifdef CONFIG_MMU
>  			MLK(VECTORS_BASE, VECTORS_BASE + PAGE_SIZE),
> +#else
> +			MLK(vectors_base, vectors_base + PAGE_SIZE),
> +#endif

will mean that this conditional becomes unnecessary.

> diff --git a/arch/arm/mm/mm.h b/arch/arm/mm/mm.h
> index ce727d47275c..546f09437fca 100644
> --- a/arch/arm/mm/mm.h
> +++ b/arch/arm/mm/mm.h
> @@ -79,8 +79,9 @@ struct static_vm {
>  extern struct list_head static_vmlist;
>  extern struct static_vm *find_static_vm_vaddr(void *vaddr);
>  extern __init void add_static_vm_early(struct static_vm *svm);
> -
> -#endif
> +#else /* CONFIG_MMU */
> +extern unsigned long vectors_base;
> +#endif /* CONFIG_MMU */

and you don't need this here either.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
