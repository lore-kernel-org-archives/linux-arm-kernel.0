From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri, 18 Feb 2011 22:30:32 +0100
Subject: [PATCH 5/5] ARM: mxs: Add pwm clocks and device registration
In-Reply-To: <20110218213022.GJ22310@pengutronix.de>
References: <20110218213022.GJ22310@pengutronix.de>
Message-ID: <1298064632-15262-5-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-mxs/Kconfig                       |    2 ++
 arch/arm/mach-mxs/clock-mx23.c                  |    6 +++++-
 arch/arm/mach-mxs/clock-mx28.c                  |    9 ++++++++-
 arch/arm/mach-mxs/devices-mx23.h                |    2 ++
 arch/arm/mach-mxs/devices-mx28.h                |    2 ++
 arch/arm/mach-mxs/devices/Kconfig               |    3 +++
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-mxs-pwm.c    |   22 ++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |    4 ++++
 9 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxs-pwm.c

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 55bf075..836cc81 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -8,10 +8,12 @@ config MXS_OCOTP
 config SOC_IMX23
 	bool
 	select CPU_ARM926T
+	select HAVE_PWM
 
 config SOC_IMX28
 	bool
 	select CPU_ARM926T
+	select HAVE_PWM
 
 comment "MXS platforms:"
 
diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index 7c5dace..38ee1b1 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -447,7 +447,11 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
 	_REGISTER_CLOCK(NULL, "usb", usb_clk)
 	_REGISTER_CLOCK(NULL, "audio", audio_clk)
-	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
 };
 
 static int clk_misc_init(void)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index febd787..40726c7 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -622,7 +622,14 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
 	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
 	_REGISTER_CLOCK(NULL, "usb1", usb1_clk)
-	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.0", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.1", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.2", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.3", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.4", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.5", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.6", NULL, pwm_clk)
+	_REGISTER_CLOCK("mxs-pwm.7", NULL, pwm_clk)
 	_REGISTER_CLOCK(NULL, "lradc", lradc_clk)
 	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
 };
diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index c4d4773..7fb27b1 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -19,3 +19,5 @@ extern const struct mxs_auart_data mx23_auart_data[] __initconst;
 #define mx23_add_auart(id)	mxs_add_auart(&mx23_auart_data[id])
 #define mx23_add_auart0()		mx23_add_auart(0)
 #define mx23_add_auart1()		mx23_add_auart(1)
+
+#define mx23_add_mxs_pwm(id)		mxs_add_mxs_pwm(MX23_PWM_BASE_ADDR, id)
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 3b18304..69d19ea 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -32,3 +32,5 @@ extern const struct mxs_flexcan_data mx28_flexcan_data[] __initconst;
 	mxs_add_flexcan(&mx28_flexcan_data[id], pdata)
 #define mx28_add_flexcan0(pdata)	mx28_add_flexcan(0, pdata)
 #define mx28_add_flexcan1(pdata)	mx28_add_flexcan(1, pdata)
+
+#define mx28_add_mxs_pwm(id)		mxs_add_mxs_pwm(MX28_PWM_BASE_ADDR, id)
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index 6c65b67..3aeec24 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -11,3 +11,6 @@ config MXS_HAVE_PLATFORM_FEC
 config MXS_HAVE_PLATFORM_FLEXCAN
 	select HAVE_CAN_FLEXCAN if CAN
 	bool
+
+config MXS_HAVE_PLATFORM_MXS_PWM
+	bool
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index a8dc8d5..978310f 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_MXS_PWM) += platform-mxs-pwm.o
diff --git a/arch/arm/mach-mxs/devices/platform-mxs-pwm.c b/arch/arm/mach-mxs/devices/platform-mxs-pwm.c
new file mode 100644
index 0000000..680f5a9
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-mxs-pwm.c
@@ -0,0 +1,22 @@
+/*
+ * Copyright (C) 2010 Pengutronix
+ * Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/devices-common.h>
+
+struct platform_device *__init mxs_add_mxs_pwm(resource_size_t iobase, int id)
+{
+	struct resource res = {
+		.flags = IORESOURCE_MEM,
+	};
+
+	res.start = iobase + 0x10 + 0x20 * id;
+	res.end = res.start + 0x1f;
+
+	return mxs_add_platform_device("mxs-pwm", id, &res, 1, NULL, 0);
+}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index e7aefb4..d460d30 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -63,3 +63,7 @@ struct mxs_flexcan_data {
 struct platform_device *__init mxs_add_flexcan(
 		const struct mxs_flexcan_data *data,
 		const struct flexcan_platform_data *pdata);
+
+/* pwm */
+struct platform_device *__init mxs_add_mxs_pwm(
+		resource_size_t iobase, int id);
-- 
1.7.2.3
