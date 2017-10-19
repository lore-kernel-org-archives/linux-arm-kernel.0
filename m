From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Oct 2017 18:15:38 +0100
Subject: [PATCH 02/17] coresight tmc: Hide trace buffer handling for file read
In-Reply-To: <20171019171553.24056-1-suzuki.poulose@arm.com>
References: <20171019171553.24056-1-suzuki.poulose@arm.com>
Message-ID: <20171019171553.24056-3-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the moment we adjust the buffer pointers for reading the trace
data via misc device in the common code for ETF/ETB and ETR. Since
we are going to change how we manage the buffer for ETR, let us
move the buffer manipulation to the respective driver files, hiding
it from the common code. We do so by adding type specific helpers
for finding the length of data and the pointer to the buffer,
for a given length at a file position.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 16 ++++++++++++
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 33 ++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.c     | 34 ++++++++++++++-----------
 drivers/hwtracing/coresight/coresight-tmc.h     |  4 +++
 4 files changed, 72 insertions(+), 15 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index e2513b786242..0b6f1eb746de 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -120,6 +120,22 @@ static void tmc_etf_disable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+/*
+ * Return the available trace data in the buffer from @pos, with
+ * a maximum limit of @len, updating the @bufpp on where to
+ * find it.
+ */
+ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
+				  loff_t pos, size_t len, char **bufpp)
+{
+	/* Adjust the len to available size @pos */
+	if (pos + len > drvdata->len)
+		len = drvdata->len - pos;
+	if (len > 0)
+		*bufpp = drvdata->buf + pos;
+	return len;
+}
+
 static int tmc_enable_etf_sink_sysfs(struct coresight_device *csdev)
 {
 	int ret = 0;
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index d0208f01afd9..063f253f1c99 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -69,6 +69,39 @@ static void tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 	CS_LOCK(drvdata->base);
 }
 
+/*
+ * Return the available trace data in the buffer @pos, with a maximum
+ * limit of @len, also updating the @bufpp on where to find it.
+ */
+ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
+			    loff_t pos, size_t len, char **bufpp)
+{
+	char *bufp = drvdata->buf + pos;
+	char *bufend = (char *)(drvdata->vaddr + drvdata->size);
+
+	/* Adjust the len to available size @pos */
+	if (pos + len > drvdata->len)
+		len = drvdata->len - pos;
+
+	if (len <= 0)
+		return len;
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
+	if ((bufp + len) > bufend)
+		len = bufend - bufp;
+	*bufpp = bufp;
+	return len;
+}
+
 static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 {
 	const u32 *barrier;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 2ff4a66a3caa..c7201e40d737 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -131,24 +131,29 @@ static int tmc_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static inline ssize_t tmc_get_sysfs_trace(struct tmc_drvdata *drvdata,
+					loff_t pos, size_t len, char **bufpp)
+{
+	switch (drvdata->config_type) {
+	case TMC_CONFIG_TYPE_ETB:
+	case TMC_CONFIG_TYPE_ETF:
+		return tmc_etb_get_sysfs_trace(drvdata, pos, len, bufpp);
+	case TMC_CONFIG_TYPE_ETR:
+		return tmc_etr_get_sysfs_trace(drvdata, pos, len, bufpp);
+	}
+
+	return  -EINVAL;
+}
+
 static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 			loff_t *ppos)
 {
+	char *bufp;
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
+	len = tmc_get_sysfs_trace(drvdata, *ppos, len, &bufp);
+	if (len <= 0)
+		return 0;
 
 	if (copy_to_user(data, bufp, len)) {
 		dev_dbg(drvdata->dev, "%s: copy_to_user failed\n", __func__);
@@ -156,9 +161,8 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 	}
 
 	*ppos += len;
+	dev_dbg(drvdata->dev, "%zu bytes copied\n", len);
 
-	dev_dbg(drvdata->dev, "%s: %zu bytes copied, %d bytes left\n",
-		__func__, len, (int)(drvdata->len - *ppos));
 	return len;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 8df7a813f537..6deb3afe9db8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -183,10 +183,14 @@ int tmc_read_unprepare_etb(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etb_cs_ops;
 extern const struct coresight_ops tmc_etf_cs_ops;
 
+ssize_t tmc_etb_get_sysfs_trace(struct tmc_drvdata *drvdata,
+			    loff_t pos, size_t len, char **bufpp);
 /* ETR functions */
 int tmc_read_prepare_etr(struct tmc_drvdata *drvdata);
 int tmc_read_unprepare_etr(struct tmc_drvdata *drvdata);
 extern const struct coresight_ops tmc_etr_cs_ops;
+ssize_t tmc_etr_get_sysfs_trace(struct tmc_drvdata *drvdata,
+			    loff_t pos, size_t len, char **bufpp);
 
 
 #define TMC_REG_PAIR(name, lo_off, hi_off)				\
-- 
2.13.6
