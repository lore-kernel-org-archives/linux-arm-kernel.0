From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Mon, 12 Jun 2017 15:36:43 +0100
Subject: [PATCH 04/12] coresight: Add support for reading 64bit registers
In-Reply-To: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1497278211-5001-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for reading a lower and upper 32bits of a register
as a single 64bit register.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-priv.h | 27 ++++++++++++++++++++++-----
 drivers/hwtracing/coresight/coresight-tmc.c  |  6 +++---
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 5f662d8..b62dc6a 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -39,23 +39,29 @@
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
+#define coresight_simple_reg64(type, name, lo_off, hi_off)		\
+	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
+
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
 	ETM_ADDR_TYPE_SINGLE,
@@ -106,6 +112,17 @@ static inline void CS_UNLOCK(void __iomem *addr)
 	} while (0);
 }
 
+static inline u64
+coresight_read_reg_pair(void __iomem *addr, s32 lo_offset, s32 hi_offset)
+{
+	u64 val;
+
+	val = readl_relaxed(addr + lo_offset);
+	val |= (hi_offset < 0) ? 0 :
+		(u64)readl_relaxed(addr + hi_offset) << 32;
+	return val;
+}
+
 void coresight_disable_path(struct list_head *path);
 int coresight_enable_path(struct list_head *path, u32 mode);
 struct coresight_device *coresight_get_sink(struct list_head *path);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index eb0c7b3..7025982 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -219,11 +219,8 @@ static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
 
 #define coresight_tmc_simple_func(name, offset)			\
 	coresight_simple_func(struct tmc_drvdata, NULL, name, offset)
-
 coresight_tmc_simple_func(rsz, TMC_RSZ);
 coresight_tmc_simple_func(sts, TMC_STS);
-coresight_tmc_simple_func(rrp, TMC_RRP);
-coresight_tmc_simple_func(rwp, TMC_RWP);
 coresight_tmc_simple_func(trg, TMC_TRG);
 coresight_tmc_simple_func(ctl, TMC_CTL);
 coresight_tmc_simple_func(ffsr, TMC_FFSR);
@@ -232,6 +229,9 @@ coresight_tmc_simple_func(mode, TMC_MODE);
 coresight_tmc_simple_func(pscr, TMC_PSCR);
 coresight_tmc_simple_func(devid, CORESIGHT_DEVID);
 
+coresight_simple_reg64(struct tmc_drvdata, rrp, TMC_RRP, TMC_RRPHI);
+coresight_simple_reg64(struct tmc_drvdata, rwp, TMC_RWP, TMC_RWPHI);
+
 static struct attribute *coresight_tmc_mgmt_attrs[] = {
 	&dev_attr_rsz.attr,
 	&dev_attr_sts.attr,
-- 
2.7.4
