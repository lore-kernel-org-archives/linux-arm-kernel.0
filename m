From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 22 Feb 2011 21:36:27 +0800
Subject: [PATCH v4] ARM: mxs: add dma device
In-Reply-To: <1298284306-14710-3-git-send-email-shawn.guo@freescale.com>
References: <1298284306-14710-3-git-send-email-shawn.guo@freescale.com>
Message-ID: <1298381787-31474-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-mxs/clock-mx23.c           |    3 +-
 arch/arm/mach-mxs/clock-mx28.c           |    4 +-
 arch/arm/mach-mxs/devices/Makefile       |    1 +
 arch/arm/mach-mxs/devices/platform-dma.c |   49 ++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-dma.c

diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index b1a362e..350b28c 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -443,7 +443,8 @@ static struct clk_lookup lookups[] = {
 	/* for amba-pl011 driver */
 	_REGISTER_CLOCK("duart", NULL, uart_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
-	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
+	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
+	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
 	_REGISTER_CLOCK(NULL, "usb", usb_clk)
 	_REGISTER_CLOCK(NULL, "audio", audio_clk)
 	_REGISTER_CLOCK(NULL, "pwm", pwm_clk)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index c9d7951..a3b4787 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -617,8 +617,8 @@ static struct clk_lookup lookups[] = {
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
 	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
-	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
-	_REGISTER_CLOCK(NULL, "xclk", xbus_clk)
+	_REGISTER_CLOCK("mxs-dma-apbh", NULL, hbus_clk)
+	_REGISTER_CLOCK("mxs-dma-apbx", NULL, xbus_clk)
 	_REGISTER_CLOCK("flexcan.0", NULL, can0_clk)
 	_REGISTER_CLOCK("flexcan.1", NULL, can1_clk)
 	_REGISTER_CLOCK(NULL, "usb0", usb0_clk)
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index a8dc8d5..ca7acc4 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_AUART) += platform-auart.o
+obj-y += platform-dma.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FLEXCAN) += platform-flexcan.o
diff --git a/arch/arm/mach-mxs/devices/platform-dma.c b/arch/arm/mach-mxs/devices/platform-dma.c
new file mode 100644
index 0000000..295c442
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/platform-dma.c
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2011 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <linux/compiler.h>
+#include <linux/err.h>
+#include <linux/init.h>
+
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+static struct platform_device *__init mxs_add_dma(const char *devid,
+						resource_size_t base)
+{
+	struct resource res[] = {
+		{
+			.start = base,
+			.end = base + SZ_8K - 1,
+			.flags = IORESOURCE_MEM,
+		}
+	};
+
+	return mxs_add_platform_device_dmamask(devid, -1,
+				res, ARRAY_SIZE(res), NULL, 0,
+				DMA_BIT_MASK(32));
+}
+
+static int __init mxs_add_mxs_dma(void)
+{
+	char *apbh = "mxs-dma-apbh";
+	char *apbx = "mxs-dma-apbx";
+
+	if (cpu_is_mx23()) {
+		mxs_add_dma(apbh, MX23_APBH_DMA_BASE_ADDR);
+		mxs_add_dma(apbx, MX23_APBX_DMA_BASE_ADDR);
+	}
+
+	if (cpu_is_mx28()) {
+		mxs_add_dma(apbh, MX28_APBH_DMA_BASE_ADDR);
+		mxs_add_dma(apbx, MX28_APBX_DMA_BASE_ADDR);
+	}
+
+	return 0;
+}
+arch_initcall(mxs_add_mxs_dma);
-- 
1.7.1
