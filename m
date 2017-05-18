From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 18 May 2017 23:56:35 +0200
Subject: [PATCH 3/3] rtc: gemini/ftrtc010: rename driver and symbols
In-Reply-To: <20170518215635.13505-1-linus.walleij@linaro.org>
References: <20170518215635.13505-1-linus.walleij@linaro.org>
Message-ID: <20170518215635.13505-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Gemini RTC is actually a generic IP block from Faraday
Technology names FTRTC010. Rename the driver file and all
symbols to match this IP name.

The relationship can be clearly seen in the U-Boot driver
posted by Po-Yu Chuang for the Faraday A320 board:
https://lists.denx.de/pipermail/u-boot/2009-September/061326.html

Remove the dependency on ARCH_GEMINI but select the driver
for ARCH_GEMINI so we get a smooth transition. The IP block
is synthsized on different silicon and architectures.

Cc: Po-Yu Chuang <ratbert@faraday-tech.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 MAINTAINERS                                  |  2 +-
 drivers/rtc/Kconfig                          | 10 +--
 drivers/rtc/Makefile                         |  2 +-
 drivers/rtc/{rtc-gemini.c => rtc-ftrtc010.c} | 91 ++++++++++++++--------------
 4 files changed, 53 insertions(+), 52 deletions(-)
 rename drivers/rtc/{rtc-gemini.c => rtc-ftrtc010.c} (62%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f7d568b8f133..c6f0f412b32e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1226,7 +1226,7 @@ L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://github.com/ulli-kroll/linux.git
 S:	Maintained
 F:	arch/arm/mach-gemini/
-F:	drivers/rtc/rtc-gemini.c
+F:	drivers/rtc/rtc-ftrtc010.c
 
 ARM/CSR SIRFPRIMA2 MACHINE SUPPORT
 M:	Barry Song <baohua@kernel.org>
diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 8d3b95728326..e60ed55d0b82 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1484,16 +1484,16 @@ config RTC_DRV_ARMADA38X
 	  This driver can also be built as a module. If so, the module
 	  will be called armada38x-rtc.
 
-config RTC_DRV_GEMINI
-	tristate "Gemini SoC RTC"
-	depends on ARCH_GEMINI || COMPILE_TEST
+config RTC_DRV_FTRTC010
+	tristate "Faraday Technology FTRTC010 RTC"
 	depends on HAS_IOMEM
+	default ARCH_GEMINI
 	help
 	  If you say Y here you will get support for the
-	  RTC found on Gemini SoC's.
+	  Faraday Technolog FTRTC010 found on e.g. Gemini SoC's.
 
 	  This driver can also be built as a module. If so, the module
-	  will be called rtc-gemini.
+	  will be called rtc-ftrtc010.
 
 config RTC_DRV_PS3
 	tristate "PS3 RTC"
diff --git a/drivers/rtc/Makefile b/drivers/rtc/Makefile
index 13857d2fce09..5d3944a42d48 100644
--- a/drivers/rtc/Makefile
+++ b/drivers/rtc/Makefile
@@ -67,7 +67,7 @@ obj-$(CONFIG_RTC_DRV_EFI)	+= rtc-efi.o
 obj-$(CONFIG_RTC_DRV_EM3027)	+= rtc-em3027.o
 obj-$(CONFIG_RTC_DRV_EP93XX)	+= rtc-ep93xx.o
 obj-$(CONFIG_RTC_DRV_FM3130)	+= rtc-fm3130.o
-obj-$(CONFIG_RTC_DRV_GEMINI)	+= rtc-gemini.o
+obj-$(CONFIG_RTC_DRV_FTRTC010)	+= rtc-ftrtc010.o
 obj-$(CONFIG_RTC_DRV_GENERIC)	+= rtc-generic.o
 obj-$(CONFIG_RTC_DRV_HID_SENSOR_TIME) += rtc-hid-sensor-time.o
 obj-$(CONFIG_RTC_DRV_HYM8563)	+= rtc-hym8563.o
diff --git a/drivers/rtc/rtc-gemini.c b/drivers/rtc/rtc-ftrtc010.c
similarity index 62%
rename from drivers/rtc/rtc-gemini.c
rename to drivers/rtc/rtc-ftrtc010.c
index d69a35aa80e7..31281beb8ebd 100644
--- a/drivers/rtc/rtc-gemini.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -1,5 +1,5 @@
 /*
- *  Gemini OnChip RTC
+ *  Faraday Technology FTRTC010 driver
  *
  *  Copyright (C) 2009 Janos Laube <janos.dev@gmail.com>
  *
@@ -28,14 +28,14 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 
-#define DRV_NAME        "rtc-gemini"
+#define DRV_NAME        "rtc-ftrtc010"
 
 MODULE_AUTHOR("Hans Ulli Kroll <ulli.kroll@googlemail.com>");
 MODULE_DESCRIPTION("RTC driver for Gemini SoC");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("platform:" DRV_NAME);
 
-struct gemini_rtc {
+struct ftrtc010_rtc {
 	struct rtc_device	*rtc_dev;
 	void __iomem		*rtc_base;
 	int			rtc_irq;
@@ -43,19 +43,19 @@ struct gemini_rtc {
 	struct clk		*extclk;
 };
 
-enum gemini_rtc_offsets {
-	GEMINI_RTC_SECOND	= 0x00,
-	GEMINI_RTC_MINUTE	= 0x04,
-	GEMINI_RTC_HOUR		= 0x08,
-	GEMINI_RTC_DAYS		= 0x0C,
-	GEMINI_RTC_ALARM_SECOND	= 0x10,
-	GEMINI_RTC_ALARM_MINUTE	= 0x14,
-	GEMINI_RTC_ALARM_HOUR	= 0x18,
-	GEMINI_RTC_RECORD	= 0x1C,
-	GEMINI_RTC_CR		= 0x20
+enum ftrtc010_rtc_offsets {
+	FTRTC010_RTC_SECOND		= 0x00,
+	FTRTC010_RTC_MINUTE		= 0x04,
+	FTRTC010_RTC_HOUR		= 0x08,
+	FTRTC010_RTC_DAYS		= 0x0C,
+	FTRTC010_RTC_ALARM_SECOND	= 0x10,
+	FTRTC010_RTC_ALARM_MINUTE	= 0x14,
+	FTRTC010_RTC_ALARM_HOUR		= 0x18,
+	FTRTC010_RTC_RECORD		= 0x1C,
+	FTRTC010_RTC_CR			= 0x20,
 };
 
-static irqreturn_t gemini_rtc_interrupt(int irq, void *dev)
+static irqreturn_t ftrtc010_rtc_interrupt(int irq, void *dev)
 {
 	return IRQ_HANDLED;
 }
@@ -69,18 +69,18 @@ static irqreturn_t gemini_rtc_interrupt(int irq, void *dev)
  * the same thing, without the rtc-lib.c calls.
  */
 
-static int gemini_rtc_read_time(struct device *dev, struct rtc_time *tm)
+static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct gemini_rtc *rtc = dev_get_drvdata(dev);
+	struct ftrtc010_rtc *rtc = dev_get_drvdata(dev);
 
 	unsigned int  days, hour, min, sec;
 	unsigned long offset, time;
 
-	sec  = readl(rtc->rtc_base + GEMINI_RTC_SECOND);
-	min  = readl(rtc->rtc_base + GEMINI_RTC_MINUTE);
-	hour = readl(rtc->rtc_base + GEMINI_RTC_HOUR);
-	days = readl(rtc->rtc_base + GEMINI_RTC_DAYS);
-	offset = readl(rtc->rtc_base + GEMINI_RTC_RECORD);
+	sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
+	min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
+	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
+	days = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
+	offset = readl(rtc->rtc_base + FTRTC010_RTC_RECORD);
 
 	time = offset + days * 86400 + hour * 3600 + min * 60 + sec;
 
@@ -89,9 +89,9 @@ static int gemini_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	return 0;
 }
 
