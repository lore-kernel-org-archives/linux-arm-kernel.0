From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 14 Mar 2016 06:01:11 +0800
Subject: [PATCH v2 2/2] iommu/mediatek: Add 4GB mode support
In-Reply-To: <1457906471-31549-1-git-send-email-yong.wu@mediatek.com>
References: <1457906471-31549-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1457906471-31549-3-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add 4GB mode support for m4u.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 721ffdb..b97de21 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -11,6 +11,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#include <linux/bootmem.h>
 #include <linux/bug.h>
 #include <linux/clk.h>
 #include <linux/component.h>
@@ -56,7 +57,7 @@
 #define F_MMU_TF_PROTECT_SEL(prot)		(((prot) & 0x3) << 5)
 
 #define REG_MMU_IVRP_PADDR			0x114
-#define F_MMU_IVRP_PA_SET(pa)			((pa) >> 1)
+#define F_MMU_IVRP_PA_SET(pa, ext)		(((pa) >> 1) | ((!!(ext)) << 31))
 
 #define REG_MMU_INT_CONTROL0			0x120
 #define F_L2_MULIT_HIT_EN			BIT(0)
@@ -125,6 +126,7 @@ struct mtk_iommu_data {
 	struct mtk_iommu_domain		*m4u_dom;
 	struct iommu_group		*m4u_group;
 	struct mtk_smi_iommu		smi_imu;      /* SMI larb iommu info */
+	bool                            enable_4GB;
 };
 
 static struct iommu_ops mtk_iommu_ops;
@@ -257,6 +259,9 @@ static int mtk_iommu_domain_finalise(struct mtk_iommu_data *data)
 		.iommu_dev = data->dev,
 	};
 
+	if (data->enable_4GB)
+		dom->cfg.quirks |= IO_PGTABLE_QUIRK_ARM_MTK_4GB;
+
 	dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
 	if (!dom->iop) {
 		dev_err(data->dev, "Failed to alloc io pgtable\n");
@@ -530,7 +535,7 @@ static int mtk_iommu_hw_init(const struct mtk_iommu_data *data)
 		F_INT_PRETETCH_TRANSATION_FIFO_FAULT;
 	writel_relaxed(regval, data->base + REG_MMU_INT_MAIN_CONTROL);
 
-	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base),
+	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
 		       data->base + REG_MMU_IVRP_PADDR);
 
 	writel_relaxed(0, data->base + REG_MMU_DCM_DIS);
@@ -592,6 +597,9 @@ static int mtk_iommu_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	data->protect_base = ALIGN(virt_to_phys(protect), MTK_PROTECT_PA_ALIGN);
 
+	/* Whether the current dram is over 4GB */
+	data->enable_4GB = !!(max_pfn > (0xffffffffUL >> PAGE_SHIFT));
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	data->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(data->base))
@@ -691,7 +699,7 @@ static int mtk_iommu_resume(struct device *dev)
 	writel_relaxed(reg->ctrl_reg, base + REG_MMU_CTRL_REG);
 	writel_relaxed(reg->int_control0, base + REG_MMU_INT_CONTROL0);
 	writel_relaxed(reg->int_main_control, base + REG_MMU_INT_MAIN_CONTROL);
-	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base),
+	writel_relaxed(F_MMU_IVRP_PA_SET(data->protect_base, data->enable_4GB),
 		       base + REG_MMU_IVRP_PADDR);
 	return 0;
 }
-- 
1.8.1.1.dirty
