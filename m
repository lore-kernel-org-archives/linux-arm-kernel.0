From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed,  3 Aug 2016 17:12:32 +0100
Subject: [PATCH 2/2] coresight: fix handling of ETM trace register access via
 sysfs
In-Reply-To: <1470240752-17331-1-git-send-email-sudeep.holla@arm.com>
References: <1470240752-17331-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1470240752-17331-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ETM registers are classified into 2 categories: trace and management.
The core power domain contains most of the trace unit logic including
all(except TRCOSLAR and TRCOSLSR) the trace registers. The debug power
domain contains the external debugger interface including all management
registers.

This patch adds coresight unit specific function coresight_simple_func
which can be used for ETM trace registers by providing a ETM specific
read function which does smp cross call to ensure the trace core is
powered up before the register is accessed.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwtracing/coresight/coresight-etb10.c      |  2 +-
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    |  2 +-
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 58 ++++++++++++++++------
 drivers/hwtracing/coresight/coresight-etm4x.h      |  1 +
 drivers/hwtracing/coresight/coresight-priv.h       |  9 +++-
 drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
 drivers/hwtracing/coresight/coresight-tmc.c        |  2 +-
 7 files changed, 54 insertions(+), 22 deletions(-)

Hi Mathieu,

I think the latest release of the firmware(inparticular SCP v1.16.0) for
Juno fixes the issue you had previously encountered. However there's a
pending issue with A53 ETM management register access when it's powered
down.

I don't think Juno platform should block these changes as ETMv4
specification is clear on the power management and register access
perspective.

Regards,
Sudeep

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 8a4927ca9181..d7325c6534ad 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -559,7 +559,7 @@ static const struct file_operations etb_fops = {
 };

 #define coresight_etb10_simple_func(name, offset)                       \
-	coresight_simple_func(struct etb_drvdata, name, offset)
+	coresight_simple_func(struct etb_drvdata, NULL, name, offset)

 coresight_etb10_simple_func(rdp, ETB_RAM_DEPTH_REG);
 coresight_etb10_simple_func(sts, ETB_STATUS_REG);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 02d4b629891f..4856c8098416 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -1222,7 +1222,7 @@ static struct attribute *coresight_etm_attrs[] = {
 };

 #define coresight_etm3x_simple_func(name, offset)			\
-	coresight_simple_func(struct etm_drvdata, name, offset)
+	coresight_simple_func(struct etm_drvdata, NULL, name, offset)

 coresight_etm3x_simple_func(etmccr, ETMCCR);
 coresight_etm3x_simple_func(etmccer, ETMCCER);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 7c84308c5564..2390ee43e3d9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2039,15 +2039,38 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	NULL,
 };

+struct etm_reg {
+	void __iomem *addr;
+	u32 data;
+};
+
+static void do_smp_cross_read(void *data)
+{
+	struct etm_reg *reg = data;
+
+	reg->data = readl_relaxed(reg->addr);
+}
+
+static u32 etmv4_chk_trace_reg_access(const struct device *dev, u32 offset)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev);
+	struct etm_reg reg;
+
+	reg.addr = drvdata->base + offset;
+	smp_call_function_single(drvdata->cpu, do_smp_cross_read, &reg, 1);
+	return reg.data;
+}
+
 #define coresight_etm4x_simple_func(name, offset)			\
-	coresight_simple_func(struct etmv4_drvdata, name, offset)
+	coresight_simple_func(struct etmv4_drvdata, NULL, name, offset)
+
+#define coresight_etm4x_trace_reg_func(name, offset)			\
+	coresight_simple_func(struct etmv4_drvdata, etmv4_chk_trace_reg_access,\
+			      name, offset)

-coresight_etm4x_simple_func(trcoslsr, TRCOSLSR);
 coresight_etm4x_simple_func(trcpdcr, TRCPDCR);
 coresight_etm4x_simple_func(trcpdsr, TRCPDSR);
 coresight_etm4x_simple_func(trclsr, TRCLSR);
-coresight_etm4x_simple_func(trcconfig, TRCCONFIGR);
-coresight_etm4x_simple_func(trctraceid, TRCTRACEIDR);
 coresight_etm4x_simple_func(trcauthstatus, TRCAUTHSTATUS);
 coresight_etm4x_simple_func(trcdevid, TRCDEVID);
 coresight_etm4x_simple_func(trcdevtype, TRCDEVTYPE);
@@ -2055,6 +2078,9 @@ coresight_etm4x_simple_func(trcpidr0, TRCPIDR0);
 coresight_etm4x_simple_func(trcpidr1, TRCPIDR1);
 coresight_etm4x_simple_func(trcpidr2, TRCPIDR2);
 coresight_etm4x_simple_func(trcpidr3, TRCPIDR3);
