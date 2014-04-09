From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 9 Apr 2014 12:15:15 +0100
Subject: [PATCH 2/3] ARM: mm: add support for HW coherent systems in PL310
In-Reply-To: <20140408201212.067d526d@skate>
References: <1395677872-32741-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1395677872-32741-3-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140408172424.GE16373@arm.com> <20140408201212.067d526d@skate>
Message-ID: <20140409111515.GE13737@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 08, 2014 at 07:12:12PM +0100, Thomas Petazzoni wrote:
> On Tue, 8 Apr 2014 18:24:25 +0100, Catalin Marinas wrote:
> > >  	of_init = true;
> > >  	memcpy(&outer_cache, &data->outer_cache, sizeof(outer_cache));
> > > +
> > > +	/*
> > > +	 * PL310 doesn't need an outer cache sync operation when the
> > > +	 * system is operating with hardware coherency enabled, as it
> > > +	 * is done directly in hardware.
> > > +	 */
> > > +	if (of_device_is_compatible(np, "arm,pl310-cache") && is_coherent)
> > > +		outer_cache.sync = NULL;
> > > +
> > 
> > For this particular case, you can add a specific l2x0_of_data structure
> > with the right compatible string for your platform where
> > outer_cache.sync is NULL,
> 
> In fact, I'm not sure using a separate compatible string is possible,
> because there are situations where the hardware platform may be I/O
> coherent, and some situations where it is not the case. For example, in
> the current kernel, the platform is I/O coherent when CONFIG_SMP is
> enabled, but not I/O coherent when CONFIG_SMP is disabled. And it's the
> same hardware platform, so same Device Tree in both cases.
> 
> So using a different compatible string doesn't work here: we would have
> to adjust the compatible string depending on whether CONFIG_SMP
> or !CONFIG_SMP is used. Of course, this is doable at run time before
> probing the L2 cache driver, using a small quirk, but that doesn't
> sound really nice.

You could use #ifdef CONFIG_SMP around the compatible string but I
agree, it doesn't look nice.

> > assuming that dma_alloc_coherent() returns
> > Cacheable memory (e.g. your platform uses arm_coherent_dma_ops).
> 
> We don't use arm_coherent_dma_ops, we have our own DMA operations, see
> arch/arm/mach-mvebu/coherency.c (in mainline, only the support for the
> PJ4B based Armada 370/XP is there, but the support for the Cortex-A9
> based Armada 375/38x has been posted at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244916.html).

Slightly confusing. So for dma_alloc you can use Cacheable memory, but
for the from_device cases, you need some mvebu_hwcc_sync_io_barrier()
(and no cache maintenance). Doesn't it mean that barriers like rmb()
need such barrier as well (in combination with dma_alloc'ed buffers)?

> > >  	l2x0_init(l2x0_base, aux_val, aux_mask);
> > >  
> > >  	return 0;
> > >  }
> > > +
> > > +int __init l2x0_of_init(u32 aux_val, u32 aux_mask)
> > > +{
> > > +	return l2x0_of_init_common(aux_val, aux_mask, false);
> > > +}
> > > +
> > > +int __init l2x0_of_init_coherent(u32 aux_val, u32 aux_mask)
> > > +{
> > > +	return l2x0_of_init_common(aux_val, aux_mask, true);
> > > +}
> > 
> > This could be a bit misleading. I would rather have a generic
> > pl310_data_dma_coherent structure (though even on coherent systems you
> > could still have drivers that prefer writecombine/NormalNC memory to
> > avoid thrashing the cache).
> 
> I'm not sure to follow your suggestion here. What structure type would
> pl310_data_dma_coherent be? A "struct l2x0_of_data" like this:
> 
> static const struct l2x0_of_data pl310_dma_coherent_data = {
>         .setup = pl310_of_setup,
>         .save  = pl310_save,
>         .outer_cache = {
>                 .resume      = pl310_resume,
>                 .inv_range   = l2x0_inv_range,
>                 .clean_range = l2x0_clean_range,
>                 .flush_range = l2x0_flush_range,
>                 .sync        = NULL,
>                 .flush_all   = l2x0_flush_all,
>                 .inv_all     = l2x0_inv_all,
>                 .disable     = l2x0_disable,
>         },
> };
> 
> static const struct of_device_id l2x0_ids[] __initconst = {
> 	[...]
>         { .compatible = "arm,pl310-cache", .data = (void *)&pl310_data },
>         { .compatible = "arm,pl310-cache-dma-coherent", .data = (void *)&pl310_dma_coherent_data },
> 	[...]
> };
> 
> Is this what you have in mind? This looks ok to me, if we have a
> solution for the CONFIG_SMP vs. !CONFIG_SMP problem.

I don't have a nice way. Basically for this board, even if the coherency
was fully set up by firmware (which BTW should be the case for arm64, we
don't take mach-* directories ;)), it depends on the kernel build, I
guess this is because of the Shareable vs NonShareable mappings. The
best I can come up with is a conditionally compiled "marvell,..."
compatible string but your original approach is probably nicer (and as I
said, with the assumption that no driver uses writecombine/dmacoherent
memory for DMA).

-- 
Catalin
