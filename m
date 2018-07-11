From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 11 Jul 2018 13:40:24 -0600
Subject: [PATCH 14/25] coresight: tmc: Add configuration support for trace
 buffer size
In-Reply-To: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
References: <1531338035-11729-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1531338035-11729-15-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Now that we can dynamically switch between contiguous memory and
SG table depending on the trace buffer size, provide the support
for selecting an appropriate buffer size.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |  8 ++++++
 .../devicetree/bindings/arm/coresight.txt          |  3 +-
 drivers/hwtracing/coresight/coresight-tmc.c        | 33 ++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index 4fe677ed1305..ab49b9ac3bcb 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -83,3 +83,11 @@ KernelVersion:	4.7
 Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
 Description:	(R) Indicates the capabilities of the Coresight TMC.
 		The value is read directly from the DEVID register, 0xFC8,
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/buffer_size
+Date:		December 2018
+KernelVersion:	4.19
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(RW) Size of the trace buffer for TMC-ETR when used in SYSFS
+		mode. Writable only for TMC-ETR configurations. The value
+		should be aligned to the kernel pagesize.
diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index 603d3c62e8c7..9aa30a156b57 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -84,7 +84,8 @@ its hardware characteristcs.
 * Optional property for TMC:
 
 	* arm,buffer-size: size of contiguous buffer space for TMC ETR
-	 (embedded trace router)
+	  (embedded trace router). This property is obsolete. The buffer size
+	  can be configured dynamically via buffer_size property in sysfs.
 
 	* arm,scatter-gather: boolean. Indicates that the TMC-ETR can safely
 	  use the SG mode on this system.
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index bc8fc860c473..1b817ec1192c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -277,8 +277,41 @@ static ssize_t trigger_cntr_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(trigger_cntr);
 
+static ssize_t buffer_size_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	return sprintf(buf, "%#x\n", drvdata->size);
+}
+
+static ssize_t buffer_size_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	int ret;
+	unsigned long val;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	/* Only permitted for TMC-ETRs */
+	if (drvdata->config_type != TMC_CONFIG_TYPE_ETR)
+		return -EPERM;
+
+	ret = kstrtoul(buf, 0, &val);
+	if (ret)
+		return ret;
+	/* The buffer size should be page aligned */
+	if (val & (PAGE_SIZE - 1))
+		return -EINVAL;
+	drvdata->size = val;
+	return size;
+}
+
+static DEVICE_ATTR_RW(buffer_size);
+
 static struct attribute *coresight_tmc_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
+	&dev_attr_buffer_size.attr,
 	NULL,
 };
 
-- 
2.7.4
