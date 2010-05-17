From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 17 May 2010 08:53:14 +0200
Subject: [PATCH 6/7] ARM: S5PV210: add common I2C device helpers
In-Reply-To: <1274079195-18105-1-git-send-email-m.szyprowski@samsung.com>
References: <1274079195-18105-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274079195-18105-7-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2C platform helpers required by s3c2440-i2c driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig                 |   10 ++++
 arch/arm/mach-s5pv210/Makefile                |    2 +
 arch/arm/mach-s5pv210/cpu.c                   |    6 ++
 arch/arm/mach-s5pv210/include/mach/map.h      |    4 ++
 arch/arm/mach-s5pv210/setup-i2c1.c            |   30 +++++++++++
 arch/arm/mach-s5pv210/setup-i2c2.c            |   31 +++++++++++
 arch/arm/plat-samsung/Kconfig                 |    5 ++
 arch/arm/plat-samsung/Makefile                |    1 +
 arch/arm/plat-samsung/dev-i2c2.c              |   69 +++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h     |    1 +
 arch/arm/plat-samsung/include/plat/iic-core.h |    7 +++
 arch/arm/plat-samsung/include/plat/iic.h      |    2 +
 12 files changed, 168 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c1.c
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c2.c
 create mode 100644 arch/arm/plat-samsung/dev-i2c2.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index a7adc24..8b5975a 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -15,6 +15,16 @@ config CPU_S5PV210
 	help
 	  Enable S5PV210 CPU support
 
+config S5PV210_SETUP_I2C1
+	bool
+	help
+	  Common setup code for i2c bus 1.
+
+config S5PV210_SETUP_I2C2
+	bool
+	help
+	  Common setup code for i2c bus 2.
+
 config S5PV210_SETUP_FB_24BPP
 	bool
 	help
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index a2707a8..ea7119a 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -18,6 +18,8 @@ obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
 # Helper and device support
 
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
+obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
+obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 2b776eb..2d4a3d2 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -32,6 +32,7 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/s5pv210.h>
+#include <plat/iic-core.h>
 
 /* Initial IO mappings */
 
@@ -75,6 +76,11 @@ static void s5pv210_idle(void)
 void __init s5pv210_map_io(void)
 {
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
+
+	/* the i2c devices are directly compatible with s3c2440 */
+	s3c_i2c0_setname("s3c2440-i2c");
+	s3c_i2c1_setname("s3c2440-i2c");
+	s3c_i2c2_setname("s3c2440-i2c");
 }
 
 void __init s5pv210_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pv210/include/mach/map.h b/arch/arm/mach-s5pv210/include/mach/map.h
index 5903056..36bc608 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -26,6 +26,8 @@
 #define S5P_PA_GPIO		S5PV210_PA_GPIO
 
 #define S5PV210_PA_IIC0		(0xE1800000)
+#define S5PV210_PA_IIC1		(0xFAB00000)
+#define S5PV210_PA_IIC2		(0xE1A00000)
 
 #define S5PV210_PA_TIMER	(0xE2500000)
 #define S5P_PA_TIMER		S5PV210_PA_TIMER
@@ -63,6 +65,8 @@
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PV210_PA_UART
 #define S3C_PA_IIC		S5PV210_PA_IIC0
+#define S3C_PA_IIC1		S5PV210_PA_IIC1
+#define S3C_PA_IIC2		S5PV210_PA_IIC2
 #define S3C_PA_FB		S5PV210_PA_FB
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv210/setup-i2c1.c b/arch/arm/mach-s5pv210/setup-i2c1.c
new file mode 100644
index 0000000..3e9ed3b
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-i2c1.c
@@ -0,0 +1,30 @@
+/*
+ * linux/arch/arm/mach-s5pv210/setup-i2c1.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *
+ * Base S5PV210 I2C bus 1 gpio configuration
+ *
+ * Based on mach-s3c64xx/setup-i2c1.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct platform_device; /* don't need the contents */
+
+#include <mach/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPD1(2), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPD1(3), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(3), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pv210/setup-i2c2.c b/arch/arm/mach-s5pv210/setup-i2c2.c
new file mode 100644
index 0000000..6cdbbdc
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-i2c2.c
@@ -0,0 +1,31 @@
+/*
+ * linux/arch/arm/mach-s5pv210/setup-i2c2.c
+ *
+ * Copyright (C) 2009 Samsung Electronics Co.Ltd
+ *
+ * Base S5PV210 I2C bus 2 gpio configuration
+ *
+ * Based on mach-s3c64xx/setup-i2c1.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+
+struct platform_device; /* don't need the contents */
+
+#include <mach/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c2_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPD1(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(4), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPD1(5), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(5), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 6ccfd60..44f7da1 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -170,6 +170,11 @@ config S3C_DEV_I2C1
 	help
 	  Compile in platform device definitions for I2C channel 1
 
