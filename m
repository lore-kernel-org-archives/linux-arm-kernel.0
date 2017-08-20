From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 20 Aug 2017 03:36:30 +0200
Subject: [RFC 2/3] rtc: Add Realtek RTD1295
In-Reply-To: <20170820013632.18375-1-afaerber@suse.de>
References: <20170820013632.18375-1-afaerber@suse.de>
Message-ID: <20170820013632.18375-3-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on QNAP's mach-rtk119x/driver/rtk_rtc_drv.c code.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 drivers/rtc/Kconfig       |   8 +++
 drivers/rtc/Makefile      |   1 +
 drivers/rtc/rtc-rtd119x.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 drivers/rtc/rtc-rtd119x.c

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 72419ac2c52a..882828b1b351 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1765,6 +1765,14 @@ config RTC_DRV_CPCAP
 	   Say y here for CPCAP rtc found on some Motorola phones
 	   and tablets such as Droid 4.
 
+config RTC_DRV_RTD119X
+	bool "Realtek RTD129x RTC"
+	depends on ARCH_REALTEK || COMPILE_TEST
+	default ARCH_REALTEK
+	help
+	  If you say yes here, you get support for the RTD1295 SoC
+	  Real Time Clock.
+
 comment "HID Sensor RTC drivers"
 
 config RTC_DRV_HID_SENSOR_TIME
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index acd366b41c85..55a0a5ca45b0 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -131,6 +131,7 @@ obj-$(CONFIG_RTC_DRV_RP5C01)	+= rtc-rp5c01.o
 obj-$(CONFIG_RTC_DRV_RS5C313)	+= rtc-rs5c313.o
 obj-$(CONFIG_RTC_DRV_RS5C348)	+= rtc-rs5c348.o
 obj-$(CONFIG_RTC_DRV_RS5C372)	+= rtc-rs5c372.o
+obj-$(CONFIG_RTC_DRV_RTD119X)	+= rtc-rtd119x.o
 obj-$(CONFIG_RTC_DRV_RV3029C2)	+= rtc-rv3029c2.o
 obj-$(CONFIG_RTC_DRV_RV8803)	+= rtc-rv8803.o
 obj-$(CONFIG_RTC_DRV_RX4581)	+= rtc-rx4581.o
