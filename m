From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 21 Dec 2010 21:12:10 +0800
Subject: [PATCH] ARM: mxs: Change duart device to use amba-pl011
In-Reply-To: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
References: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1292937130-32155-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mxs duart is actually an amba-pl011 device. This commit changes
the duart device code to dynamically allocate amba-pl011 device,
so that drivers/serial/amba-pl011.c can be used on mxs.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
This is a follow-up patch again the patch series below, which is
waiting for the merge.

 [PATCH v8 00/15] ARM: mxs: Add initial support for MX23 and MX28

 arch/arm/mach-mxs/Kconfig                       |    6 ++-
 arch/arm/mach-mxs/clock-mx23.c                  |    2 +-
 arch/arm/mach-mxs/clock-mx28.c                  |    2 +-
 arch/arm/mach-mxs/devices-mx23.h                |    4 +-
 arch/arm/mach-mxs/devices-mx28.h                |    4 +-
 arch/arm/mach-mxs/devices/Kconfig               |    2 +-
 arch/arm/mach-mxs/devices/Makefile              |    2 +-
 arch/arm/mach-mxs/devices/amba-duart.c          |   39 ++++++++++++++++++
 arch/arm/mach-mxs/devices/platform-duart.c      |   48 -----------------------
 arch/arm/mach-mxs/include/mach/devices-common.h |    9 +---
 10 files changed, 53 insertions(+), 65 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/amba-duart.c
 delete mode 100644 arch/arm/mach-mxs/devices/platform-duart.c

diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index c4ac7b4..0d072e9 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -5,17 +5,19 @@ source "arch/arm/mach-mxs/devices/Kconfig"
 config SOC_IMX23
 	bool
 	select CPU_ARM926T
+	select ARM_AMBA
 
 config SOC_IMX28
 	bool
 	select CPU_ARM926T
+	select ARM_AMBA
 
 comment "MXS platforms:"
 
 config MACH_MX23EVK
 	bool "Support MX23EVK Platform"
 	select SOC_IMX23
-	select MXS_HAVE_PLATFORM_DUART
+	select MXS_HAVE_AMBA_DUART
 	default y
 	help
 	  Include support for MX23EVK platform. This includes specific
@@ -24,7 +26,7 @@ config MACH_MX23EVK
 config MACH_MX28EVK
 	bool "Support MX28EVK Platform"
 	select SOC_IMX28
-	select MXS_HAVE_PLATFORM_DUART
+	select MXS_HAVE_AMBA_DUART
 	select MXS_HAVE_PLATFORM_FEC
 	default y
 	help
