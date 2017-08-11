From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 11 Aug 2017 17:56:15 +0800
Subject: [PATCH 6/8] iommu/mediatek: Enlarge the validate PA range for 4GB mode
In-Reply-To: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
References: <1502445377-26936-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1502445377-26936-7-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is for 4GB mode, mainly for 4 issues:
1) Fix a 4GB bug:
   if the dram base is 0x4000_0000, the dram size is 0xc000_0000.
   then the code just meet a corner case because max_pfn is
   0x10_0000.
   data->enable_4GB = !!(max_pfn > (0xffffffffUL >> PAGE_SHIFT));
   It's true at the case above. That isn't unexpected.
2) In mt2712, there is a new register for the 4GB PA range(0x118)
   we should enlarge the max PA range, or the HW will report
   error.
   The dram range is from 0x1_0000_0000 to 0x1_ffff_ffff in the 4GB
   mode, we cut out the bit[32:30] of the SA(Start address) and
   EA(End address) into this REG_MMU_VLD_PA_RNG(0x118).
3) In mt2712, the register(0x13c) is extended for 4GB mode.
   bit[7:6] indicate the valid PA[32:33]. Thus, we don't mask the
   value and print it directly for debug.
4) if 4GB is enabled, the dram PA range is from 0x1_0000_0000 to
   0x1_ffff_ffff. Thus, the PA from iova_to_pa should also '|' BIT(32)

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
this patch also include bug-fix for mt8173 and mt2712.
I also don't split them.
---
 drivers/iommu/mtk_iommu.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index b7c8e52..a3817e0 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -60,6 +60,8 @@
 
 #define REG_MMU_IVRP_PADDR			0x114
 #define F_MMU_IVRP_PA_SET(pa, ext)		(((pa) >> 1) | ((!!(ext)) << 31))
+#define REG_MMU_VLD_PA_RNG			0x118
+#define F_MMU_VLD_PA_RNG(EA, SA)		(((EA) << 8) | (SA))
 
 #define REG_MMU_INT_CONTROL0			0x120
 #define F_L2_MULIT_HIT_EN			BIT(0)
@@ -84,7 +86,6 @@
 #define REG_MMU_FAULT_ST1			0x134
 
 #define REG_MMU_FAULT_VA			0x13c
-#define F_MMU_FAULT_VA_MSK			0xfffff000
 #define F_MMU_FAULT_VA_WRITE_BIT		BIT(1)
 #define F_MMU_FAULT_VA_LAYER_BIT		BIT(0)
 
@@ -206,7 +207,6 @@ static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
 	fault_iova = readl_relaxed(data->base + REG_MMU_FAULT_VA);
 	layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
 	write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
-	fault_iova &= F_MMU_FAULT_VA_MSK;
 	fault_pa = readl_relaxed(data->base + REG_MMU_INVLD_PA);
 	regval = readl_relaxed(data->base + REG_MMU_INT_ID);
 	fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
@@ -385,6 +385,7 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 					  dma_addr_t iova)
 {
 	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
+	struct mtk_iommu_data *data = mtk_iommu_get_m4u_data();
 	unsigned long flags;
 	phys_addr_t pa;
 
@@ -392,6 +393,9 @@ static phys_addr_t mtk_iommu_iova_to_phys(struct iommu_domain *domain,
 	pa = dom->iop->iova_to_phys(dom->iop, iova);
 	spin_unlock_irqrestore(&dom->pgtlock, flags);
 
+	if (data->enable_4GB)
+		pa |= BIT(32);
+
 	return pa;
 }
 
@@ -522,6 +526,14 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 
 	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
 		       data->base + REG_MMU_IVRP_PADDR);
+	if (data->enable_4GB && data->m4u_type != M4U_MT8173) {
+		/*
+		 * If 4GB mode is enabled, the validate PA range is from
+		 * 0x1_0000_0000 to 0x1_ffff_ffff. here record bit[32:30].
+		 */
+		regval = F_MMU_VLD_PA_RNG(7, 4);
+		writel_relaxed(regval, data->base + REG_MMU_VLD_PA_RNG);
+	}
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
 
 	/* It's MISC control register whose default value is ok except mt8173.*/
@@ -567,7 +579,7 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
 
 	/* Whether the current dram is over 4GB */
-	data->enable_4GB = !!(max_pfn > (0xffffffffUL >> PAGE_SHIFT));
+	data->enable_4GB = !!(max_pfn > (BIT(32) >> PAGE_SHIFT));
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->base = devm_ioremap_resource(dev, res);
-- 
1.9.1
