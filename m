From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Sun, 18 Oct 2015 12:24:28 -0600
Subject: [PATCH V2 11/30] coresight: etm3x: implementing user/kernel mode
 tracing
In-Reply-To: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
References: <1445192687-24112-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1445192687-24112-12-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding new mode to limit tracing to kernel or user space.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h        |  9 +++-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  4 ++
 drivers/hwtracing/coresight/coresight-etm3x.c      | 60 ++++++++++++++++++++++
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index f33aeb4e545d..ebc710df27dc 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -110,7 +110,12 @@
 #define ETM_MODE_STALL		BIT(2)
 #define ETM_MODE_TIMESTAMP	BIT(3)
 #define ETM_MODE_CTXID		BIT(4)
-#define ETM_MODE_ALL		0x1f
+#define ETM_MODE_EXCL_KERN	BIT(5)
+#define ETM_MODE_EXCL_USER	BIT(6)
+#define ETM_MODE_ALL		(ETM_MODE_EXCLUDE | ETM_MODE_CYCACC | \
+				 ETM_MODE_STALL | ETM_MODE_TIMESTAMP | \
+				 ETM_MODE_CTXID | ETM_MODE_EXCL_KERN | \
+				 ETM_MODE_EXCL_USER)
 
 #define ETM_SQR_MASK		0x3
 #define ETM_TRACEID_MASK	0x3f
@@ -302,5 +307,7 @@ static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
 extern const struct attribute_group *coresight_etm_groups[];
 int etm_get_trace_id(struct etm_drvdata *drvdata);
 void etm_set_default(struct etm_config *config);
+void etm_config_trace_mode(struct etm_drvdata *drvdata,
+			   struct etm_config *config, u32 mode);
 struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index bc8f04214567..1e0908c0ca6d 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -176,6 +176,10 @@ static ssize_t mode_store(struct device *dev,
 		config->ctrl |= ETMCR_CTXID_SIZE;
 	else
 		config->ctrl &= ~ETMCR_CTXID_SIZE;
+
+	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
+		etm_config_trace_mode(drvdata, config, config->mode);
+
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index cc0b08437419..8a133d761f6a 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -252,6 +252,66 @@ void etm_set_default(struct etm_config *config)
 	config->ctxid_mask = 0x0;
 }
 
+void etm_config_trace_mode(struct etm_drvdata *drvdata,
+			   struct etm_config *config,
+			   u32 mode)
+{
+	u32 flags;
+
+	mode &= (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER);
+
+	/* excluding kernel AND user space doesn't make sense */
+	WARN_ON_ONCE(mode == (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER));
+
+	/* nothing to do if neither flags are set */
+	if (!(mode & ETM_MODE_EXCL_KERN) && !(mode & ETM_MODE_EXCL_USER))
+		return;
+
+	flags = (1 << 0 |	/* instruction execute*/
+		 3 << 3 |	/* ARM instruction */
+		 0 << 5 |	/* No data value comparison */
+		 0 << 7 |	/* No exact mach */
+		 0 << 8);	/* Ignore context ID */
+
+	/* No need to worry about single address comparators. */
+	config->enable_ctrl2 = 0x0;
+
+	/* Bit 0 is address range comparator 1 */
+	config->enable_ctrl1 = ETMTECR1_ADDR_COMP_1;
+
+	/* On ETMv3.5:
+	 * ETMACTRn[13,11] == Non-secure state comparison control
+	 * ETMACTRn[12,10] == Secure state comparison control
+	 *
+	 * b00 == Match in all modes in this state
+	 * b01 == Do not match in any more in this state
+	 * b10 == Match in all modes excepts user mode in this state
+	 * b11 == Match only in user mode in this state
+	 */
+
+	/* Tracing in secure mode is not supported at this time */
+	flags |= (0 << 12 | 1 << 10);
+
+	if (mode & ETM_MODE_EXCL_USER) {
+		/* exclude user, match all modes except user mode */
+		flags |= (1 << 13 | 0 << 11);
+	} else {
+		/* exclude kernel, match only in user mode */
+		flags |= (1 << 13 | 1 << 11);
+	}
+
+	/* The ETMEEVR register is already set to "hard wire A", and as
+	 * such all there is to do is setup an address comparator that spans
+	 * the entire address range and configure the state and mode bits
+	 */
+	config->addr_val[0] = (u32) 0x0;
+	config->addr_val[1] = (u32) ~0x0;
+	config->addr_acctype[0] = flags;
+	config->addr_acctype[1] = flags;
+	config->addr_type[0] = ETM_ADDR_TYPE_RANGE;
+	config->addr_type[1] = ETM_ADDR_TYPE_RANGE;
+}
+
 static void etm_enable_hw(void *info)
 {
 	int i;
-- 
1.9.1
