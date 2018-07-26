From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 26 Jul 2018 13:54:47 +0100
Subject: [PATCH v3 09/13] coresight: Convert driver messages to dev_dbg
In-Reply-To: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
References: <1532609691-16863-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1532609691-16863-10-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert component enable/disable messages from dev_info to dev_dbg.
When used with perf, the components in the paths are enabled/disabled
during each schedule of the run, which can flood the dmesg with these
messages. Moreover, they are only useful for debug purposes. So,
convert such messages to dev_dbg() which can be turned on as
needed.

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
index f6d0571..ebb8043 100644
--- a/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-dynamic-replicator.c
@@ -56,7 +56,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 
 	CS_LOCK(drvdata->base);
 
-	dev_info(drvdata->dev, "REPLICATOR enabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
 	return 0;
 }
 
@@ -75,7 +75,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 
 	CS_LOCK(drvdata->base);
 
-	dev_info(drvdata->dev, "REPLICATOR disabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index e5808fd..474c247 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -160,7 +160,7 @@ static int etb_enable(struct coresight_device *csdev, u32 mode)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 out:
-	dev_info(drvdata->dev, "ETB enabled\n");
+	dev_dbg(drvdata->dev, "ETB enabled\n");
 	return 0;
 }
 
@@ -266,7 +266,7 @@ static void etb_disable(struct coresight_device *csdev)
 
 	local_set(&drvdata->mode, CS_MODE_DISABLED);
 
-	dev_info(drvdata->dev, "ETB disabled\n");
+	dev_dbg(drvdata->dev, "ETB disabled\n");
 }
 
 static void *etb_alloc_buffer(struct coresight_device *csdev, int cpu,
@@ -509,7 +509,7 @@ static void etb_dump(struct etb_drvdata *drvdata)
 	}
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "ETB dumped\n");
+	dev_dbg(drvdata->dev, "ETB dumped\n");
 }
 
 static int etb_open(struct inode *inode, struct file *file)
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index 7c74263..9ce8fba 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -501,7 +501,7 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 	drvdata->sticky_enable = true;
 	spin_unlock(&drvdata->spinlock);
 
-	dev_info(drvdata->dev, "ETM tracing enabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
 	return 0;
 
 err:
@@ -604,7 +604,7 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
-	dev_info(drvdata->dev, "ETM tracing disabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing disabled\n");
 }
 
 static void etm_disable(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 1d94ebe..c1dcc7c 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -267,7 +267,7 @@ static int etm4_enable_sysfs(struct coresight_device *csdev)
 	drvdata->sticky_enable = true;
 	spin_unlock(&drvdata->spinlock);
 
-	dev_info(drvdata->dev, "ETM tracing enabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing enabled\n");
 	return 0;
 
 err:
@@ -380,7 +380,7 @@ static void etm4_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
-	dev_info(drvdata->dev, "ETM tracing disabled\n");
+	dev_dbg(drvdata->dev, "ETM tracing disabled\n");
 }
 
 static void etm4_disable(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 448145a..ee7a30b 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -65,7 +65,7 @@ static int funnel_enable(struct coresight_device *csdev, int inport,
 
 	funnel_enable_hw(drvdata, inport);
 
-	dev_info(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
+	dev_dbg(drvdata->dev, "FUNNEL inport %d enabled\n", inport);
 	return 0;
 }
 
@@ -89,7 +89,7 @@ static void funnel_disable(struct coresight_device *csdev, int inport,
 
 	funnel_disable_hw(drvdata, inport);
 
-	dev_info(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
+	dev_dbg(drvdata->dev, "FUNNEL inport %d disabled\n", inport);
 }
 
 static const struct coresight_ops_link funnel_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 8d2eaaa..feac983 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -35,7 +35,7 @@ static int replicator_enable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	dev_info(drvdata->dev, "REPLICATOR enabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR enabled\n");
 	return 0;
 }
 
@@ -44,7 +44,7 @@ static void replicator_disable(struct coresight_device *csdev, int inport,
 {
 	struct replicator_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
-	dev_info(drvdata->dev, "REPLICATOR disabled\n");
+	dev_dbg(drvdata->dev, "REPLICATOR disabled\n");
 }
 
 static const struct coresight_ops_link replicator_link_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index c46c70a..35d6f97 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -211,7 +211,7 @@ static int stm_enable(struct coresight_device *csdev,
 	stm_enable_hw(drvdata);
 	spin_unlock(&drvdata->spinlock);
 
-	dev_info(drvdata->dev, "STM tracing enabled\n");
+	dev_dbg(drvdata->dev, "STM tracing enabled\n");
 	return 0;
 }
 
@@ -274,7 +274,7 @@ static void stm_disable(struct coresight_device *csdev,
 		pm_runtime_put(drvdata->dev);
 
 		local_set(&drvdata->mode, CS_MODE_DISABLED);
-		dev_info(drvdata->dev, "STM tracing disabled\n");
+		dev_dbg(drvdata->dev, "STM tracing disabled\n");
 	}
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 0549249..434003a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -233,7 +233,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev, u32 mode)
 	if (ret)
 		return ret;
 
-	dev_info(drvdata->dev, "TMC-ETB/ETF enabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETB/ETF enabled\n");
 	return 0;
 }
 
@@ -256,7 +256,7 @@ static void tmc_disable_etf_sink(struct coresight_device *csdev)
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETB/ETF disabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETB/ETF disabled\n");
 }
 
 static int tmc_enable_etf_link(struct coresight_device *csdev,
@@ -275,7 +275,7 @@ static int tmc_enable_etf_link(struct coresight_device *csdev,
 	drvdata->mode = CS_MODE_SYSFS;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETF enabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETF enabled\n");
 	return 0;
 }
 
@@ -295,7 +295,7 @@ static void tmc_disable_etf_link(struct coresight_device *csdev,
 	drvdata->mode = CS_MODE_DISABLED;
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETF disabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETF disabled\n");
 }
 
 static void *tmc_alloc_etf_buffer(struct coresight_device *csdev, int cpu,
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 671a2ba..85a3f59 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1098,7 +1098,7 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 		tmc_etr_free_sysfs_buf(free_buf);
 
 	if (!ret)
-		dev_info(drvdata->dev, "TMC-ETR enabled\n");
+		dev_dbg(drvdata->dev, "TMC-ETR enabled\n");
 
 	return ret;
 }
@@ -1141,7 +1141,7 @@ static void tmc_disable_etr_sink(struct coresight_device *csdev)
 
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
-	dev_info(drvdata->dev, "TMC-ETR disabled\n");
+	dev_dbg(drvdata->dev, "TMC-ETR disabled\n");
 }
 
 static const struct coresight_ops_sink tmc_etr_sink_ops = {
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 1b817ec..ea249f0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -81,7 +81,7 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 	}
 
 	if (!ret)
-		dev_info(drvdata->dev, "TMC read start\n");
+		dev_dbg(drvdata->dev, "TMC read start\n");
 
 	return ret;
 }
@@ -103,7 +103,7 @@ static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
 	}
 
 	if (!ret)
-		dev_info(drvdata->dev, "TMC read end\n");
+		dev_dbg(drvdata->dev, "TMC read end\n");
 
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 01b7457..7daeb084 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -73,7 +73,7 @@ static int tpiu_enable(struct coresight_device *csdev, u32 mode)
 
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
2.7.4
