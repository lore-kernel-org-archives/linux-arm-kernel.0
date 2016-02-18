From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 18 Feb 2016 10:55:59 -0500 (EST)
Subject: [PATCH 3/9] ARM: make free_memmap as __init
In-Reply-To: <1455804123-2526139-4-git-send-email-arnd@arndb.de>
References: <1455804123-2526139-1-git-send-email-arnd@arndb.de>
 <1455804123-2526139-4-git-send-email-arnd@arndb.de>
Message-ID: <alpine.LFD.2.20.1602181055320.13632@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Feb 2016, Arnd Bergmann wrote:

> free_memmap is an inline function, but gcc may choose to ignore that
> when CONFIG_OPTIMIZE_INLINING is set. In that case it is put in the
> .text section, causing a kbuild warning:
> 
> WARNING: vmlinux.o(.text.unlikely+0x1a0): Section mismatch in reference from the function free_memmap() to the function .init.text:__memblock_free_early()
> The function free_memmap() references
> the function __init __memblock_free_early().
> This is often because free_memmap lacks a __init
> annotation or the annotation of __memblock_free_early is wrong.
> 
> FATAL: modpost: Section mismatches detected.
> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
> 
> This marks the function both inline and __init, which is a
> correct annotation and avoids the problem.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
> index 370581aeb871..a4db267c35b2 100644
> --- a/arch/arm/mm/init.c
> +++ b/arch/arm/mm/init.c
> @@ -330,7 +330,7 @@ static inline void poison_init_mem(void *s, size_t count)
>  		*p++ = 0xe7fddef0;
>  }
>  
> -static inline void
> +static inline void __init
>  free_memmap(unsigned long start_pfn, unsigned long end_pfn)
>  {
>  	struct page *start_pg, *end_pg;
> -- 
> 2.7.0
> 
> 
