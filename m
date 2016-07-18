From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 18 Jul 2016 13:51:23 -0600
Subject: [PATCH 02/10] coresight: remove duplicated enumeration
In-Reply-To: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
References: <1468871491-10997-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1468871491-10997-3-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both ETMv3 and ETMv4 drivers are declaring an 'enum etm_addr_type',
creating reduncancy.

This patch removes the enumeration from the driver files and adds
it to a common header.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h         | 8 --------
 drivers/hwtracing/coresight/coresight-etm3x-sysfs.c | 1 +
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 1 +
 drivers/hwtracing/coresight/coresight-etm4x.h       | 8 --------
 drivers/hwtracing/coresight/coresight-priv.h        | 8 ++++++++
 5 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index 51597cb2c08a..4a18ee499965 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -259,14 +259,6 @@ struct etm_drvdata {
 	struct etm_config		config;
 };
 
-enum etm_addr_type {
-	ETM_ADDR_TYPE_NONE,
-	ETM_ADDR_TYPE_SINGLE,
-	ETM_ADDR_TYPE_RANGE,
-	ETM_ADDR_TYPE_START,
-	ETM_ADDR_TYPE_STOP,
-};
-
 static inline void etm_writel(struct etm_drvdata *drvdata,
 			      u32 val, u32 off)
 {
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 02d4b629891f..3f73cee7a094 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/sysfs.h>
 #include "coresight-etm.h"
+#include "coresight-priv.h"
 
 static ssize_t nr_addr_cmp_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 7c84308c5564..6ae26ffeaefd 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -18,6 +18,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/sysfs.h>
 #include "coresight-etm4x.h"
+#include "coresight-priv.h"
 
 static int etm4_set_mode_exclude(struct etmv4_drvdata *drvdata, bool exclude)
 {
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 5359c5197c1d..111f4bb3a6b2 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -407,14 +407,6 @@ enum etm_addr_ctxtype {
 	ETM_CTX_CTXID_VMID,
 };
 
-enum etm_addr_type {
-	ETM_ADDR_TYPE_NONE,
-	ETM_ADDR_TYPE_SINGLE,
-	ETM_ADDR_TYPE_RANGE,
-	ETM_ADDR_TYPE_START,
-	ETM_ADDR_TYPE_STOP,
-};
-
 extern const struct attribute_group *coresight_etmv4_groups[];
 void etm4_config_trace_mode(struct etmv4_config *config);
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 3cb574b3cdd9..1f6b580ef1c4 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -47,6 +47,14 @@ static ssize_t name##_show(struct device *_dev,				\
 }									\
 static DEVICE_ATTR_RO(name)
 
+enum etm_addr_type {
+	ETM_ADDR_TYPE_NONE,
+	ETM_ADDR_TYPE_SINGLE,
+	ETM_ADDR_TYPE_RANGE,
+	ETM_ADDR_TYPE_START,
+	ETM_ADDR_TYPE_STOP,
+};
+
 enum cs_mode {
 	CS_MODE_DISABLED,
 	CS_MODE_SYSFS,
-- 
2.7.4
