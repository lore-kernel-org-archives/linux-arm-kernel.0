From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:14 -0600
Subject: [PATCH 06/14] coresight: tmc: making prepare/unprepare functions
 generic
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-7-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dealing with HW related matters in tmc_read_prepare/unprepare
becomes convoluted when many cases need to be handled distinctively.

As such moving processing related to HW setup to individual driver
files and keep the core driver generic.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 68 ++++++++++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 50 +++++++++++++++++-
 drivers/hwtracing/coresight/coresight-tmc.c     | 55 ++++----------------
 drivers/hwtracing/coresight/coresight-tmc.h     |  8 +--
 4 files changed, 131 insertions(+), 50 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 467d19221f7b..789384be81b6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -71,7 +71,7 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 	}
 }
 
-void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
+static void tmc_etb_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -202,3 +202,69 @@ const struct coresight_ops tmc_etf_cs_ops = {
 	.sink_ops	= &tmc_etf_sink_ops,
 	.link_ops	= &tmc_etf_link_ops,
 };
+
+int tmc_read_prepare_etf(struct tmc_drvdata *drvdata)
+{
+	int ret = 0;
+	enum tmc_mode mode;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* The TMC isn't enable, so there is no need to disable it */
+	if (!drvdata->enable)
+		goto out;
+
+	if (drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
+	    drvdata->config_type != TMC_CONFIG_TYPE_ETF) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* There is no point in reading a TMC in HW FIFO mode */
+	mode = readl_relaxed(drvdata->base + TMC_MODE);
+	if (mode != TMC_MODE_CIRCULAR_BUFFER) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tmc_etb_disable_hw(drvdata);
+	drvdata->reading = true;
+
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
+}
+
+int tmc_read_unprepare_etf(struct tmc_drvdata *drvdata)
+{
+	int ret = 0;
+	enum tmc_mode mode;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* The TMC isn't enable, so there is no need to enable it */
+	if (!drvdata->enable)
+		goto out;
+
+	if (drvdata->config_type != TMC_CONFIG_TYPE_ETB &&
+	    drvdata->config_type != TMC_CONFIG_TYPE_ETF) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* There is no point in reading a TMC in HW FIFO mode */
+	mode = readl_relaxed(drvdata->base + TMC_MODE);
+	if (mode != TMC_MODE_CIRCULAR_BUFFER) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tmc_etb_enable_hw(drvdata);
+	drvdata->reading = false;
+
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
+}
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 910d6f3b7d26..e1b43e0bd1dd 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -70,7 +70,7 @@ static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 		drvdata->buf = drvdata->vaddr;
 }
 
-void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
+static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
 {
 	CS_UNLOCK(drvdata->base);
 
@@ -126,3 +126,51 @@ static const struct coresight_ops_sink tmc_etr_sink_ops = {
 const struct coresight_ops tmc_etr_cs_ops = {
 	.sink_ops	= &tmc_etr_sink_ops,
 };
+
+int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* The TMC isn't enable, so there is no need to disable it */
+	if (!drvdata->enable)
+		goto out;
+
+	if (drvdata->config_type != TMC_CONFIG_TYPE_ETR) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tmc_etr_disable_hw(drvdata);
+	drvdata->reading = true;
+
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
+}
+
+int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata)
+{
+	int ret = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+
+	/* The TMC isn't enable, so there is no need to enable it */
+	if (!drvdata->enable)
+		goto out;
+
+	if (drvdata->config_type != TMC_CONFIG_TYPE_ETR) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	tmc_etr_enable_hw(drvdata);
+	drvdata->reading = false;
+
+out:
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	return ret;
+}
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index bc31131e4bd5..26dbef305851 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -75,76 +75,43 @@ void tmc_disable_hw(struct tmc_drvdata *drvdata)
 static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
-	unsigned long flags;
-	enum tmc_mode mode;
-
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (!drvdata->enable)
-		goto out;
 
 	switch (drvdata->config_type) {
 	case TMC_CONFIG_TYPE_ETB:
-		tmc_etb_disable_hw(drvdata);
-		break;
 	case TMC_CONFIG_TYPE_ETF:
-		/* There is no point in reading a TMC in HW FIFO mode */
-		mode = readl_relaxed(drvdata->base + TMC_MODE);
-		if (mode != TMC_MODE_CIRCULAR_BUFFER) {
-			ret = -EINVAL;
-			goto err;
-		}
-
-		tmc_etb_disable_hw(drvdata);
+		ret = tmc_read_prepare_etf(drvdata);
 		break;
 	case TMC_CONFIG_TYPE_ETR:
-		tmc_etr_disable_hw(drvdata);
+		ret = tmc_read_prepare_etr(drvdata);
 		break;
 	default:
 		ret = -EINVAL;
-		goto err;
 	}
 
-out:
-	drvdata->reading = true;
-	dev_info(drvdata->dev, "TMC read start\n");
-err:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	if (!ret)
+		dev_info(drvdata->dev, "TMC read start\n");
+
 	return ret;
 }
 
 static void tmc_read_unprepare(struct tmc_drvdata *drvdata)
 {
-	unsigned long flags;
-	enum tmc_mode mode;
-
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	if (!drvdata->enable)
-		goto out;
+	int ret = 0;
 
 	switch (drvdata->config_type) {
 	case TMC_CONFIG_TYPE_ETB:
-		tmc_etb_enable_hw(drvdata);
-		break;
 	case TMC_CONFIG_TYPE_ETF:
-		/* Make sure we don't re-enable a TMC in HW FIFO mode */
-		mode = readl_relaxed(drvdata->base + TMC_MODE);
-		if (mode != TMC_MODE_CIRCULAR_BUFFER)
-			goto err;
-
-		tmc_etb_enable_hw(drvdata);
+		ret = tmc_read_unprepare_etf(drvdata);
 		break;
 	case TMC_CONFIG_TYPE_ETR:
-		tmc_etr_disable_hw(drvdata);
+		ret = tmc_read_unprepare_etr(drvdata);
 		break;
 	default:
-		goto err;
+		ret = -EINVAL;
 	}
 
-out:
-	drvdata->reading = false;
-	dev_info(drvdata->dev, "TMC read end\n");
-err:
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+	if (!ret)
+		dev_info(drvdata->dev, "TMC read end\n");
 }
 
 static int tmc_open(struct inode *inode, struct file *file)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index b99d4dfc1d0b..6b11caf77ad1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -128,13 +128,13 @@ void tmc_enable_hw(struct tmc_drvdata *drvdata);
 void tmc_disable_hw(struct tmc_drvdata *drvdata);
 
 /* ETB/ETF functions */
-void tmc_etb_enable_hw(struct tmc_drvdata *drvdata);
-void tmc_etb_disable_hw(struct tmc_drvdata *drvdata);
+int tmc_read_prepare_etf(struct tmc_drvdata *drvdata);
+int tmc_read_unprepare_etf(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etb_cs_ops;
 extern const struct coresight_ops tmc_etf_cs_ops;
 
 /* ETR functions */
-void tmc_etr_enable_hw(struct tmc_drvdata *drvdata);
-void tmc_etr_disable_hw(struct tmc_drvdata *drvdata);
+int tmc_read_prepare_etr(struct tmc_drvdata *drvdata);
+int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etr_cs_ops;
 #endif
-- 
2.1.4
