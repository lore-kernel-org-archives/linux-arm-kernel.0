From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 23 Nov 2009 17:27:22 +0000
Subject: [PATCH v2 06/17] ARM: dma-mapping: fix for speculative accesses
In-Reply-To: <c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
References: <E1NBYEF-0005l7-Tq@rmk-PC.arm.linux.org.uk>
	<E1NCZ7p-0002A0-Ib@rmk-PC.arm.linux.org.uk>
	<c70ff3ad0911230725h6d688c09k8576b66d012f29f0@mail.gmail.com>
Message-ID: <20091123172722.GE18142@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 23, 2009 at 05:25:06PM +0200, saeed bishara wrote:
> > + ? ? ? if (dir == DMA_FROM_DEVICE) {
> > + ? ? ? ? ? ? ? outer_inv_range(paddr, paddr + size);
> > + ? ? ? ? ? ? ? dmac_inv_range(kaddr, kaddr + size);
> it's not clear why outer cache invalidated before inner cache, and, I
> think that it may be incorrect, how can you be sure that a dirty line
> that is in inner cache can't be moved down to outer cache?

I think you have a point, but also see Catalin's point.  When we are
invalidating, we have to invalidate the outer caches before the inner
caches, otherwise there is a danger that the inner caches could
prefetch from the outer between the two operations.

I think that the only thing we can do is as my previous version did,
and always clean the caches at this point - first the inner and then
the outer caches.

The only other alternative would be to invalidate the outer cache,
then the inner cache, followed again by the outer cache.  I don't
currently have a feeling for how expensive that would be against
just cleaning them.

Catalin, any thoughts?


> > +void ___dma_single_dev_to_cpu(const void *kaddr, size_t size,
> > + ? ? ? enum dma_data_direction dir)
> > +{
> > + ? ? ? BUG_ON(!virt_addr_valid(kaddr) || !virt_addr_valid(kaddr + size - 1));
> > +
> > + ? ? ? /* don't bother invalidating if DMA to device */
> > + ? ? ? if (dir != DMA_TO_DEVICE) {
> > + ? ? ? ? ? ? ? unsigned long paddr = __pa(kaddr);
> > + ? ? ? ? ? ? ? outer_inv_range(paddr, paddr + size);
> > + ? ? ? ? ? ? ? dmac_inv_range(kaddr, kaddr + size);
> > + ? ? ? }
> that code implies that cache invalidate will be applied also for CPU's
> that doesn't suffer from speculative prefetch issue, right?

Yes, but we need to do this for bidirectional mappings as well (which
would've only been cleaned.)

What would be useful is if someone could run some tests on the performance
impact of this (eg, measuring the DMA performance of a SATA hard drive)
and comparing the resulting performance.

I _could_ do that, but it would mean taking down my network and running
the tests on a fairly old machine.

If it does turn out to be a problem, we can change the 'inv_range' and
'clean_range' functions to be 'dev_to_cpu' and 'cpu_to_dev' functions,
and push the decisions about what to do at each point down into the
per-CPU assembly.