diff --git a/drivers/rtc/rtc-rtd119x.c b/drivers/rtc/rtc-rtd119x.c
new file mode 100644
index 000000000000..b532e127b56e
--- /dev/null
+++ b/drivers/rtc/rtc-rtd119x.c
@@ -0,0 +1,175 @@
+/*
+ * Realtek RTD129x RTC
+ *
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: GPL-2.0+
+ */
+
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/rtc.h>
+
+#define RTD_RTCSEC		0x00
+#define RTD_RTCMIN		0x04
+#define RTD_RTCHR		0x08
+#define RTD_RTCDATE_LOW		0x0c
+#define RTD_RTCDATE_HIGH	0x10
+#define RTD_RTCACR		0x28
+#define RTD_RTCEN		0x2c
+
+struct rtd119x_rtc {
+	void __iomem *base;
+	struct clk *clk;
+	struct rtc_device *rtcdev;
+	unsigned base_year;
+};
+
+static void rtd119x_rtc_set_enabled(struct device *dev, bool enable)
+{
+	struct rtd119x_rtc *data = dev_get_drvdata(dev);
+	u32 val;
+
+	val = readl_relaxed(data->base + RTD_RTCEN);
+	dev_info(dev, "%s: rtcen = 0x%08x\n", __func__, val);
+	if (enable) {
+		if ((val & 0xff) == 0x5a)
+			return;
+		writel_relaxed(0x5a, data->base + RTD_RTCEN);
+	} else {
+		writel_relaxed(0, data->base + RTD_RTCEN);
+	}
+}
+
+static int rtd119x_rtc_read_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rtd119x_rtc *data = dev_get_drvdata(dev);
+	time64_t t;
+	u32 day;
+
+	day = readl_relaxed(data->base + RTD_RTCDATE_LOW);
+	day |= readl_relaxed(data->base + RTD_RTCDATE_HIGH) << 8;
+	t = mktime64(data->base_year, 1, 1, 0, 0, 0);
+	t += day * 24 * 60 * 60;
+	rtc_time64_to_tm(t, tm);
+	tm->tm_sec  = readl_relaxed(data->base + RTD_RTCSEC) >> 1;
+	tm->tm_min  = readl_relaxed(data->base + RTD_RTCMIN);
+	tm->tm_hour = readl_relaxed(data->base + RTD_RTCHR);
+
+	return rtc_valid_tm(tm);
+}
+
+static int rtd119x_rtc_set_time(struct device *dev, struct rtc_time *tm)
+{
+	struct rtd119x_rtc *data = dev_get_drvdata(dev);
+	time64_t time_base, new_time, time_delta;
+	unsigned long day;
+
+	if (tm->tm_year < data->base_year)
+		return -EINVAL;
+
+	time_base = mktime64(data->base_year, 1, 1, 0, 0, 0);
+	new_time = rtc_tm_to_time64(tm);
+	time_delta = new_time - time_base;
+	day = time_delta / (24 * 60 * 60);
+	if (day > 0x7fff)
+		return -EINVAL;
+
+	rtd119x_rtc_set_enabled(dev, false);
+
+	writel_relaxed(tm->tm_sec,  data->base + RTD_RTCSEC);
+	writel_relaxed(tm->tm_min,  data->base + RTD_RTCMIN);
+	writel_relaxed(tm->tm_hour, data->base + RTD_RTCHR);
+	writel_relaxed(day & 0xff, data->base + RTD_RTCDATE_LOW);
+	writel_relaxed((day >> 8) & 0x7f, data->base + RTD_RTCDATE_HIGH);
+
+	rtd119x_rtc_set_enabled(dev, true);
+
+	return 0;
+}
+
+static int rtd119x_rtc_open(struct device *dev)
+{
+	struct rtd119x_rtc *data = dev_get_drvdata(dev);
+	u32 val;
+	int ret;
+
+	ret = clk_prepare_enable(data->clk);
+	if (ret)
+		return ret;
+
+	val = readl_relaxed(data->base + RTD_RTCACR);
+	dev_info(dev, "rtcacr = 0x%08x\n", val);
+	if (!(val & BIT(7))) {
+	}
+
+	rtd119x_rtc_set_enabled(dev, true);
+
+	return 0;
+}
+
+static void rtd119x_rtc_release(struct device *dev)
+{
+	struct rtd119x_rtc *data = dev_get_drvdata(dev);
+
+	rtd119x_rtc_set_enabled(dev, false);
+
+	clk_disable_unprepare(data->clk);
+}
+
+static const struct rtc_class_ops rtd119x_rtc_ops = {
+	.open		= rtd119x_rtc_open,
+	.release	= rtd119x_rtc_release,
+	.read_time	= rtd119x_rtc_read_time,
+	.set_time	= rtd119x_rtc_set_time,
+};
+
+static const struct of_device_id rtd119x_rtc_dt_ids[] = {
+	 { .compatible = "realtek,rtd1295-rtc" },
+	 { }
+};
+
+static int rtd119x_rtc_probe(struct platform_device *pdev)
+{
+	struct rtd119x_rtc *data;
+	struct resource *res;
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, data);
+	data->base_year = 2014;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(data->base))
+		return PTR_ERR(data->base);
+
+	data->clk = of_clk_get(pdev->dev.of_node, 0);
+	if (IS_ERR(data->clk))
+		return PTR_ERR(data->clk);
+
+	data->rtcdev = devm_rtc_device_register(&pdev->dev, "rtc",
+				&rtd119x_rtc_ops, THIS_MODULE);
+	if (IS_ERR(data->rtcdev)) {
+		dev_err(&pdev->dev, "failed to register rtc device");
+		clk_put(data->clk);
+		return PTR_ERR(data->rtcdev);
+	}
+
+	return 0;
+}
+
+static struct platform_driver rtd119x_rtc_driver = {
+	.probe = rtd119x_rtc_probe,
+	.driver = {
+		.name = "rtd1295-rtc",
+		.of_match_table	= rtd119x_rtc_dt_ids,
+	},
+};
+builtin_platform_driver(rtd119x_rtc_driver);
-- 
2.12.3
