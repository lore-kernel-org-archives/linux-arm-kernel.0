From: w.sang@pengutronix.de (Wolfram Sang)
Date: Tue, 12 Jul 2011 14:16:25 +0200
Subject: [PATCH 1/2] arm: mach-mxs: add device for rtc
Message-ID: <1310472986-31493-1-git-send-email-w.sang@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Tested-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/devices-mx23.h                  |    2 +
 arch/arm/mach-mxs/devices-mx28.h                  |    2 +
 arch/arm/mach-mxs/devices/Kconfig                 |    3 +
 arch/arm/mach-mxs/devices/Makefile                |    1 +
 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c |   51 +++++++++++++++++++++
 5 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c

diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index c6f345f..3fa651d 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -29,3 +29,5 @@ extern const struct mxs_mxs_mmc_data mx23_mxs_mmc_data[] __initconst;
 
 struct platform_device *__init mx23_add_mxsfb(
 		const struct mxsfb_platform_data *pdata);
+
+struct platform_device *__init mx23_add_rtc_stmp3xxx(void);
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 79b9452..a252c68 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -45,3 +45,5 @@ extern const struct mxs_mxs_mmc_data mx28_mxs_mmc_data[] __initconst;
 
 struct platform_device *__init mx28_add_mxsfb(
 		const struct mxsfb_platform_data *pdata);
+
+struct platform_device *__init mx28_add_rtc_stmp3xxx(void);
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index acf9eea..9d8d239 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -23,3 +23,6 @@ config MXS_HAVE_PLATFORM_MXS_PWM
 
 config MXS_HAVE_PLATFORM_MXSFB
 	bool
+
+config MXS_HAVE_PLATFORM_RTC_STMP3XXX
+	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index 351915c..31e0a0b 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_MMC) += platform-mxs-mmc.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
 obj-y += platform-gpio-mxs.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_MXSFB) += platform-mxsfb.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_RTC_STMP3XXX) += platform-rtc-stmp3xxx.o
diff --git a/arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c b/arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c
new file mode 100644
index 0000000..639eaee
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-rtc-stmp3xxx.c
@@ -0,0 +1,51 @@
+/*
+ * Copyright (C) 2011 Pengutronix, Wolfram Sang <w.sang@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+#ifdef CONFIG_SOC_IMX23
+struct platform_device *__init mx23_add_rtc_stmp3xxx(void)
+{
+	struct resource res[] = {
+		{
+			.start = MX23_RTC_BASE_ADDR,
+			.end = MX23_RTC_BASE_ADDR + SZ_8K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = MX23_INT_RTC_ALARM,
+			.end = MX23_INT_RTC_ALARM,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return mxs_add_platform_device("stmp3xxx-rtc", 0, res, ARRAY_SIZE(res),
+					NULL, 0);
+}
+#endif /* CONFIG_SOC_IMX23 */
+
+#ifdef CONFIG_SOC_IMX28
+struct platform_device *__init mx28_add_rtc_stmp3xxx(void)
+{
+	struct resource res[] = {
+		{
+			.start = MX28_RTC_BASE_ADDR,
+			.end = MX28_RTC_BASE_ADDR + SZ_8K - 1,
+			.flags = IORESOURCE_MEM,
+		}, {
+			.start = MX28_INT_RTC_ALARM,
+			.end = MX28_INT_RTC_ALARM,
+			.flags = IORESOURCE_IRQ,
+		},
+	};
+
+	return mxs_add_platform_device("stmp3xxx-rtc", 0, res, ARRAY_SIZE(res),
+					NULL, 0);
+}
+#endif /* CONFIG_SOC_IMX28 */
-- 
1.7.5.4
