From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Aug 2016 15:19:02 -0600
Subject: [PATCH 12/28] coresight: add PM runtime calls to
 coresight_simple_func()
In-Reply-To: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
References: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1472159958-5981-13-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is mandatory to enable a coresight block's power domain before
trying to access management registers.  Otherwise the transaction
simply stalls, leading to a system hang.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index ad975c58080d..decfd52b5dc3 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -16,6 +16,7 @@
 #include <linux/bitops.h>
 #include <linux/io.h>
 #include <linux/coresight.h>
+#include <linux/pm_runtime.h>
 
 /*
  * Coresight management registers (0xf00-0xfcc)
@@ -42,8 +43,11 @@ static ssize_t name##_show(struct device *_dev,				\
 			   struct device_attribute *attr, char *buf)	\
 {									\
 	type *drvdata = dev_get_drvdata(_dev->parent);			\
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n",			\
-			 readl_relaxed(drvdata->base + offset));	\
+	u32 val;							\
+	pm_runtime_get_sync(_dev->parent);				\
+	val = readl_relaxed(drvdata->base + offset);			\
+	pm_runtime_put_sync(_dev->parent);				\
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);		\
 }									\
 static DEVICE_ATTR_RO(name)
 
-- 
2.7.4
