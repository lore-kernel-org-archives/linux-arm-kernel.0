From: will.deacon@arm.com (Will Deacon)
Date: Tue, 21 Jul 2015 15:59:10 +0100
Subject: [PATCH v3 5/6] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
References: <1437037475-9065-1-git-send-email-yong.wu@mediatek.com>
 <1437037475-9065-6-git-send-email-yong.wu@mediatek.com>
Message-ID: <20150721145910.GG31095@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong Wu,

On Thu, Jul 16, 2015 at 10:04:34AM +0100, Yong Wu wrote:
> This patch adds support for mediatek m4u (MultiMedia Memory Management
> Unit).

[...]

> +static void mtk_iommu_tlb_flush_all(void *cookie)
> +{
> +       struct mtk_iommu_domain *domain = cookie;
> +       void __iomem *base;
> +
> +       base = domain->data->base;
> +       writel(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
> +       writel(F_ALL_INVLD, base + REG_MMU_INVALIDATE);

This needs to be synchronous, so you probably want to call
mtk_iommu_tlb_sync at the end.

> +}
> +
> +static void mtk_iommu_tlb_add_flush(unsigned long iova, size_t size,
> +                                   bool leaf, void *cookie)
> +{
> +       struct mtk_iommu_domain *domain = cookie;
> +       void __iomem *base = domain->data->base;
> +       unsigned int iova_start = iova, iova_end = iova + size - 1;
> +
> +       writel(F_INVLD_EN1 | F_INVLD_EN0, base + REG_MMU_INV_SEL);
> +
> +       writel(iova_start, base + REG_MMU_INVLD_START_A);
> +       writel(iova_end, base + REG_MMU_INVLD_END_A);
> +       writel(F_MMU_INV_RANGE, base + REG_MMU_INVALIDATE);

Why are you using writel instead of writel_relaxed? I asked this before
but I don't think you replied.

Will
