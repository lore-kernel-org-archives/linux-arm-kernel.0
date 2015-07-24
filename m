From: shenwei.wang@freescale.com (Shenwei Wang)
Date: Fri, 24 Jul 2015 12:12:59 -0500
Subject: [PATCH 1/1] misc: sram: add dev_pm_ops to support module power gate
Message-ID: <1437757979-25889-1-git-send-email-shenwei.wang@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When system goes into low power states like SUSPEND_MEM and
HIBERNATION, the hardware IP block may be powered off to reduce
the power consumption. This power down will lost all the
data inside the ram. This patch added the dev_pm_ops and
implemented two callbacks: suspend_noirq and resume_noirq, which
will save the data in the on-chip-ram right before power down
and restore it after system resumes.

A new property string named "can-power-gate" is added to
the devicetree bindings too.

Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
Signed-off-by: Anson Huang <b20788@freescale.com>
---
 Documentation/devicetree/bindings/misc/sram.txt |  2 ++
 drivers/misc/sram.c                             | 44 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/sram.txt b/Documentation/devicetree/bindings/misc/sram.txt
index 36cbe5a..1170086 100644
--- a/Documentation/devicetree/bindings/misc/sram.txt
+++ b/Documentation/devicetree/bindings/misc/sram.txt
@@ -33,6 +33,8 @@ Optional properties in the area nodes:
 
 - compatible : standard definition, should contain a vendor specific string
                in the form <vendor>,[<device>-]<usage>
+- can-power-gate: a property to tell the driver that the sram can support
+		power gate
 
 Example:
 
diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index 15c33cc..924692c 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -30,6 +30,7 @@
 
 struct sram_dev {
 	struct device *dev;
+	void *power_off_save;
 	void __iomem *virt_base;
 
 	struct gen_pool *pool;
@@ -156,6 +157,37 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
 	return ret;
 }
 
+static int sram_suspend_noirq(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sram_dev *sram = platform_get_drvdata(pdev);
+
+	if (!sram->power_off_save)
+		return 0;
+
+	/* Save necessary regs */
+	clk_enable(sram->clk);
+	memcpy(sram->power_off_save, sram->virt_base,gen_pool_size(sram->pool));
+	clk_disable(sram->clk);
+
+	return 0;
+}
+
+static int sram_resume_noirq(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct sram_dev *sram = platform_get_drvdata(pdev);
+
+	if (!sram->power_off_save)
+		return 0;
+
+	clk_enable(sram->clk);
+	memcpy(sram->virt_base, sram->power_off_save, gen_pool_size(sram->pool));
+	clk_disable(sram->clk);
+
+	return 0;
+}
+
 static int sram_probe(struct platform_device *pdev)
 {
 	struct sram_dev *sram;
@@ -203,6 +235,12 @@ static int sram_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, sram);
 
+	if (of_get_property(pdev->dev.of_node, "can-power-gate", NULL))
+	{
+		sram->power_off_save = devm_kzalloc(&pdev->dev,
+				gen_pool_size(sram->pool), GFP_KERNEL);
+	}
+
 	dev_dbg(sram->dev, "SRAM pool: %zu KiB @ 0x%p\n",
 		gen_pool_size(sram->pool) / 1024, sram->virt_base);
 
@@ -229,10 +267,16 @@ static const struct of_device_id sram_dt_ids[] = {
 };
 #endif
 
+static const struct dev_pm_ops sram_pm_ops = {
+	.suspend_noirq = sram_suspend_noirq,
+	.resume_noirq = sram_resume_noirq,
+};
+
 static struct platform_driver sram_driver = {
 	.driver = {
 		.name = "sram",
 		.of_match_table = of_match_ptr(sram_dt_ids),
+		.pm	= &sram_pm_ops,
 	},
 	.probe = sram_probe,
 	.remove = sram_remove,
-- 
2.5.0.rc2
