From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 21 Aug 2017 19:00:19 +0800
Subject: [PATCH v2 6/8] iommu/mediatek: Disable iommu clock when system suspend
In-Reply-To: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
References: <1503313221-26453-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1503313221-26453-7-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When system suspend, infra power domain may be off, and the iommu's
clock must be disabled when system off, or the iommu's bclk clock maybe
disabled after system resume.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 drivers/iommu/mtk_iommu.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index a82196c..e21de86 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -675,6 +675,7 @@ static int __maybe_unused mtk_iommu_suspend(struct device *dev)
 	reg->ctrl_reg = readl_relaxed(base + REG_MMU_CTRL_REG);
 	reg->int_control0 = readl_relaxed(base + REG_MMU_INT_CONTROL0);
 	reg->int_main_control = readl_relaxed(base + REG_MMU_INT_MAIN_CONTROL);
+	clk_disable_unprepare(data->bclk);
 	return 0;
 }
 
@@ -683,7 +684,13 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 	struct mtk_iommu_data *data = dev_get_drvdata(dev);
 	struct mtk_iommu_suspend_reg *reg = &data->reg;
 	void __iomem *base = data->base;
+	int ret;
 
+	ret = clk_prepare_enable(data->bclk);
+	if (ret) {
+		dev_err(data->dev, "Failed to enable clk(%d) in resume\n", ret);
+		return ret;
+	}
 	writel_relaxed(reg->standard_axi_mode,
 		       base + REG_MMU_STANDARD_AXI_MODE);
 	writel_relaxed(reg->dcm_dis, base + REG_MMU_DCM_DIS);
@@ -699,7 +706,7 @@ static int __maybe_unused mtk_iommu_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops mtk_iommu_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(mtk_iommu_suspend, mtk_iommu_resume)
 };
 
 static const struct of_device_id mtk_iommu_of_ids[] = {
-- 
1.9.1
