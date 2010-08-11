From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Aug 2010 14:03:57 +0200
Subject: [PATCH 8/9] ARM: S5PV210: convert i2c to device-table
In-Reply-To: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
References: <1281528238-7298-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1281528238-7298-9-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert s3c-i2c platform device initialization to device-table approach.
The conversion is performed only for S5PV210 SoC.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/Kconfig                 |   12 +++-
 arch/arm/mach-s5pv210/Makefile                |    4 +-
 arch/arm/mach-s5pv210/cpu.c                   |    6 --
 arch/arm/mach-s5pv210/dev-table.c             |   18 ++++++
 arch/arm/mach-s5pv210/setup-i2c.c             |   81 +++++++++++++++++++++++++
 arch/arm/mach-s5pv210/setup-i2c0.c            |   30 ---------
 arch/arm/mach-s5pv210/setup-i2c1.c            |   30 ---------
 arch/arm/mach-s5pv210/setup-i2c2.c            |   30 ---------
 arch/arm/plat-samsung/Kconfig                 |    9 +--
 arch/arm/plat-samsung/Makefile                |    4 +-
 arch/arm/plat-samsung/dev-i2c.c               |   43 +++++++++++++
 arch/arm/plat-samsung/dev-i2c0.c              |   72 ----------------------
 arch/arm/plat-samsung/dev-i2c1.c              |   69 ---------------------
 arch/arm/plat-samsung/dev-i2c2.c              |   70 ---------------------
 arch/arm/plat-samsung/dev_templates.c         |    2 +
 arch/arm/plat-samsung/include/plat/iic-core.h |   42 -------------
 arch/arm/plat-samsung/include/plat/iic.h      |   50 +++++++++++----
 17 files changed, 194 insertions(+), 378 deletions(-)
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c.c
 delete mode 100644 arch/arm/mach-s5pv210/setup-i2c0.c
 delete mode 100644 arch/arm/mach-s5pv210/setup-i2c1.c
 delete mode 100644 arch/arm/mach-s5pv210/setup-i2c2.c
 create mode 100644 arch/arm/plat-samsung/dev-i2c.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c0.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c1.c
 delete mode 100644 arch/arm/plat-samsung/dev-i2c2.c
 delete mode 100644 arch/arm/plat-samsung/include/plat/iic-core.h

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 734c0b7..4034ea8 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -17,15 +17,23 @@ config CPU_S5PV210
 	help
 	  Enable S5PV210 CPU support
 
+config S5PV210_SETUP_I2C0
+	select S3C_DEV_I2C
+	bool
+	help
+	  Common setup code for i2c0 bus.
+
 config S5PV210_SETUP_I2C1
+	select S3C_DEV_I2C
 	bool
 	help
-	  Common setup code for i2c bus 1.
+	  Common setup code for i2c1 bus.
 
 config S5PV210_SETUP_I2C2
+	select S3C_DEV_I2C
 	bool
 	help
-	  Common setup code for i2c bus 2.
+	  Common setup code for i2c2 bus.
 
 config S5PV210_SETUP_IDE
 	bool
diff --git a/arch/arm/mach-s5pv210/Makefile b/arch/arm/mach-s5pv210/Makefile
index a5fd9ae..8148254 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -13,7 +13,6 @@ obj-				:=
 # Core support for S5PV210 system
 
 obj-$(CONFIG_CPU_S5PV210)	+= cpu.o clock.o dma.o gpiolib.o
-obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
 obj-$(CONFIG_CPU_S5PV210)	+= dev-table.o
 
 # machine support
@@ -29,8 +28,7 @@ obj-y				+= dev-audio.o
 obj-$(CONFIG_S3C64XX_DEV_SPI)	+= dev-spi.o
 
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
-obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
-obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
+obj-$(CONFIG_S3C_DEV_I2C)		+= setup-i2c.o
 obj-$(CONFIG_S5PV210_SETUP_IDE)		+= setup-ide.o
 obj-$(CONFIG_S5PV210_SETUP_KEYPAD)	+= setup-keypad.o
 obj-$(CONFIG_S3C_DEV_HSMMC)		+= setup-sdhci.o
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 5f5ab1e..9806ba0 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -35,7 +35,6 @@
 #include <plat/adc-core.h>
 #include <plat/ata-core.h>
 #include <plat/fimc-core.h>