-static int gemini_rtc_set_time(struct device *dev, struct rtc_time *tm)
+static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct gemini_rtc *rtc = dev_get_drvdata(dev);
+	struct ftrtc010_rtc *rtc = dev_get_drvdata(dev);
 	unsigned int sec, min, hour, day;
 	unsigned long offset, time;
 
@@ -100,27 +100,27 @@ static int gemini_rtc_set_time(struct device *dev, struct rtc_time *tm)
 
 	rtc_tm_to_time(tm, &time);
 
-	sec = readl(rtc->rtc_base + GEMINI_RTC_SECOND);
-	min = readl(rtc->rtc_base + GEMINI_RTC_MINUTE);
-	hour = readl(rtc->rtc_base + GEMINI_RTC_HOUR);
-	day = readl(rtc->rtc_base + GEMINI_RTC_DAYS);
+	sec = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
+	min = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
+	hour = readl(rtc->rtc_base + FTRTC010_RTC_HOUR);
+	day = readl(rtc->rtc_base + FTRTC010_RTC_DAYS);
 
 	offset = time - (day * 86400 + hour * 3600 + min * 60 + sec);
 
-	writel(offset, rtc->rtc_base + GEMINI_RTC_RECORD);
-	writel(0x01, rtc->rtc_base + GEMINI_RTC_CR);
+	writel(offset, rtc->rtc_base + FTRTC010_RTC_RECORD);
+	writel(0x01, rtc->rtc_base + FTRTC010_RTC_CR);
 
 	return 0;
 }
 
