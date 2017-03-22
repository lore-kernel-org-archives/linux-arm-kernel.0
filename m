From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Mar 2017 16:32:37 +0000
Subject: [PATCH] ARM: dma-mapping: Fix dma_get_sgtable() for regions
 without struct page
In-Reply-To: <CAKocOONSt=UjPPVEN0ESLBMAsbk_HeWGQdkzyuUW+X7ddaLwzQ@mail.gmail.com>
References: <CGME20170221131655eucas1p2f2ca6e3c819aeae227c5e5c5f2bc7d3f@eucas1p2.samsung.com>
 <1487682998-2564-1-git-send-email-m.szyprowski@samsung.com>
 <20170322111020.GD21222@n2100.armlinux.org.uk>
 <CAKocOONSt=UjPPVEN0ESLBMAsbk_HeWGQdkzyuUW+X7ddaLwzQ@mail.gmail.com>
Message-ID: <20170322163237.GF21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 09:46:05AM -0600, Shuah Khan wrote:
> This check doesn't really do any kind of validation.

Exactly right.

> I have been debugging
> a pagefault when the sgtable created by arm_dma_get_sgtable() runs into
> the following kernel error when vb2_dc_dmabuf_ops_map() tries to map
> the exported buffer from another driver.

It is _completely_ incorrect to even try to pass memory allocated from
the coherent DMA allocator back into the _streaming_ DMA API.  That is
just something that the streaming DMA API does not support.

I am dismayed at dma_get_sgtable() ever having been proposed - I think
it's completely wrong.  Looking back to when it was created in 2012, it
appears that it never got any review from architecture people - there
certainly are no architecture people in the attributations for it.

There are two Samsung people and a DRM person in the sign-off, and IMHO
that's not good enough for a proposal which completely changes the way
DMA memory is dealt with - especially as _that_ is soo architecture
dependent.

Annoyingly, when I was looking at the dma_buf API while I was implementing
the armada DRM driver, I did point out the problems with the dma_buf API
wrt passing contiguous regions from one driver to another, and I suggested
separating the DMA mapping operation somewhat, but all that fell on deaf
ears.  I guess the results of that are now coming home to roost.

The fundamental point about coherent DMA memory, or memory that is
provided via the declaration mechanisms is that there is _no_ gurantee
that there will be a "struct page" backing it, so creating a scatterlist
with "struct page" pointers, which is then subsequently dma_map_sg()'d
elsewhere is always going to be totally broken.  In the case of some
coherent DMA allocators, there _may_ be a "struct page" backing the
memory, but that's not guaranteed, and since dma_map_sg() relies on
there being a valid "struct page", things will go wrong.

And by "wrong", I mean it could oops the kernel because of trying to
dereference the "struct page" pointer, or if that's successful, we
could end up invalidating the cache lines for some random region of
memory, which then goes on to cause a completely different failure, or
maybe filesystem corruption (eg, what if it hits a page cache page
containing an inode table, and invalidates all updates to that page?)
The consequences really don't bare thinking about.

> Just an an experiment, I added this hack: in this case __dc_alloc()
> returned values is the mapped page. This is by mo means a fix - I am
> not sure if we can rely on this page, since at DQBUF its get unmapped.
> 
> /* In this case cpu_addr is the page - just use it */
>         if ((attrs & DMA_ATTR_NO_KERNEL_MAPPING) == 0)
>                 page = cpu_addr;
> 
> At this point I dumped some data:
> 
> [  154.627505] platform 11000000.codec:left:
> debug_arm_dma_get_sgtable: bus_to_pfn 772608 dma_pfn_offset 0
> PHYS_PFN_OFFSET 262144
> [  154.627512] platform 11000000.codec:left:
> debug_arm_dma_get_sgtable: dma_to_pfn 772608 virt_to_pfn 470272
> virt_to_dma 1926234112 virt_to_page ef6ca000 page f0004000
> 
> cpu_addr is
> [  154.627520] platform 11000000.codec:left:
> debug_arm_dma_get_sgtable: cpu_addr f2d00000 handle bca00000 page =
> f2d00000 size 946176 align size 946176
> [  154.627527] platform 11000000.codec:left: after
> dma_get_sgtable_attrs() vb2_dc_get_base_sgt: sgt ecdcec00 page
> f2d00000 buf ecdced80 cookie f2d00000 vaddr f2d00000 dc_cookie
> ecdced90 dma_addr bca00000 size 946176
> 
> cpu_addr is f2d00000 and the page you get from
> pfn_to_page(dma_to_pfn(dev, handle)) is f0004000.

I'd like to see the diff that produced the above dumps to make better
sense of it...

> The page you get with struct page *page = pfn_to_page(dma_to_pfn(dev, handle));
> is bogus. So this check Merek added doesn't find a bogus page, does a reverse
> validation of the bogus page.

Right - dma_to_pfn() will correctly translate the "handle" to a PFN
number, so we can just multiply that with PAGE_SIZE to get the physical
address, which if I'm interpreting your information above correctly,
would be 0x72d00000.

However, what you're saying is that there is no valid "struct page"
associated with that address.

The correct way to validate this is:

	unsigned long pfn = dma_to_pfn(dev, handle);
	struct page *page;

	if (!pfn_valid(pfn))
		return -ENXIO;

	page = pfn_to_page(pfn);

However, I have a huge big problem with this - this can pass even for
memory obtained through the coherent allocator (because of the way CMA
works.)

This can end up with the DMA streaming API kmapping memory using
cacheable attributes while CMA has it mapped with uncacheable attributes,
where (as mentioned on IRC this morning):

	you enter the realm of "mismatched memory attributes",
	which don't blow up, but you can lose guarantees of both
	mappings wrt coherence and ordering

We really don't want to go there.  The problem, however, is that we
can't distingish a CMA page allocated via the DMA coherent allocator
(and so potentially mapped uncacheable) with a normal allocation of
the same page, which would be valid for streaming DMA API use.

I think the best we can do is as per the above for declared DMA memory
(iow, memory that isn't struct page backed.)  It should _never_ be
passed into the streaming DMA API.

I also think that the dma_get_sgtable() thing is a total trainwreck,
and we need to have a rethink about this.

This isn't a case of "something changed in the architecture that broke
dma_get_sgtable()" - this is a case that it's always been broken in
this way ever since dma_get_sgtable() was introduced, and dma_get_sgtable()
was never (properly?) reviewed with this kind of use-case in mind.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
