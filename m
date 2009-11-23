From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Nov 2009 12:03:02 +0000
Subject: [PATCH 6/7] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
Message-ID: <1258977782.8088.10.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2009-11-20 at 18:06 +0000, Russell King - ARM Linux wrote:
> Rather than handing all cache maintainence before DMA begins, we
> also need to handle cache maintainence upon completion when we
> have CPUs which prefetch speculatively.
> 
> This renames the dma_cache_maint*() functions, and changes their
> parameters to indicate whether we are mapping a DMA buffer.  We
> always clean DMA buffers when we map them, but avoid invalidating
> them if we are DMA'ing to the device.
[...]
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
[...]
> @@ -70,6 +70,11 @@ extern void dma_cache_maint_page(struct page *page, unsigned long offset,
>   * by it) or exclusively owned by the DMA device.  These helper functions
>   * represent the transitions between these two ownership states.
>   *
> + * Note, however, that on later ARMs, this notion does not work due to
> + * speculative prefetches.  We model our approach on the assumption that
> + * the CPU does do speculative prefetches, which means we clean caches
> + * before transfers and delay cache invalidation until transfer completion.
> + *
>   * As above, these are private support functions and not part of the API.
>   * Drivers must not use these.
>   */
> @@ -77,26 +82,32 @@ static inline void __dma_single_cpu_to_dev(const void *kaddr, size_t size,
>         enum dma_data_direction dir)
>  {
>         if (!arch_is_coherent())
> -               dma_cache_maint(kaddr, size, dir);
> +               __dma_cache_maint(kaddr, size, 1);
>  }
[...]
>  static inline void __dma_page_cpu_to_dev(struct page *page, unsigned long off,
>         size_t size, enum dma_data_direction dir)
>  {
>         if (!arch_is_coherent())
> -               dma_cache_maint_page(page, off, size, dir);
> +               __dma_cache_maint_page(page, off, size, 1);
>  }

Does this mean that the direction information is lost after this point?
My only issue with this is that in the FROM_DEVICE case we use a clean
operation before the transfer even though an invalidate would be enough
and probably faster.

But I agree that it's a nice simplification.

> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -539,58 +539,40 @@ core_initcall(consistent_init);
>   * platforms with CONFIG_DMABOUNCE.
>   * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
>   */
> -void dma_cache_maint(const void *start, size_t size, int direction)
> +void __dma_cache_maint(const void *start, size_t size, int map)
>  {
>         void (*inner_op)(const void *, const void *);
>         void (*outer_op)(unsigned long, unsigned long);
> 
>         BUG_ON(!virt_addr_valid(start) || !virt_addr_valid(start + size - 1));
> 
> -       switch (direction) {
> -       case DMA_FROM_DEVICE:           /* invalidate only */
> -               inner_op = dmac_inv_range;
> -               outer_op = outer_inv_range;
> -               break;
> -       case DMA_TO_DEVICE:             /* writeback only */
> +       if (map) {              /* writeback only */
>                 inner_op = dmac_clean_range;
>                 outer_op = outer_clean_range;
> -               break;
> -       case DMA_BIDIRECTIONAL:         /* writeback and invalidate */
> -               inner_op = dmac_flush_range;
> -               outer_op = outer_flush_range;
> -               break;
> -       default:
> -               BUG();
> +       } else {                /* invalidate only */
> +               inner_op = dmac_inv_range;
> +               outer_op = outer_inv_range;
>         }
> 
>         inner_op(start, start + size);
>         outer_op(__pa(start), __pa(start) + size);
>  }

Since we have real issues with speculative accesses, for the !map case,
we need to invalidate the outer cache before the inner cache. I think it
just makes sense to avoid the inner_op and outer_op pointers.

-- 
Catalin