-#include <plat/iic-core.h>
 #include <plat/keypad-core.h>
 #include <plat/sdhci.h>
 #include <plat/reset.h>
@@ -98,11 +97,6 @@ void __init s5pv210_map_io(void)
 	s3c_fimc_setname(1, "s5pv210-fimc");
 	s3c_fimc_setname(2, "s5pv210-fimc");
 
-	/* the i2c devices are directly compatible with s3c2440 */
-	s3c_i2c0_setname("s3c2440-i2c");
-	s3c_i2c1_setname("s3c2440-i2c");
-	s3c_i2c2_setname("s3c2440-i2c");
-
 	/* Use s5pv210-keypad instead of samsung-keypad */
 	samsung_keypad_setname("s5pv210-keypad");
 }
diff --git a/arch/arm/mach-s5pv210/dev-table.c b/arch/arm/mach-s5pv210/dev-table.c
index b88b43d..559413f 100644
--- a/arch/arm/mach-s5pv210/dev-table.c
+++ b/arch/arm/mach-s5pv210/dev-table.c
@@ -99,6 +99,24 @@ struct s3c_pdev_table s5pv210_dev_table[] __initdata = {
 		.res	= {S5PV210_PA_HSMMC(2), IRQ_HSMMC2},
 		.defpdata = s5pv210_hsmmc2_def_platdata_p,
 	}, {
+		.type	= SAMSUNG_DEVICE_I2C,
+		.name	= "s3c2440-i2c",
+		.index	= 0,
+		.res	= {S5PV210_PA_IIC0, IRQ_IIC},
+		.defpdata = s5pv210_i2c0_def_platdata_p,
+	}, {
+		.type	= SAMSUNG_DEVICE_I2C,
+		.name	= "s3c2440-i2c",
+		.index	= 1,
+		.res	= {S5PV210_PA_IIC1, IRQ_IIC1},
+		.defpdata = s5pv210_i2c0_def_platdata_p,
+	}, {
+		.type	= SAMSUNG_DEVICE_I2C,
+		.name	= "s3c2440-i2c",
+		.index	= 2,
+		.res	= {S5PV210_PA_IIC2, IRQ_CAN0},
+		.defpdata = s5pv210_i2c0_def_platdata_p,
+	}, {
 		.type	= SAMSUNG_DEVICE_FB,
 		.index	= -1,
 		.name	= "s3c-fb",
diff --git a/arch/arm/mach-s5pv210/setup-i2c.c b/arch/arm/mach-s5pv210/setup-i2c.c
new file mode 100644
index 0000000..c9c6f3a
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-i2c.c
@@ -0,0 +1,81 @@
+/* linux/arch/arm/mach-s5pv210/setup-i2c0.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * I2C0 GPIO configuration.
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
+#include <linux/platform_device.h>
+
+#include <mach/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+#ifdef CONFIG_S5PV210_SETUP_I2C0
+
+static void s5pv210_i2c0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPD1(0), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPD1(1), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(1), S3C_GPIO_PULL_UP);
+}
+
+struct s3c2410_platform_i2c s5pv210_i2c0_def_platdata __initdata = {
+	.flags		= 0,
+	.slave_addr	= 0x10,
+	.frequency	= 100*1000,
+	.sda_delay	= 100,
+	.cfg_gpio	= &s5pv210_i2c0_cfg_gpio,
+};
+
+#endif
+
+#ifdef CONFIG_S5PV210_SETUP_I2C1
+
+static void s5pv210_i2c1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPD1(2), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPD1(3), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(3), S3C_GPIO_PULL_UP);
+}
+
+struct s3c2410_platform_i2c s5pv210_i2c1_def_platdata __initdata = {
+	.flags		= 0,
+	.slave_addr	= 0x10,
+	.frequency	= 100*1000,
+	.sda_delay	= 100,
+	.cfg_gpio	= &s5pv210_i2c1_cfg_gpio,
+};
+
+#endif
+
+#ifdef CONFIG_S5PV210_SETUP_I2C2
+
+static void s5pv210_i2c2_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV210_GPD1(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(4), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPD1(5), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(5), S3C_GPIO_PULL_UP);
+}
+
+struct s3c2410_platform_i2c s5pv210_i2c2_def_platdata __initdata = {
+	.flags		= 0,
+	.slave_addr	= 0x10,
+	.frequency	= 100*1000,
+	.sda_delay	= 100,
+	.cfg_gpio	= &s5pv210_i2c2_cfg_gpio,
+};
+
+#endif
diff --git a/arch/arm/mach-s5pv210/setup-i2c0.c b/arch/arm/mach-s5pv210/setup-i2c0.c
deleted file mode 100644
index d38f7cb..0000000
--- a/arch/arm/mach-s5pv210/setup-i2c0.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/setup-i2c0.c
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * I2C0 GPIO configuration.
- *
- * Based on plat-s3c64xx/setup-i2c0.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/gpio.h>
-
-struct platform_device; /* don't need the contents */
-
-#include <plat/iic.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c0_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgpin(S5PV210_GPD1(0), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(0), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PV210_GPD1(1), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(1), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/mach-s5pv210/setup-i2c1.c b/arch/arm/mach-s5pv210/setup-i2c1.c
deleted file mode 100644
index 148bb78..0000000
--- a/arch/arm/mach-s5pv210/setup-i2c1.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/setup-i2c1.c
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * I2C1 GPIO configuration.
- *
- * Based on plat-s3c64xx/setup-i2c1.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/gpio.h>
-
-struct platform_device; /* don't need the contents */
-
-#include <plat/iic.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c1_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgpin(S5PV210_GPD1(2), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(2), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PV210_GPD1(3), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(3), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/mach-s5pv210/setup-i2c2.c b/arch/arm/mach-s5pv210/setup-i2c2.c
deleted file mode 100644
index 2396cb8..0000000
--- a/arch/arm/mach-s5pv210/setup-i2c2.c
+++ /dev/null
@@ -1,30 +0,0 @@
-/* linux/arch/arm/mach-s5pv210/setup-i2c2.c
- *
- * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * I2C2 GPIO configuration.
- *
- * Based on plat-s3c64xx/setup-i2c0.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/gpio.h>
-
-struct platform_device; /* don't need the contents */
-
-#include <plat/iic.h>
-#include <plat/gpio-cfg.h>
-
-void s3c_i2c2_cfg_gpio(struct platform_device *dev)
-{
-	s3c_gpio_cfgpin(S5PV210_GPD1(4), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(4), S3C_GPIO_PULL_UP);
-	s3c_gpio_cfgpin(S5PV210_GPD1(5), S3C_GPIO_SFN(2));
-	s3c_gpio_setpull(S5PV210_GPD1(5), S3C_GPIO_PULL_UP);
-}
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 57c791c..f60603b 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -165,15 +165,10 @@ config S3C_DEV_HWMON
 	help
 	    Compile in platform device definitions for HWMON
 
-config S3C_DEV_I2C1
+config S3C_DEV_I2C
 	bool
 	help
-	  Compile in platform device definitions for I2C channel 1
-
-config S3C_DEV_I2C2
-	bool
-	help
-	  Compile in platform device definitions for I2C channel 2
+	  Compile in platform device definitions for I2C code
 
 config S3C_DEV_FB
 	bool
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index b59a6e4..d880c2d 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -37,10 +37,8 @@ obj-$(CONFIG_S3C24XX_DEV_UART)	+= dev-uart-s3c24xx.o
 obj-$(CONFIG_S3C64XX_DEV_UART)	+= dev-uart-s3c64xx.o
 obj-$(CONFIG_S3C_DEV_HSMMC)	+= dev-hsmmc.o
 obj-$(CONFIG_S3C_DEV_HWMON)	+= dev-hwmon.o
-obj-y				+= dev-i2c0.o
-obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
-obj-$(CONFIG_S3C_DEV_I2C2)	+= dev-i2c2.o
 obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
+obj-$(CONFIG_S3C_DEV_I2C)	+= dev-i2c.o
 obj-y				+= dev-uart.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
diff --git a/arch/arm/plat-samsung/dev-i2c.c b/arch/arm/plat-samsung/dev-i2c.c
new file mode 100644
index 0000000..67e19b5
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-i2c.c
@@ -0,0 +1,43 @@
+/* linux/arch/arm/plat-s3c/dev-i2c0.c
+ *
+ * Copyright 2008-2009 Simtec Electronics
+ *	Ben Dooks <ben@simtec.co.uk>
+ *	http://armlinux.simtec.co.uk/
+ *
+ * S3C series device definition for i2c device 0
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
+#include <plat/iic.h>
+#include <plat/devs.h>
+#include <plat/dev-core.h>
+
+void __init s3c_i2c_set_platdata(void *src, int id)
+{
+	struct s3c2410_platform_i2c *pd = src;
+	struct s3c2410_platform_i2c *set;
+	set = s3c_device_get_defplatdata(SAMSUNG_DEVICE_I2C, id);
+	if (!set) {
+		printk(KERN_ERR "%s: no default platform data\n", __func__);
+		return;
+	}
+	if (!pd->cfg_gpio)
+		pd->cfg_gpio = set->cfg_gpio;
+	memcpy(set, pd, sizeof(struct s3c2410_platform_i2c));
+}
+
+struct s3c_pdev_template s3c_i2c_template __initdata = {
+	.type = SAMSUNG_DEVICE_I2C,
+	.resources = s3c_std_resources_4k,
+	.nr_res = 2,
+	.pdata_size = sizeof(struct s3c2410_platform_i2c),
+	.pdata_set = s3c_i2c_set_platdata,
+};
diff --git a/arch/arm/plat-samsung/dev-i2c0.c b/arch/arm/plat-samsung/dev-i2c0.c
deleted file mode 100644
index 3a601c1..0000000
--- a/arch/arm/plat-samsung/dev-i2c0.c
+++ /dev/null
@@ -1,72 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-i2c0.c
- *
- * Copyright 2008-2009 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series device definition for i2c device 0
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start = S3C_PA_IIC,
-		.end   = S3C_PA_IIC + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_IIC,
-		.end   = IRQ_IIC,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c0 = {
-	.name		  = "s3c2410-i2c",
-#ifdef CONFIG_S3C_DEV_I2C1
-	.id		  = 0,
-#else
-	.id		  = -1,
-#endif
-	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
-	.resource	  = s3c_i2c_resource,
-};
-
-static struct s3c2410_platform_i2c default_i2c_data0 __initdata = {
-	.flags		= 0,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
-void __init s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd)
-		pd = &default_i2c_data0;
-
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c0_cfg_gpio;
-
-	s3c_device_i2c0.dev.platform_data = npd;
-}
diff --git a/arch/arm/plat-samsung/dev-i2c1.c b/arch/arm/plat-samsung/dev-i2c1.c
deleted file mode 100644
index 858ee2a..0000000
--- a/arch/arm/plat-samsung/dev-i2c1.c
+++ /dev/null
@@ -1,69 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-i2c1.c
- *
- * Copyright 2008-2009 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *	http://armlinux.simtec.co.uk/
- *
- * S3C series device definition for i2c device 1
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start = S3C_PA_IIC1,
-		.end   = S3C_PA_IIC1 + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_IIC1,
-		.end   = IRQ_IIC1,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c1 = {
-	.name		  = "s3c2410-i2c",
-	.id		  = 1,
-	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
-	.resource	  = s3c_i2c_resource,
-};
-
-static struct s3c2410_platform_i2c default_i2c_data1 __initdata = {
-	.flags		= 0,
-	.bus_num	= 1,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
-void __init s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd)
-		pd = &default_i2c_data1;
-
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c1_cfg_gpio;
-
-	s3c_device_i2c1.dev.platform_data = npd;
-}
diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-samsung/dev-i2c2.c
deleted file mode 100644
index 07036de..0000000
--- a/arch/arm/plat-samsung/dev-i2c2.c
+++ /dev/null
@@ -1,70 +0,0 @@
-/* linux/arch/arm/plat-s3c/dev-i2c2.c
- *
- * Copyright (c) 2010 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
- *
- * S3C series device definition for i2c device 2
- *
- * Based on plat-samsung/dev-i2c0.c
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#include <linux/gfp.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/platform_device.h>
-
-#include <mach/irqs.h>
-#include <mach/map.h>
-
-#include <plat/regs-iic.h>
-#include <plat/iic.h>
-#include <plat/devs.h>
-#include <plat/cpu.h>
-
-static struct resource s3c_i2c_resource[] = {
-	[0] = {
-		.start = S3C_PA_IIC2,
-		.end   = S3C_PA_IIC2 + SZ_4K - 1,
-		.flags = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start = IRQ_CAN0,
-		.end   = IRQ_CAN0,
-		.flags = IORESOURCE_IRQ,
-	},
-};
-
-struct platform_device s3c_device_i2c2 = {
-	.name		  = "s3c2410-i2c",
-	.id		  = 2,
-	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
-	.resource	  = s3c_i2c_resource,
-};
-
-static struct s3c2410_platform_i2c default_i2c_data2 __initdata = {
-	.flags		= 0,
-	.bus_num	= 2,
-	.slave_addr	= 0x10,
-	.frequency	= 100*1000,
-	.sda_delay	= 100,
-};
-
-void __init s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *pd)
-{
-	struct s3c2410_platform_i2c *npd;
-
-	if (!pd)
-		pd = &default_i2c_data2;
-
-	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
-	if (!npd)
-		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
-	else if (!npd->cfg_gpio)
-		npd->cfg_gpio = s3c_i2c2_cfg_gpio;
-
-	s3c_device_i2c2.dev.platform_data = npd;
-}
diff --git a/arch/arm/plat-samsung/dev_templates.c b/arch/arm/plat-samsung/dev_templates.c
index be06c19..6a1d2e1 100644
--- a/arch/arm/plat-samsung/dev_templates.c
+++ b/arch/arm/plat-samsung/dev_templates.c
@@ -23,6 +23,7 @@
 
 #include <plat/uart.h>
 #include <plat/fb.h>
+#include <plat/iic.h>
 #include <plat/sdhci.h>
 
 #define TEMPLATE_ENTRY(_type, _res) \
@@ -45,6 +46,7 @@ struct resource s3c_std_resources_4k[] __initdata = {
 static struct s3c_pdev_template *templates[] __initdata = {
 	s3c24xx_uart_template_p,
 	s3c64xx_uart_template_p,
+	s3c_i2c_template_p,
 	s3c_hsmmc_template_p,
 	s3c_fb_template_p,
 };
diff --git a/arch/arm/plat-samsung/include/plat/iic-core.h b/arch/arm/plat-samsung/include/plat/iic-core.h
deleted file mode 100644
index f182669..0000000
--- a/arch/arm/plat-samsung/include/plat/iic-core.h
+++ /dev/null
@@ -1,42 +0,0 @@
-/* arch/arm/mach-s3c2410/include/mach/iic-core.h
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * S3C - I2C Controller core functions
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_IIC_CORE_H
-#define __ASM_ARCH_IIC_CORE_H __FILE__
-
-/* These functions are only for use with the core support code, such as
- * the cpu specific initialisation code
- */
-
-/* re-define device name depending on support. */
-static inline void s3c_i2c0_setname(char *name)
-{
-	/* currently this device is always compiled in */
-	s3c_device_i2c0.name = name;
-}
-
-static inline void s3c_i2c1_setname(char *name)
-{
-#ifdef CONFIG_S3C_DEV_I2C1
-	s3c_device_i2c1.name = name;
-#endif
-}
-
-static inline void s3c_i2c2_setname(char *name)
-{
-#ifdef CONFIG_S3C_DEV_I2C2
-	s3c_device_i2c2.name = name;
-#endif
-}
-
-#endif /* __ASM_ARCH_IIC_H */
diff --git a/arch/arm/plat-samsung/include/plat/iic.h b/arch/arm/plat-samsung/include/plat/iic.h
index 133308b..5f77d94b 100644
--- a/arch/arm/plat-samsung/include/plat/iic.h
+++ b/arch/arm/plat-samsung/include/plat/iic.h
@@ -38,8 +38,8 @@ struct s3c2410_platform_i2c {
 };
 
 /**
- * s3c_i2c0_set_platdata - set platform data for i2c0 device
- * @i2c: The platform data to set, or NULL for default data.
+ * s3c_i2c_set_platdata - set platform data for i2c0 device
+ * @i2c: The platform data to set.
  *
  * Register the given platform data for use with the i2c0 device. This
  * call copies the platform data, so the caller can use __initdata for
@@ -47,18 +47,40 @@ struct s3c2410_platform_i2c {
  *
  * This call will set cfg_gpio if is null to the default platform
  * implementation.
- *
- * Any user of s3c_device_i2c0 should call this, even if it is with
- * NULL to ensure that the device is given the default platform data
- * as the driver will no longer carry defaults.
  */
-extern void s3c_i2c0_set_platdata(struct s3c2410_platform_i2c *i2c);
-extern void s3c_i2c1_set_platdata(struct s3c2410_platform_i2c *i2c);
-extern void s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *i2c);
-
-/* defined by architecture to configure gpio */
-extern void s3c_i2c0_cfg_gpio(struct platform_device *dev);
-extern void s3c_i2c1_cfg_gpio(struct platform_device *dev);
-extern void s3c_i2c2_cfg_gpio(struct platform_device *dev);
+extern void s3c_i2c_set_platdata(void *i2c, int id);
+
+#ifdef CONFIG_S3C_DEV_I2C
+extern struct s3c_pdev_template s3c_i2c_template;
+#define s3c_i2c_template_p (&s3c_i2c_template)
+#else
+#define s3c_i2c_template_p NULL
+#endif
+
+/* Default platform data, exported so that per-cpu initialisation can
+ * set the correct one when there are more than one cpu type selected.
+*/
+
+#ifdef CONFIG_S5PV210_SETUP_I2C0
+extern struct s3c2410_platform_i2c s5pv210_i2c0_def_platdata;
+#define s5pv210_i2c0_def_platdata_p (&s5pv210_i2c0_def_platdata)
+#else
+#define s5pv210_i2c0_def_platdata_p NULL
+#endif
+
+#ifdef CONFIG_S5PV210_SETUP_I2C1
+extern struct s3c2410_platform_i2c s5pv210_i2c1_def_platdata;
+#define s5pv210_i2c1_def_platdata_p (&s5pv210_i2c1_def_platdata)
+#else
+#define s5pv210_i2c1_def_platdata_p NULL
+#endif
+
+#ifdef CONFIG_S5PV210_SETUP_I2C2
+extern struct s3c2410_platform_i2c s5pv210_i2c2_def_platdata;
+#define s5pv210_i2c2_def_platdata_p (&s5pv210_i2c2_def_platdata)
+#else
+#define s5pv210_i2c2_def_platdata_p NULL
+#endif
+
 
 #endif /* __ASM_ARCH_IIC_H */
-- 
1.7.1.569.g6f426