-static const struct rtc_class_ops gemini_rtc_ops = {
-	.read_time     = gemini_rtc_read_time,
-	.set_time      = gemini_rtc_set_time,
+static const struct rtc_class_ops ftrtc010_rtc_ops = {
+	.read_time     = ftrtc010_rtc_read_time,
+	.set_time      = ftrtc010_rtc_set_time,
 };
 
-static int gemini_rtc_probe(struct platform_device *pdev)
+static int ftrtc010_rtc_probe(struct platform_device *pdev)
 {
-	struct gemini_rtc *rtc;
+	struct ftrtc010_rtc *rtc;
 	struct device *dev = &pdev->dev;
 	struct resource *res;
 	int ret;
@@ -166,19 +166,19 @@ static int gemini_rtc_probe(struct platform_device *pdev)
 	if (!rtc->rtc_base)
 		return -ENOMEM;
 
-	ret = devm_request_irq(dev, rtc->rtc_irq, gemini_rtc_interrupt,
+	ret = devm_request_irq(dev, rtc->rtc_irq, ftrtc010_rtc_interrupt,
 			       IRQF_SHARED, pdev->name, dev);
 	if (unlikely(ret))
 		return ret;
 
 	rtc->rtc_dev = rtc_device_register(pdev->name, dev,
-					   &gemini_rtc_ops, THIS_MODULE);
+					   &ftrtc010_rtc_ops, THIS_MODULE);
 	return PTR_ERR_OR_ZERO(rtc->rtc_dev);
 }
 
-static int gemini_rtc_remove(struct platform_device *pdev)
+static int ftrtc010_rtc_remove(struct platform_device *pdev)
 {
-	struct gemini_rtc *rtc = platform_get_drvdata(pdev);
+	struct ftrtc010_rtc *rtc = platform_get_drvdata(pdev);
 
 	if (!IS_ERR(rtc->extclk))
 		clk_disable_unprepare(rtc->extclk);
@@ -189,19 +189,20 @@ static int gemini_rtc_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id gemini_rtc_dt_match[] = {
+static const struct of_device_id ftrtc010_rtc_dt_match[] = {
 	{ .compatible = "cortina,gemini-rtc" },
+	{ .compatible = "faraday,ftrtc010" },
 	{ }
 };
-MODULE_DEVICE_TABLE(of, gemini_rtc_dt_match);
+MODULE_DEVICE_TABLE(of, ftrtc010_rtc_dt_match);
 
-static struct platform_driver gemini_rtc_driver = {
+static struct platform_driver ftrtc010_rtc_driver = {
 	.driver		= {
 		.name	= DRV_NAME,
-		.of_match_table = gemini_rtc_dt_match,
+		.of_match_table = ftrtc010_rtc_dt_match,
 	},
-	.probe		= gemini_rtc_probe,
-	.remove		= gemini_rtc_remove,
+	.probe		= ftrtc010_rtc_probe,
+	.remove		= ftrtc010_rtc_remove,
 };
 
-module_platform_driver_probe(gemini_rtc_driver, gemini_rtc_probe);
+module_platform_driver_probe(ftrtc010_rtc_driver, ftrtc010_rtc_probe);
-- 
2.9.3
