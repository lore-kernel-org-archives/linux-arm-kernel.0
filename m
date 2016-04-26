From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 26 Apr 2016 16:10:26 -0600
Subject: [PATCH V4 10/18] coresight: tmc: getting rid of multiple read access
In-Reply-To: <1461708634-6327-1-git-send-email-mathieu.poirier@linaro.org>
References: <1461708634-6327-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1461708634-6327-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allowing multiple readers to access the trace data simultaniously
via sysFS provides no shortage of opportunity for race condition,
mandates two variable to be maintained (drvdata::read_count and
drvdata::reading), makes the code complex and provide little
advantages, if any.

This patch streamlines the read process by restricting trace data
access to a single user.  That way drvdata::read_count can
be eliminated and race conditions (along with faulty error handling)
in function tmc_open() and tmc_release() eliminated.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  5 +++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c |  4 ++++
 drivers/hwtracing/coresight/coresight-tmc.c     | 24 +++++++++---------------
 drivers/hwtracing/coresight/coresight-tmc.h     |  2 --
 4 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 6eb1665cfc9c..60edf4d1968f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -260,6 +260,11 @@ int tmc_read_prepare_etb(struct tmc_drvdata *drvdata)
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
 
+	if (drvdata->reading) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* There is no point in reading a TMC in HW FIFO mode */
 	mode = readl_relaxed(drvdata->base + TMC_MODE);
 	if (mode != TMC_MODE_CIRCULAR_BUFFER) {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index ac37bf904fb7..d6999b457fb8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -188,6 +188,10 @@ int tmc_read_prepare_etr(struct tmc_drvdata *drvdata)
 		return -EINVAL;
 
 	spin_lock_irqsave(&drvdata->spinlock, flags);
+	if (drvdata->reading) {
+		ret = -EBUSY;
+		goto out;
+	}
 
 	/* If drvdata::buf is NULL the trace data has been read already */
 	if (drvdata->buf == NULL) {
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index e8e12a9b917a..ae7525a2b94a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -95,7 +95,7 @@ static int tmc_read_prepare(struct tmc_drvdata *drvdata)
 	return ret;
 }
 
-static void tmc_read_unprepare(struct tmc_drvdata *drvdata)
+static int tmc_read_unprepare(struct tmc_drvdata *drvdata)
 {
 	int ret = 0;
 
@@ -113,21 +113,20 @@ static void tmc_read_unprepare(struct tmc_drvdata *drvdata)
 
 	if (!ret)
 		dev_info(drvdata->dev, "TMC read end\n");
+
+	return ret;
 }
 
 static int tmc_open(struct inode *inode, struct file *file)
 {
+	int ret;
 	struct tmc_drvdata *drvdata = container_of(file->private_data,
 						   struct tmc_drvdata, miscdev);
-	int ret = 0;
-
-	if (drvdata->read_count++)
-		goto out;
 
 	ret = tmc_read_prepare(drvdata);
 	if (ret)
 		return ret;
-out:
+
 	nonseekable_open(inode, file);
 
 	dev_dbg(drvdata->dev, "%s: successfully opened\n", __func__);
@@ -167,19 +166,14 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 
 static int tmc_release(struct inode *inode, struct file *file)
 {
+	int ret;
 	struct tmc_drvdata *drvdata = container_of(file->private_data,
 						   struct tmc_drvdata, miscdev);
 
-	if (--drvdata->read_count) {
-		if (drvdata->read_count < 0) {
-			dev_err(drvdata->dev, "mismatched close\n");
-			drvdata->read_count = 0;
-		}
-		goto out;
-	}
+	ret = tmc_read_unprepare(drvdata);
+	if (ret)
+		return ret;
 
-	tmc_read_unprepare(drvdata);
-out:
 	dev_dbg(drvdata->dev, "%s: released\n", __func__);
 	return 0;
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index df661903f83c..592eb149fe3a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -94,7 +94,6 @@ enum tmc_mem_intf_width {
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
  * @spinlock:	only one at a time pls.
- * @read_count:	manages preparation of buffer for reading.
  * @buf:	area of memory where trace data get sent.
  * @paddr:	DMA start location in RAM.
  * @vaddr:	virtual representation of @paddr.
@@ -109,7 +108,6 @@ struct tmc_drvdata {
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
 	spinlock_t		spinlock;
-	int			read_count;
 	bool			reading;
 	char			*buf;
 	dma_addr_t		paddr;
-- 
2.5.0
