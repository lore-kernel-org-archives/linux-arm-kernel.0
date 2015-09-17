From: yong.wu@mediatek.com (Yong Wu)
Date: Thu, 17 Sep 2015 10:38:19 +0800
Subject: [PATCH v3 3/6] iommu: add ARM short descriptor page table
 allocator.
In-Reply-To: <20150916125535.GI28771@arm.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
 <1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
 <20150721171101.GN31095@arm.com> <1442233500.19588.35.camel@mhfsdcap03>
 <20150916125535.GI28771@arm.com>
Message-ID: <1442457499.8145.23.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-09-16 at 13:55 +0100, Will Deacon wrote:
> Hello Yong,
> 
> On Mon, Sep 14, 2015 at 01:25:00PM +0100, Yong Wu wrote:
> > On Tue, 2015-07-21 at 18:11 +0100, Will Deacon wrote:
> > > > +       ret = _arm_short_map(data, iova, paddr, pgdprot, pteprot, large);
> > > > +
> > > > +       tlb->tlb_add_flush(iova, size, true, data->iop.cookie);
> > > > +       tlb->tlb_sync(data->iop.cookie);
> > > 
> > > In _arm_short_map, it looks like you can only go from invalid -> valid,
> > > so why do you need to flush the TLB here?
> > 
> > Hi Will,
> >    Here is about flush-tlb after map iova, I have deleted it in v4
> > following this suggestion. But We meet a problem about it.
> 
> Ok.
> 
> > Take a example with JPEG. the test steps is:
> > a).JPEG HW decode a picture with the source iova,like 0xfd780000.
> > b).JPEG HW decode done, It will unmap the iova(write 0 in pagetable and
> > flush tlb).
> > c).JPEG HW decode the second picture, whose source iova is also
> > 0xfd780000.
> >    Then our HW maybe fail due to it will auto prefetch, It may prefecth
> > between the step b) and c). then the HW may fetch the pagetable content
> > which has been unmapped in step b). then the HW will get the iova's
> > physical address is 0, It will translation fault!
> 
> Oh no! So-called "negative caching" is certainly prohibited by the ARM
> architecture, but if you've built it then we can probably work around it
> as an additional quirk. I assume the prefetcher stops prefetching when
> it sees an invalid descriptor?

Yes, If it's a invalid descriptor, the HW will stop prefetch.

> 
> >     So I think our HW need flush-tlb after map iova. Could we add a
> > QUIRK like "IO_PGTABLE_QUIRK_AUTO_PREFETCH_ENABLE" for it?
> > If it's not allowed, we will have to add this in our internal function
> > mtk_iommu_map of mtk_iommu.c.
> 
> Actually, this type of quirk is ringing bells with me (I think another
> IOMMU needed something similar in the past), so maybe just add
> IO_PGTABLE_QUIRK_TLBI_ON_MAP?

Thanks. I will add it like:
//=====================
ret = _arm_short_map(data, iova, paddr, pgdprot, pteprot, large);

if (data->iop.cfg.quirk & IO_PGTABLE_QUIRK_TLBI_ON_MAP) {
	tlb->tlb_add_flush(iova, size, true, data->iop.cookie);
	tlb->tlb_sync(data->iop.cookie);
}
//======================
It will flush-tlb every time after map-iova. then the HW will fetch the
new PA from the dram.

> 
> Will
