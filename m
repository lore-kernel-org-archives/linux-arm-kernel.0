From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  5 Apr 2016 11:53:51 -0600
Subject: [PATCH 10/11] coresight: etb10: splitting sysFS "status" entry
In-Reply-To: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
References: <1459878832-15219-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1459878832-15219-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sysFS "status" entry conveys a wealth of information about
the status of the HW but goes agains the sysFS rule of one topic
per file.

This patch rectify the situation by adding read-only entries for
each of the field formaly displayed by "status".  The ABI
documentation is kept up to date.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../ABI/testing/sysfs-bus-coresight-devices-etb10  | 69 ++++++++++++++++--
 drivers/hwtracing/coresight/coresight-etb10.c      | 81 ++++++++++------------
 2 files changed, 100 insertions(+), 50 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10 b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10
index 4b8d6ec92e2b..b5f526081711 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-etb10
@@ -6,13 +6,6 @@ Description:	(RW) Add/remove a sink from a trace path.  There can be multiple
 		source for a single sink.
 		ex: echo 1 > /sys/bus/coresight/devices/20010000.etb/enable_sink
 
-What:		/sys/bus/coresight/devices/<memory_map>.etb/status
-Date:		November 2014
-KernelVersion:	3.19
-Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
-Description:	(R) List various control and status registers.  The specific
-		layout and content is driver specific.
-
 What:		/sys/bus/coresight/devices/<memory_map>.etb/trigger_cntr
 Date:		November 2014
 KernelVersion:	3.19
@@ -22,3 +15,65 @@ Description:	(RW) Disables write access to the Trace RAM by stopping the
 		following the trigger event. The number of 32-bit words written
 		into the Trace RAM following the trigger event is equal to the
 		value stored in this register+1 (from ARM ETB-TRM).
+
+What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/rdp
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Defines the depth, in words, of the trace RAM in powers of
+		2.  The value is read directly from HW register RDP, 0x004.
+
+What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/sts
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the ETB status register.  The value
+		is read directly from HW register STS, 0x00C.
+
+What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/rrp
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the ETB RAM Read Pointer register
+		that is used to read entries from the Trace RAM over the APB
+		interface.  The value is read directly from HW register RRP,
+		0x014.
+
+What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/rwp
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the ETB RAM Write Pointer register
+		that is used to sets the write pointer to write entries from
+		the CoreSight bus into the Trace RAM. The value is read directly
+		from HW register RWP, 0x018.
+
+What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/trg
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Similar to "trigger_cntr" above except that this value is
+		read directly from HW register TRG, 0x01C.
+
+What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/ctl
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the ETB Control register. The value
+		is read directly from HW register CTL, 0x020.
+
+What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/ffsr
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the ETB Formatter and Flush Status
+		register.  The value is read directly from HW register FFSR,
+		0x300.
+
+What:		/sys/bus/coresight/devices/<memory_map>.etb/mgmt/ffcr
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the ETB Formatter and Flush Control
+		register.  The value is read directly from HW register FFCR,
+		0x304.
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index acbce79934d6..8bf4429e1fb3 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -579,47 +579,29 @@ static const struct file_operations etb_fops = {
 	.llseek		= no_llseek,
 };
 
-static ssize_t status_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
-{
-	unsigned long flags;
-	u32 etb_rdr, etb_sr, etb_rrp, etb_rwp;
-	u32 etb_trg, etb_cr, etb_ffsr, etb_ffcr;
-	struct etb_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	pm_runtime_get_sync(drvdata->dev);
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	CS_UNLOCK(drvdata->base);
-
-	etb_rdr = readl_relaxed(drvdata->base + ETB_RAM_DEPTH_REG);
-	etb_sr = readl_relaxed(drvdata->base + ETB_STATUS_REG);
-	etb_rrp = readl_relaxed(drvdata->base + ETB_RAM_READ_POINTER);
-	etb_rwp = readl_relaxed(drvdata->base + ETB_RAM_WRITE_POINTER);
-	etb_trg = readl_relaxed(drvdata->base + ETB_TRG);
-	etb_cr = readl_relaxed(drvdata->base + ETB_CTL_REG);
-	etb_ffsr = readl_relaxed(drvdata->base + ETB_FFSR);
-	etb_ffcr = readl_relaxed(drvdata->base + ETB_FFCR);
-
-	CS_LOCK(drvdata->base);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
-
-	pm_runtime_put(drvdata->dev);
-
-	return sprintf(buf,
-		       "Depth:\t\t0x%x\n"
-		       "Status:\t\t0x%x\n"
-		       "RAM read ptr:\t0x%x\n"
-		       "RAM wrt ptr:\t0x%x\n"
-		       "Trigger cnt:\t0x%x\n"
-		       "Control:\t0x%x\n"
-		       "Flush status:\t0x%x\n"
-		       "Flush ctrl:\t0x%x\n",
-		       etb_rdr, etb_sr, etb_rrp, etb_rwp,
-		       etb_trg, etb_cr, etb_ffsr, etb_ffcr);
-
-	return -EINVAL;
-}
-static DEVICE_ATTR_RO(status);
+#define coresight_etb10_simple_func(name, offset)                       \
+	coresight_simple_func(struct etb_drvdata, name, offset)
+
+coresight_etb10_simple_func(rdp, ETB_RAM_DEPTH_REG);
+coresight_etb10_simple_func(sts, ETB_STATUS_REG);
+coresight_etb10_simple_func(rrp, ETB_RAM_READ_POINTER);
+coresight_etb10_simple_func(rwp, ETB_RAM_WRITE_POINTER);
+coresight_etb10_simple_func(trg, ETB_TRG);
+coresight_etb10_simple_func(ctl, ETB_CTL_REG);
+coresight_etb10_simple_func(ffsr, ETB_FFSR);
+coresight_etb10_simple_func(ffcr, ETB_FFCR);
+
+static struct attribute *coresight_etb_mgmt_attrs[] = {
+	&dev_attr_rdp.attr,
+	&dev_attr_sts.attr,
+	&dev_attr_rrp.attr,
+	&dev_attr_rwp.attr,
+	&dev_attr_trg.attr,
+	&dev_attr_ctl.attr,
+	&dev_attr_ffsr.attr,
+	&dev_attr_ffcr.attr,
+	NULL,
+};
 
 static ssize_t trigger_cntr_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
@@ -649,10 +631,23 @@ static DEVICE_ATTR_RW(trigger_cntr);
 
 static struct attribute *coresight_etb_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
-	&dev_attr_status.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(coresight_etb);
+
+static const struct attribute_group coresight_etb_group = {
+	.attrs = coresight_etb_attrs,
+};
+
+static const struct attribute_group coresight_etb_mgmt_group = {
+	.attrs = coresight_etb_mgmt_attrs,
+	.name = "mgmt",
+};
+
+const struct attribute_group *coresight_etb_groups[] = {
+	&coresight_etb_group,
+	&coresight_etb_mgmt_group,
+	NULL,
+};
 
 static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 {
-- 
2.1.4
