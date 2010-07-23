From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 23 Jul 2010 18:21:18 +0200
Subject: [PATCH v3 3/8] ARM: Samsung: Add platform definitions and helpers for
	FIMC driver
In-Reply-To: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
References: <1279902083-21250-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1279902083-21250-4-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FIMC (CAMIF) device is a camera interface embedded in S3C/S5P Samsung
SOC series. It supports ITU-R BT.601/656 and MIPI-CSI2 standards,
memory to memory operations, color conversion, resizing and rotation.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc100/include/mach/map.h       |    8 ++++
 arch/arm/mach-s5pv210/cpu.c                    |    5 +++
 arch/arm/mach-s5pv210/include/mach/map.h       |    9 +++++
 arch/arm/plat-s5p/Kconfig                      |   16 ++++++++
 arch/arm/plat-s5p/Makefile                     |    3 ++
 arch/arm/plat-s5p/dev-fimc0.c                  |   35 ++++++++++++++++++
 arch/arm/plat-s5p/dev-fimc1.c                  |   35 ++++++++++++++++++
 arch/arm/plat-s5p/dev-fimc2.c                  |   35 ++++++++++++++++++
 arch/arm/plat-samsung/include/plat/fimc-core.h |   45 ++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/fimc.h      |   23 ++++++++++++
 10 files changed, 214 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s5p/dev-fimc0.c
 create mode 100644 arch/arm/plat-s5p/dev-fimc1.c
 create mode 100644 arch/arm/plat-s5p/dev-fimc2.c
 create mode 100644 arch/arm/plat-samsung/include/plat/fimc-core.h
 create mode 100644 arch/arm/plat-samsung/include/plat/fimc.h

diff --git a/arch/arm/mach-s5pc100/include/mach/map.h b/arch/arm/mach-s5pc100/include/mach/map.h
index 809ff90..b8a5ee4 100644
--- a/arch/arm/mach-s5pc100/include/mach/map.h
+++ b/arch/arm/mach-s5pc100/include/mach/map.h
@@ -118,6 +118,11 @@
 #define S5PC100_PA_SDRAM	(0x20000000)
 #define S5P_PA_SDRAM		S5PC100_PA_SDRAM
 
+/* FIMC */
+#define S5PC100_PA_FIMC0	(0xEE200000)
+#define S5PC100_PA_FIMC1	(0xEE300000)
+#define S5PC100_PA_FIMC2	(0xEE400000)
+
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PC100_PA_UART
 #define S3C_PA_IIC		S5PC100_PA_IIC0
@@ -141,6 +146,9 @@
 #define S3C_PA_ONENAND		S5PC100_PA_ONENAND
 #define S3C_PA_ONENAND_BUF	S5PC100_PA_ONENAND_BUF
 #define S3C_SZ_ONENAND_BUF	S5PC100_SZ_ONENAND_BUF
+#define S5P_PA_FIMC0		S5PC100_PA_FIMC0
+#define S5P_PA_FIMC1		S5PC100_PA_FIMC1
+#define S5P_PA_FIMC2		S5PC100_PA_FIMC2
 
 #define SAMSUNG_PA_ADC		S5PC100_PA_TSADC
 #define SAMSUNG_PA_CFCON	S5PC100_PA_CFCON
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 394ca86..1ee444d 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -37,6 +37,7 @@
 #include <plat/iic-core.h>
 #include <plat/keypad-core.h>
 #include <plat/sdhci.h>
+#include <plat/fimc-core.h>
 
 /* Initial IO mappings */
 
@@ -98,6 +99,10 @@ void __init s5pv210_map_io(void)
 
 	/* Use s5pv210-keypad instead of samsung-keypad */
 	samsung_keypad_setname("s5pv210-keypad");
+
+	s3c_fimc_setname(0, "s5pv210-fimc");
+	s3c_fimc_setname(1, "s5pv210-fimc");
+	s3c_fimc_setname(2, "s5pv210-fimc");
 }
 
 void __init s5pv210_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 9f6c2ed..5bcf8c6 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -96,6 +96,11 @@
 
 #define S5PV210_PA_ADC		(0xE1700000)
 
