From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed,  2 Aug 2017 10:22:05 -0600
Subject: [PATCH 11/26] coresight: Add support for reading 64bit registers
In-Reply-To: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
References: <1501690940-4137-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1501690940-4137-12-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Add support for reading a lower and upper 32bits of a register
as a single 64bit register. Also add simplified macros for
direct register accesses.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-priv.h | 29 +++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 3e25b1dd1a1a..9fdebb773e71 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -39,23 +39,31 @@
 #define ETM_MODE_EXCL_USER	BIT(31)
 
 typedef u32 (*coresight_read_fn)(const struct device *, u32 offset);
-#define coresight_simple_func(type, func, name, offset)			\
+#define __coresight_simple_func(type, func, name, lo_off, hi_off)	\
 static ssize_t name##_show(struct device *_dev,				\
 			   struct device_attribute *attr, char *buf)	\
 {									\
 	type *drvdata = dev_get_drvdata(_dev->parent);			\
 	coresight_read_fn fn = func;					\
-	u32 val;							\
+	u64 val;							\
 	pm_runtime_get_sync(_dev->parent);				\
 	if (fn)								\
-		val = fn(_dev->parent, offset);				\
+		val = (u64)fn(_dev->parent, lo_off);			\
 	else								\
-		val = readl_relaxed(drvdata->base + offset);		\
+		val = coresight_read_reg_pair(drvdata->base,		\
+						 lo_off, hi_off);	\
 	pm_runtime_put_sync(_dev->parent);				\
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);		\
+	return scnprintf(buf, PAGE_SIZE, "0x%llx\n", val);		\
 }									\
 static DEVICE_ATTR_RO(name)
 
+#define coresight_simple_func(type, func, name, offset)			\
+	__coresight_simple_func(type, func, name, offset, -1)
+#define coresight_simple_reg32(type, name, offset)			\
+	__coresight_simple_func(type, NULL, name, offset, -1)
+#define coresight_simple_reg64(type, name, lo_off, hi_off)		\
+	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
+
 extern const u32 barrier_pkt[5];
 
 enum etm_addr_type {
@@ -108,6 +116,17 @@ static inline void CS_UNLOCK(void __iomem *addr)
 	} while (0);
 }
 
+static inline u64
+coresight_read_reg_pair(void __iomem *addr, s32 lo_offset, s32 hi_offset)
+{
+	u64 val;
+
+	val = readl_relaxed(addr + lo_offset);
+	val |= (hi_offset < 0) ? 0 :
+	       (u64)readl_relaxed(addr + hi_offset) << 32;
+	return val;
+}
+
 void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode);
 struct coresight_device *coresight_get_sink(struct list_head *path);
-- 
2.7.4
