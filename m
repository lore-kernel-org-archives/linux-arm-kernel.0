From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:11 -0600
Subject: [PATCH 17/26] coresight tmc etr: Add capabilitiy information
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-18-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

With new version of TMC ETR, there are differing set of
features supported by the TMC. Add the capability of a
given TMC ETR for making safer decisions at runtime.

The device configuration register of the TMC (DEVID) lists
some of the capabilities. So, we can detect some of them at
probe. However, some of the features (or changes in behavior)
are not advertised and we have to depend on the PID to infer
the features. So we use a static description of the "unadvertised"
capabilities attached to the PID. Combining both, the static
and the dynamic capabilities, we maintain a bitmask of the
available features which can be later checked to take
appropriate actions.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 20 +++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tmc.h | 20 ++++++++++++++++++++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 6adf74689a85..0c99ef7b9b2b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -299,6 +299,20 @@ const struct attribute_group *coresight_tmc_groups[] = {
 	NULL,
 };
 
+/* Detect and initialise the capabilities of a TMC ETR */
+static int tmc_etr_setup_caps(struct tmc_drvdata *drvdata,
+			     u32 devid, void *dev_caps)
+{
+	/* Set the unadvertised capabilities */
+	tmc_etr_init_caps(drvdata, (u32)(unsigned long)dev_caps);
+
+	/*
+	 * ETR configuration uses a 40-bit AXI master in place of
+	 * the embedded SRAM of ETB/ETF.
+	 */
+	return dma_set_mask_and_coherent(drvdata->dev, DMA_BIT_MASK(40));
+}
+
 static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 {
 	int ret = 0;
@@ -370,11 +384,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		desc.type = CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.ops = &tmc_etr_cs_ops;
-		/*
-		 * ETR configuration uses a 40-bit AXI master in place of
-		 * the embedded SRAM of ETB/ETF.
-		 */
-		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+		ret = tmc_etr_setup_caps(drvdata, devid, id->data);
 		if (ret)
 			goto out;
 		break;
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index c4ff23336e76..13ab1008f110 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -104,6 +104,8 @@ enum tmc_mem_intf_width {
  * @config_type: TMC variant, must be of type @tmc_config_type.
  * @memwidth:	width of the memory interface databus, in bytes.
  * @trigger_cntr: amount of words to store after a trigger.
+ * @etr_caps:	Bitmask of capabilities of the TMC ETR, inferred from the
+ *		device configuration register (DEVID)
  */
 struct tmc_drvdata {
 	void __iomem		*base;
@@ -121,6 +123,7 @@ struct tmc_drvdata {
 	enum tmc_config_type	config_type;
 	enum tmc_mem_intf_width	memwidth;
 	u32			trigger_cntr;
+	u32			etr_caps;
 };
 
 /* Generic functions */
@@ -157,4 +160,21 @@ TMC_REG_PAIR(rrp, TMC_RRP, TMC_RRPHI)
 TMC_REG_PAIR(rwp, TMC_RWP, TMC_RWPHI)
 TMC_REG_PAIR(dba, TMC_DBALO, TMC_DBAHI)
 
+/* Initialise the caps from unadvertised static capabilities of the device */
+static inline void tmc_etr_init_caps(struct tmc_drvdata *drvdata, u32 dev_caps)
+{
+	WARN_ON(drvdata->etr_caps);
+	drvdata->etr_caps = dev_caps;
+}
+
+static inline void tmc_etr_set_cap(struct tmc_drvdata *drvdata, u32 cap)
+{
+	drvdata->etr_caps |= cap;
+}
+
+static inline bool tmc_etr_has_cap(struct tmc_drvdata *drvdata, u32 cap)
+{
+	return !!(drvdata->etr_caps & cap);
+}
+
 #endif
-- 
2.7.4
