From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  3 May 2016 11:33:57 -0600
Subject: [PATCH 23/27] coresight: tmc: keep track of memory width
In-Reply-To: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
References: <1462296841-12327-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1462296841-12327-24-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Accessing the HW configuration register each time the memory
width is needed simply doesn't make sense.  It is much more
efficient to read the value once and keep a reference for
later use.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 14 +---------
 drivers/hwtracing/coresight/coresight-tmc.c     | 34 +++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.h     | 10 +++++---
 3 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index b11c52be54a9..ba3384781f71 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -41,25 +41,13 @@ void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 {
-	enum tmc_mem_intf_width memwidth;
-	u8 memwords;
 	char *bufp;
 	u32 read_data;
 	int i;
 
-	memwidth = BMVAL(readl_relaxed(drvdata->base + CORESIGHT_DEVID), 8, 10);
-	if (memwidth == TMC_MEM_INTF_WIDTH_32BITS)
-		memwords = 1;
-	else if (memwidth == TMC_MEM_INTF_WIDTH_64BITS)
-		memwords = 2;
-	else if (memwidth == TMC_MEM_INTF_WIDTH_128BITS)
-		memwords = 4;
-	else
-		memwords = 8;
-
 	bufp = drvdata->buf;
 	while (1) {
-		for (i = 0; i < memwords; i++) {
+		for (i = 0; i < drvdata->memwidth; i++) {
 			read_data = readl_relaxed(drvdata->base + TMC_RRD);
 			if (read_data == 0xFFFFFFFF)
 				return;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index ae7525a2b94a..9e02ac963cd0 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -186,6 +186,39 @@ static const struct file_operations tmc_fops = {
 	.llseek		= no_llseek,
 };
 
+static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
+{
+	enum tmc_mem_intf_width memwidth;
+
+	/*
+	 * Excerpt from the TRM:
+	 *
+	 * DEVID::MEMWIDTH[10:8]
+	 * 0x2 Memory interface databus is 32 bits wide.
+	 * 0x3 Memory interface databus is 64 bits wide.
+	 * 0x4 Memory interface databus is 128 bits wide.
+	 * 0x5 Memory interface databus is 256 bits wide.
+	 */
+	switch (BMVAL(devid, 8, 10)) {
+	case 0x2:
+		memwidth = TMC_MEM_INTF_WIDTH_32BITS;
+		break;
+	case 0x3:
+		memwidth = TMC_MEM_INTF_WIDTH_64BITS;
+		break;
+	case 0x4:
+		memwidth = TMC_MEM_INTF_WIDTH_128BITS;
+		break;
+	case 0x5:
+		memwidth = TMC_MEM_INTF_WIDTH_256BITS;
+		break;
+	default:
+		memwidth = 0;
+	}
+
+	return memwidth;
+}
+
 #define coresight_tmc_simple_func(name, offset)			\
 	coresight_simple_func(struct tmc_drvdata, name, offset)
 
@@ -299,6 +332,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 
 	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
 	drvdata->config_type = BMVAL(devid, 6, 7);
+	drvdata->memwidth = tmc_get_memwidth(devid);
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
 		if (np)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 94bc034d3b98..c5d06fd57fa8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -81,10 +81,10 @@ enum tmc_mode {
 };
 
 enum tmc_mem_intf_width {
-	TMC_MEM_INTF_WIDTH_32BITS	= 0x2,
-	TMC_MEM_INTF_WIDTH_64BITS	= 0x3,
-	TMC_MEM_INTF_WIDTH_128BITS	= 0x4,
-	TMC_MEM_INTF_WIDTH_256BITS	= 0x5,
+	TMC_MEM_INTF_WIDTH_32BITS	= 1,
+	TMC_MEM_INTF_WIDTH_64BITS	= 2,
+	TMC_MEM_INTF_WIDTH_128BITS	= 4,
+	TMC_MEM_INTF_WIDTH_256BITS	= 8,
 };
 
 /**
@@ -100,6 +100,7 @@ enum tmc_mem_intf_width {
  * @size:	@buf size.
  * @mode:	how this TMC is being used.
  * @config_type: TMC variant, must be of type @tmc_config_type.
+ * @memwidth:	width of the memory interface databus, in bytes.
  * @trigger_cntr: amount of words to store after a trigger.
  */
 struct tmc_drvdata {
@@ -115,6 +116,7 @@ struct tmc_drvdata {
 	u32			size;
 	local_t			mode;
 	enum tmc_config_type	config_type;
+	enum tmc_mem_intf_width	memwidth;
 	u32			trigger_cntr;
 };
 
-- 
2.5.0
