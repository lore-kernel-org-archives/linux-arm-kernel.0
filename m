From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 May 2010 08:13:06 +0200
Subject: [PATCH 6/7] ARM: S5PV210: add common I2C device helpers
In-Reply-To: <1274335987-1141-1-git-send-email-m.szyprowski@samsung.com>
References: <1274335987-1141-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1274335987-1141-7-git-send-email-m.szyprowski@samsung.com>
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
 arch/arm/mach-s5pv210/setup-i2c0.c            |    9 +++-
 arch/arm/mach-s5pv210/setup-i2c1.c            |   30 +++++++++++
 arch/arm/mach-s5pv210/setup-i2c2.c            |   30 +++++++++++
 arch/arm/plat-samsung/Kconfig                 |    5 ++
 arch/arm/plat-samsung/Makefile                |    1 +
 arch/arm/plat-samsung/dev-i2c2.c              |   70 +++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/devs.h     |    1 +
 arch/arm/plat-samsung/include/plat/iic-core.h |    7 +++
 arch/arm/plat-samsung/include/plat/iic.h      |    2 +
 13 files changed, 175 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c1.c
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c2.c
 create mode 100644 arch/arm/plat-samsung/dev-i2c2.c

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 073d9c5..7e5c264 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -17,6 +17,16 @@ config CPU_S5PV210
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
index f73975d..722b69f 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -25,3 +25,5 @@ obj-$(CONFIG_MACH_AQUILA)	+= mach-aquila.o
 
 obj-y				+= dev-audio.o
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
+obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
+obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
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
index e6bb12c..0254e08 100644
--- a/arch/arm/mach-s5pv210/include/mach/map.h
+++ b/arch/arm/mach-s5pv210/include/mach/map.h
@@ -26,6 +26,8 @@
 #define S5P_PA_GPIO		S5PV210_PA_GPIO
 
 #define S5PV210_PA_IIC0		(0xE1800000)
+#define S5PV210_PA_IIC1		(0xFAB00000)
+#define S5PV210_PA_IIC2		(0xE1A00000)
 
 #define S5PV210_PA_TIMER	(0xE2500000)
 #define S5P_PA_TIMER		S5PV210_PA_TIMER
@@ -80,6 +82,8 @@
 /* compatibiltiy defines. */
 #define S3C_PA_UART		S5PV210_PA_UART
 #define S3C_PA_IIC		S5PV210_PA_IIC0
+#define S3C_PA_IIC1		S5PV210_PA_IIC1
+#define S3C_PA_IIC2		S5PV210_PA_IIC2
 #define S3C_PA_FB		S5PV210_PA_FB
 
 #endif /* __ASM_ARCH_MAP_H */
diff --git a/arch/arm/mach-s5pv210/setup-i2c0.c b/arch/arm/mach-s5pv210/setup-i2c0.c
index 9ec6845..c718253 100644
--- a/arch/arm/mach-s5pv210/setup-i2c0.c
+++ b/arch/arm/mach-s5pv210/setup-i2c0.c
@@ -1,6 +1,6 @@
 /* linux/arch/arm/mach-s5pv210/setup-i2c0.c
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
  *
  * I2C0 GPIO configuration.
@@ -17,9 +17,14 @@
 
 struct platform_device; /* don't need the contents */
 
+#include <mach/gpio.h>
 #include <plat/iic.h>
+#include <plat/gpio-cfg.h>
 
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-	/* Will be populated later */
+	s3c_gpio_cfgpin(S5PV210_GPD1(0), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPD1(1), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(1), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv210/setup-i2c1.c b/arch/arm/mach-s5pv210/setup-i2c1.c
new file mode 100644
index 0000000..45e0e6e
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-i2c1.c
@@ -0,0 +1,30 @@
+/* linux/arch/arm/mach-s5pv210/setup-i2c1.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * I2C1 GPIO configuration.
+ *
+ * Based on plat-s3c64xx/setup-i2c1.c
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
index 0000000..b11b4bf
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-i2c2.c
@@ -0,0 +1,30 @@
+/* linux/arch/arm/mach-s5pv210/setup-i2c2.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * I2C2 GPIO configuration.
+ *
+ * Based on plat-s3c64xx/setup-i2c0.c
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
+void s3c_i2c2_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPD1(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(4), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPD1(5), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(5), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 229919e..5b328e9 100644
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
index 4828849..606ec84 100644
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
index 0000000..07036de
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-i2c2.c
@@ -0,0 +1,70 @@
+/* linux/arch/arm/plat-s3c/dev-i2c2.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
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
index ef69e56..78d2420 100644
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
