From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:11 -0600
Subject: [PATCH 03/14] coresight: tmc: re-implementing
 tmc_read_prepare/unprepare() functions
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In their current implementation the tmc_read_prepare/unprepare()
are a lump of if/else that is difficult to read.  This patch is
alleviating that by using a switch statement.  The latter also
allows for a better control on the error path.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 56 ++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index f4ba837a0810..208d47dd3083 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -430,7 +430,7 @@ static const struct coresight_ops tmc_etf_cs_ops = {
 
 static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
-	int ret;
+	int ret = 0;
 	unsigned long flags;
 	enum tmc_mode mode;
 
@@ -438,25 +438,31 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 	if (!drvdata->enable)
 		goto out;
 
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETB) {
+	switch (drvdata->config_type) {
+	case TMC_CONFIG_TYPE_ETB:
 		tmc_etb_disable_hw(drvdata);
-	} else if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
-		tmc_etr_disable_hw(drvdata);
-	} else {
+		break;
+	case TMC_CONFIG_TYPE_ETF:
+		/* There is no point in reading a TMC in HW FIFO mode */
 		mode = readl_relaxed(drvdata->base + TMC_MODE);
-		if (mode == TMC_MODE_CIRCULAR_BUFFER) {
-			tmc_etb_disable_hw(drvdata);
-		} else {
-			ret = -ENODEV;
+		if (mode != TMC_MODE_CIRCULAR_BUFFER) {
+			ret = -EINVAL;
 			goto err;
 		}
+
+		tmc_etb_disable_hw(drvdata);
+		break;
+	case TMC_CONFIG_TYPE_ETR:
+		tmc_etr_disable_hw(drvdata);
+		break;
+	default:
+		ret = -EINVAL;
+		goto err;
 	}
+
 out:
 	drvdata->reading = true;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
 	dev_info(drvdata->dev, "TMC read start\n");
-	return 0;
 err:
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return ret;
@@ -471,20 +477,30 @@ static void tmc_read_unprepare(struct tmc_drvdata *drvdata)
 	if (!drvdata->enable)
 		goto out;
 
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETB) {
+	switch (drvdata->config_type) {
+	case TMC_CONFIG_TYPE_ETB:
 		tmc_etb_enable_hw(drvdata);
-	} else if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
-		tmc_etr_enable_hw(drvdata);
-	} else {
+		break;
+	case TMC_CONFIG_TYPE_ETF:
+		/* Make sure we don't re-enable a TMC in HW FIFO mode */
 		mode = readl_relaxed(drvdata->base + TMC_MODE);
-		if (mode == TMC_MODE_CIRCULAR_BUFFER)
-			tmc_etb_enable_hw(drvdata);
+		if (mode != TMC_MODE_CIRCULAR_BUFFER)
+			goto err;
+
+		tmc_etb_enable_hw(drvdata);
+		break;
+	case TMC_CONFIG_TYPE_ETR:
+		tmc_etr_disable_hw(drvdata);
+		break;
+	default:
+		goto err;
 	}
+
 out:
 	drvdata->reading = false;
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
 	dev_info(drvdata->dev, "TMC read end\n");
+err:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 }
 
 static int tmc_open(struct inode *inode, struct file *file)
-- 
2.1.4
