From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Mar 2017 22:42:00 +0000
Subject: [PATCH] ARM: dma-mapping: Fix dma_get_sgtable() for regions
 without struct page
In-Reply-To: <CAKocOOMqWByyAotnjKM3Zqq9xUBNcBFMens5Rj08aiM99wxEzg@mail.gmail.com>
References: <CGME20170221131655eucas1p2f2ca6e3c819aeae227c5e5c5f2bc7d3f@eucas1p2.samsung.com>
 <1487682998-2564-1-git-send-email-m.szyprowski@samsung.com>
 <20170322111020.GD21222@n2100.armlinux.org.uk>
 <CAKocOONSt=UjPPVEN0ESLBMAsbk_HeWGQdkzyuUW+X7ddaLwzQ@mail.gmail.com>
 <20170322163237.GF21222@n2100.armlinux.org.uk>
 <CAKocOOMqWByyAotnjKM3Zqq9xUBNcBFMens5Rj08aiM99wxEzg@mail.gmail.com>
Message-ID: <20170322224200.GH21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 02:29:09PM -0600, Shuah Khan wrote:
> On Wed, Mar 22, 2017 at 10:32 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Right - dma_to_pfn() will correctly translate the "handle" to a PFN
> > number, so we can just multiply that with PAGE_SIZE to get the physical
> > address, which if I'm interpreting your information above correctly,
> > would be 0x72d00000.
> 
> Correct paddr is 0x72d00000. I forgot to add the allocation time debug dump:
> 
> [  154.619456] platform 11000000.codec:left: vb2_dc_alloc: buf
> ecdced80 cookie f2d00000 vaddr f2d00000 paddr 72d00000 dma_addr
> bca00000 size 946176 dc_cookie ecdced90 dma_to_pfn 772608
> 
> > However, what you're saying is that there is no valid "struct page"
> > associated with that address.
> 
> >From what I can tell from the data I have, dma_to_pfn(dev, handle);
> doesn't return valid page at arm_dma_get_sgtable(), even though
> dma_to_pfn(dev, handle); itself stays the same from alloc time, as you
> can see in the above dump from vb2_dc_alloc(): dma_to_pfn 772608

dma_to_pfn() returns the physical page frame number of the DMA address
in handle.  It's page number 772608, which multiplying by the page size
gives us a physical address of 0xbca00000.  So, it's correct in so far
as if the dma_addr (of 0xbca00000 above) is correct, then that
corresponds with a physical address of 0xbca00000.

I now think that 0xf2d00000 virtual is a remapped address, not part of
lowmem (it's within the vmalloc region) which will probably be confirmed
if you look in /proc/vmallocinfo.  Since this address is remapped,
"__pa(buf->vaddr)" is invalid, it does not reference the physical page
at 0x72d00000 at all.  __pa() is just doing a simple mathematical offset
translation, which is why it's undefined for remapped addresses.

So, I'll go with 0xbca00000 being the real physical address, not
0x72d00000.

> I am guessing page might not be valid, even at the alloc time. That is
> next on debug list.

If this is coming from dma_declare_coherent_memory() then it won't have
a struct page associated with it.

> Which is somewhat puzzling, because dma_attrs don't have the
> DMA_ATTR_NO_KERNEL_MAP set, __dma_alloc() passes in want_vaddr true.
> __alloc_from_contiguous() will map the page and return a valid vaddr
> 
> __dma_alloc() then does
> *handle = pfn_to_dma(dev, page_to_pfn(page));
> 
> to return the handle.

I think you're missing something, which is the code in
include/linux/dma-mapping.h - dma_alloc_attrs().

That calls dma_alloc_from_coherent() first, which is how memory provided
via dma_declare_coherent_memory() is allocated.  This bypasses the
architecture code in arch/arm/mm/dma-mapping.c.  This provides memory
which is _not_ backed by a valid "struct page".

> > The correct way to validate this is:
> >
> >         unsigned long pfn = dma_to_pfn(dev, handle);
> >         struct page *page;
> >
> >         if (!pfn_valid(pfn))
> >                 return -ENXIO;
> >
> >         page = pfn_to_page(pfn);
> >
> > However, I have a huge big problem with this - this can pass even for
> > memory obtained through the coherent allocator (because of the way CMA
> > works.)
> 
> Right. DMA_ATTR_NO_KERNEL_MAP is another variable, if set, there won't
> be an kernel mapping.

Correct - which is why the above is probably the most correct way on
ARM (provided there is no IOMMU in the path) to get the corresponding
valid struct page pointer.

> > This can end up with the DMA streaming API kmapping memory using
> > cacheable attributes while CMA has it mapped with uncacheable attributes,
> > where (as mentioned on IRC this morning):
> 
> Which irc channel?? I can get on there for the discussion if it makes
> it easier.

It was for an unrelated discussion.

> We can see some of the evidence here in this case. One driver allocates
> the buffer and another driber tries to import. After buffer is exported,
> there is a window between DQBUF and QBUF, DQBUF unmaps the buffers. Then
> the importer comes along referencing the sg_table and looks to map them.
> Before mapping, looks like D-cache clean has to occur and that would need
> vaddr if I understand correctly. So there a lot of places, it can trip
> all over.

This is wrong, and this is where I say that the dma_buf stuff is totally
broken.

DMA coherent memory must _never_ be passed to the streaming DMA API.  No
exceptions.

However, the dma_buf stuff does not differentiate between DMA coherent
memory and streaming DMA memory - the model is purely around the exporter
creating a scatterlist, and the importer calling dma_map_sg() on the
scatterlist to obtain its own set of DMA addresses.

(sorry for the caps, but it's an important point)  THIS DOES NOT WORK.

It is a violation of the DMA API.

> > I also think that the dma_get_sgtable() thing is a total trainwreck,
> > and we need to have a rethink about this.
> 
> I don't think it works for the case I am running into.

This is the root cause - the idea that you can create a valid
scatterlist from a DMA coherent area is _just_ completely broken.
It's not possible.  dma_get_sgtable() is _fundamentally_ broken in
its design.

> > This isn't a case of "something changed in the architecture that broke
> > dma_get_sgtable()" - this is a case that it's always been broken in
> > this way ever since dma_get_sgtable() was introduced, and dma_get_sgtable()
> > was never (properly?) reviewed with this kind of use-case in mind.
> 
> I think the use-case I am debugging has always been broken.

It's _always_ been invalid to pass memory allocated from
dma_alloc_coherent() into the streaming API functions (like
dma_map_sg().)  So, you are quite correct that this has _always_ been
broken.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
