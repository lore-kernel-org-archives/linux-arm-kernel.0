From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 12 Apr 2016 11:54:49 -0600
Subject: [PATCH V2 12/15] coresight: tmc: keep track of memory width
In-Reply-To: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1460483692-25061-13-git-send-email-mathieu.poirier@linaro.org>
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
index 50d32e8ef4ea..a440784e3b27 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -41,18 +41,16 @@ void tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 
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
index 4d7b64f69389..bc013d5f71c3 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -306,6 +306,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 
 	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
 	drvdata->config_type = BMVAL(devid, 6, 7);
+	drvdata->memwidth = BMVAL(devid, 8, 10);
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
 		if (np)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 821bdf150ac9..062dd7dcea96 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -102,6 +102,7 @@ enum tmc_mem_intf_width {
  * @size:	@buf size.
  * @mode:	how this TMC is being used.
  * @config_type: TMC variant, must be of type @tmc_config_type.
+ * @memwidth:	width of the memory interface databus, powers of two.
  * @trigger_cntr: amount of words to store after a trigger.
  */
 struct tmc_drvdata {
@@ -118,6 +119,7 @@ struct tmc_drvdata {
 	u32			size;
 	local_t			mode;
 	enum tmc_config_type	config_type;
+	enum tmc_mem_intf_width	memwidth;
 	u32			trigger_cntr;
 };
 
-- 
2.5.0
