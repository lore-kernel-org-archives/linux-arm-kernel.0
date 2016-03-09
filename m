From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue,  8 Mar 2016 20:48:36 -0700
Subject: [PATCH 3/3] coresight: tmc: adding sysFS management entries
In-Reply-To: <1457495316-5281-1-git-send-email-mathieu.poirier@linaro.org>
References: <1457495316-5281-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1457495316-5281-4-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding management registers that convey implementation
specific characteristics.  Those are useful for trace
configuration and collection along with general trouble
shooting.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../ABI/testing/sysfs-bus-coresight-devices-tmc    |  77 +++++++++++++++
 drivers/hwtracing/coresight/coresight-tmc.c        | 107 +++++++++------------
 2 files changed, 120 insertions(+), 64 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
index f38cded5fa22..4fe677ed1305 100644
--- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
+++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tmc
@@ -6,3 +6,80 @@ Description:	(RW) Disables write access to the Trace RAM by stopping the
 		formatter after a defined number of words have been stored
 		following the trigger event. Additional interface for this
 		driver are expected to be added as it matures.
+
+What:           /sys/bus/coresight/devices/<memory_map>.tmc/mgmt/rsz
+Date:           March 2016
+KernelVersion:  4.7
+Contact:        Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:    (R) Defines the size, in 32-bit words, of the local RAM buffer.
+                The value is read directly from HW register RSZ, 0x004.
+
+What:           /sys/bus/coresight/devices/<memory_map>.tmc/mgmt/sts
+Date:           March 2016
+KernelVersion:  4.7
+Contact:        Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the TMC status register.  The value
+                is read directly from HW register STS, 0x00C.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/rrp
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the TMC RAM Read Pointer register
+		that is used to read entries from the Trace RAM over the APB
+		interface.  The value is read directly from HW register RRP,
+		0x014.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/rwp
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the TMC RAM Write Pointer register
+		that is used to sets the write pointer to write entries from
+		the CoreSight bus into the Trace RAM. The value is read directly
+		from HW register RWP, 0x018.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/trg
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Similar to "trigger_cntr" above except that this value is
+		read directly from HW register TRG, 0x01C.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/ctl
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the TMC Control register. The value
+		is read directly from HW register CTL, 0x020.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/ffsr
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the TMC Formatter and Flush Status
+		register.  The value is read directly from HW register FFSR,
+		0x300.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/ffcr
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the TMC Formatter and Flush Control
+		register.  The value is read directly from HW register FFCR,
+		0x304.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/mode
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Shows the value held by the TMC Mode register, which
+		indicate the mode the device has been configured to enact.  The
+		The value is read directly from the MODE register, 0x028.
+
+What:		/sys/bus/coresight/devices/<memory_map>.tmc/mgmt/devid
+Date:		March 2016
+KernelVersion:	4.7
+Contact:	Mathieu Poirier <mathieu.poirier@linaro.org>
+Description:	(R) Indicates the capabilities of the Coresight TMC.
+		The value is read directly from the DEVID register, 0xFC8,
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index ac91b0b40ec2..f0a67f984591 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -555,56 +555,38 @@ static const struct file_operations tmc_fops = {
 	.llseek		= no_llseek,
 };
 
