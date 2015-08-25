From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 25 Aug 2015 08:01:32 -0700 (PDT)
Subject: [RFC] arm: change some function and data to init section
In-Reply-To: <1440488173-28825-1-git-send-email-yalin.wang2010@gmail.com>
References: <1440488173-28825-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <alpine.LFD.2.20.1508250800090.21591@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Aug 2015, yalin wang wrote:

> This patch change some function and the related data to init section,
> they are only called by free_initmem(), can be freed safely after
> boot up.

The magic keyword here is __init_refok.

> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/mm/init.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 8a63b4c..7b505de 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -577,7 +577,7 @@ struct section_perm {
>  	pmdval_t clear;
>  };
>  
> -static struct section_perm nx_perms[] = {
> +static struct section_perm nx_perms[] __initdata = {
>  	/* Make pages tables, etc before _stext RW (set NX). */
>  	{
>  		.start	= PAGE_OFFSET,
> @@ -680,7 +680,7 @@ static inline bool arch_has_strict_perms(void)
>  	}								\
>  }
>  
> -static inline void fix_kernmem_perms(void)
> +static void __init fix_kernmem_perms(void)
>  {
>  	set_section_perms(nx_perms, prot);
>  }
> @@ -706,7 +706,7 @@ void set_kernel_text_ro(void)
>  static inline void fix_kernmem_perms(void) { }
>  #endif /* CONFIG_ARM_KERNMEM_PERMS */
>  
> -void free_tcmmem(void)
> +static void __init free_tcmmem(void)
>  {
>  #ifdef CONFIG_HAVE_TCM
>  	extern char __tcm_start, __tcm_end;
> @@ -716,7 +716,7 @@ void free_tcmmem(void)
>  #endif
>  }
>  
> -void free_initmem(void)
> +void __init_refok free_initmem(void)
>  {
>  	fix_kernmem_perms();
>  	free_tcmmem();
> @@ -728,9 +728,9 @@ void free_initmem(void)
>  
>  #ifdef CONFIG_BLK_DEV_INITRD
>  
> -static int keep_initrd;
> +static int keep_initrd __initdata;
>  
> -void free_initrd_mem(unsigned long start, unsigned long end)
> +void __init free_initrd_mem(unsigned long start, unsigned long end)
>  {
>  	if (!keep_initrd) {
>  		if (start == initrd_start)
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
