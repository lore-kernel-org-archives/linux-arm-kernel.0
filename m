From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 14 Sep 2015 20:25:00 +0800
Subject: [PATCH v3 3/6] iommu: add ARM short descriptor page table
 allocator.
In-Reply-To: <20150721171101.GN31095@arm.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
 <1437037475-9065-4-git-send-email-yong.wu@mediatek.com>
 <20150721171101.GN31095@arm.com>
Message-ID: <1442233500.19588.35.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-07-21 at 18:11 +0100, Will Deacon wrote:
[...]
> > +static int arm_short_map(struct io_pgtable_ops *ops, unsigned long iova,
> > +                        phys_addr_t paddr, size_t size, int prot)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_ops_to_data(ops);
> > +       const struct iommu_gather_ops *tlb = data->iop.cfg.tlb;
> > +       int ret;
> > +       arm_short_iopte pgdprot = 0, pteprot = 0;
> > +       bool large;
> > +
> > +       /* If no access, then nothing to do */
> > +       if (!(prot & (IOMMU_READ | IOMMU_WRITE)))
> > +               return 0;
> > +
> > +       switch (size) {
> > +       case SZ_4K:
> > +       case SZ_64K:
> > +               large = (size == SZ_64K) ? true : false;
> > +               pteprot = __arm_short_pte_prot(data, prot, large);
> > +               pgdprot = __arm_short_pgtable_prot(data, prot & IOMMU_NOEXEC);
> > +               break;
> > +
> > +       case SZ_1M:
> > +       case SZ_16M:
> > +               large = (size == SZ_16M) ? true : false;
> > +               pgdprot = __arm_short_pgd_prot(data, prot, large);
> > +               break;
> > +       default:
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (WARN_ON((iova | paddr) & (size - 1)))
> > +               return -EINVAL;
> > +
> > +       ret = _arm_short_map(data, iova, paddr, pgdprot, pteprot, large);
> > +
> > +       tlb->tlb_add_flush(iova, size, true, data->iop.cookie);
> > +       tlb->tlb_sync(data->iop.cookie);
> 
> In _arm_short_map, it looks like you can only go from invalid -> valid,
> so why do you need to flush the TLB here?

Hi Will,
   Here is about flush-tlb after map iova, I have deleted it in v4
following this suggestion. But We meet a problem about it.

Take a example with JPEG. the test steps is:
a).JPEG HW decode a picture with the source iova,like 0xfd780000.
b).JPEG HW decode done, It will unmap the iova(write 0 in pagetable and
flush tlb).
c).JPEG HW decode the second picture, whose source iova is also
0xfd780000.
   Then our HW maybe fail due to it will auto prefetch, It may prefecth
between the step b) and c). then the HW may fetch the pagetable content
which has been unmapped in step b). then the HW will get the iova's
physical address is 0, It will translation fault!

    So I think our HW need flush-tlb after map iova. Could we add a
QUIRK like "IO_PGTABLE_QUIRK_AUTO_PREFETCH_ENABLE" for it?
If it's not allowed, we will have to add this in our internal function
mtk_iommu_map of mtk_iommu.c.
Thanks.

> 
> > +       return ret;
> > +}
> > +
[...]
