From: yong.wu@mediatek.com (Yong Wu)
Date: Wed, 13 May 2015 10:52:43 +0800
Subject: [RFC PATCH] iommu: add ARM short descriptor page table allocator.
In-Reply-To: <CABuKBeKupM0zmWu6T3g5omH7PRo9Oxp85bfpQVhC1ur16_dzvg@mail.gmail.com>
References: <1430206881-18294-1-git-send-email-yong.wu@mediatek.com>
 <CABuKBeKupM0zmWu6T3g5omH7PRo9Oxp85bfpQVhC1ur16_dzvg@mail.gmail.com>
Message-ID: <1431485563.4799.2.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-12 at 11:15 +0200, Matthias Brugger wrote:
> 2015-04-28 9:41 GMT+02:00 Yong Wu <yong.wu@mediatek.com>:
> > This patch is for ARM Short Descriptor Format.It has 2-levels
> > pagetable and the allocator supports 4K/64K/1M/16M.
> >
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
[snip]
> > +static phys_addr_t arm_short_iova_to_phys(struct io_pgtable_ops *ops,
> > +                                         unsigned long iova)
> > +{
> > +       struct arm_short_io_pgtable *data = io_pgtable_short_ops_to_data(ops);
> > +       arm_short_iopte *pte, *pgd = data->pgd;
> > +       phys_addr_t pa = 0;
> > +
> > +       pgd += ARM_SHORT_PGD_IDX(iova);
> > +
> > +       if (ARM_SHORT_F_PGD_TYPE_IS_PAGE(*pgd)) {
> > +               pte = arm_short_get_pte_in_pgd(*pgd, iova);
> > +
> > +               if (ARM_SHORT_F_PTE_TYPE_GET(*pte)
> > +                   == ARM_SHORT_F_PTE_TYPE_LARGE) {
> > +                       pa = (*pte) & ARM_SHORT_F_PTE_PA_LARGE_MSK;
> > +                       pa |= iova & (~ARM_SHORT_F_PTE_PA_LARGE_MSK);
> > +               } else if (ARM_SHORT_F_PTE_TYPE_GET(*pte)
> > +                          == ARM_SHORT_F_PTE_TYPE_SMALL) {
> 
> Would make it easier to read:
> u8 pte_type;
> 
> [...]
> 
> pte_type = ARM_SHORT_F_PTE_TYPE_GET(*pte)
> if (pte_type == ARM_SHORT_F_PTE_TYPE_LARGE) {
> [...]
> } else if (pte_type == ARM_SHORT_F_PTE_TYPE_SMALL) {
> [...]
Hi Matthias,
	Thanks for your review.I will fix this in next version.
