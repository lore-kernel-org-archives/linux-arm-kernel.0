From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 Jan 2012 11:13:32 +0900
Subject: [PATCH v8 2/2] iommu/exynos: Add iommu driver for Exynos Platforms
In-Reply-To: <CAHQjnOMyoOH2cFjjGSzMvefZTQGROmQgaA8S0MmxnKGHWyQhyA@mail.gmail.com>
References: <001001ccc625$0afa7ee0$20ef7ca0$%cho@samsung.com>
 <20120123142706.GA6269@8bytes.org>
 <CAHQjnOMyoOH2cFjjGSzMvefZTQGROmQgaA8S0MmxnKGHWyQhyA@mail.gmail.com>
Message-ID: <017b01ccdc99$44a12420$cde36c60$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KyongHo Cho wrote:
> 
> Hi,
> On Mon, Jan 23, 2012 at 11:27 PM, Joerg Roedel <joro@8bytes.org> wrote:
> > Hi,
> >
> > please also get and inclue Acks from the Exynos maintainer for the next
> > post.
> > Since I have a compiling config for exynos now I will merge the patches
> > when you have the Acks and addressed or explained the issues I pointed
> > out below.
> >
> Thanks for review!
> I will include the Acks in the next patchset.

If his updated patch is ok to me, let me reply then.

As a note, I'm preparing for new EXYNOS SoC and so some exynos stuff such as
clock can be modified. So would be better if KyongHo could update regarding
arch/arm/ part based on that. Maybe in the beginning of Feb.?

Joerg, as I said, I need a topic branch for this to avoid conflict and I
think, now you can provide it for samsung tree.

If any problems, please let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> I will post the next patchset with corrections by the day after tomorrow.
> 
> And sorry for late reply.
> I had holidays for the new year's day based on Lunar system.
> 
> > On Thu, Dec 29, 2011 at 09:26:08PM +0900, KyongHo Cho wrote:
> >> +static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
> >> +{
> >> + ? ? struct exynos_iommu_domain *priv = domain->priv;
> >> + ? ? struct list_head *pos, *n;
> >> + ? ? unsigned long flags;
> >> + ? ? int i;
> >> +
> >> + ? ? WARN_ON(!list_empty(&priv->clients));
> >
> > This isn't really a problem. We allow destroying a domain with devices
> > attached. So this WARN_ON is not necessary.
> >
> OK.
> BTW, Isn't it a problem when a device driver does not know that its
> iommu domain is destroyed?
> Can we regards that it is the faulty use of iommu API?
> 
> >> +static int exynos_iommu_map(struct iommu_domain *domain, unsigned long
> iova,
> >> + ? ? ? ? ? ? ? ? ? ? ?phys_addr_t paddr, size_t size, int prot)
> >> +{
> >> + ? ? struct exynos_iommu_domain *priv = domain->priv;
> >> + ? ? unsigned long *entry;
> >> + ? ? unsigned long flags;
> >> + ? ? int ret = -ENOMEM;
> >> +
> >> + ? ? BUG_ON(priv->pgtable == NULL);
> >> +
> >> + ? ? spin_lock_irqsave(&priv->pgtablelock, flags);
> >> +
> >> + ? ? entry = section_entry(priv->pgtable, iova);
> >> +
> >> + ? ? if (size >= SECT_SIZE) {
> >> + ? ? ? ? ? ? ret = lv1set_section(entry, paddr, size >> SECT_ORDER,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? &priv-
> >lv2entcnt[lv1ent_offset(iova)]);
> >
> > This looks like you are partially re-implementing behavior of generic
> > code because you are mapping multiple sections at once. The generic map
> > code already splits up the address range correctly, so no need to do
> > this in the driver (unless there is some benefit in the hardware, like
> > an IOTLB entry that can cover multiple sections or something similar).
> >
> Yes, I wanted to avoid repeated function call by iommu_map().
> s5p_iommu_map() maps once for the same page size since it is efficient
> and simple.
> That's why this driver initializes domain->pgsize_bitmap with 0xFFFFF000
> even though our IOMMU driver just supports 3 different page sizes
> including 4KB, 64KB and 1MB.
> 
> Do you think it is better for s5p_iommu_map() to map just one page at
once?
> 
> >> +static size_t exynos_iommu_unmap(struct iommu_domain *domain,
> >> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?unsigned long iova, size_t
size)
> >> +{
> >> + ? ? struct exynos_iommu_domain *priv = domain->priv;
> >> + ? ? struct iommu_client *client;
> >> + ? ? unsigned long flags;
> >> +
> >> + ? ? BUG_ON(priv->pgtable == NULL);
> >> +
> >> + ? ? spin_lock_irqsave(&priv->pgtablelock, flags);
> >> +
> >> + ? ? while (size != 0) {
> >> + ? ? ? ? ? ? int i, nent, order;
> >> + ? ? ? ? ? ? unsigned long *pent, *sent;
> >
> > Same with this while-loop. This looks like it re-implements behavior
> > from the generic code.
> >
> If a region to unmap consists of tens of pages
> there is no way to avoid flushing IOTLB repeatedly.
> 
> Out iommu driver doesn't need to flush IOTLB more than once for a
> region to unmap.
> 
> Do you think the driver is better to unmaps just one page at once
> though flushing IOTLB repeatedly?
> 
> 
> Thank you.
> 
>   KyongHo
