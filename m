From: axel.lin@ingics.com (Axel Lin)
Date: Sat, 09 Mar 2013 16:49:41 +0800
Subject: [PATCH] mfd: ab8500-gpadc: Complain if we fail to enable vtvout LDO
Message-ID: <1362818981.6371.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit c8801a8e
"regulator: core: Mark all get and enable calls as __must_check",
we must check return value of regulator_enable() to silence below build warning.

  CC      drivers/mfd/ab8500-gpadc.o
drivers/mfd/ab8500-gpadc.c: In function 'ab8500_gpadc_runtime_resume':
drivers/mfd/ab8500-gpadc.c:598:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]
drivers/mfd/ab8500-gpadc.c: In function 'ab8500_gpadc_probe':
drivers/mfd/ab8500-gpadc.c:655:18: warning: ignoring return value of 'regulator_enable', declared with attribute warn_unused_result [-Wunused-result]

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/mfd/ab8500-gpadc.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/mfd/ab8500-gpadc.c b/drivers/mfd/ab8500-gpadc.c
index b1f3561..e005670 100644
--- a/drivers/mfd/ab8500-gpadc.c
+++ b/drivers/mfd/ab8500-gpadc.c
@@ -594,9 +594,12 @@ static int ab8500_gpadc_runtime_suspend(struct device *dev)
 static int ab8500_gpadc_runtime_resume(struct device *dev)
 {
 	struct ab8500_gpadc *gpadc = dev_get_drvdata(dev);
+	int ret;
 
-	regulator_enable(gpadc->regu);
-	return 0;
+	ret = regulator_enable(gpadc->regu);
+	if (ret)
+		dev_err(dev, "Failed to enable vtvout LDO: %d\n", ret);
+	return ret;
 }
 
 static int ab8500_gpadc_runtime_idle(struct device *dev)
@@ -652,7 +655,11 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, gpadc);
 
-	regulator_enable(gpadc->regu);
+	ret = regulator_enable(gpadc->regu);
+	if (ret) {
+		dev_err(gpadc->dev, "Failed to enable vtvout LDO: %d\n", ret);
+		goto fail_enable;
+	}
 
 	pm_runtime_set_autosuspend_delay(gpadc->dev, GPADC_AUDOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(gpadc->dev);
@@ -663,6 +670,9 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
 	list_add_tail(&gpadc->node, &ab8500_gpadc_list);
 	dev_dbg(gpadc->dev, "probe success\n");
 	return 0;
+
+fail_enable:
+	regulator_disable(gpadc->regu);
 fail_irq:
 	free_irq(gpadc->irq, gpadc);
 fail:
-- 
1.7.9.5
