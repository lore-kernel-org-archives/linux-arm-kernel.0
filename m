From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Mon,  4 Mar 2013 15:05:45 +0100
Subject: [PATCH 6/9] rtc: stmp3xxx: add sysfs entries for persistent regs
In-Reply-To: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1362405948-12992-7-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The persistent registers 1-5 are completely software defined. To have access
from userspace, export them via sysfs.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/rtc/rtc-stmp3xxx.c |   69 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/rtc/rtc-stmp3xxx.c b/drivers/rtc/rtc-stmp3xxx.c
index 936b0ca..16b45c8 100644
--- a/drivers/rtc/rtc-stmp3xxx.c
+++ b/drivers/rtc/rtc-stmp3xxx.c
@@ -67,6 +67,8 @@
 /* missing bitmask in headers */
 #define STMP3XXX_RTC_PERSISTENT1_FORCE_UPDATER	0x80000000
 
+#define STMP3XXX_RTC_PERSISTENT_LEN		(0xC0 - STMP3XXX_RTC_PERSISTENT1)
+
 enum clock_source { MXS_UNKNOWN, MXS_OSC_24M, MXS_OSC_32K, MXS_OSC_32K768 };
 
 struct stmp3xxx_rtc_data {
@@ -74,6 +76,9 @@ struct stmp3xxx_rtc_data {
 	void __iomem *io;
 	int irq_alarm;
 	enum clock_source clk_src;
+#if IS_ENABLED(CONFIG_RTC_INTF_SYSFS)
+	struct bin_attribute *persist;
+#endif
 };
 
 #if IS_ENABLED(CONFIG_STMP3XXX_RTC_WATCHDOG)
@@ -262,6 +267,42 @@ static int stmp3xxx_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_RTC_INTF_SYSFS)
+static ssize_t stmp3xxx_rtc_persist_read(struct file *filep,
+					 struct kobject *kobj,
+					 struct bin_attribute *bin_attr,
+					 char *buf, loff_t off, size_t size)
+{
+	struct rtc_device *rtc = container_of(kobj, struct rtc_device,
+					      dev.kobj);
+	struct device *dev = rtc->dev.parent;
+	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
+	ssize_t count;
+
+	for (count = 0; size; size--, off++, count++)
+		*buf++ = readl(rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + off);
+
+	return count;
+}
+
+static ssize_t stmp3xxx_rtc_persist_write(struct file *filep,
+					  struct kobject *kobj,
+					  struct bin_attribute *bin_attr,
+					  char *buf, loff_t off, size_t size)
+{
+	struct rtc_device *rtc = container_of(kobj, struct rtc_device,
+					      dev.kobj);
+	struct device *dev = rtc->dev.parent;
+	struct stmp3xxx_rtc_data *rtc_data = dev_get_drvdata(dev);
+	ssize_t count;
+
+	for (count = 0; size; size--, off++, count++)
+		writel(*buf++, rtc_data->io + STMP3XXX_RTC_PERSISTENT1 + off);
+
+	return count;
+}
+#endif
+
 static struct rtc_class_ops stmp3xxx_rtc_ops = {
 	.alarm_irq_enable =
 			  stmp3xxx_alarm_irq_enable,
@@ -278,6 +319,11 @@ static int stmp3xxx_rtc_remove(struct platform_device *pdev)
 	if (!rtc_data)
 		return 0;
 
+#if IS_ENABLED(CONFIG_RTC_INTF_SYSFS)
+	sysfs_remove_bin_file(&pdev->dev.kobj, rtc_data->persist);
+	kfree(rtc_data->persist);
+#endif
+
 	writel(STMP3XXX_RTC_CTRL_ALARM_IRQ_EN,
 			rtc_data->io + STMP3XXX_RTC_CTRL_CLR);
 	free_irq(rtc_data->irq_alarm, &pdev->dev);
@@ -384,8 +430,31 @@ static int stmp3xxx_rtc_probe(struct platform_device *pdev)
 	}
 
 	stmp3xxx_wdt_register(pdev);
+
+#if IS_ENABLED(CONFIG_RTC_INTF_SYSFS)
+	rtc_data->persist = kzalloc(sizeof(struct bin_attribute), GFP_KERNEL);
+	if (!rtc_data->persist) {
+		err = -ENOMEM;
+		goto out_persist;
+	}
+
+	rtc_data->persist->attr.name = "persistent";
+	rtc_data->persist->attr.mode = S_IRUGO | S_IWUSR;
+	sysfs_bin_attr_init(rtc_data->persist);
+	rtc_data->persist->read = stmp3xxx_rtc_persist_read;
+	rtc_data->persist->write = stmp3xxx_rtc_persist_write;
+	rtc_data->persist->size = STMP3XXX_RTC_PERSISTENT_LEN;
+	err = sysfs_create_bin_file(&rtc_data->rtc->dev.kobj,
+				rtc_data->persist);
+	if (err) {
+		kfree(rtc_data->persist);
+		goto out_persist;
+	}
+#endif
+
 	return 0;
 
+out_persist:
 out_irq_alarm:
 	rtc_device_unregister(rtc_data->rtc);
 out_remap:
-- 
1.7.10.4
