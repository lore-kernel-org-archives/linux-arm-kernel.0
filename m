From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  8 Mar 2016 20:48:34 -0700
Subject: [PATCH 1/3] coresight: moving coresight_simple_func() to header file
In-Reply-To: <1457495316-5281-1-git-send-email-mathieu.poirier@linaro.org>
References: <1457495316-5281-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1457495316-5281-2-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Macro "coresight_simple_func()" can be used by several drivers.
As such making the structure type generic and moving to a
globally available header file.  That way individual drivers
can use the functionality by simply specifying the structure
they need to work with.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 33 +++++-------
 .../hwtracing/coresight/coresight-etm4x-sysfs.c    | 63 ++++++++++------------
 drivers/hwtracing/coresight/coresight-priv.h       | 10 ++++
 3 files changed, 51 insertions(+), 55 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index cbb4046c1070..02d4b629891f 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -1221,26 +1221,19 @@ static struct attribute *coresight_etm_attrs[] = {
 	NULL,
 };
 
-#define coresight_simple_func(name, offset)                             \
-static ssize_t name##_show(struct device *_dev,                         \
-			   struct device_attribute *attr, char *buf)    \
-{                                                                       \
-	struct etm_drvdata *drvdata = dev_get_drvdata(_dev->parent);    \
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n",                      \
-			 readl_relaxed(drvdata->base + offset));        \
-}                                                                       \
-DEVICE_ATTR_RO(name)
-
-coresight_simple_func(etmccr, ETMCCR);
-coresight_simple_func(etmccer, ETMCCER);
-coresight_simple_func(etmscr, ETMSCR);
-coresight_simple_func(etmidr, ETMIDR);
-coresight_simple_func(etmcr, ETMCR);
-coresight_simple_func(etmtraceidr, ETMTRACEIDR);
-coresight_simple_func(etmteevr, ETMTEEVR);
-coresight_simple_func(etmtssvr, ETMTSSCR);
-coresight_simple_func(etmtecr1, ETMTECR1);
-coresight_simple_func(etmtecr2, ETMTECR2);
+#define coresight_etm3x_simple_func(name, offset)			\
+	coresight_simple_func(struct etm_drvdata, name, offset)
+
+coresight_etm3x_simple_func(etmccr, ETMCCR);
+coresight_etm3x_simple_func(etmccer, ETMCCER);
+coresight_etm3x_simple_func(etmscr, ETMSCR);
+coresight_etm3x_simple_func(etmidr, ETMIDR);
+coresight_etm3x_simple_func(etmcr, ETMCR);
+coresight_etm3x_simple_func(etmtraceidr, ETMTRACEIDR);
+coresight_etm3x_simple_func(etmteevr, ETMTEEVR);
+coresight_etm3x_simple_func(etmtssvr, ETMTSSCR);
+coresight_etm3x_simple_func(etmtecr1, ETMTECR1);
+coresight_etm3x_simple_func(etmtecr2, ETMTECR2);
 
 static struct attribute *coresight_etm_mgmt_attrs[] = {
 	&dev_attr_etmccr.attr,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 0e80ec668402..7c84308c5564 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2039,29 +2039,22 @@ static struct attribute *coresight_etmv4_attrs[] = {
 	NULL,
 };
 
-#define coresight_simple_func(name, offset)				\
-static ssize_t name##_show(struct device *_dev,				\
-			   struct device_attribute *attr, char *buf)	\
-{									\
-	struct etmv4_drvdata *drvdata = dev_get_drvdata(_dev->parent);	\
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n",			\
-			 readl_relaxed(drvdata->base + offset));	\
-}									\
-DEVICE_ATTR_RO(name)
-
-coresight_simple_func(trcoslsr, TRCOSLSR);
-coresight_simple_func(trcpdcr, TRCPDCR);
-coresight_simple_func(trcpdsr, TRCPDSR);
-coresight_simple_func(trclsr, TRCLSR);
-coresight_simple_func(trcconfig, TRCCONFIGR);
-coresight_simple_func(trctraceid, TRCTRACEIDR);
-coresight_simple_func(trcauthstatus, TRCAUTHSTATUS);
-coresight_simple_func(trcdevid, TRCDEVID);
-coresight_simple_func(trcdevtype, TRCDEVTYPE);
-coresight_simple_func(trcpidr0, TRCPIDR0);
-coresight_simple_func(trcpidr1, TRCPIDR1);
-coresight_simple_func(trcpidr2, TRCPIDR2);
-coresight_simple_func(trcpidr3, TRCPIDR3);
+#define coresight_etm4x_simple_func(name, offset)			\
+	coresight_simple_func(struct etmv4_drvdata, name, offset)
+
+coresight_etm4x_simple_func(trcoslsr, TRCOSLSR);
+coresight_etm4x_simple_func(trcpdcr, TRCPDCR);
+coresight_etm4x_simple_func(trcpdsr, TRCPDSR);
+coresight_etm4x_simple_func(trclsr, TRCLSR);
+coresight_etm4x_simple_func(trcconfig, TRCCONFIGR);
+coresight_etm4x_simple_func(trctraceid, TRCTRACEIDR);
+coresight_etm4x_simple_func(trcauthstatus, TRCAUTHSTATUS);
+coresight_etm4x_simple_func(trcdevid, TRCDEVID);
+coresight_etm4x_simple_func(trcdevtype, TRCDEVTYPE);
+coresight_etm4x_simple_func(trcpidr0, TRCPIDR0);
+coresight_etm4x_simple_func(trcpidr1, TRCPIDR1);
+coresight_etm4x_simple_func(trcpidr2, TRCPIDR2);
+coresight_etm4x_simple_func(trcpidr3, TRCPIDR3);
 
 static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	&dev_attr_trcoslsr.attr,
@@ -2080,19 +2073,19 @@ static struct attribute *coresight_etmv4_mgmt_attrs[] = {
 	NULL,
 };
 
-coresight_simple_func(trcidr0, TRCIDR0);
-coresight_simple_func(trcidr1, TRCIDR1);
-coresight_simple_func(trcidr2, TRCIDR2);
-coresight_simple_func(trcidr3, TRCIDR3);
-coresight_simple_func(trcidr4, TRCIDR4);
-coresight_simple_func(trcidr5, TRCIDR5);
+coresight_etm4x_simple_func(trcidr0, TRCIDR0);
+coresight_etm4x_simple_func(trcidr1, TRCIDR1);
+coresight_etm4x_simple_func(trcidr2, TRCIDR2);
+coresight_etm4x_simple_func(trcidr3, TRCIDR3);
+coresight_etm4x_simple_func(trcidr4, TRCIDR4);
+coresight_etm4x_simple_func(trcidr5, TRCIDR5);
 /* trcidr[6,7] are reserved */
-coresight_simple_func(trcidr8, TRCIDR8);
-coresight_simple_func(trcidr9, TRCIDR9);
-coresight_simple_func(trcidr10, TRCIDR10);
-coresight_simple_func(trcidr11, TRCIDR11);
-coresight_simple_func(trcidr12, TRCIDR12);
-coresight_simple_func(trcidr13, TRCIDR13);
+coresight_etm4x_simple_func(trcidr8, TRCIDR8);
+coresight_etm4x_simple_func(trcidr9, TRCIDR9);
+coresight_etm4x_simple_func(trcidr10, TRCIDR10);
+coresight_etm4x_simple_func(trcidr11, TRCIDR11);
+coresight_etm4x_simple_func(trcidr12, TRCIDR12);
+coresight_etm4x_simple_func(trcidr13, TRCIDR13);
 
 static struct attribute *coresight_etmv4_trcidr_attrs[] = {
 	&dev_attr_trcidr0.attr,
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index 333eddaed339..3b5dd95a3588 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -37,6 +37,16 @@
 #define ETM_MODE_EXCL_KERN	BIT(30)
 #define ETM_MODE_EXCL_USER	BIT(31)
 
+#define coresight_simple_func(type, name, offset)			\
+static ssize_t name##_show(struct device *_dev,				\
+			   struct device_attribute *attr, char *buf)	\
+{									\
+	type *drvdata = dev_get_drvdata(_dev->parent);			\
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n",			\
+			 readl_relaxed(drvdata->base + offset));	\
+}									\
+static DEVICE_ATTR_RO(name)
+
 enum cs_mode {
 	CS_MODE_DISABLED,
 	CS_MODE_SYSFS,
-- 
2.1.4
