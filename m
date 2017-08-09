From: arvind.yadav.cs@gmail.com (Arvind Yadav)
Date: Wed,  9 Aug 2017 10:18:10 +0530
Subject: [RFT v2] mfd: exynos-lpass: Handle return value of clk_prepare_enable
Message-ID: <8de486cf36afdf97792313a6b21432e04374e47e.1502253715.git.arvind.yadav.cs@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

clk_prepare_enable() can fail here and we must check its return value.
we must call pm_runtime_disable() and pm_runtime_set_suspended(),
If exynos_lpass_probe is not successful.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
changes in v2:
             added regmap_exit(lpass->top) and blank line before return.

 drivers/mfd/exynos-lpass.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/exynos-lpass.c b/drivers/mfd/exynos-lpass.c
index ca829f8..1ab7210 100644
--- a/drivers/mfd/exynos-lpass.c
+++ b/drivers/mfd/exynos-lpass.c
@@ -73,9 +73,13 @@ static void exynos_lpass_core_sw_reset(struct exynos_lpass *lpass, int mask)
 	regmap_write(lpass->top, SFR_LPASS_CORE_SW_RESET, val);
 }
 
-static void exynos_lpass_enable(struct exynos_lpass *lpass)
+static int exynos_lpass_enable(struct exynos_lpass *lpass)
 {
-	clk_prepare_enable(lpass->sfr0_clk);
+	int ret;
+
+	ret = clk_prepare_enable(lpass->sfr0_clk);
+	if (ret)
+		return ret;
 
 	/* Unmask SFR, DMA and I2S interrupt */
 	regmap_write(lpass->top, SFR_LPASS_INTR_CA5_MASK,
@@ -87,6 +91,8 @@ static void exynos_lpass_enable(struct exynos_lpass *lpass)
 	exynos_lpass_core_sw_reset(lpass, LPASS_I2S_SW_RESET);
 	exynos_lpass_core_sw_reset(lpass, LPASS_DMA_SW_RESET);
 	exynos_lpass_core_sw_reset(lpass, LPASS_MEM_SW_RESET);
+
+	return 0;
 }
 
 static void exynos_lpass_disable(struct exynos_lpass *lpass)
@@ -112,6 +118,7 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	struct exynos_lpass *lpass;
 	void __iomem *base_top;
 	struct resource *res;
+	int ret;
 
 	lpass = devm_kzalloc(dev, sizeof(*lpass), GFP_KERNEL);
 	if (!lpass)
@@ -136,7 +143,13 @@ static int exynos_lpass_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, lpass);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
-	exynos_lpass_enable(lpass);
+	ret = exynos_lpass_enable(lpass);
+	if (ret) {
+		pm_runtime_disable(dev);
+		pm_runtime_set_suspended(dev);
+		regmap_exit(lpass->top);
+		return ret;
+	}
 
 	return devm_of_platform_populate(dev);
 }
@@ -167,9 +180,7 @@ static int __maybe_unused exynos_lpass_resume(struct device *dev)
 {
 	struct exynos_lpass *lpass = dev_get_drvdata(dev);
 
-	exynos_lpass_enable(lpass);
-
-	return 0;
+	return exynos_lpass_enable(lpass);
 }
 
 static const struct dev_pm_ops lpass_pm_ops = {
-- 
1.9.1