+config S3C_DEV_I2C2
+	bool
+	help
+	  Compile in platform device definitions for I2C channel 2
+
 config S3C_DEV_FB
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 0ad820a..45fad33 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
 obj-$(CONFIG_S3C_DEV_HWMON)	+= dev-hwmon.o
 obj-y				+= dev-i2c0.o
 obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
+obj-$(CONFIG_S3C_DEV_I2C2)	+= dev-i2c2.o
 obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
 obj-y				+= dev-uart.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-samsung/dev-i2c2.c
new file mode 100644
index 0000000..b8de233
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-i2c2.c
@@ -0,0 +1,69 @@
+/* linux/arch/arm/plat-s3c/dev-i2c2.c
+ *
+ * Copyright 2010 Samsung Electronics
+ *
+ * S3C series device definition for i2c device 2
+ *
+ * Based on plat-samsung/dev-i2c0.c
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <linux/gfp.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/regs-iic.h>
+#include <plat/iic.h>
+#include <plat/devs.h>
+#include <plat/cpu.h>
+
+static struct resource s3c_i2c_resource[] = {
+	[0] = {
+		.start = S3C_PA_IIC2,
+		.end   = S3C_PA_IIC2 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_CAN0,
+		.end   = IRQ_CAN0,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c2 = {
+	.name		  = "s3c2410-i2c",
+	.id		  = 2,
+	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
+	.resource	  = s3c_i2c_resource,
+};
+
+static struct s3c2410_platform_i2c default_i2c_data2 __initdata = {
+	.flags		= 0,
+	.bus_num	= 2,
+	.slave_addr	= 0x10,
+	.frequency	= 100*1000,
+	.sda_delay	= 100,
+};
+
+void __init s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd)
+		pd = &default_i2c_data2;
+
+	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	else if (!npd->cfg_gpio)
+		npd->cfg_gpio = s3c_i2c2_cfg_gpio;
+
+	s3c_device_i2c2.dev.platform_data = npd;
+}
diff --git a/arch/arm/plat-samsung/include/plat/devs.h b/arch/arm/plat-samsung/include/plat/devs.h
index 796d242..faa3e8f 100644
--- a/arch/arm/plat-samsung/include/plat/devs.h
+++ b/arch/arm/plat-samsung/include/plat/devs.h
@@ -45,6 +45,7 @@ extern struct platform_device s3c_device_lcd;
 extern struct platform_device s3c_device_wdt;
 extern struct platform_device s3c_device_i2c0;
 extern struct platform_device s3c_device_i2c1;
+extern struct platform_device s3c_device_i2c2;
 extern struct platform_device s3c_device_rtc;
 extern struct platform_device s3c_device_adc;
 extern struct platform_device s3c_device_sdi;
diff --git a/arch/arm/plat-samsung/include/plat/iic-core.h b/arch/arm/plat-samsung/include/plat/iic-core.h
index 36397ca..f182669 100644
--- a/arch/arm/plat-samsung/include/plat/iic-core.h
+++ b/arch/arm/plat-samsung/include/plat/iic-core.h
@@ -32,4 +32,11 @@ static inline void s3c_i2c1_setname(char *name)
 #endif
 }
 
+static inline void s3c_i2c2_setname(char *name)
+{
+#ifdef CONFIG_S3C_DEV_I2C2
+	s3c_device_i2c2.name = name;
+#endif
+}
+
 #endif /* __ASM_ARCH_IIC_H */
diff --git a/arch/arm/plat-samsung/include/plat/iic.h b/arch/arm/plat-samsung/include/plat/iic.h
index 3083df0..133308b 100644
--- a/arch/arm/plat-samsung/include/plat/iic.h
+++ b/arch/arm/plat-samsung/include/plat/iic.h
@@ -54,9 +54,11 @@ struct s3c2410_platform_i2c {
  */
 extern void s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *i2c);
 extern void s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *i2c);
+extern void s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *i2c);
 
 /* defined by architecture to configure gpio */
 extern void s3c_i2c0_cfg_gpio(struct platform_device *dev);
 extern void s3c_i2c1_cfg_gpio(struct platform_device *dev);
+extern void s3c_i2c2_cfg_gpio(struct platform_device *dev);
 
 #endif /* __ASM_ARCH_IIC_H */
-- 
1.6.4
