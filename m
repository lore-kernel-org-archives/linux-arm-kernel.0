From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Jun 2011 10:19:51 +0100
Subject: [PATCH] mtd: OneNAND: samsung: Write DMA support
In-Reply-To: <1309420530.23597.153.camel@sauron>
References: <20110608101804.GA5527@july> <1309420530.23597.153.camel@sauron>
Message-ID: <20110630091951.GQ21898@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 30, 2011 at 10:55:25AM +0300, Artem Bityutskiy wrote:
> > +	/* Handle vmalloc address */
> > +	if (buf >= high_memory) {
> > +		struct page *page;
> 
> OK, Russell will yell at this, but we do DMA vmalloc'ed addresses for

I most certainly will, because its broken.

> > +
> > +		if (((size_t) buf & PAGE_MASK) !=
> > +		    ((size_t) (buf + count - 1) & PAGE_MASK))
> 
> Something is fishy with these size_t casts, could you revisit this piece
> of code - and turn it to something simpler, if possible?
> 
> > +			goto normal;
> > +
> > +		page = vmalloc_to_page(buf);
> > +		if (unlikely(!page))
> > +			goto normal;
> > +
> > +		/* Page offset */
> > +		ofs = ((size_t) buf & ~PAGE_MASK);
> > +		page_dma = 1;
> > +
> > +		/* DMA routine */
> > +		dma_src = dma_map_page(dev, page, ofs, count, DMA_TO_DEVICE);

Which is that this code is trying to work around the restriction in the
DMA API that dma_map_single() can only take virtual addresses in the
kernel direct mapped region.

The key thing here is that with CPUs which lookup by virtual address,
like ARMs, you _must_ handle the cache aliases associated with the mapping
which you are accessing the memory via.

This means if you are accessing a DMA buffer at address X, and address X
is cacheable, address X needs cache maintainence performed on it.  Address
Y, which may correspond with the same memory as X through a different
mapping is no good.  It has to be X.

However, there is NO API for mapping DMA buffers from vmalloc space.
What we do now have are a pair of functions which must be used _correctly_
(iow, one before and one after) to ensure that virtual cached architectures
can access the data correctly - and its documented at the bottom of
cachetlb.txt.

As this is something which keeps coming up in connection with MTD, it
may be a good idea if MTD gave driver authors a helping hand with DMA
setup/teardown so that the chances of driver authors getting this right
is greater...
