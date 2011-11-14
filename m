From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 14 Nov 2011 12:36:57 -0500 (EST)
Subject: [PATCH 1/2] ARM: use cache type functions for
 arch_get_unmapped_area
In-Reply-To: <1320709421-14469-1-git-send-email-robherring2@gmail.com>
References: <1320709421-14469-1-git-send-email-robherring2@gmail.com>
Message-ID: <alpine.LFD.2.02.1111141236200.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Nov 2011, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> There are already cache type decoding functions, so use those instead
> of custom decode code which only works for ARMv6.
> 
> This change also correctly enables cache colour alignment on Cortex-A9
> whose I-cache is aliasing VIPT.
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Acked-by: Nicolas Pitre <nico@linaro.org>


> ---
>  arch/arm/mm/mmap.c |   23 ++++++-----------------
>  1 files changed, 6 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm/mm/mmap.c b/arch/arm/mm/mmap.c
> index 74be05f..80e70ef 100644
> --- a/arch/arm/mm/mmap.c
> +++ b/arch/arm/mm/mmap.c
> @@ -9,8 +9,7 @@
>  #include <linux/io.h>
>  #include <linux/personality.h>
>  #include <linux/random.h>
> -#include <asm/cputype.h>
> -#include <asm/system.h>
> +#include <asm/cachetype.h>
>  
>  #define COLOUR_ALIGN(addr,pgoff)		\
>  	((((addr)+SHMLBA-1)&~(SHMLBA-1)) +	\
> @@ -32,25 +31,15 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
>  	struct mm_struct *mm = current->mm;
>  	struct vm_area_struct *vma;
>  	unsigned long start_addr;
> -#if defined(CONFIG_CPU_V6) || defined(CONFIG_CPU_V6K)
> -	unsigned int cache_type;
> -	int do_align = 0, aliasing = 0;
> +	int do_align = 0;
> +	int aliasing = cache_is_vipt_aliasing() || icache_is_vipt_aliasing();
>  
>  	/*
>  	 * We only need to do colour alignment if either the I or D
> -	 * caches alias.  This is indicated by bits 9 and 21 of the
> -	 * cache type register.
> +	 * caches alias.
>  	 */
> -	cache_type = read_cpuid_cachetype();
> -	if (cache_type != read_cpuid_id()) {
> -		aliasing = (cache_type | cache_type >> 12) & (1 << 11);
> -		if (aliasing)
> -			do_align = filp || flags & MAP_SHARED;
> -	}
> -#else
> -#define do_align 0
> -#define aliasing 0
> -#endif
> +	if (aliasing)
> +		do_align = filp || (flags & MAP_SHARED);
>  
>  	/*
>  	 * We enforce the MAP_FIXED case.
> -- 
> 1.7.5.4
> 
