From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Mon, 30 Mar 2015 14:13:40 -0600
Subject: [PATCH 7/8] coresight-tmc: Adding a status interface to sysfs
In-Reply-To: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
References: <1427746421-31360-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1427746421-31360-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Knowing the state of various control register is always
useful for degging and tuning.  As such add an entry in
sysfs that expose to userspace the most important registers.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/coresight/coresight-tmc.c | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/coresight/coresight-tmc.c b/drivers/coresight/coresight-tmc.c
index 030e097c4fb2..7147f3dd363c 100644
--- a/drivers/coresight/coresight-tmc.c
+++ b/drivers/coresight/coresight-tmc.c
@@ -565,6 +565,59 @@ static const struct file_operations tmc_fops = {
 	.llseek		= no_llseek,
 };
 
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	int ret;
+	unsigned long flags;
+	u32 tmc_rsz, tmc_sts, tmc_rrp, tmc_rwp, tmc_trg;
+	u32 tmc_ctl, tmc_ffsr, tmc_ffcr, tmc_mode, tmc_pscr;
+	u32 devid;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
+
+	ret = clk_prepare_enable(drvdata->clk);
+	if (ret)
+		goto out;
+
+	spin_lock_irqsave(&drvdata->spinlock, flags);
+	CS_UNLOCK(drvdata->base);
+
+	tmc_rsz = readl_relaxed(drvdata->base + TMC_RSZ);
+	tmc_sts = readl_relaxed(drvdata->base + TMC_STS);
+	tmc_rrp = readl_relaxed(drvdata->base + TMC_RRP);
+	tmc_rwp = readl_relaxed(drvdata->base + TMC_RWP);
+	tmc_trg = readl_relaxed(drvdata->base + TMC_TRG);
+	tmc_ctl = readl_relaxed(drvdata->base + TMC_CTL);
+	tmc_ffsr = readl_relaxed(drvdata->base + TMC_FFSR);
+	tmc_ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
+	tmc_mode = readl_relaxed(drvdata->base + TMC_MODE);
+	tmc_pscr = readl_relaxed(drvdata->base + TMC_PSCR);
+	devid = readl_relaxed(drvdata->base + CORESIGHT_DEVID);
+
+	CS_LOCK(drvdata->base);
+	spin_unlock_irqrestore(&drvdata->spinlock, flags);
+
+	clk_disable_unprepare(drvdata->clk);
+
+	return sprintf(buf,
+		       "Depth:\t\t0x%x\n"
+		       "Status:\t\t0x%x\n"
+		       "RAM read ptr:\t0x%x\n"
+		       "RAM wrt ptr:\t0x%x\n"
+		       "Trigger cnt:\t0x%x\n"
+		       "Control:\t0x%x\n"
+		       "Flush status:\t0x%x\n"
+		       "Flush ctrl:\t0x%x\n"
+		       "Mode:\t\t0x%x\n"
+		       "PSRC:\t\t0x%x\n"
+		       "DEVID:\t\t0x%x\n",
+			tmc_rsz, tmc_sts, tmc_rrp, tmc_rwp, tmc_trg,
+			tmc_ctl, tmc_ffsr, tmc_ffcr, tmc_mode, tmc_pscr, devid);
+out:
+	return -EINVAL;
+}
+static DEVICE_ATTR_RO(status);
+
 static ssize_t trigger_cntr_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
@@ -593,18 +646,21 @@ static DEVICE_ATTR_RW(trigger_cntr);
 
 static struct attribute *coresight_etb_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(coresight_etb);
 
 static struct attribute *coresight_etr_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(coresight_etr);
 
 static struct attribute *coresight_etf_attrs[] = {
 	&dev_attr_trigger_cntr.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(coresight_etf);
-- 
1.9.1