+coresight_etm4x_trace_reg_func(trcoslsr, TRCOSLSR);
+coresight_etm4x_trace_reg_func(trcconfig, TRCCONFIGR);
+coresight_etm4x_trace_reg_func(trctraceid, TRCTRACEIDR);

 static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	&dev_attr_trcoslsr.attr,
@@ -2073,19 +2099,19 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	NULL,
 };

-coresight_etm4x_simple_func(trcidr0, TRCIDR0);
-coresight_etm4x_simple_func(trcidr1, TRCIDR1);
-coresight_etm4x_simple_func(trcidr2, TRCIDR2);
-coresight_etm4x_simple_func(trcidr3, TRCIDR3);
-coresight_etm4x_simple_func(trcidr4, TRCIDR4);
-coresight_etm4x_simple_func(trcidr5, TRCIDR5);
+coresight_etm4x_trace_reg_func(trcidr0, TRCIDR0);
+coresight_etm4x_trace_reg_func(trcidr1, TRCIDR1);
+coresight_etm4x_trace_reg_func(trcidr2, TRCIDR2);
+coresight_etm4x_trace_reg_func(trcidr3, TRCIDR3);
+coresight_etm4x_trace_reg_func(trcidr4, TRCIDR4);
+coresight_etm4x_trace_reg_func(trcidr5, TRCIDR5);
 /* trcidr[6,7] are reserved */
-coresight_etm4x_simple_func(trcidr8, TRCIDR8);
-coresight_etm4x_simple_func(trcidr9, TRCIDR9);
-coresight_etm4x_simple_func(trcidr10, TRCIDR10);
-coresight_etm4x_simple_func(trcidr11, TRCIDR11);
-coresight_etm4x_simple_func(trcidr12, TRCIDR12);
-coresight_etm4x_simple_func(trcidr13, TRCIDR13);
+coresight_etm4x_trace_reg_func(trcidr8, TRCIDR8);
+coresight_etm4x_trace_reg_func(trcidr9, TRCIDR9);
+coresight_etm4x_trace_reg_func(trcidr10, TRCIDR10);
+coresight_etm4x_trace_reg_func(trcidr11, TRCIDR11);
+coresight_etm4x_trace_reg_func(trcidr12, TRCIDR12);
+coresight_etm4x_trace_reg_func(trcidr13, TRCIDR13);

 static struct attribute *coresight_etmv4_trcidr_attrs[] = {
 	&dev_attr_trcidr0.attr,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 2629954429a1..ba4dd2e820ea 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -185,6 +185,7 @@

 /* PowerDown Control Register bits */
 #define TRCPDCR_PU			BIT(3)
+#define TRCPDSR_POWER			BIT(0)

 /* secure state access levels */
 #define ETM_EXLEVEL_S_APP		BIT(8)
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index decfd52b5dc3..39841d1f58e0 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -38,14 +38,19 @@
 #define ETM_MODE_EXCL_KERN	BIT(30)
 #define ETM_MODE_EXCL_USER	BIT(31)

-#define coresight_simple_func(type, name, offset)			\
+typedef u32 (*coresight_read_fn)(const struct device *, u32 offset);
+#define coresight_simple_func(type, func, name, offset)			\
 static ssize_t name##_show(struct device *_dev,				\
 			   struct device_attribute *attr, char *buf)	\
 {									\
 	type *drvdata = dev_get_drvdata(_dev->parent);			\
+	coresight_read_fn fn = func;					\
 	u32 val;							\
 	pm_runtime_get_sync(_dev->parent);				\
-	val = readl_relaxed(drvdata->base + offset);			\
+	if (fn)								\
+		val = fn(_dev->parent, offset);				\
+	else								\
+		val = readl_relaxed(drvdata->base + offset);		\
 	pm_runtime_put_sync(_dev->parent);				\
 	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);		\
 }									\
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 819629aed2f7..7949f0f6744a 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -635,7 +635,7 @@ static ssize_t traceid_store(struct device *dev,
 static DEVICE_ATTR_RW(traceid);

 #define coresight_stm_simple_func(name, offset)	\
-	coresight_simple_func(struct stm_drvdata, name, offset)
+	coresight_simple_func(struct stm_drvdata, NULL, name, offset)

 coresight_stm_simple_func(tcsr, STMTCSR);
 coresight_stm_simple_func(tsfreqr, STMTSFREQR);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 4cbcaf93c9d9..a4748630f5d6 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -218,7 +218,7 @@ static enum tmc_mem_intf_width tmc_get_memwidth(u32 devid)
 }

 #define coresight_tmc_simple_func(name, offset)			\
-	coresight_simple_func(struct tmc_drvdata, name, offset)
+	coresight_simple_func(struct tmc_drvdata, NULL, name, offset)

 coresight_tmc_simple_func(rsz, TMC_RSZ);
 coresight_tmc_simple_func(sts, TMC_STS);
--
2.7.4
