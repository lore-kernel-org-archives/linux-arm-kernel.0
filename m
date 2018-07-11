From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 11 Jul 2018 13:40:15 -0600
Subject: [PATCH 05/25] coresight: tmc: Hide trace buffer handling for file read
In-Reply-To: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1531338035-11729-6-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

At the moment we adjust the buffer pointers for reading the trace
data via misc device in the common code for ETF/ETB and ETR. Since
we are going to change how we manage the buffer for ETR, let us
move the buffer manipulation to the respective driver files, hiding
it from the common code. We do so by adding type specific helpers
for finding the length of data and the pointer to the buffer,
for a given length at a file position.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 18 +++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 34 ++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.c     | 41 ++++++++++++++-----------
 drivers/hwtracing/coresight/coresight-tmc.h     |  4 +++
 4 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 61d849b11c26..73160cd0e0d1 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -109,6 +109,24 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+/*
+ * Return the available trace data in the buffer from @pos, with
+ * a maximum limit of @len, updating the @bufpp on where to
+ * find it.
+ */
+ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
+				loff_t pos, size_t len, char **bufpp)
+{
+	ssize_t actual = len;
+
+	/* Adjust the len to available size @pos */
+	if (pos + actual > drvdata->len)
+		actual = drvdata->len - pos;
+	if (actual > 0)
+		*bufpp = drvdata->buf + pos;
+	return actual;
+}
+
 static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 02f747afa2ba..f88342d400ef 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -58,6 +58,40 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+/*
+ * Return the available trace data in the buffer @pos, with a maximum
+ * limit of @len, also updating the @bufpp on where to find it.
+ */
+ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
+				loff_t pos, size_t len, char **bufpp)
+{
+	ssize_t actual = len;
+	char *bufp = drvdata->buf + pos;
+	char *bufend = (char *)(drvdata->vaddr + drvdata->size);
+
+	/* Adjust the len to available size @pos */
+	if (pos + actual > drvdata->len)
+		actual = drvdata->len - pos;
+
+	if (actual <= 0)
+		return actual;
+
+	/*
+	 * Since we use a circular buffer, with trace data starting
+	 * @drvdata->buf, possibly anywhere in the buffer @drvdata->vaddr,
+	 * wrap the current @pos to within the buffer.
+	 */
+	if (bufp >= bufend)
+		bufp -= drvdata->size;
+	/*
+	 * For simplicity, avoid copying over a wrapped around buffer.
+	 */
+	if ((bufp + actual) > bufend)
+		actual = bufend - bufp;
+	*bufpp = bufp;
+	return actual;
+}
+
 static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 {
 	const u32 *barrier;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 456f122df74f..bb57e7f57eb5 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -123,35 +123,40 @@ static int tmc_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static inline ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
+					  loff_t pos, size_t len, char **bufpp)
+{
+	switch (drvdata->config_type) {
+	case TMC_CONFIG_TYPE_ETB:
+	case TMC_CONFIG_TYPE_ETF:
+		return tmc_etb_get_sysfs_trace(drvdata, pos, len, bufpp);
+	case TMC_CONFIG_TYPE_ETR:
+		return tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
+	}
+
+	return -EINVAL;
+}
+
 static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 			loff_t *ppos)
 {
+	char *bufp;
+	ssize_t actual;
 	struct tmc_drvdata *drvdata = container_of(file->private_data,
 						   struct tmc_drvdata, miscdev);
-	char *bufp = drvdata->buf + *ppos;
-
-	if (*ppos + len > drvdata->len)
-		len = drvdata->len - *ppos;
-
-	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
-		if (bufp == (char *)(drvdata->vaddr + drvdata->size))
-			bufp = drvdata->vaddr;
-		else if (bufp > (char *)(drvdata->vaddr + drvdata->size))
-			bufp -= drvdata->size;
-		if ((bufp + len) > (char *)(drvdata->vaddr + drvdata->size))
-			len = (char *)(drvdata->vaddr + drvdata->size) - bufp;
-	}
+	actual = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
+	if (actual <= 0)
+		return 0;
 
-	if (copy_to_user(data, bufp, len)) {
+	if (copy_to_user(data, bufp, actual)) {
 		dev_dbg(drvdata->dev, "%s: copy_to_user failed\n", __func__);
 		return -EFAULT;
 	}
 
-	*ppos += len;
+	*ppos += actual;
+	dev_dbg(drvdata->dev, "%zu bytes copied\n", actual);
 
-	dev_dbg(drvdata->dev, "%s: %zu bytes copied, %d bytes left\n",
-		__func__, len, (int)(drvdata->len - *ppos));
-	return len;
+	return actual;
 }
 
 static int tmc_release(struct inode *inode, struct file *file)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index dfaff077a7fc..1d7cd582919b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -172,10 +172,14 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etb_cs_ops;
 extern const struct coresight_ops tmc_etf_cs_ops;
 
+ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
+				loff_t pos, size_t len, char **bufpp);
 /* ETR functions */
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata);
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etr_cs_ops;
+ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
+				loff_t pos, size_t len, char **bufpp);
 
 
 #define TMC_REG_PAIR(name, lo_off, hi_off)				\
-- 
2.7.4
