From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 28 Feb 2011 09:02:32 +0100
Subject: [PATCH 2/2] ARM i.MX23/28: Add framebuffer device support
In-Reply-To: <1298880152-28913-1-git-send-email-s.hauer@pengutronix.de>
References: <1298880152-28913-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1298880152-28913-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/clock-mx23.c             |    1 +
 arch/arm/mach-mxs/clock-mx28.c             |    1 +
 arch/arm/mach-mxs/devices-mx23.h           |    4 ++
 arch/arm/mach-mxs/devices-mx28.h           |    4 ++
 arch/arm/mach-mxs/devices/Kconfig          |    4 ++
 arch/arm/mach-mxs/devices/Makefile         |    1 +
 arch/arm/mach-mxs/devices/platform-mxsfb.c |   46 ++++++++++++++++++++++++++++
 7 files changed, 61 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-mxsfb.c

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index ca72a05..efd84f5 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -447,6 +447,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "usb", usb_clk)
 	_REGISTER_CLOCK(NULL, "audio", audio_clk)
 	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
+	_REGISTER_CLOCK("imx23-fb", NULL, lcdif_clk)
 };
 
 static int clk_misc_init(void)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index fd1c4c5..6a7ebcb 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -620,6 +620,7 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
 	_REGISTER_CLOCK(NULL, "lradc", lradc_clk)
 	_REGISTER_CLOCK(NULL, "spdif", spdif_clk)
+	_REGISTER_CLOCK("imx28-fb", NULL, lcdif_clk)
 };
 
 static int clk_misc_init(void)
diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index 1256788..88c00f2 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -10,7 +10,11 @@
  */
 #include <mach/mx23.h>
 #include <mach/devices-common.h>
+#include <mach/mxsfb.h>
 
 extern const struct amba_device mx23_duart_device __initconst;
 #define mx23_add_duart() \
 	mxs_add_duart(&mx23_duart_device)
+
+struct platform_device *__init mx23_add_mxsfb(
+		const struct mxsfb_platform_data *pdata);
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 33773a6..64740cb 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -10,6 +10,7 @@
  */
 #include <mach/mx28.h>
 #include <mach/devices-common.h>
+#include <mach/mxsfb.h>
 
 extern const struct amba_device mx28_duart_device __initconst;
 #define mx28_add_duart() \
@@ -18,3 +19,6 @@ extern const struct amba_device mx28_duart_device __initconst;
 extern const struct mxs_fec_data mx28_fec_data[] __initconst;
 #define mx28_add_fec(id, pdata) \
 	mxs_add_fec(&mx28_fec_data[id], pdata)
+
+struct platform_device *__init mx28_add_mxsfb(
+		const struct mxsfb_platform_data *pdata);
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index cf7dc1a..1538cb9 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -4,3 +4,7 @@ config MXS_HAVE_AMBA_DUART
 
 config MXS_HAVE_PLATFORM_FEC
 	bool
+
+config MXS_HAVE_PLATFORM_MXSFB
+	bool
+
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index d0a09f6..0cf8b48 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -1,2 +1,3 @@
 obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
+obj-$(CONFIG_MXS_HAVE_PLATFORM_MXSFB) += platform-mxsfb.o
diff --git a/arch/arm/mach-mxs/devices/platform-mxsfb.c b/arch/arm/mach-mxs/devices/platform-mxsfb.c
new file mode 100644
index 0000000..bf72c9b
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-mxsfb.c
@@ -0,0 +1,46 @@
+/*
+ * Copyright (C) 2011 Pengutronix, Sascha Hauer <s.hauer@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <asm/sizes.h>
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+#include <mach/mxsfb.h>
+
+#ifdef CONFIG_SOC_IMX23
+struct platform_device *__init mx23_add_mxsfb(
+		const struct mxsfb_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = MX23_LCDIF_BASE_ADDR,
+			.end = MX23_LCDIF_BASE_ADDR + SZ_8K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+	};
+
+	return mxs_add_platform_device_dmamask("imx23-fb", -1,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
+#endif /* ifdef CONFIG_SOC_IMX23 */
+
+#ifdef CONFIG_SOC_IMX28
+struct platform_device *__init mx28_add_mxsfb(
+		const struct mxsfb_platform_data *pdata)
+{
+	struct resource res[] = {
+		{
+			.start = MX28_LCDIF_BASE_ADDR,
+			.end = MX28_LCDIF_BASE_ADDR + SZ_8K - 1,
+			.flags = IORESOURCE_MEM,
+		},
+	};
+
+	return mxs_add_platform_device_dmamask("imx28-fb", -1,
+			res, ARRAY_SIZE(res), pdata, sizeof(*pdata), DMA_BIT_MASK(32));
+}
+#endif /* ifdef CONFIG_SOC_IMX28 */
-- 
1.7.2.3