diff --git a/arch/arm/mach-mxs/clock-mx23.c b/arch/arm/mach-mxs/clock-mx23.c
index 8f5a19a..0f65d15 100644
--- a/arch/arm/mach-mxs/clock-mx23.c
+++ b/arch/arm/mach-mxs/clock-mx23.c
@@ -437,7 +437,7 @@ _DEFINE_CLOCK(clk32k_clk, XTAL, TIMROT_CLK32K_GATE, &ref_xtal_clk);
 	},
 
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK("mxs-duart.0", NULL, uart_clk)
+	_REGISTER_CLOCK("uart", NULL, uart_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
 	_REGISTER_CLOCK(NULL, "hclk", hbus_clk)
 	_REGISTER_CLOCK(NULL, "xclk", xbus_clk)
diff --git a/arch/arm/mach-mxs/clock-mx28.c b/arch/arm/mach-mxs/clock-mx28.c
index 74e2103..dd6d158 100644
--- a/arch/arm/mach-mxs/clock-mx28.c
+++ b/arch/arm/mach-mxs/clock-mx28.c
@@ -602,7 +602,7 @@ _DEFINE_CLOCK(fec_clk, ENET, DISABLE, &hbus_clk);
 	},
 
 static struct clk_lookup lookups[] = {
-	_REGISTER_CLOCK("mxs-duart.0", NULL, uart_clk)
+	_REGISTER_CLOCK("uart", NULL, uart_clk)
 	_REGISTER_CLOCK("fec.0", NULL, fec_clk)
 	_REGISTER_CLOCK("rtc", NULL, rtc_clk)
 	_REGISTER_CLOCK("pll2", NULL, pll2_clk)
diff --git a/arch/arm/mach-mxs/devices-mx23.h b/arch/arm/mach-mxs/devices-mx23.h
index d0f49fc..36397ff 100644
--- a/arch/arm/mach-mxs/devices-mx23.h
+++ b/arch/arm/mach-mxs/devices-mx23.h
@@ -11,6 +11,6 @@
 #include <mach/mx23.h>
 #include <mach/devices-common.h>
 
-extern const struct mxs_duart_data mx23_duart_data __initconst;
+extern struct amba_device mx23_duart_device;
 #define mx23_add_duart() \
-	mxs_add_duart(&mx23_duart_data)
+	mxs_add_duart(&mx23_duart_device)
diff --git a/arch/arm/mach-mxs/devices-mx28.h b/arch/arm/mach-mxs/devices-mx28.h
index 00b736c..e84a7fe 100644
--- a/arch/arm/mach-mxs/devices-mx28.h
+++ b/arch/arm/mach-mxs/devices-mx28.h
@@ -11,9 +11,9 @@
 #include <mach/mx28.h>
 #include <mach/devices-common.h>
 
-extern const struct mxs_duart_data mx28_duart_data __initconst;
+extern struct amba_device mx28_duart_device;
 #define mx28_add_duart() \
-	mxs_add_duart(&mx28_duart_data)
+	mxs_add_duart(&mx28_duart_device)
 
 extern const struct mxs_fec_data mx28_fec_data[] __initconst;
 #define mx28_add_fec(id, pdata) \
diff --git a/arch/arm/mach-mxs/devices/Kconfig b/arch/arm/mach-mxs/devices/Kconfig
index a35a2dc..3dff25c 100644
--- a/arch/arm/mach-mxs/devices/Kconfig
+++ b/arch/arm/mach-mxs/devices/Kconfig
@@ -1,4 +1,4 @@
-config MXS_HAVE_PLATFORM_DUART
+config MXS_HAVE_AMBA_DUART
 	bool
 
 config MXS_HAVE_PLATFORM_FEC
diff --git a/arch/arm/mach-mxs/devices/Makefile b/arch/arm/mach-mxs/devices/Makefile
index 4b5266a..d0a09f6 100644
--- a/arch/arm/mach-mxs/devices/Makefile
+++ b/arch/arm/mach-mxs/devices/Makefile
@@ -1,2 +1,2 @@
-obj-$(CONFIG_MXS_HAVE_PLATFORM_DUART) += platform-duart.o
+obj-$(CONFIG_MXS_HAVE_AMBA_DUART) += amba-duart.o
 obj-$(CONFIG_MXS_HAVE_PLATFORM_FEC) += platform-fec.o
diff --git a/arch/arm/mach-mxs/devices/amba-duart.c b/arch/arm/mach-mxs/devices/amba-duart.c
new file mode 100644
index 0000000..d805e22
--- /dev/null
+++ b/arch/arm/mach-mxs/devices/amba-duart.c
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2009-2010 Pengutronix
+ * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
+ *
+ * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it under
+ * the terms of the GNU General Public License version 2 as published by the
+ * Free Software Foundation.
+ */
+#include <mach/mx23.h>
+#include <mach/mx28.h>
+#include <mach/devices-common.h>
+
+#define MXS_AMBA_DEVICE(name, soc)				\
+struct amba_device name##_device = {				\
+	.dev = {						\
+		.init_name = "uart",				\
+	},							\
+	.res = {						\
+		.start = soc ## _DUART_BASE_ADDR,		\
+		.end = (soc ## _DUART_BASE_ADDR) + SZ_8K - 1,	\
+		.flags = IORESOURCE_MEM,			\
+	},							\
+	.irq = {soc ## _INT_DUART, NO_IRQ},			\
+}
+
+#ifdef CONFIG_SOC_IMX23
+MXS_AMBA_DEVICE(mx23_duart, MX23);
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+MXS_AMBA_DEVICE(mx28_duart, MX28);
+#endif
+
+int __init mxs_add_duart(struct amba_device *dev)
+{
+	return amba_device_register(dev, &iomem_resource);
+}
diff --git a/arch/arm/mach-mxs/devices/platform-duart.c b/arch/arm/mach-mxs/devices/platform-duart.c
deleted file mode 100644
index 2fe0df5..0000000
--- a/arch/arm/mach-mxs/devices/platform-duart.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- * Copyright (C) 2009-2010 Pengutronix
- * Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
- *
- * Copyright 2010 Freescale Semiconductor, Inc. All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify it under
- * the terms of the GNU General Public License version 2 as published by the
- * Free Software Foundation.
- */
-#include <mach/mx23.h>
-#include <mach/mx28.h>
-#include <mach/devices-common.h>
-
-#define mxs_duart_data_entry(soc)					\
-	{								\
-		.iobase = soc ## _DUART_BASE_ADDR,			\
-		.irq = soc ## _INT_DUART,				\
-	}
-
-#ifdef CONFIG_SOC_IMX23
-const struct mxs_duart_data mx23_duart_data __initconst =
-	mxs_duart_data_entry(MX23);
-#endif
-
-#ifdef CONFIG_SOC_IMX28
-const struct mxs_duart_data mx28_duart_data __initconst =
-	mxs_duart_data_entry(MX28);
-#endif
-
-struct platform_device *__init mxs_add_duart(
-		const struct mxs_duart_data *data)
-{
-	struct resource res[] = {
-		{
-			.start = data->iobase,
-			.end = data->iobase + SZ_8K - 1,
-			.flags = IORESOURCE_MEM,
-		}, {
-			.start = data->irq,
-			.end = data->irq,
-			.flags = IORESOURCE_IRQ,
-		},
-	};
-
-	return mxs_add_platform_device("mxs-duart", 0, res, ARRAY_SIZE(res),
-					NULL, 0);
-}
diff --git a/arch/arm/mach-mxs/include/mach/devices-common.h b/arch/arm/mach-mxs/include/mach/devices-common.h
index 3da48d4..fca0551 100644
--- a/arch/arm/mach-mxs/include/mach/devices-common.h
+++ b/arch/arm/mach-mxs/include/mach/devices-common.h
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
 #include <linux/init.h>
+#include <linux/amba/bus.h>
 
 struct platform_device *mxs_add_platform_device_dmamask(
 		const char *name, int id,
@@ -25,13 +26,7 @@ static inline struct platform_device *mxs_add_platform_device(
 }
 
 /* duart */
-struct mxs_duart_data {
-	resource_size_t iobase;
-	resource_size_t iosize;
-	resource_size_t irq;
-};
-struct platform_device *__init mxs_add_duart(
-		const struct mxs_duart_data *data);
+int __init mxs_add_duart(struct amba_device *dev);
 
 /* fec */
 #include <linux/fec.h>
-- 
1.7.1
