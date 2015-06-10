From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Jun 2015 17:31:21 +0100
Subject: [PATCH 1/2] scatterlist: use sg_phys()
In-Reply-To: <CAPcyv4gat8TG9YnHmvD_7A7RD00Urn=febCj2Uc_cVcPi+fnCg@mail.gmail.com>
References: <20150609162659.21910.41681.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150609162710.21910.57295.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150610093252.GA20384@8bytes.org>
 <CAPcyv4gat8TG9YnHmvD_7A7RD00Urn=febCj2Uc_cVcPi+fnCg@mail.gmail.com>
Message-ID: <20150610163121.GP7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 09:00:31AM -0700, Dan Williams wrote:
> On Wed, Jun 10, 2015 at 2:32 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > On Tue, Jun 09, 2015 at 12:27:10PM -0400, Dan Williams wrote:
> >> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> >> index 7e7583ddd607..9f6ff6671f01 100644
> >> --- a/arch/arm/mm/dma-mapping.c
> >> +++ b/arch/arm/mm/dma-mapping.c
> >> @@ -1502,7 +1502,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
> >>               return -ENOMEM;
> >>
> >>       for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
> >> -             phys_addr_t phys = page_to_phys(sg_page(s));
> >> +             phys_addr_t phys = sg_phys(s) - s->offset;
> >
> > So sg_phys() turns out to be 'page_to_phys(sg_page(s)) + s->offset',
> > which makes the above statement to:
> >
> >         page_to_phys(sg_page(s)) + s->offset - s->offset;
> >
> > The compiler will probably optimize that away, but it still doesn't look
> > like an improvement.
> 
> The goal is to eventually stop leaking struct page deep into the i/o
> stack.  Anything that relies on being able to retrieve a struct page
> out of an sg entry needs to be converted.  I think we need a new
> helper for this case "sg_phys_aligned()?".

Why?  The aim of the code is not to detect whether the address is aligned
to a page (if it were, it'd be testing for a zero s->offset, or it would
be testing for an s->offset being a multiple of the page size.

Let's first understand the code that's being modified (which seems to be
something which isn't done very much today - people seem to just like
changing code for the hell of it.)

        for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
                phys_addr_t phys = page_to_phys(sg_page(s));
                unsigned int len = PAGE_ALIGN(s->offset + s->length);

                if (!is_coherent &&
                        !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
                        __dma_page_cpu_to_dev(sg_page(s), s->offset, s->length,
dir);

                prot = __dma_direction_to_prot(dir);

                ret = iommu_map(mapping->domain, iova, phys, len, prot);
                if (ret < 0)
                        goto fail;
                count += len >> PAGE_SHIFT;
                iova += len;
        }

What it's doing is trying to map each scatterlist entry via an IOMMU.
Unsurprisingly, IOMMUs are page based - you can't map a partial IOMMU
page.

However, what says that the IOMMU page size is the same as the host CPU
page size - it may not be... so the above code is wrong for a completely
different reason.

What we _should_ be doing is finding out what the IOMMU minimum page
size is, and using that in conjunction with the sg_phys() of the
scatterlist entry to determine the start and length of the mapping
such that the IOMMU mapping covers the range described by the scatterlist
entry.  (iommu_map() takes arguments which must be aligned to the IOMMU
minimum page size.)

However, what we can also see from the above is that we have other code
here using sg_page() - which is a necessity to be able to perform the
required DMA cache maintanence to ensure that the data is visible to the
DMA device.  We need to kmap_atomic() these in order to flush them, and
there's no other way other than struct page to represent a highmem page.

So, I think your intent to want to remove struct page from the I/O
subsystem is a false hope, unless you want to end up rewriting lots of
architecture code, and you can come up with an alternative method to
represent highmem pages.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
