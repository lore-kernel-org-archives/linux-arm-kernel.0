From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 11 Sep 2018 15:49:55 -0600
Subject: [PATCH 5/5] coresight: Allow drivers to be verbose only in sysFS mode
In-Reply-To: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
References: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1536702595-9999-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Debug messages emitted during perf sessions are useless and have
an habit of triggering the lockdep mechanic.  As such this patch
confines driver output to the sysFS mode where the establishement
of paths between source and sink happens outside of an atomic
context.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-dynamic-replicator.c | 4 ++--
 drivers/hwtracing/coresight/coresight-etb10.c              | 6 +++---
 drivers/hwtracing/coresight/coresight-etm3x.c              | 7 +++++--
 drivers/hwtracing/coresight/coresight-etm4x.c              | 8 ++++++--
 drivers/hwtracing/coresight/coresight-funnel.c             | 6 ++++--
 drivers/hwtracing/coresight/coresight-replicator.c         | 4 ++--
 drivers/hwtracing/coresight/coresight-stm.c                | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c            | 8 ++++----
 drivers/hwtracing/coresight/coresight-tmc-etr.c            | 2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c               | 4 ++--
 10 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index de2c197886c6..ea7b19aac94c 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -56,7 +56,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "REPLICATOR enabled\n");
 	return 0;
 }
 
@@ -75,7 +75,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 79793cb51d82..78b4669e7dc7 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -211,7 +211,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode, void *data)
 	if (ret)
 		return ret;
 
-	dev_dbg(drvdata->dev, "ETB enabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "ETB enabled\n");
 	return 0;
 }
 
@@ -320,7 +320,7 @@ static void etb_disable(struct coresight_device *csdev, u32 mode)
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "ETB disabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "ETB disabled\n");
 }
 
 static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
@@ -532,7 +532,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "ETB dumped\n");
+	coresight_dev_dbg(drvdata->dev, drvdata->mode, "ETB dumped\n");
 }
 
 static int etb_open(struct inode *inode, struct file *file)
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 9ce8fba20b0f..f9e40078422e 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -358,10 +358,12 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 static void etm_enable_hw(void *info)
 {
 	int i;
-	u32 etmcr;
+	u32 etmcr, mode;
 	struct etm_drvdata *drvdata = info;
 	struct etm_config *config = &drvdata->config;
 
+	mode = local_read(&drvdata->mode);
+
 	CS_UNLOCK(drvdata->base);
 
 	/* Turn engine on */
@@ -420,7 +422,8 @@ static void etm_enable_hw(void *info)
 	etm_clr_prog(drvdata);
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
+	coresight_dev_dbg(drvdata->dev,  mode,
+			  "cpu: %d enable smp call done\n", drvdata->cpu);
 }
 
 static int etm_cpu_id(struct coresight_device *csdev)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index b7379e9cfb30..70519fea3c41 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -83,6 +83,7 @@ static void etm4_enable_hw(void *info)
 	int i;
 	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
+	u32 mode = local_read(&drvdata->mode);
 
 	CS_UNLOCK(drvdata->base);
 
@@ -177,7 +178,8 @@ static void etm4_enable_hw(void *info)
 
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d enable smp call done\n", drvdata->cpu);
+	coresight_dev_dbg(drvdata->dev, mode,
+			  "cpu: %d enable smp call done\n", drvdata->cpu);
 }
 
 static int etm4_parse_event_config(struct etmv4_drvdata *drvdata,
@@ -311,6 +313,7 @@ static void etm4_disable_hw(void *info)
 {
 	u32 control;
 	struct etmv4_drvdata *drvdata = info;
+	u32 mode = local_read(&drvdata->mode);
 
 	CS_UNLOCK(drvdata->base);
 
@@ -331,7 +334,8 @@ static void etm4_disable_hw(void *info)
 
 	CS_LOCK(drvdata->base);
 
-	dev_dbg(drvdata->dev, "cpu: %d disable smp call done\n", drvdata->cpu);
+	coresight_dev_dbg(drvdata->dev, mode,
+			  "cpu: %d disable smp call done\n", drvdata->cpu);
 }
 
 static int etm4_disable_perf(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index c1c9f5fccc4b..cc7a424cf676 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -65,7 +65,8 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 
 	funnel_enable_hw(drvdata, inport);
 
-	dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
+	coresight_dev_dbg(drvdata->dev, mode,
+			  "FUNNEL inport %d enabled\n", inport);
 	return 0;
 }
 
@@ -89,7 +90,8 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 
 	funnel_disable_hw(drvdata, inport);
 
-	dev_dbg(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
+	coresight_dev_dbg(drvdata->dev, mode,
+			  "FUNNEL inport %d disabled\n", inport);
 }
 
 static const struct coresight_ops_link funnel_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 0b749302c066..c81bbd5adf13 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -35,7 +35,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "REPLICATOR enabled\n");
 	return 0;
 }
 
@@ -44,7 +44,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 35d6f9709274..40bdcada696b 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -211,7 +211,7 @@ static int stm_enable(struct coresight_device *csdev,
 	stm_enable_hw(drvdata);
 	spin_unlock(&drvdata->spinlock);
 
-	dev_dbg(drvdata->dev, "STM tracing enabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "STM tracing enabled\n");
 	return 0;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index ce33c0f05148..ea8334f70ca7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -242,7 +242,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev,
 	if (ret)
 		return ret;
 
-	dev_dbg(drvdata->dev, "TMC-ETB/ETF enabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "TMC-ETB/ETF enabled\n");
 	return 0;
 }
 
@@ -265,7 +265,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev, u32 mode)
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "TMC-ETB/ETF disabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "TMC-ETB/ETF disabled\n");
 }
 
 static int tmc_enable_etf_link(struct coresight_device *csdev,
@@ -284,7 +284,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	drvdata->mode = CS_MODE_SYSFS;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "TMC-ETF enabled\n");
 	return 0;
 }
 
@@ -304,7 +304,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	drvdata->mode = CS_MODE_DISABLED;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "TMC-ETF disabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "TMC-ETF disabled\n");
 }
 
 static void *tmc_alloc_etf_buffer(struct coresight_device *csdev, int cpu,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index ec5100e7b7b9..51af305244d2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1383,7 +1383,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev, u32 mode)
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_dbg(drvdata->dev, "TMC-ETR disabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "TMC-ETR disabled\n");
 }
 
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 5f9fe97690fe..dc78c3ae2218 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -74,7 +74,7 @@ static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
 
 	tpiu_enable_hw(drvdata);
 
-	dev_dbg(drvdata->dev, "TPIU enabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "TPIU enabled\n");
 	return 0;
 }
 
@@ -100,7 +100,7 @@ static void tpiu_disable(struct coresight_device *csdev, u32 mode)
 
 	tpiu_disable_hw(drvdata);
 
-	dev_dbg(drvdata->dev, "TPIU disabled\n");
+	coresight_dev_dbg(drvdata->dev, mode, "TPIU disabled\n");
 }
 
 static const struct coresight_ops_sink tpiu_sink_ops = {
-- 
2.7.4
