From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 12:08:16 +0000
Subject: [PATCH 6/7] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <1258977782.8088.10.camel@pc1117.cambridge.arm.com>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<1258977782.8088.10.camel@pc1117.cambridge.arm.com>
Message-ID: <20091123120816.GA18142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2009 at 12:03:02PM +0000, Catalin Marinas wrote:
> Does this mean that the direction information is lost after this point?
> My only issue with this is that in the FROM_DEVICE case we use a clean
> operation before the transfer even though an invalidate would be enough
> and probably faster.

Yes we do.  In the long run, I'd like to change dmac_*_range to be
dmac_map_range and dmac_unmap_range, taking the direction argument.
The problem at the moment is the highmem page stuff gets rather messy
and less efficient to go that far.

> > --- a/arch/arm/mm/dma-mapping.c
> > +++ b/arch/arm/mm/dma-mapping.c
> > @@ -539,58 +539,40 @@ core_initcall(consistent_init);
> >   * platforms with CONFIG_DMABOUNCE.
> >   * Use the driver DMA support - see dma-mapping.h (dma_sync_*)
> >   */
> > -void dma_cache_maint(const void *start, size_t size, int direction)
> > +void __dma_cache_maint(const void *start, size_t size, int map)
> >  {
> >         void (*inner_op)(const void *, const void *);
> >         void (*outer_op)(unsigned long, unsigned long);
> > 
> >         BUG_ON(!virt_addr_valid(start) || !virt_addr_valid(start + size - 1));
> > 
> > -       switch (direction) {
> > -       case DMA_FROM_DEVICE:           /* invalidate only */
> > -               inner_op = dmac_inv_range;
> > -               outer_op = outer_inv_range;
> > -               break;
> > -       case DMA_TO_DEVICE:             /* writeback only */
> > +       if (map) {              /* writeback only */
> >                 inner_op = dmac_clean_range;
> >                 outer_op = outer_clean_range;
> > -               break;
> > -       case DMA_BIDIRECTIONAL:         /* writeback and invalidate */
> > -               inner_op = dmac_flush_range;
> > -               outer_op = outer_flush_range;
> > -               break;
> > -       default:
> > -               BUG();
> > +       } else {                /* invalidate only */
> > +               inner_op = dmac_inv_range;
> > +               outer_op = outer_inv_range;
> >         }
> > 
> >         inner_op(start, start + size);
> >         outer_op(__pa(start), __pa(start) + size);
> >  }
> 
> Since we have real issues with speculative accesses, for the !map case,
> we need to invalidate the outer cache before the inner cache. I think it
> just makes sense to avoid the inner_op and outer_op pointers.

Yes, good catch.
