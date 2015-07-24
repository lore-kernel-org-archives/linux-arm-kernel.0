From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Jul 2015 17:55:10 +0100
Subject: [PATCH v3 5/6] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1437716593.23932.73.camel@mhfsdcap03>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
 <1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
 <20150721145910.GG31095@arm.com>
 <1437716593.23932.73.camel@mhfsdcap03>
Message-ID: <20150724165509.GD21177@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 06:43:13AM +0100, Yong Wu wrote:
> On Tue, 2015-07-21 at 15:59 +0100, Will Deacon wrote:
> > On Thu, Jul 16, 2015 at 10:04:34AM +0100, Yong Wu wrote:
> > > +static void mtk_iommu_tlb_flush_all(void *cookie)
> > > +{
> > > +       struct mtk_iommu_domain *domain = cookie;
> > > +       void __iomem *base;
> > > +
> > > +       base = domain->data->base;
> > > +       writel(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
> > > +       writel(F_ALL_INVLD, base + REG_MMU_INVALIDATE);
> > 
> > This needs to be synchronous, so you probably want to call
> > mtk_iommu_tlb_sync at the end.
> 
> From our spec, we have to wait until HW done after tlb flush range.
> But it don't need wait after tlb flush all.
> so It isn't necessary to add mtk_iommu_tlb_sync in tlb_flush_all here.

Okey doke, but I'm surprised you don't need a subsequent DSB or read-back.
What if the writel is buffered on the way to the IOMMU?

Will