-static ssize_t status_show(struct device *dev,
-			   struct device_attribute *attr, char *buf)
-{
-	unsigned long flags;
-	u32 tmc_rsz, tmc_sts, tmc_rrp, tmc_rwp, tmc_trg;
-	u32 tmc_ctl, tmc_ffsr, tmc_ffcr, tmc_mode, tmc_pscr;
-	u32 devid;
-	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	pm_runtime_get_sync(drvdata->dev);
-	spin_lock_irqsave(&drvdata->spinlock, flags);
-	CS_UNLOCK(drvdata->base);
-
-	tmc_rsz = readl_relaxed(drvdata->base + TMC_RSZ);
-	tmc_sts = readl_relaxed(drvdata->base + TMC_STS);
-	tmc_rrp = readl_relaxed(drvdata->base + TMC_RRP);
-	tmc_rwp = readl_relaxed(drvdata->base + TMC_RWP);
-	tmc_trg = readl_relaxed(drvdata->base + TMC_TRG);
-	tmc_ctl = readl_relaxed(drvdata->base + TMC_CTL);
-	tmc_ffsr = readl_relaxed(drvdata->base + TMC_FFSR);
-	tmc_ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
-	tmc_mode = readl_relaxed(drvdata->base + TMC_MODE);
-	tmc_pscr = readl_relaxed(drvdata->base + TMC_PSCR);
-	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
-
-	CS_LOCK(drvdata->base);
-	spin_unlock_irqrestore(&drvdata->spinlock, flags);
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
-		       "Flush ctrl:\t0x%x\n"
-		       "Mode:\t\t0x%x\n"
-		       "PSRC:\t\t0x%x\n"
-		       "DEVID:\t\t0x%x\n",
-			tmc_rsz, tmc_sts, tmc_rrp, tmc_rwp, tmc_trg,
-			tmc_ctl, tmc_ffsr, tmc_ffcr, tmc_mode, tmc_pscr, devid);
-
-	return -EINVAL;
-}
-static DEVICE_ATTR_RO(status);
+#define coresight_tmc_simple_func(name, offset)			\
+	coresight_simple_func(struct tmc_drvdata, name, offset)
+
+coresight_tmc_simple_func(rsz, TMC_RSZ);
+coresight_tmc_simple_func(sts, TMC_STS);
+coresight_tmc_simple_func(rrp, TMC_RRP);
+coresight_tmc_simple_func(rwp, TMC_RWP);
+coresight_tmc_simple_func(trg, TMC_TRG);
+coresight_tmc_simple_func(ctl, TMC_CTL);
+coresight_tmc_simple_func(ffsr, TMC_FFSR);
+coresight_tmc_simple_func(ffcr, TMC_FFCR);
+coresight_tmc_simple_func(mode, TMC_MODE);
+coresight_tmc_simple_func(pscr, TMC_PSCR);
+coresight_tmc_simple_func(devid, CORESIGHT_DEVID);
+
+static struct attribute *coresight_tmc_mgmt_attrs[] = {
+	&dev_attr_rsz.attr,
+	&dev_attr_sts.attr,
+	&dev_attr_rrp.attr,
+	&dev_attr_rwp.attr,
+	&dev_attr_trg.attr,
+	&dev_attr_ctl.attr,
+	&dev_attr_ffsr.attr,
+	&dev_attr_ffcr.attr,
+	&dev_attr_mode.attr,
+	&dev_attr_pscr.attr,
+	&dev_attr_devid.attr,
+	NULL,
+};
 
-static ssize_t trigger_cntr_show(struct device *dev,
-			    struct device_attribute *attr, char *buf)
+ssize_t trigger_cntr_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->trigger_cntr;
@@ -629,26 +611,25 @@ static ssize_t trigger_cntr_store(struct device *dev,
 }
 static DEVICE_ATTR_RW(trigger_cntr);
 
-static struct attribute *coresight_etb_attrs[] = {
+static struct attribute *coresight_tmc_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
-	&dev_attr_status.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(coresight_etb);
 
-static struct attribute *coresight_etr_attrs[] = {
-	&dev_attr_trigger_cntr.attr,
-	&dev_attr_status.attr,
-	NULL,
+static const struct attribute_group coresight_tmc_group = {
+	.attrs = coresight_tmc_attrs,
 };
-ATTRIBUTE_GROUPS(coresight_etr);
 
-static struct attribute *coresight_etf_attrs[] = {
-	&dev_attr_trigger_cntr.attr,
-	&dev_attr_status.attr,
+static const struct attribute_group coresight_tmc_mgmt_group = {
+	.attrs = coresight_tmc_mgmt_attrs,
+	.name = "mgmt",
+};
+
+const struct attribute_group *coresight_tmc_groups[] = {
+	&coresight_tmc_group,
+	&coresight_tmc_mgmt_group,
 	NULL,
 };
-ATTRIBUTE_GROUPS(coresight_etf);
 
 static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -724,20 +705,18 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	desc->pdata = pdata;
 	desc->dev = dev;
 	desc->subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
+	desc->groups = coresight_tmc_groups;
 
 	if (drvdata->config_type == TMC_CONFIG_TYPE_ETB) {
 		desc->type = CORESIGHT_DEV_TYPE_SINK;
 		desc->ops = &tmc_etb_cs_ops;
-		desc->groups = coresight_etb_groups;
 	} else if (drvdata->config_type == TMC_CONFIG_TYPE_ETR) {
 		desc->type = CORESIGHT_DEV_TYPE_SINK;
 		desc->ops = &tmc_etr_cs_ops;
-		desc->groups = coresight_etr_groups;
 	} else {
 		desc->type = CORESIGHT_DEV_TYPE_LINKSINK;
 		desc->subtype.link_subtype = CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
 		desc->ops = &tmc_etf_cs_ops;
-		desc->groups = coresight_etf_groups;
 	}
 
 	drvdata->csdev = coresight_register(desc);
-- 
2.1.4
