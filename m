From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Sep 2012 14:30:13 +0100
Subject: [PATCH v3 RESEND 08/17] ARM: LPAE: use phys_addr_t in
 free_memmap()
In-Reply-To: <20120925112256.GC14924@arm.com>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-9-git-send-email-cyril@ti.com>
 <20120924132942.GD23298@arm.com>
 <20120924134145.GB26454@n2100.arm.linux.org.uk> <506077BE.6000600@ti.com>
 <20120924152220.GE26454@n2100.arm.linux.org.uk> <50608D3D.2010106@ti.com>
 <20120924165145.GD14198@arm.com>
 <20120924171425.GG26454@n2100.arm.linux.org.uk>
 <20120925112256.GC14924@arm.com>
Message-ID: <20120925133013.GP15609@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 25, 2012 at 02:08:04PM +0100, Catalin Marinas wrote:
> On Mon, Sep 24, 2012 at 06:14:25PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Sep 24, 2012 at 05:51:46PM +0100, Catalin Marinas wrote:
> > > I don't think that's needed. free_all_bootmem() in mm/nobootmem.c takes
> > > care of freeing lowmem but it has a different notion of max_low_pfn. So
> > > this hunk did the trick:
> > > 
> > > @@ -420,8 +366,8 @@ void __init bootmem_init(void)
> > >  	 * Note: max_low_pfn and max_pfn reflect the number of _pages_ in
> > >  	 * the system, not the maximum PFN.
> > >  	 */
> > > -	max_low_pfn = max_low - PHYS_PFN_OFFSET;
> > > -	max_pfn = max_high - PHYS_PFN_OFFSET;
> > > +	max_low_pfn = max_low;
> > > +	max_pfn = max_high;
> > >  }
> > 
> > Did you actually look to see where that's used before you made the change.
> > I don't think you did.
> > 
> > The reason we have that there is that much of the kernel assumes memory
> > always starts at physical zero, so the max*pfn variables can be used to
> > generate bitmasks to cover the range of system memory addresses - iow,
> > (1 << max_low_pfn) - 1.
> > 
> > Eg, in the block code:
> > 
> >         blk_max_low_pfn = max_low_pfn - 1;
> >         blk_max_pfn = max_pfn - 1;
> > ...
> >         unsigned long b_pfn = dma_mask >> PAGE_SHIFT;
> > 
> >         if (b_pfn < blk_max_low_pfn)
> >                 dma = 1;
> > 
> > Having a DMA mask for a peripheral which only has 24 bits wired (so
> > 0x00ffffff) with a system memory offset of 0xc0000000 results in
> > apparantly _all_ system memory being DMA-able according to this test
> > unless max_low_pfn is defined as the _number_ of bits in the RAM
> > address.
> > 
> > In dma_get_required_mask():
> > 
> >         u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
> > 
> >                 low_totalram = (1 << (fls(low_totalram) - 1));
> >                 low_totalram += low_totalram - 1;
> > 
> > which results in (for a phys offset of 0xc0000000) low_totalram being
> > 0xffffffff unconditionally no matter how much RAM you actually have.
> 
> And for those platforms the phys and bus (dma) addresses are different.

That doesn't have anything to do with it actually.  If you look at the
above analysis, where the DMA addresses are has nothing to do with it.

> So it's not about whether the physical RAM starts at 0 but whether the
> device has a different view of the RAM address space.

Yes it is.  Much of the kernel assumes PFN0 equals physical address 0.
That's a pretty sane assumption.

max_pfn/max_low_pfn are PFNs, so the theoretical correct value for these
should be max_physical_address_of_ram >> PAGE_SHIFT.  But, as I say, that
breaks _anything_ that has an offset of RAM _and_ a device which can't
address all RAM.  The reason for that is that DMA _masks_ are _masks_ and
are not the upper limit of addressible RAM.

Taking my example above, the DMA mask for a device with only 24-bits of
addressing is 0x00ffffff.  That may be connected to a system bridge which
maps the low order bus space to system RAM, and system RAM may start at
0xc0000000, and end at 0xcfffffff.

In that situation:

	blk_max_low_pfn = max_low_pfn - 1;

	unsigned long b_pfn = dma_mask >> PAGE_SHIFT;
	if (b_pfn < blk_max_low_pfn)
		dma = 1;

_breaks_ if we define max_low_pfn to be 0xcfffffff >> PAGE_SHIFT,
because now the above calculation says the whole of system memory is
DMA-able.

This isn't a question of setting a different DMA mask for the device.
The DMA mask for the device is correct.  What's wrong is that there's
a mis-interpretation between different parts of the kernel caused by
the assumption that system RAM always starts at PFN0, physical address
zero.

> The reverse could
> also be problematic if phys == bus and max_low_pfn corresponds to an
> address that's not actually accessible for the device (though in
> practice I don't expect this).

"In practice I don't expect this" - history has shown, for at least the
last 12 years, that this isn't a problem because this has been how things
have been done on ARM.

What I have shown above is that there _are_ problems, particularly in
the block layer, if we _don't_ do this.
