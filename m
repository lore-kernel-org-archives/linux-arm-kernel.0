From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Mar 2010 13:34:18 +0000
Subject: [PATCH] ARM: fix highmem with VIPT cache and DMA
In-Reply-To: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
References: <alpine.LFD.2.00.1003251638030.694@xanadu.home>
Message-ID: <1269610458.807.49.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2010-03-25 at 21:02 +0000, Nicolas Pitre wrote:
> --- a/arch/arm/include/asm/highmem.h
> +++ b/arch/arm/include/asm/highmem.h
> @@ -11,7 +11,11 @@
> 
>  #define kmap_prot              PAGE_KERNEL
> 
> -#define flush_cache_kmaps()    flush_cache_all()
> +#define flush_cache_kmaps() \
> +       do { \
> +               if (cache_is_vivt()) \
> +                       flush_cache_all(); \
> +       } while (0)

Do the aliasing VIPT caches need flushing as well?

> --- a/arch/arm/mm/highmem.c
> +++ b/arch/arm/mm/highmem.c
> @@ -79,7 +79,8 @@ void kunmap_atomic(void *kvaddr, enum km_type type)
>         unsigned int idx = type + KM_TYPE_NR * smp_processor_id();
> 
>         if (kvaddr >= (void *)FIXADDR_START) {
> -               __cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);
> +               if (cache_is_vivt())
> +                       __cpuc_flush_dcache_area((void *)vaddr, PAGE_SIZE);

Same here (and probably some other places in this patch, not sure).

-- 
Catalin