+/* FIMC */
+#define S5PV210_PA_FIMC0	(0xFB200000)
+#define S5PV210_PA_FIMC1	(0xFB300000)
+#define S5PV210_PA_FIMC2	(0xFB400000)
+
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PV210_PA_UART
 #define S3C_PA_HSMMC0		S5PV210_PA_HSMMC(0)
@@ -112,4 +117,8 @@
 #define SAMSUNG_PA_CFCON	S5PV210_PA_CFCON
 #define SAMSUNG_PA_KEYPAD	S5PV210_PA_KEYPAD
 
+#define S5P_PA_FIMC0		S5PV210_PA_FIMC0
+#define S5P_PA_FIMC1		S5PV210_PA_FIMC1
+#define S5P_PA_FIMC2		S5PV210_PA_FIMC2
+
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/plat-s5p/Kconfig b/arch/arm/plat-s5p/Kconfig
index 11d6a1b..38b60c7 100644
--- a/arch/arm/plat-s5p/Kconfig
+++ b/arch/arm/plat-s5p/Kconfig
@@ -5,6 +5,22 @@
 #
 # Licensed under GPLv2
 
+config S5P_DEV_FIMC0
+	bool
+	help
+	  Compile in platform device definitions for FIMC controller 0
+
+config S5P_DEV_FIMC1
+	bool
+	help
+	  Compile in platform device definitions for FIMC controller 1
+
+config S5P_DEV_FIMC2
+	bool
+	help
+	  Compile in platform device definitions for FIMC controller 2
+
+
 config PLAT_S5P
 	bool
 	depends on (ARCH_S5P6440 || ARCH_S5P6442 || ARCH_S5PC100 || ARCH_S5PV210)
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index 7e34194..a2d9905 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -19,3 +19,6 @@ obj-y				+= clock.o
 obj-y				+= irq.o
 obj-$(CONFIG_S5P_EXT_INT)	+= irq-eint.o
 
