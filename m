From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 25 Sep 2012 14:08:04 +0100
Subject: [PATCH v3 RESEND 08/17] ARM: LPAE: use phys_addr_t in
 free_memmap()
In-Reply-To: <20120924171425.GG26454@n2100.arm.linux.org.uk>
References: <1348242975-19184-1-git-send-email-cyril@ti.com>
 <1348242975-19184-9-git-send-email-cyril@ti.com>
 <20120924132942.GD23298@arm.com>
 <20120924134145.GB26454@n2100.arm.linux.org.uk>
 <506077BE.6000600@ti.com>
 <20120924152220.GE26454@n2100.arm.linux.org.uk>
 <50608D3D.2010106@ti.com> <20120924165145.GD14198@arm.com>
 <20120924171425.GG26454@n2100.arm.linux.org.uk>
Message-ID: <20120925112256.GC14924@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 24, 2012 at 06:14:25PM +0100, Russell King - ARM Linux wrote:
> On Mon, Sep 24, 2012 at 05:51:46PM +0100, Catalin Marinas wrote:
> > I don't think that's needed. free_all_bootmem() in mm/nobootmem.c takes
> > care of freeing lowmem but it has a different notion of max_low_pfn. So
> > this hunk did the trick:
> > 
> > @@ -420,8 +366,8 @@ void __init bootmem_init(void)
> >  	 * Note: max_low_pfn and max_pfn reflect the number of _pages_ in
> >  	 * the system, not the maximum PFN.
> >  	 */
> > -	max_low_pfn = max_low - PHYS_PFN_OFFSET;
> > -	max_pfn = max_high - PHYS_PFN_OFFSET;
> > +	max_low_pfn = max_low;
> > +	max_pfn = max_high;
> >  }
> 
> Did you actually look to see where that's used before you made the change.
> I don't think you did.
> 
> The reason we have that there is that much of the kernel assumes memory
> always starts at physical zero, so the max*pfn variables can be used to
> generate bitmasks to cover the range of system memory addresses - iow,
> (1 << max_low_pfn) - 1.
> 
> Eg, in the block code:
> 
>         blk_max_low_pfn = max_low_pfn - 1;
>         blk_max_pfn = max_pfn - 1;
> ...
>         unsigned long b_pfn = dma_mask >> PAGE_SHIFT;
> 
>         if (b_pfn < blk_max_low_pfn)
>                 dma = 1;
> 
> Having a DMA mask for a peripheral which only has 24 bits wired (so
> 0x00ffffff) with a system memory offset of 0xc0000000 results in
> apparantly _all_ system memory being DMA-able according to this test
> unless max_low_pfn is defined as the _number_ of bits in the RAM
> address.
> 
> In dma_get_required_mask():
> 
>         u32 low_totalram = ((max_pfn - 1) << PAGE_SHIFT);
> 
>                 low_totalram = (1 << (fls(low_totalram) - 1));
>                 low_totalram += low_totalram - 1;
> 
> which results in (for a phys offset of 0xc0000000) low_totalram being
> 0xffffffff unconditionally no matter how much RAM you actually have.

And for those platforms the phys and bus (dma) addresses are different.
So it's not about whether the physical RAM starts at 0 but whether the
device has a different view of the RAM address space. The reverse could
also be problematic if phys == bus and max_low_pfn corresponds to an
address that's not actually accessible for the device (though in
practice I don't expect this).

There is no consistency in the kernel on whether max_low_pfn is absolute
or relative (nobootmem.c considers it absolute). There is also a
min_low_pfn which could be used to update the above functions or
introduce a new min_dma_pfn.

-- 
Catalin
