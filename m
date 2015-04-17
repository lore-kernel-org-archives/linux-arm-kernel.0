From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 17 Apr 2015 10:58:54 +0200
Subject: [PATCH 07/13] coresight: tmc: let runtime PM handle core clock
In-Reply-To: <1429261140-13910-1-git-send-email-linus.walleij@linaro.org>
References: <1429261140-13910-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1429261140-13910-8-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This uses runtime PM to manage the PCLK ("amba_pclk") instead
of screwing around with the framework by going in and taking
a copy from the amba device. The amba bus core will uprepare
and disable the clock when the device is unused when
CONFIG_PM is selected, else the clock will be always on.

Prior to this patch, as the AMBA primecell bus code enables
the PCLK, it would be left on after probe as
the clk_prepare_enable() and clk_disable_unprepare() was
called and thus just increase and decreas the refcount by
one, without it reaching zero and actually disabling the
clock. Now the runtime PM callbacks will make sure the PCLK
is properly disabled after probe.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/coresight/coresight-tmc.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/coresight/coresight-tmc.c b/drivers/coresight/coresight-tmc.c
index 3ff232f9ddf7..db917c70d2b3 100644
--- a/drivers/coresight/coresight-tmc.c
+++ b/drivers/coresight/coresight-tmc.c
@@ -23,7 +23,7 @@
 #include <linux/slab.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
-#include <linux/clk.h>
+#include <linux/pm_runtime.h>
 #include <linux/of.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
@@ -104,7 +104,6 @@ enum tmc_mem_intf_width {
  * @dev:	the device entity associated to this component.
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
- * @clk:	the clock this component is associated to.
  * @spinlock:	only one at a time pls.
  * @read_count:	manages preparation of buffer for reading.
  * @buf:	area of memory where trace data get sent.
@@ -120,7 +119,6 @@ struct tmc_drvdata {
 	struct device		*dev;
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
-	struct clk		*clk;
 	spinlock_t		spinlock;
 	int			read_count;
 	bool			reading;
@@ -242,17 +240,14 @@ static void tmc_etf_enable_hw(struct tmc_drvdata *drvdata)
 
 static int tmc_enable(struct tmc_drvdata *drvdata, enum tmc_mode mode)
 {
-	int ret;
 	unsigned long flags;
 
-	ret = clk_prepare_enable(drvdata->clk);
-	if (ret)
-		return ret;
+	pm_runtime_get_sync(drvdata->dev);
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 	if (drvdata->reading) {
 		spin_unlock_irqrestore(&drvdata->spinlock, flags);
-		clk_disable_unprepare(drvdata->clk);
+		pm_runtime_put(drvdata->dev);
 		return -EBUSY;
 	}
 
@@ -386,7 +381,7 @@ out:
 	drvdata->enable = false;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	clk_disable_unprepare(drvdata->clk);
+	pm_runtime_put(drvdata->dev);
 
 	dev_info(drvdata->dev, "TMC disabled\n");
 }
@@ -644,11 +639,6 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 
 	spin_lock_init(&drvdata->spinlock);
 
-	drvdata->clk = adev->pclk;
-	ret = clk_prepare_enable(drvdata->clk);
-	if (ret)
-		return ret;
-
 	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
 	drvdata->config_type = BMVAL(devid, 6, 7);
 
@@ -663,7 +653,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		drvdata->size = readl_relaxed(drvdata->base + TMC_RSZ) * 4;
 	}
 
-	clk_disable_unprepare(drvdata->clk);
+	pm_runtime_put(&adev->dev);
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
 		drvdata->vaddr = dma_alloc_coherent(dev, drvdata->size,
-- 
1.9.3
