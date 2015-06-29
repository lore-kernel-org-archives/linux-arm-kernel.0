From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 29 Jun 2015 11:37:37 +0100
Subject: [RFC PATCH v3] arm DMA: Fix allocation from CMA for coherent DMA
In-Reply-To: <CAE=W-e3YUjT=KbYTizBwg+3huvFLDqHvhzZN-oPqEnOKUXAtoQ@mail.gmail.com>
References: <1434663862-17858-1-git-send-email-lorenx4@gmail.com>
 <20150626162549.GK3078@e104818-lin.cambridge.arm.com>
 <CAE=W-e3YUjT=KbYTizBwg+3huvFLDqHvhzZN-oPqEnOKUXAtoQ@mail.gmail.com>
Message-ID: <20150629103737.GC29907@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 28, 2015 at 10:14:43PM +0200, Lorenzo Nava wrote:
> On Fri, Jun 26, 2015 at 6:25 PM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Thu, Jun 18, 2015 at 11:44:22PM +0200, Lorenzo Nava wrote:
> >> @@ -680,9 +694,14 @@ void *arm_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
> >>  static void *arm_coherent_dma_alloc(struct device *dev, size_t size,
> >>       dma_addr_t *handle, gfp_t gfp, struct dma_attrs *attrs)
> >>  {
> >> -     pgprot_t prot = __get_dma_pgprot(attrs, PAGE_KERNEL);
> >> +     pgprot_t prot;
> >>       void *memory;
> >>
> >> +     if (attrs == NULL)
> >> +              prot  = PAGE_KERNEL;
> >> +     else
> >> +              prot  = __get_dma_pgprot(attrs, PAGE_KERNEL);
> >> +
> >>       if (dma_alloc_from_coherent(dev, size, handle, &memory))
> >>               return memory;
> >
> > I still think this is the wrong way to fix. It doesn't address the
> > coherent dma mmap operation. I already replied on the previous version
> > that we should rather have an extra argument "coherent" to
> > __get_dma_pgprot().
>
> I avoided touching the __get_dma_pgprot() function because it affects
> a lot of different functions.
> If you think that the implementation you suggested in previous reply
> was ok and doesn't introduce problems on the other functions using the
> __get_dma_pgprot(), for me it's of course ok as well.

I forgot about the arm_dma_mmap fix here:

https://lkml.org/lkml/2015/5/7/512

So we either fix both cases by changing __get_dma_pgprot() or just go
for Mike's and your patches as above. It's up to Russell.

At some point, we could do with some more clean-up in the dma-mapping.c.
For example, both __alloc_simple_buffer() and __alloc_from_contiguous()
end up calling __dma_clear_buffer() even when not necessary (cacheable
mapping). Not too bad though as this is only done when setting up the
buffer.

> Do you see any code that maybe need a double check: I'm thinking, for
> example, at the function arm_iommu_alloc_attrs() and
> arm_iommu_mmap_attrs()?

I think this has bigger problems. The code seems to only be right for
non-cacheable mappings. For cacheable/coherent iommu mappings, I don't
see any use of the IOMMU_CACHE attribute (should it be returned by
__dma_direction_to_prot?).

-- 
Catalin
