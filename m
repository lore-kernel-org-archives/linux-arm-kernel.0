From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 23 Apr 2014 21:52:03 +0200
Subject: [PATCH 3/4] dma: ste_dma40: Convert to PM macros while providing the
 PM callbacks
In-Reply-To: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
References: <1398282724-2607-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1398282724-2607-3-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Converting to the PM macros makes us simplify and remove some code.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/dma/ste_dma40.c |  150 ++++++++++++++++++++++-------------------------
 1 file changed, 71 insertions(+), 79 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 45e809f..0b29af3 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1054,62 +1054,6 @@ static int d40_sg_2_dmalen(struct scatterlist *sgl, int sg_len,
 	return len;
 }
 
-
-#ifdef CONFIG_PM
-static void dma40_backup(void __iomem *baseaddr, u32 *backup,
-			 u32 *regaddr, int num, bool save)
-{
-	int i;
-
-	for (i = 0; i < num; i++) {
-		void __iomem *addr = baseaddr + regaddr[i];
-
-		if (save)
-			backup[i] = readl_relaxed(addr);
-		else
-			writel_relaxed(backup[i], addr);
-	}
-}
-
-static void d40_save_restore_registers(struct d40_base *base, bool save)
-{
-	int i;
-
-	/* Save/Restore channel specific registers */
-	for (i = 0; i < base->num_phy_chans; i++) {
-		void __iomem *addr;
-		int idx;
-
-		if (base->phy_res[i].reserved)
-			continue;
-
-		addr = base->virtbase + D40_DREG_PCBASE + i * D40_DREG_PCDELTA;
-		idx = i * ARRAY_SIZE(d40_backup_regs_chan);
-
-		dma40_backup(addr, &base->reg_val_backup_chan[idx],
-			     d40_backup_regs_chan,
-			     ARRAY_SIZE(d40_backup_regs_chan),
-			     save);
-	}
-
-	/* Save/Restore global registers */
-	dma40_backup(base->virtbase, base->reg_val_backup,
-		     d40_backup_regs, ARRAY_SIZE(d40_backup_regs),
-		     save);
-
-	/* Save/Restore registers only existing on dma40 v3 and later */
-	if (base->gen_dmac.backup)
-		dma40_backup(base->virtbase, base->reg_val_backup_v4,
-			     base->gen_dmac.backup,
-			base->gen_dmac.backup_size,
-			save);
-}
-#else
-static void d40_save_restore_registers(struct d40_base *base, bool save)
-{
-}
-#endif
-
 static int __d40_execute_command_phy(struct d40_chan *d40c,
 				     enum d40_command command)
 {
@@ -2996,8 +2940,8 @@ failure1:
 }
 
 /* Suspend resume functionality */
-#ifdef CONFIG_PM
-static int dma40_pm_suspend(struct device *dev)
+#ifdef CONFIG_PM_SLEEP
+static int dma40_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
 	struct d40_base *base = platform_get_drvdata(pdev);
@@ -3008,6 +2952,69 @@ static int dma40_pm_suspend(struct device *dev)
 	return ret;
 }
 
+static int dma40_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct d40_base *base = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	if (base->lcpa_regulator)
+		ret = regulator_enable(base->lcpa_regulator);
+
+	return ret;
+}
+#endif
+
+#ifdef CONFIG_PM
+static void dma40_backup(void __iomem *baseaddr, u32 *backup,
+			 u32 *regaddr, int num, bool save)
+{
+	int i;
+
+	for (i = 0; i < num; i++) {
+		void __iomem *addr = baseaddr + regaddr[i];
+
+		if (save)
+			backup[i] = readl_relaxed(addr);
+		else
+			writel_relaxed(backup[i], addr);
+	}
+}
+
+static void d40_save_restore_registers(struct d40_base *base, bool save)
+{
+	int i;
+
+	/* Save/Restore channel specific registers */
+	for (i = 0; i < base->num_phy_chans; i++) {
+		void __iomem *addr;
+		int idx;
+
+		if (base->phy_res[i].reserved)
+			continue;
+
+		addr = base->virtbase + D40_DREG_PCBASE + i * D40_DREG_PCDELTA;
+		idx = i * ARRAY_SIZE(d40_backup_regs_chan);
+
+		dma40_backup(addr, &base->reg_val_backup_chan[idx],
+			     d40_backup_regs_chan,
+			     ARRAY_SIZE(d40_backup_regs_chan),
+			     save);
+	}
+
+	/* Save/Restore global registers */
+	dma40_backup(base->virtbase, base->reg_val_backup,
+		     d40_backup_regs, ARRAY_SIZE(d40_backup_regs),
+		     save);
+
+	/* Save/Restore registers only existing on dma40 v3 and later */
+	if (base->gen_dmac.backup)
+		dma40_backup(base->virtbase, base->reg_val_backup_v4,
+			     base->gen_dmac.backup,
+			base->gen_dmac.backup_size,
+			save);
+}
+
 static int dma40_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -3034,29 +3041,14 @@ static int dma40_runtime_resume(struct device *dev)
 		       base->virtbase + D40_DREG_GCC);
 	return 0;
 }
-
-static int dma40_resume(struct device *dev)
-{
-	struct platform_device *pdev = to_platform_device(dev);
-	struct d40_base *base = platform_get_drvdata(pdev);
-	int ret = 0;
-
-	if (base->lcpa_regulator)
-		ret = regulator_enable(base->lcpa_regulator);
-
-	return ret;
-}
+#endif
 
 static const struct dev_pm_ops dma40_pm_ops = {
-	.suspend		= dma40_pm_suspend,
-	.runtime_suspend	= dma40_runtime_suspend,
-	.runtime_resume		= dma40_runtime_resume,
-	.resume			= dma40_resume,
+	SET_SYSTEM_SLEEP_PM_OPS(dma40_suspend, dma40_resume)
+	SET_PM_RUNTIME_PM_OPS(dma40_runtime_suspend,
+				dma40_runtime_resume,
+				NULL)
 };
-#define DMA40_PM_OPS	(&dma40_pm_ops)
-#else
-#define DMA40_PM_OPS	NULL
-#endif
 
 /* Initialization functions. */
 
@@ -3753,7 +3745,7 @@ static struct platform_driver d40_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
 		.name  = D40_NAME,
-		.pm = DMA40_PM_OPS,
+		.pm = &dma40_pm_ops,
 		.of_match_table = d40_match,
 	},
 };
-- 
1.7.9.5
