From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 06 Aug 2010 17:21:49 +0900
Subject: [RFC PATCH] ARM: S5PC210: I2C3 support
Message-ID: <20100806082149.GA11605@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5PC210 has total 8 I2C devices. It's not easy to use existing i2c device
framework since it's designed for the 3 I2Cs at previous samsung socs.

To support 3/4/5/6/7 I2Cs. I created the dev-i2c{3..7} at mach-s5pv310 directory since it's only valid in this cpu.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index faa3436..626e079 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -25,6 +25,11 @@ config S5PV310_SETUP_I2C2
 	help
 	  Common setup code for i2c bus 2.
 
+config S5PV310_SETUP_I2C3
+	bool
+	help
+	  Common setup code for i2c bus 3.
+
 # machine support
 
 config MACH_SMDKV310
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index de49e98..485af8f 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -28,3 +28,4 @@ obj-$(CONFIG_MACH_UNIVERSAL)	+= mach-universal.o
 
 obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
+obj-$(CONFIG_S5PV310_SETUP_I2C3)	+= dev-i2c3.o
diff --git a/arch/arm/mach-s5pv310/dev-i2c3.c b/arch/arm/mach-s5pv310/dev-i2c3.c
new file mode 100644
index 0000000..6b03f50
--- /dev/null
+++ b/arch/arm/mach-s5pv310/dev-i2c3.c
@@ -0,0 +1,64 @@
+/*
+ * linux/arch/arm/plat-s5p/dev-i2c3.c
+ *
+ * Copyright (C) 2010 Samsung Electronics
+ *
+ * S5PC210 series device definition for i2c device 3
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+#include <linux/gpio.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/regs-iic.h>
+#include <plat/iic.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+#include <plat/gpio-cfg.h>
+
+static struct resource s5pc210_i2c_resource[] = {
+	[0] = {
+		.start = S5PV310_PA_I2C3,
+		.end   = S5PV310_PA_I2C3 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_I2C3,
+		.end   = IRQ_I2C3,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+static void s5pc210_i2c3_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV310_GPA1(2), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PV310_GPA1(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV310_GPA1(3), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PV310_GPA1(3), S3C_GPIO_PULL_UP);
+}
+
+static struct s3c2410_platform_i2c default_i2c_data3 = {
+	.bus_num		= 3,
+	.slave_addr		= 0x10,
+	.frequency		= 400 * 1000,
+	.sda_delay		= 100,
+	.cfg_gpio		= s5pc210_i2c3_cfg_gpio,
+};
+
+struct platform_device s5p_device_i2c3 = {
+	.name			= "s3c2440-i2c",
+	.id			= 3,
+	.dev			= {
+		.platform_data	= &default_i2c_data3,
+	},
+	.num_resources		= ARRAY_SIZE(s5pc210_i2c_resource),
+	.resource		= s5pc210_i2c_resource,
+};
diff --git a/arch/arm/mach-s5pv310/include/mach/irqs.h b/arch/arm/mach-s5pv310/include/mach/irqs.h
index 56885ca..a718667 100644
--- a/arch/arm/mach-s5pv310/include/mach/irqs.h
+++ b/arch/arm/mach-s5pv310/include/mach/irqs.h
@@ -64,6 +64,13 @@
 #define IRQ_UART3		COMBINER_IRQ(26, 3)
 #define IRQ_UART4		COMBINER_IRQ(26, 4)
 
+#define IRQ_I2C7		COMBINER_IRQ(27, 7)
+#define IRQ_I2C6		COMBINER_IRQ(27, 6)
+#define IRQ_I2C5		COMBINER_IRQ(27, 5)
+#define IRQ_I2C4		COMBINER_IRQ(27, 4)
+#define IRQ_I2C3		COMBINER_IRQ(27, 3)
+#define IRQ_IIC2		COMBINER_IRQ(27, 2)
+#define IRQ_IIC1		COMBINER_IRQ(27, 1)
 #define IRQ_IIC			COMBINER_IRQ(27, 0)
 
 /* Set the default NR_IRQS */
diff --git a/arch/arm/mach-s5pv310/include/mach/map.h b/arch/arm/mach-s5pv310/include/mach/map.h
index 7eb2a7a..0c34a6e 100644
--- a/arch/arm/mach-s5pv310/include/mach/map.h
+++ b/arch/arm/mach-s5pv310/include/mach/map.h
@@ -55,7 +55,16 @@
 
 #define S5P_SZ_UART			SZ_256
 
-#define S5PV310_PA_IIC0			(0x13860000)
+#define S5PV310_PA_I2C			(0x13860000)
+#define S5P_PA_I2C(x)			(S5PV310_PA_I2C + ((x) * 0x10000))
+#define S5PV310_PA_I2C0			S5P_PA_I2C(0)
+#define S5PV310_PA_I2C1			S5P_PA_I2C(1)
+#define S5PV310_PA_I2C2			S5P_PA_I2C(2)
+#define S5PV310_PA_I2C3			S5P_PA_I2C(3)
+#define S5PV310_PA_I2C4			S5P_PA_I2C(4)
+#define S5PV310_PA_I2C5			S5P_PA_I2C(5)
+#define S5PV310_PA_I2C6			S5P_PA_I2C(6)
+#define S5PV310_PA_I2C7			S5P_PA_I2C(7)
 
 #define S5PV310_PA_TIMER		(0x139D0000)
 #define S5P_PA_TIMER			S5PV310_PA_TIMER
@@ -65,7 +74,7 @@
 
 /* compatibiltiy defines. */
 #define S3C_PA_UART			S5PV310_PA_UART
-#define S3C_PA_IIC			S5PV310_PA_IIC0
+#define S3C_PA_IIC			S5PV310_PA_I2C0
 #define S3C_PA_WDT			S5PV310_PA_WATCHDOG
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 4c31d32..0b49cce 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -46,6 +46,7 @@ extern struct platform_device s3c_device_wdt;
 extern struct platform_device s3c_device_i2c0;
 extern struct platform_device s3c_device_i2c1;
 extern struct platform_device s3c_device_i2c2;
+extern struct platform_device s5p_device_i2c3;
 extern struct platform_device s3c_device_rtc;
 extern struct platform_device s3c_device_adc;
 extern struct platform_device s3c_device_sdi;
