From: zhouqiao@marvell.com (Qiao Zhou)
Date: Wed, 13 Jun 2012 17:04:10 +0800
Subject: [PATCH 2/3] rtc: add rtc support to 88PM80X PMIC
In-Reply-To: <1339578251-15009-1-git-send-email-zhouqiao@marvell.com>
References: <1339578251-15009-1-git-send-email-zhouqiao@marvell.com>
Message-ID: <1339578251-15009-3-git-send-email-zhouqiao@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add rtc driver for MARVELL 88PM80X PMIC and enable rtc function.

Signed-off-by: Qiao Zhou <zhouqiao@marvell.com>
---
 drivers/rtc/Kconfig       |   10 ++
 drivers/rtc/Makefile      |    1 +
 drivers/rtc/rtc-88pm80x.c |  370 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 381 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-88pm80x.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 08cbdb9..f3b49f8 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -135,6 +135,16 @@ config RTC_DRV_88PM860X
 	  This driver can also be built as a module. If so, the module
 	  will be called rtc-88pm860x.
 
+config RTC_DRV_88PM80X
+	tristate "Marvell 88PM80x"
+	depends on RTC_CLASS && I2C && MFD_88PM80X
+	help
+	  If you say yes here you get support for RTC function in Marvell
+	  88PM80x chips.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called rtc-88pm80x.
+
 config RTC_DRV_DS1307
 	tristate "Dallas/Maxim DS1307/37/38/39/40, ST M41T00, EPSON RX-8025"
 	help
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 2973921..0d5b2b6 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -16,6 +16,7 @@ rtc-core-$(CONFIG_RTC_INTF_SYSFS) += rtc-sysfs.o
 # Keep the list ordered.
 
 obj-$(CONFIG_RTC_DRV_88PM860X)  += rtc-88pm860x.o
+obj-$(CONFIG_RTC_DRV_88PM80X)	+= rtc-88pm80x.o
 obj-$(CONFIG_RTC_DRV_AB3100)	+= rtc-ab3100.o
 obj-$(CONFIG_RTC_DRV_AB8500)	+= rtc-ab8500.o
 obj-$(CONFIG_RTC_DRV_AT32AP700X)+= rtc-at32ap700x.o
diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
new file mode 100644
index 0000000..109f0e5
--- /dev/null
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -0,0 +1,370 @@
+/*
+ * Real Time Clock driver for Marvell 88PM80x PMIC
+ *
+ * Copyright (c) 2012 Marvell International Ltd.
+ *  Wenzeng Chen<wzch@marvell.com>
+ *  Qiao Zhou <zhouqiao@marvell.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License. See the file "COPYING" in the main directory of this
+ * archive for more details.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/rtc.h>
+#include <linux/delay.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/88pm80x.h>
+#include <linux/sched.h>
+
+struct pm80x_rtc_info {
+	struct pm80x_chip *chip;
+	struct i2c_client *i2c;
+	struct rtc_device *rtc_dev;
+	struct device *dev;
+	struct delayed_work calib_work;
+
+	int irq;
+	int vrtc;
+	int (*sync) (unsigned int ticks);
+};
+
+static int pm80x_rtc_read_time(struct device *dev, struct rtc_time *tm);
+
+static irqreturn_t rtc_update_handler(int irq, void *data)
+{
+	struct pm80x_rtc_info *info = (struct pm80x_rtc_info *)data;
+	int mask;
+
+	mask = PM800_ALARM | PM800_ALARM_WAKEUP;
+	pm80x_set_bits(info->i2c, PM800_RTC_CONTROL, mask | PM800_ALARM1_EN,
+		       mask);
+	rtc_update_irq(info->rtc_dev, 1, RTC_AF);
+	return IRQ_HANDLED;
+}
+
+static int pm80x_rtc_alarm_irq_enable(struct device *dev, unsigned int enabled)
+{
+	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
+
+	if (enabled)
+		pm80x_set_bits(info->i2c, PM800_RTC_CONTROL, PM800_ALARM1_EN,
+			       PM800_ALARM1_EN);
+	else
+		pm80x_set_bits(info->i2c, PM800_RTC_CONTROL, PM800_ALARM1_EN,
+			       0);
+	return 0;
+}
+
+/*
+ * Calculate the next alarm time given the requested alarm time mask
+ * and the current time.
+ */
+static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
+				struct rtc_time *alrm)
+{
+	unsigned long next_time;
+	unsigned long now_time;
+
+	next->tm_year = now->tm_year;
+	next->tm_mon = now->tm_mon;
+	next->tm_mday = now->tm_mday;
+	next->tm_hour = alrm->tm_hour;
+	next->tm_min = alrm->tm_min;
+	next->tm_sec = alrm->tm_sec;
+
+	rtc_tm_to_time(now, &now_time);
+	rtc_tm_to_time(next, &next_time);
+
+	if (next_time < now_time) {
+		/* Advance one day */
+		next_time += 60 * 60 * 24;
+		rtc_time_to_tm(next_time, next);
+	}
+}
+
+static int pm80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
+	unsigned char buf[4];
+	unsigned long ticks, base, data;
+	pm80x_bulk_read(info->i2c, PM800_RTC_EXPIRE2_1, 4, buf);
+	base = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	dev_dbg(info->dev, "%x-%x-%x-%x\n", buf[0], buf[1], buf[2], buf[3]);
+
+	/* load 32-bit read-only counter */
+	pm80x_bulk_read(info->i2c, PM800_RTC_COUNTER1, 4, buf);
+	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	ticks = base + data;
+	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+		base, data, ticks);
+	rtc_time_to_tm(ticks, tm);
+	return 0;
+}
+
+static int pm80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
+	unsigned char buf[4];
+	unsigned long ticks, base, data;
+	if ((tm->tm_year < 70) || (tm->tm_year > 138)) {
+		dev_dbg(info->dev,
+			"Set time %d out of range. Please set time between 1970 to 2038.\n",
+			1900 + tm->tm_year);
+		return -EINVAL;
+	}
+	rtc_tm_to_time(tm, &ticks);
+
+	/* load 32-bit read-only counter */
+	pm80x_bulk_read(info->i2c, PM800_RTC_COUNTER1, 4, buf);
+	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	base = ticks - data;
+	dev_dbg(info->dev, "set base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+		base, data, ticks);
+	buf[0] = base & 0xFF;
+	buf[1] = (base >> 8) & 0xFF;
+	buf[2] = (base >> 16) & 0xFF;
+	buf[3] = (base >> 24) & 0xFF;
+	pm80x_bulk_write(info->i2c, PM800_RTC_EXPIRE2_1, 4, buf);
+
+	if (info->sync)
+		info->sync(ticks);
+
+	return 0;
+}
+
+static int pm80x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
+	unsigned char buf[4];
+	unsigned long ticks, base, data;
+	int ret;
+
+	pm80x_bulk_read(info->i2c, PM800_RTC_EXPIRE2_1, 4, buf);
+	base = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	dev_dbg(info->dev, "%x-%x-%x-%x\n", buf[0], buf[1], buf[2], buf[3]);
+
+	pm80x_bulk_read(info->i2c, PM800_RTC_EXPIRE1_1, 4, buf);
+	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	ticks = base + data;
+	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+		base, data, ticks);
+
+	rtc_time_to_tm(ticks, &alrm->time);
+	ret = pm80x_reg_read(info->i2c, PM800_RTC_CONTROL);
+	alrm->enabled = (ret & PM800_ALARM1_EN) ? 1 : 0;
+	alrm->pending = (ret & (PM800_ALARM | PM800_ALARM_WAKEUP)) ? 1 : 0;
+	return 0;
+}
+
+static int pm80x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
+{
+	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
+	struct rtc_time now_tm, alarm_tm;
+	unsigned long ticks, base, data;
+	unsigned char buf[4];
+	int mask;
+
+	pm80x_set_bits(info->i2c, PM800_RTC_CONTROL, PM800_ALARM1_EN, 0);
+
+	pm80x_bulk_read(info->i2c, PM800_RTC_EXPIRE2_1, 4, buf);
+	base = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	dev_dbg(info->dev, "%x-%x-%x-%x\n", buf[0], buf[1], buf[2], buf[3]);
+
+	/* load 32-bit read-only counter */
+	pm80x_bulk_read(info->i2c, PM800_RTC_COUNTER1, 4, buf);
+	data = (buf[3] << 24) | (buf[2] << 16) | (buf[1] << 8) | buf[0];
+	ticks = base + data;
+	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
+		base, data, ticks);
+
+	rtc_time_to_tm(ticks, &now_tm);
+	dev_dbg(info->dev, "%s, now time : %lu\n", __func__, ticks);
+	rtc_next_alarm_time(&alarm_tm, &now_tm, &alrm->time);
+	/* get new ticks for alarm in 24 hours */
+	rtc_tm_to_time(&alarm_tm, &ticks);
+	dev_dbg(info->dev, "%s, alarm time: %lu\n", __func__, ticks);
+	data = ticks - base;
+
+	buf[0] = data & 0xff;
+	buf[1] = (data >> 8) & 0xff;
+	buf[2] = (data >> 16) & 0xff;
+	buf[3] = (data >> 24) & 0xff;
+	pm80x_bulk_write(info->i2c, PM800_RTC_EXPIRE1_1, 4, buf);
+	if (alrm->enabled) {
+		mask = PM800_ALARM | PM800_ALARM_WAKEUP | PM800_ALARM1_EN;
+		pm80x_set_bits(info->i2c, PM800_RTC_CONTROL, mask, mask);
+	} else {
+		mask = PM800_ALARM | PM800_ALARM_WAKEUP | PM800_ALARM1_EN;
+		pm80x_set_bits(info->i2c, PM800_RTC_CONTROL, mask,
+			       PM800_ALARM | PM800_ALARM_WAKEUP);
+	}
+	return 0;
+}
+
+static const struct rtc_class_ops pm80x_rtc_ops = {
+	.read_time = pm80x_rtc_read_time,
+	.set_time = pm80x_rtc_set_time,
+	.read_alarm = pm80x_rtc_read_alarm,
+	.set_alarm = pm80x_rtc_set_alarm,
+	.alarm_irq_enable = pm80x_rtc_alarm_irq_enable,
+};
+
+#ifdef CONFIG_PM
+static int pm80x_rtc_suspend(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+
+	if (device_may_wakeup(dev))
+		chip->wu_flag_pm800 |= (1 << PM800_IRQ_RTC);
+
+	return 0;
+}
+
+static int pm80x_rtc_resume(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+
+	if (device_may_wakeup(dev))
+		chip->wu_flag_pm800 &= ~(1 << PM800_IRQ_RTC);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(pm80x_rtc_pm_ops, pm80x_rtc_suspend, pm80x_rtc_resume);
+
+static int __devinit pm80x_rtc_probe(struct platform_device *pdev)
+{
+	struct pm80x_chip *chip = dev_get_drvdata(pdev->dev.parent);
+	struct pm80x_platform_data *pm80x_pdata;
+	struct pm80x_rtc_pdata *pdata = NULL;
+	struct pm80x_rtc_info *info;
+	struct rtc_time tm;
+	unsigned long ticks = 0;
+	int ret;
+
+	pdata = pdev->dev.platform_data;
+	if (pdata == NULL)
+		dev_warn(&pdev->dev, "No platform data!\n");
+
+	info =
+	    devm_kzalloc(&pdev->dev, sizeof(struct pm80x_rtc_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+	info->irq = platform_get_irq(pdev, 0);
+	if (info->irq < 0) {
+		dev_err(&pdev->dev, "No IRQ resource!\n");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	info->chip = chip;
+	info->i2c = chip->base_page;
+	info->dev = &pdev->dev;
+	dev_set_drvdata(&pdev->dev, info);
+
+	ret = request_threaded_irq(info->irq, NULL, rtc_update_handler,
+				   IRQF_ONESHOT, "rtc", info);
+	if (ret < 0) {
+		dev_err(chip->dev, "Failed to request IRQ: #%d: %d\n",
+			info->irq, ret);
+		goto out;
+	}
+
+	ret = pm80x_rtc_read_time(&pdev->dev, &tm);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to read initial time.\n");
+		goto out_rtc;
+	}
+	if ((tm.tm_year < 70) || (tm.tm_year > 138)) {
+		tm.tm_year = 70;
+		tm.tm_mon = 0;
+		tm.tm_mday = 1;
+		tm.tm_hour = 0;
+		tm.tm_min = 0;
+		tm.tm_sec = 0;
+		ret = pm80x_rtc_set_time(&pdev->dev, &tm);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Failed to set initial time.\n");
+			goto out_rtc;
+		}
+	}
+	rtc_tm_to_time(&tm, &ticks);
+	if (pdata && pdata->sync) {
+		pdata->sync(ticks);
+		info->sync = pdata->sync;
+	}
+
+	info->rtc_dev = rtc_device_register("88pm80x-rtc", &pdev->dev,
+					    &pm80x_rtc_ops, THIS_MODULE);
+	ret = PTR_ERR(info->rtc_dev);
+	if (IS_ERR(info->rtc_dev)) {
+		dev_err(&pdev->dev, "Failed to register RTC device: %d\n", ret);
+		goto out_rtc;
+	}
+	/*
+	 * enable internal XO instead of internal 3.25MHz clock since it can
+	 * free running in PMIC power-down state.
+	 */
+	pm80x_set_bits(info->i2c, PM800_RTC_CONTROL, PM800_RTC1_USE_XO,
+		       PM800_RTC1_USE_XO);
+
+	if (pdev->dev.parent->platform_data) {
+		pm80x_pdata = pdev->dev.parent->platform_data;
+		pdata = pm80x_pdata->rtc;
+		if (pdata)
+			info->rtc_dev->dev.platform_data = &pdata->rtc_wakeup;
+	}
+
+	device_init_wakeup(&pdev->dev, 1);
+
+	return 0;
+out_rtc:
+	free_irq(info->irq, info);
+out:
+	devm_kfree(&pdev->dev, info);
+	return ret;
+}
+
+static int __devexit pm80x_rtc_remove(struct platform_device *pdev)
+{
+	struct pm80x_rtc_info *info = platform_get_drvdata(pdev);
+	platform_set_drvdata(pdev, NULL);
+	rtc_device_unregister(info->rtc_dev);
+	free_irq(info->irq, info);
+	devm_kfree(&pdev->dev, info);
+	return 0;
+}
+
+static struct platform_driver pm80x_rtc_driver = {
+	.driver = {
+		   .name = "88pm80x-rtc",
+		   .owner = THIS_MODULE,
+		   .pm = &pm80x_rtc_pm_ops,
+		   },
+	.probe = pm80x_rtc_probe,
+	.remove = __devexit_p(pm80x_rtc_remove),
+};
+
+module_platform_driver(pm80x_rtc_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Marvell 88PM80x RTC driver");
+MODULE_AUTHOR("Qiao Zhou <zhouqiao@marvell.com>");
+MODULE_ALIAS("platform:88pm80x-rtc");
-- 
1.7.4.1
