From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  5 Apr 2016 11:53:48 -0600
Subject: [PATCH 07/11] coresight: etm4x: implementing user/kernel mode tracing
In-Reply-To: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
References: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1459878832-15219-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding new mode to limit tracing to kernel or user space.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    |  3 ++
 drivers/hwtracing/coresight/coresight-etm4x.c      | 35 ++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm4x.h      |  5 +++-
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index a996db7ef2fc..0e80ec668402 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -440,6 +440,9 @@ static ssize_t mode_store(struct device *dev,
 	else
 		config->vinst_ctrl &= ~BIT(11);
 
+	if (config->mode & (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER))
+		etm4_config_trace_mode(config);
+
 	spin_unlock(&drvdata->spinlock);
 
 	return size;
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 9f51a8f47650..88b8bc0f6549 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -566,6 +566,41 @@ static void etm4_set_default(struct etmv4_config *config)
 	config->vissctlr = 0x0;
 }
 
+void etm4_config_trace_mode(struct etmv4_config *config)
+{
+	u32 addr_acc, mode;
+
+	mode = config->mode;
+	mode &= (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER);
+
+	/* excluding kernel AND user space doesn't make sense */
+	WARN_ON_ONCE(mode == (ETM_MODE_EXCL_KERN | ETM_MODE_EXCL_USER));
+
+	/* nothing to do if neither flags are set */
+	if (!(mode & ETM_MODE_EXCL_KERN) && !(mode & ETM_MODE_EXCL_USER))
+		return;
+
+	addr_acc = config->addr_acc[ETM_DEFAULT_ADDR_COMP];
+	/* clear default config */
+	addr_acc &= ~(ETM_EXLEVEL_NS_APP | ETM_EXLEVEL_NS_OS);
+
+	/*
+	 * EXLEVEL_NS, bits[15:12]
+	 * The Exception levels are:
+	 *   Bit[12] Exception level 0 - Application
+	 *   Bit[13] Exception level 1 - OS
+	 *   Bit[14] Exception level 2 - Hypervisor
+	 *   Bit[15] Never implemented
+	 */
+	if (mode & ETM_MODE_EXCL_KERN)
+		addr_acc |= ETM_EXLEVEL_NS_OS;
+	else
+		addr_acc |= ETM_EXLEVEL_NS_APP;
+
+	config->addr_acc[ETM_DEFAULT_ADDR_COMP] = addr_acc;
+	config->addr_acc[ETM_DEFAULT_ADDR_COMP + 1] = addr_acc;
+}
+
 static int etm4_cpu_callback(struct notifier_block *nfb, unsigned long action,
 			    void *hcpu)
 {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index f7748ae63451..a291d4cc8bd8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -176,7 +176,9 @@
 #define ETM_MODE_TRACE_RESET		BIT(25)
 #define ETM_MODE_TRACE_ERR		BIT(26)
 #define ETM_MODE_VIEWINST_STARTSTOP	BIT(27)
-#define ETMv4_MODE_ALL			0xFFFFFFF
+#define ETMv4_MODE_ALL			(GENMASK(27, 0) | \
+					 ETM_MODE_EXCL_KERN | \
+					 ETM_MODE_EXCL_USER)
 
 #define TRCSTATR_IDLE_BIT		0
 #define ETM_DEFAULT_ADDR_COMP		0
@@ -414,4 +416,5 @@ enum etm_addr_type {
 };
 
 extern const struct attribute_group *coresight_etmv4_groups[];
+void etm4_config_trace_mode(struct etmv4_config *config);
 #endif
-- 
2.1.4
