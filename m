From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 11 Sep 2018 15:49:53 -0600
Subject: [PATCH 3/5] coresight: Make sink disable functions aware of operation
 mode
In-Reply-To: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
References: <1536702595-9999-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1536702595-9999-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sink disable functions aware of the operation mode they are under
so that log messages can be controlled.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 +-
 drivers/hwtracing/coresight/coresight-tpiu.c    | 2 +-
 drivers/hwtracing/coresight/coresight.c         | 6 +++---
 include/linux/coresight.h                       | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 08fa660098f8..79793cb51d82 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -305,7 +305,7 @@ static void etb_dump_hw(struct etb_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void etb_disable(struct coresight_device *csdev)
+static void etb_disable(struct coresight_device *csdev, u32 mode)
 {
 	struct etb_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	unsigned long flags;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 28b3ff830597..ce33c0f05148 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -246,7 +246,7 @@ static int tmc_enable_etf_sink(struct coresight_device *csdev,
 	return 0;
 }
 
-static void tmc_disable_etf_sink(struct coresight_device *csdev)
+static void tmc_disable_etf_sink(struct coresight_device *csdev, u32 mode)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 56fea4ff947e..ec5100e7b7b9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1364,7 +1364,7 @@ static int tmc_enable_etr_sink(struct coresight_device *csdev,
 	return -EINVAL;
 }
 
-static void tmc_disable_etr_sink(struct coresight_device *csdev)
+static void tmc_disable_etr_sink(struct coresight_device *csdev, u32 mode)
 {
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index b2f72a1fa402..5f9fe97690fe 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -94,7 +94,7 @@ static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
-static void tpiu_disable(struct coresight_device *csdev)
+static void tpiu_disable(struct coresight_device *csdev, u32 mode)
 {
 	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index edfb7f8d2f0b..c19c2692b95e 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -149,11 +149,11 @@ static int coresight_enable_sink(struct coresight_device *csdev,
 	return 0;
 }
 
-static void coresight_disable_sink(struct coresight_device *csdev)
+static void coresight_disable_sink(struct coresight_device *csdev, u32 mode)
 {
 	if (atomic_dec_return(csdev->refcnt) == 0) {
 		if (sink_ops(csdev)->disable) {
-			sink_ops(csdev)->disable(csdev);
+			sink_ops(csdev)->disable(csdev, mode);
 			csdev->enable = false;
 		}
 	}
@@ -301,7 +301,7 @@ void coresight_disable_path(struct list_head *path, u32 mode)
 
 		switch (type) {
 		case CORESIGHT_DEV_TYPE_SINK:
-			coresight_disable_sink(csdev);
+			coresight_disable_sink(csdev, mode);
 			break;
 		case CORESIGHT_DEV_TYPE_SOURCE:
 			/* sources are disabled from either sysFS or Perf */
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 8fc6f1e82c17..22bb0d4f1689 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -189,7 +189,7 @@ struct coresight_device {
  */
 struct coresight_ops_sink {
 	int (*enable)(struct coresight_device *csdev, u32 mode, void *data);
-	void (*disable)(struct coresight_device *csdev);
+	void (*disable)(struct coresight_device *csdev, u32 mode);
 	void *(*alloc_buffer)(struct coresight_device *csdev, int cpu,
 			      void **pages, int nr_pages, bool overwrite);
 	void (*free_buffer)(void *config);
-- 
2.7.4
