From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Oct 2017 18:15:45 +0100
Subject: [PATCH 09/17] coresight: Convert driver messages to dev_dbg
In-Reply-To: <20171019171553.24056-1-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
Message-ID: <20171019171553.24056-10-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert component enable/disable messages from dev_info to dev_dbg.
This is required to prevent LOCKDEP splats when operating in perf
mode where we could be called with locks held to enable a coresight
path. If someone wants to really see the messages, they can always
enable it at runtime via dynamic_debug.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-dynamic-replicator.c | 4 ++--
 drivers/hwtracing/coresight/coresight-etb10.c              | 6 +++---
 drivers/hwtracing/coresight/coresight-etm3x.c              | 4 ++--
 drivers/hwtracing/coresight/coresight-etm4x.c              | 4 ++--
 drivers/hwtracing/coresight/coresight-funnel.c             | 4 ++--
 drivers/hwtracing/coresight/coresight-replicator.c         | 4 ++--
 drivers/hwtracing/coresight/coresight-stm.c                | 4 ++--
 drivers/hwtracing/coresight/coresight-tmc-etf.c            | 8 ++++----
 drivers/hwtracing/coresight/coresight-tmc-etr.c            | 4 ++--
 drivers/hwtracing/coresight/coresight-tmc.c                | 4 ++--
 drivers/hwtracing/coresight/coresight-tpiu.c               | 4 ++--
 11 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
index accc2056f7c6..49efa9d90367 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -64,7 +64,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 
 	CS_LOCK(drvdata->base);
 
-	dev_info(drvdata->dev, "REPLICATOR enabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
 	return 0;
 }
 
@@ -83,7 +83,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 
 	CS_LOCK(drvdata->base);
 
-	dev_info(drvdata->dev, "REPLICATOR disabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index d7164ab8e229..757f556975f7 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -164,7 +164,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 out:
-	dev_info(drvdata->dev, "ETB enabled\n");
+	dev_dbg(drvdata->dev, "ETB enabled\n");
 	return 0;
 }
 
@@ -270,7 +270,7 @@ static void etb_disable(struct coresight_device *csdev)
 
 	local_set(&drvdata->mode, CS_MODE_DISABLED);
 
-	dev_info(drvdata->dev, "ETB disabled\n");
+	dev_dbg(drvdata->dev, "ETB disabled\n");
 }
 
 static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
@@ -513,7 +513,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "ETB dumped\n");
+	dev_dbg(drvdata->dev, "ETB dumped\n");
 }
 
 static int etb_open(struct inode *inode, struct file *file)
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index e5b1ec57dbde..aa8a2b076ad4 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -510,7 +510,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	drvdata->sticky_enable = true;
 	spin_unlock(&drvdata->spinlock);
 
-	dev_info(drvdata->dev, "ETM tracing enabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
 	return 0;
 
 err:
@@ -613,7 +613,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
-	dev_info(drvdata->dev, "ETM tracing disabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing disabled\n");
 }
 
 static void etm_disable(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index e84d80b008fc..c9c73c2f7fd8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -274,7 +274,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 	drvdata->sticky_enable = true;
 	spin_unlock(&drvdata->spinlock);
 
-	dev_info(drvdata->dev, "ETM tracing enabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
 	return 0;
 
 err:
@@ -387,7 +387,7 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
-	dev_info(drvdata->dev, "ETM tracing disabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing disabled\n");
 }
 
 static void etm4_disable(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 77642e0e955b..afdf4807c2dc 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -72,7 +72,7 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 
 	funnel_enable_hw(drvdata, inport);
 
-	dev_info(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
+	dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
 	return 0;
 }
 
@@ -96,7 +96,7 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 
 	funnel_disable_hw(drvdata, inport);
 
-	dev_info(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
+	dev_dbg(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
 }
 
 static const struct coresight_ops_link funnel_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 3756e71cb8f5..4f7781203fd4 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -42,7 +42,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	dev_info(drvdata->dev, "REPLICATOR enabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
 	return 0;
 }
 
@@ -51,7 +51,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	dev_info(drvdata->dev, "REPLICATOR disabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 92a780a6df1d..696455891ec4 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -218,7 +218,7 @@ static int stm_enable(struct coresight_device *csdev,
 	stm_enable_hw(drvdata);
 	spin_unlock(&drvdata->spinlock);
 
-	dev_info(drvdata->dev, "STM tracing enabled\n");
+	dev_dbg(drvdata->dev, "STM tracing enabled\n");
 	return 0;
 }
 
@@ -281,7 +281,7 @@ static void stm_disable(struct coresight_device *csdev,
 		pm_runtime_put(drvdata->dev);
 
 		local_set(&drvdata->mode, CS_MODE_DISABLED);
-		dev_info(drvdata->dev, "STM tracing disabled\n");
+		dev_dbg(drvdata->dev, "STM tracing disabled\n");
 	}
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d89bfb3042a2..aa4e8f03ef49 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -242,7 +242,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 	if (ret)
 		return ret;
 
-	dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETB/ETF enabled\n");
 	return 0;
 }
 
@@ -265,7 +265,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETB/ETF disabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETB/ETF disabled\n");
 }
 
 static int tmc_enable_etf_link(struct coresight_device *csdev,
@@ -284,7 +284,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	drvdata->mode = CS_MODE_SYSFS;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETF enabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
 	return 0;
 }
 
@@ -304,7 +304,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	drvdata->mode = CS_MODE_DISABLED;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETF disabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETF disabled\n");
 }
 
 static void *tmc_alloc_etf_buffer(struct coresight_device *csdev, int cpu,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 9e41eeaa5284..f12b7c5f68b2 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1142,7 +1142,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		tmc_etr_free_sysfs_buf(free_buf);
 
 	if (!ret)
-		dev_info(drvdata->dev, "TMC-ETR enabled\n");
+		dev_dbg(drvdata->dev, "TMC-ETR enabled\n");
 
 	return ret;
 }
@@ -1185,7 +1185,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETR disabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETR disabled\n");
 }
 
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 2349b1805694..4939333cc6c7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -88,7 +88,7 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 	}
 
 	if (!ret)
-		dev_info(drvdata->dev, "TMC read start\n");
+		dev_dbg(drvdata->dev, "TMC read start\n");
 
 	return ret;
 }
@@ -110,7 +110,7 @@ static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
 	}
 
 	if (!ret)
-		dev_info(drvdata->dev, "TMC read end\n");
+		dev_dbg(drvdata->dev, "TMC read end\n");
 
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index d7a3e453016d..7b105001dc32 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -77,7 +77,7 @@ static int tpiu_enable(struct coresight_device *csdev, u32 mode)
 
 	tpiu_enable_hw(drvdata);
 
-	dev_info(drvdata->dev, "TPIU enabled\n");
+	dev_dbg(drvdata->dev, "TPIU enabled\n");
 	return 0;
 }
 
@@ -99,7 +99,7 @@ static void tpiu_disable(struct coresight_device *csdev)
 
 	tpiu_disable_hw(drvdata);
 
-	dev_info(drvdata->dev, "TPIU disabled\n");
+	dev_dbg(drvdata->dev, "TPIU disabled\n");
 }
 
 static const struct coresight_ops_sink tpiu_sink_ops = {
-- 
2.13.6
