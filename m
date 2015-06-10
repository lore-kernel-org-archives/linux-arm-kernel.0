From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 10 Jun 2015 10:25:39 -0700
Subject: [PATCH 1/2] scatterlist: use sg_phys()
In-Reply-To: <20150610171304.GQ7557@n2100.arm.linux.org.uk>
References: <20150609162659.21910.41681.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150609162710.21910.57295.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150610093252.GA20384@8bytes.org>
 <CAPcyv4gat8TG9YnHmvD_7A7RD00Urn=febCj2Uc_cVcPi+fnCg@mail.gmail.com>
 <20150610163121.GP7557@n2100.arm.linux.org.uk>
 <CAPcyv4i0MB9GTL4ujtybwBLB9sV+n0PX686Oi-Rt5CGEeey_hQ@mail.gmail.com>
 <20150610171304.GQ7557@n2100.arm.linux.org.uk>
Message-ID: <CAPcyv4hFWvCO5Gs4Y3AbYSt0DMKWyXtXvFk669Odo-scfas-nA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 10:13 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jun 10, 2015 at 09:57:06AM -0700, Dan Williams wrote:
>> On Wed, Jun 10, 2015 at 9:31 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > Why?  The aim of the code is not to detect whether the address is aligned
>> > to a page (if it were, it'd be testing for a zero s->offset, or it would
>> > be testing for an s->offset being a multiple of the page size.
>> >
>> > Let's first understand the code that's being modified (which seems to be
>> > something which isn't done very much today - people seem to just like
>> > changing code for the hell of it.)
>> >
>> >         for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
>> >                 phys_addr_t phys = page_to_phys(sg_page(s));
>> >                 unsigned int len = PAGE_ALIGN(s->offset + s->length);
>> >
>> >                 if (!is_coherent &&
>> >                         !dma_get_attr(DMA_ATTR_SKIP_CPU_SYNC, attrs))
>> >                         __dma_page_cpu_to_dev(sg_page(s), s->offset, s->length,
>> > dir);
>> >
>> >                 prot = __dma_direction_to_prot(dir);
>> >
>> >                 ret = iommu_map(mapping->domain, iova, phys, len, prot);
>> >                 if (ret < 0)
>> >                         goto fail;
>> >                 count += len >> PAGE_SHIFT;
>> >                 iova += len;
>> >         }
>> >
>> > What it's doing is trying to map each scatterlist entry via an IOMMU.
>> > Unsurprisingly, IOMMUs are page based - you can't map a partial IOMMU
>> > page.
>> >
>> > However, what says that the IOMMU page size is the same as the host CPU
>> > page size - it may not be... so the above code is wrong for a completely
>> > different reason.
>> >
>> > What we _should_ be doing is finding out what the IOMMU minimum page
>> > size is, and using that in conjunction with the sg_phys() of the
>> > scatterlist entry to determine the start and length of the mapping
>> > such that the IOMMU mapping covers the range described by the scatterlist
>> > entry.  (iommu_map() takes arguments which must be aligned to the IOMMU
>> > minimum page size.)
>> >
>> > However, what we can also see from the above is that we have other code
>> > here using sg_page() - which is a necessity to be able to perform the
>> > required DMA cache maintanence to ensure that the data is visible to the
>> > DMA device.  We need to kmap_atomic() these in order to flush them, and
>> > there's no other way other than struct page to represent a highmem page.
>> >
>> > So, I think your intent to want to remove struct page from the I/O
>> > subsystem is a false hope, unless you want to end up rewriting lots of
>> > architecture code, and you can come up with an alternative method to
>> > represent highmem pages.
>>
>> I think there will always be cases that need to do pfn_to_page() for
>> buffer management.  Those configurations will be blocked from seeing
>> cases where a pfn is not struct page backed.  So, you can have highmem
>> or dma to pmem, but not both.  Christoph, this is why I have Kconfig
>> symbols (DEV_PFN etc) to gate whether an arch/config supports pfn-only
>> i/o.
>
> Hmm, pmem... yea, in the SolidRun community, we've basically decided to
> stick with my updated Marvell BMM layer rather than switch to pmem.  I
> forget the reasons why, but the decision was made after looking at what
> pmem was doing...

I'd of course be open to exploring if drivers/nvdimm/ could be made
more generally useful.

> In any case, let's not get bogged down in a peripheral issue.
>
> What I'm objecting to is that the patches I've seen seem to be just
> churn without any net benefit.
>
> You can't simply make sg_page() return NULL after this change, because
> you've done nothing with the remaining sg_page() callers to allow them
> to gracefully handle that case.
>
> What I'd like to see is a much fuller series of patches which show the
> whole progression towards your end goal rather than a piecemeal
> approach.  Right now, it's not clear that there is any benefit to
> this round of changes.
>

Fair enough.  I had them as part of a larger series [1].  Christoph
suggested that I break out the pure cleanups separately.  I'll add you
to the next rev of that series.

[1]: https://lists.01.org/pipermail/linux-nvdimm/2015-June/001094.html
