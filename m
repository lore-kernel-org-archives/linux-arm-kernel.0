From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon,  6 Jun 2016 10:11:37 +0100
Subject: [PATCH v2 5/9] coresight: tmc: Limit the trace to available data
In-Reply-To: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
References: <1465204301-24184-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1465204301-24184-6-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At present the ETF or ETR gives out the entire device
buffer, even if there is less or even no trace data
available. This patch limits the trace data given out to
the actual trace data collected.

Cc: mathieu.poirier at linaro.org
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c |  2 ++
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 12 +++++++++---
 drivers/hwtracing/coresight/coresight-tmc.c     |  6 +++---
 drivers/hwtracing/coresight/coresight-tmc.h     |  4 +++-
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 466af86..e68289b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -48,6 +48,7 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 	int i;
 
 	bufp = drvdata->buf;
+	drvdata->len = 0;
 	while (1) {
 		for (i = 0; i < drvdata->memwidth; i++) {
 			read_data = readl_relaxed(drvdata->base + TMC_RRD);
@@ -55,6 +56,7 @@ static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 				return;
 			memcpy(bufp, &read_data, 4);
 			bufp += 4;
+			drvdata->len += 4;
 		}
 	}
 }
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 3369d7a..cdb29c9 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -64,11 +64,17 @@ static void tmc_etr_dump_hw(struct tmc_drvdata *drvdata)
 	rwp = readl_relaxed(drvdata->base + TMC_RWP);
 	val = readl_relaxed(drvdata->base + TMC_STS);
 
-	/* How much memory do we still have */
-	if (val & BIT(0))
+	/*
+	 * Adjust the buffer to point to the beginning of the trace data
+	 * and the available trace data.
+	 */
+	if (val & BIT(0)) {
 		drvdata->buf = drvdata->vaddr + rwp - drvdata->paddr;
-	else
+		drvdata->len = drvdata->size;
+	} else {
 		drvdata->buf = drvdata->vaddr;
+		drvdata->len = rwp - drvdata->paddr;
+	}
 }
 
 static void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 3978cbb..1b1651d 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -140,8 +140,8 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 						   struct tmc_drvdata, miscdev);
 	char *bufp = drvdata->buf + *ppos;
 
-	if (*ppos + len > drvdata->size)
-		len = drvdata->size - *ppos;
+	if (*ppos + len > drvdata->len)
+		len = drvdata->len - *ppos;
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
 		if (bufp == (char *)(drvdata->vaddr + drvdata->size))
@@ -160,7 +160,7 @@ static ssize_t tmc_read(struct file *file, char __user *data, size_t len,
 	*ppos += len;
 
 	dev_dbg(drvdata->dev, "%s: %zu bytes copied, %d bytes left\n",
-		__func__, len, (int)(drvdata->size - *ppos));
+		__func__, len, (int)(drvdata->len - *ppos));
 	return len;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 5c5fe2a..44b3ae3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -98,7 +98,8 @@ enum tmc_mem_intf_width {
  * @buf:	area of memory where trace data get sent.
  * @paddr:	DMA start location in RAM.
  * @vaddr:	virtual representation of @paddr.
- * @size:	@buf size.
+ * @size:	trace buffer size.
+ * @len:	size of the available trace.
  * @mode:	how this TMC is being used.
  * @config_type: TMC variant, must be of type @tmc_config_type.
  * @memwidth:	width of the memory interface databus, in bytes.
@@ -115,6 +116,7 @@ struct tmc_drvdata {
 	dma_addr_t		paddr;
 	void __iomem		*vaddr;
 	u32			size;
+	u32			len;
 	local_t			mode;
 	enum tmc_config_type	config_type;
 	enum tmc_mem_intf_width	memwidth;
-- 
1.9.1
