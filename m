From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 22 Mar 2016 14:23:19 -0600
Subject: [PATCH 11/14] coresight: tmc: keep track of memory width
In-Reply-To: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
References: <1458678202-3447-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1458678202-3447-12-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Accessing the HW configuration register each time the memory
width is needed simply doesn't make sense.  It is much more
efficient to read the value once and keep a reference for
later use.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 8 +++-----
 drivers/hwtracing/coresight/coresight-tmc.c     | 1 +
 drivers/hwtracing/coresight/coresight-tmc.h     | 2 ++
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index c533b4494969..2cad1aa1949f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -42,18 +42,16 @@ void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
 static void tmc_etb_dump_hw(struct tmc_drvdata *drvdata)
 {
-	enum tmc_mem_intf_width memwidth;
 	u8 memwords;
 	char *bufp;
 	u32 read_data;
 	int i;
 
-	memwidth = BMVAL(readl_relaxed(drvdata->base + CORESIGHT_DEVID), 8, 10);
-	if (memwidth == TMC_MEM_INTF_WIDTH_32BITS)
+	if (drvdata->memwidth == TMC_MEM_INTF_WIDTH_32BITS)
 		memwords = 1;
-	else if (memwidth == TMC_MEM_INTF_WIDTH_64BITS)
+	else if (drvdata->memwidth == TMC_MEM_INTF_WIDTH_64BITS)
 		memwords = 2;
-	else if (memwidth == TMC_MEM_INTF_WIDTH_128BITS)
+	else if (drvdata->memwidth == TMC_MEM_INTF_WIDTH_128BITS)
 		memwords = 4;
 	else
 		memwords = 8;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index c614fe160f8a..beeac81ff2fe 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -304,6 +304,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 
 	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
 	drvdata->config_type = BMVAL(devid, 6, 7);
+	drvdata->memwidth = BMVAL(devid, 8, 10);
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
 		if (np)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 6dbd70861b17..a6fb7a9fec5a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -103,6 +103,7 @@ enum tmc_mem_intf_width {
  * @size:	@buf size.
  * @mode:	how this TMC is being used.
  * @config_type: TMC variant, must be of type @tmc_config_type.
+ * @memwidth:	width of the memory interface databus, powers of two.
  * @trigger_cntr: amount of words to store after a trigger.
  */
 struct tmc_drvdata {
@@ -119,6 +120,7 @@ struct tmc_drvdata {
 	u32			size;
 	local_t			mode;
 	enum tmc_config_type	config_type;
+	enum tmc_mem_intf_width	memwidth;
 	u32			trigger_cntr;
 };
 
-- 
2.1.4