+obj-$(CONFIG_S5P_DEV_FIMC0)	+= dev-fimc0.o
+obj-$(CONFIG_S5P_DEV_FIMC1)	+= dev-fimc1.o
+obj-$(CONFIG_S5P_DEV_FIMC2)	+= dev-fimc2.o
diff --git a/arch/arm/plat-s5p/dev-fimc0.c b/arch/arm/plat-s5p/dev-fimc0.c
new file mode 100644
index 0000000..8849de4
--- /dev/null
+++ b/arch/arm/plat-s5p/dev-fimc0.c
@@ -0,0 +1,35 @@
+/* linux/arch/arm/plat-s5p/dev-fimc0.c
+ *
+ * Copyright (c) 2010 Samsung Electronics
+ *
+ * Base S5P FIMC0 resource and device definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <mach/map.h>
+
+static struct resource s5p_fimc_resource[] = {
+	[0] = {
+		.start	= S5P_PA_FIMC0,
+		.end	= S5P_PA_FIMC0 + SZ_1M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_FIMC0,
+		.end	= IRQ_FIMC0,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_fimc0 = {
+	.name		= "s5p-fimc",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(s5p_fimc_resource),
+	.resource	= s5p_fimc_resource,
+};
diff --git a/arch/arm/plat-s5p/dev-fimc1.c b/arch/arm/plat-s5p/dev-fimc1.c
new file mode 100644
index 0000000..b1f8970
--- /dev/null
+++ b/arch/arm/plat-s5p/dev-fimc1.c
@@ -0,0 +1,35 @@
+/* linux/arch/arm/plat-s5p/dev-fimc1.c
+ *
+ * Copyright (c) 2010 Samsung Electronics
+ *
+ * Base S5P FIMC1 resource and device definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <mach/map.h>
+
+static struct resource s5p_fimc_resource[] = {
+	[0] = {
+		.start	= S5P_PA_FIMC1,
+		.end	= S5P_PA_FIMC1 + SZ_1M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_FIMC1,
+		.end	= IRQ_FIMC1,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_fimc1 = {
+	.name		= "s5p-fimc",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(s5p_fimc_resource),
+	.resource	= s5p_fimc_resource,
+};
diff --git a/arch/arm/plat-s5p/dev-fimc2.c b/arch/arm/plat-s5p/dev-fimc2.c
new file mode 100644
index 0000000..20df59d
--- /dev/null
+++ b/arch/arm/plat-s5p/dev-fimc2.c
@@ -0,0 +1,35 @@
+/* linux/arch/arm/plat-s5p/dev-fimc2.c
+ *
+ * Copyright (c) 2010 Samsung Electronics
+ *
+ * Base S5P FIMC2 resource and device definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/interrupt.h>
+#include <linux/ioport.h>
+#include <mach/map.h>
+
+static struct resource s5p_fimc_resource[] = {
+	[0] = {
+		.start	= S5P_PA_FIMC2,
+		.end	= S5P_PA_FIMC2 + SZ_1M - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= IRQ_FIMC2,
+		.end	= IRQ_FIMC2,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s5p_device_fimc2 = {
+	.name		= "s5p-fimc",
+	.id		= 2,
+	.num_resources	= ARRAY_SIZE(s5p_fimc_resource),
+	.resource	= s5p_fimc_resource,
+};
diff --git a/arch/arm/plat-samsung/include/plat/fimc-core.h b/arch/arm/plat-samsung/include/plat/fimc-core.h
new file mode 100644
index 0000000..a884ede
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/fimc-core.h
@@ -0,0 +1,45 @@
+/*
+ * arch/arm/plat-samsung/include/plat/fimc-core.h
+ *
+ * Copyright 2010 Samsung Electronics Co., Ltd.
+ *	Sylwester Nawrocki <s.nawrocki@samsung.com>
+ *
+ * Samsung camera interface driver core functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __ASM_PLAT_FIMC_CORE_H
+#define __ASM_PLAT_FIMC_CORE_H __FILE__
+
+/*
+ * These functions are only for use with the core support code, such as
+ * the CPU-specific initialization code.
+ */
+
+#include <plat/fimc.h>
+
+/* Re-define device name to differentiate the subsystem in various SoCs. */
+static inline void s3c_fimc_setname(int id, char *name)
+{
+	switch (id) {
+#ifdef CONFIG_S5P_DEV_FIMC0
+	case 0:
+		s5p_device_fimc0.name = name;
+		break;
+#endif
+#ifdef CONFIG_S5P_DEV_FIMC1
+	case 1:
+		s5p_device_fimc1.name = name;
+		break;
+#endif
+#ifdef CONFIG_S5P_DEV_FIMC2
+	case 2:
+		s5p_device_fimc2.name = name;
+		break;
+#endif
+	}
+}
+
+#endif /* __ASM_PLAT_FIMC_CORE_H */
diff --git a/arch/arm/plat-samsung/include/plat/fimc.h b/arch/arm/plat-samsung/include/plat/fimc.h
new file mode 100644
index 0000000..3eba064
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/fimc.h
@@ -0,0 +1,23 @@
+/* linux/arch/arm/plat-samsung/include/plat/fimc.h
+ *
+ * Platform header file for S3C/S5P FIMC driver
+ *
+ * Copyright (c) 2010 Samsung Electronics
+ *
+ * Sylwester Nawrocki, <s.nawrocki@samsung.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef FIMC_H_
+#define FIMC_H_
+
+#include <linux/platform_device.h>
+
+extern struct platform_device s5p_device_fimc0;
+extern struct platform_device s5p_device_fimc1;
+extern struct platform_device s5p_device_fimc2;
+
+#endif /* FIMC_H_ */
+
-- 
1.7.2
