From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 14 Jan 2010 12:29:34 +0100
Subject: [PATCH 16/21] ARM: S5PC1XX: add i2c platform helpers on s5pc110
	sub-platform
In-Reply-To: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
References: <1263468579-5732-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1263468579-5732-17-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Samsung S5PC110 SoC are newer Samsung SoCs. Like S5PC100 they are based
on CortexA8 ARM CPU, but have much more powerfull integrated periperals.
This patch adds required I2C platform helpers. S5PC110 SoCs has 3 I2C
controllers.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Byungho Min <bhmin@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pc110/Kconfig        |   18 +++++++++
 arch/arm/mach-s5pc110/Makefile       |    3 +
 arch/arm/mach-s5pc110/cpu.c          |    3 +
 arch/arm/mach-s5pc110/setup-i2c0.c   |   31 +++++++++++++++
 arch/arm/mach-s5pc110/setup-i2c1.c   |   31 +++++++++++++++
 arch/arm/mach-s5pc110/setup-i2c2.c   |   32 ++++++++++++++++
 arch/arm/plat-s3c/include/plat/iic.h |    2 +
 arch/arm/plat-samsung/Kconfig        |    5 ++
 arch/arm/plat-samsung/Makefile       |    1 +
 arch/arm/plat-samsung/dev-i2c2.c     |   69 ++++++++++++++++++++++++++++++++++
 10 files changed, 195 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pc110/setup-i2c0.c
 create mode 100644 arch/arm/mach-s5pc110/setup-i2c1.c
 create mode 100644 arch/arm/mach-s5pc110/setup-i2c2.c
 create mode 100644 arch/arm/plat-samsung/dev-i2c2.c

diff --git a/arch/arm/mach-s5pc110/Kconfig b/arch/arm/mach-s5pc110/Kconfig
index 4257b96..6b4d977 100644
--- a/arch/arm/mach-s5pc110/Kconfig
+++ b/arch/arm/mach-s5pc110/Kconfig
@@ -14,4 +14,22 @@ config CPU_S5PC110
 	help
 	  Enable S5PC110 CPU support
 
+config S5PC110_SETUP_I2C0
+	bool
+	default y
+	help
+	  Common setup code for i2c bus 0.
+
+	  Note, currently since i2c0 is always compiled, this setup helper
+	  is always compiled with it.
+
+config S5PC110_SETUP_I2C1
+	bool
+	help
+	  Common setup code for i2c bus 1.
+
+config S5PC110_SETUP_I2C2
+	bool
+	help
+	  Common setup code for i2c bus 2.
 endif
diff --git a/arch/arm/mach-s5pc110/Makefile b/arch/arm/mach-s5pc110/Makefile
index 3849e27..93311b3 100644
--- a/arch/arm/mach-s5pc110/Makefile
+++ b/arch/arm/mach-s5pc110/Makefile
@@ -18,5 +18,8 @@ obj-$(CONFIG_CPU_S5PC110)	+= plls.o
 obj-$(CONFIG_CPU_S5PC110)	+= uarts.o
 
 # Helper and device support
+obj-$(CONFIG_S5PC110_SETUP_I2C0)	+= setup-i2c0.o
+obj-$(CONFIG_S5PC110_SETUP_I2C1)	+= setup-i2c1.o
+obj-$(CONFIG_S5PC110_SETUP_I2C2)	+= setup-i2c2.o
 
 # machine support
diff --git a/arch/arm/mach-s5pc110/cpu.c b/arch/arm/mach-s5pc110/cpu.c
index 3ea26ff..d16ba68 100644
--- a/arch/arm/mach-s5pc110/cpu.c
+++ b/arch/arm/mach-s5pc110/cpu.c
@@ -86,6 +86,9 @@ void __init s5pc110_map_io(void)
 	iotable_init(s5pc110_iodesc, ARRAY_SIZE(s5pc110_iodesc));
 
 	/* initialise device information early */
+	/* the i2c devices are directly compatible with s3c2440 */
+	s3c_i2c0_setname("s3c2440-i2c");
+	s3c_i2c1_setname("s3c2440-i2c");
 }
 
 void __init s5pc110_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pc110/setup-i2c0.c b/arch/arm/mach-s5pc110/setup-i2c0.c
new file mode 100644
index 0000000..596b139
--- /dev/null
+++ b/arch/arm/mach-s5pc110/setup-i2c0.c
@@ -0,0 +1,31 @@
+/*
+ * linux/arch/arm/mach-s5pc110/setup-i2c2.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * Base S5PC110 I2C bus 0 gpio configuration
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
+void s3c_i2c0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PC110_GPD1(0), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC110_GPD1(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC110_GPD1(1), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC110_GPD1(1), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pc110/setup-i2c1.c b/arch/arm/mach-s5pc110/setup-i2c1.c
new file mode 100644
index 0000000..cd9649b
--- /dev/null
+++ b/arch/arm/mach-s5pc110/setup-i2c1.c
@@ -0,0 +1,31 @@
+/*
+ * linux/arch/arm/mach-s5pc110/setup-i2c1.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * Base S5PC110 I2C bus 1 gpio configuration
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
+	s3c_gpio_cfgpin(S5PC110_GPD1(2), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC110_GPD1(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC110_GPD1(3), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC110_GPD1(3), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pc110/setup-i2c2.c b/arch/arm/mach-s5pc110/setup-i2c2.c
new file mode 100644
index 0000000..aa20628
--- /dev/null
+++ b/arch/arm/mach-s5pc110/setup-i2c2.c
@@ -0,0 +1,32 @@
+/*
+ * linux/arch/arm/mach-s5pc110/setup-i2c2.c
+ *
+ * Copyright (C) 2009 Samsung Electronics Co.Ltd
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * Base S5PC110 I2C bus 2 gpio configuration
+ *
+ * Based on plat-s3c64xx/setup-i2c1.c
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
+	s3c_gpio_cfgpin(S5PC110_GPD1(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC110_GPD1(4), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PC110_GPD1(5), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PC110_GPD1(5), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/plat-s3c/include/plat/iic.h b/arch/arm/plat-s3c/include/plat/iic.h
index 3083df0..133308b 100644
--- a/arch/arm/plat-s3c/include/plat/iic.h
+++ b/arch/arm/plat-s3c/include/plat/iic.h
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
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index faec4b8..b64e1f9 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -96,6 +96,11 @@ config S3C_DEV_I2C1
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
index aeb7e12..3a5d59c 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_S3C_DEV_HSMMC1)	+= dev-hsmmc1.o
 obj-$(CONFIG_S3C_DEV_HSMMC2)	+= dev-hsmmc2.o
 obj-y				+= dev-i2c0.o
 obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
+obj-$(CONFIG_S3C_DEV_I2C2)	+= dev-i2c2.o
 obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
 obj-$(CONFIG_S3C_DEV_USB_HSOTG)	+= dev-usb-hsotg.o
diff --git a/arch/arm/plat-samsung/dev-i2c2.c b/arch/arm/plat-samsung/dev-i2c2.c
new file mode 100644
index 0000000..49ec279
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-i2c2.c
@@ -0,0 +1,69 @@
+/*
+ * linux/arch/arm/plat-s3c/dev-i2c2.c
+ *
+ * Copyright (C) 2009 Samsung Electronics Co.Ltd
+ *	Byungho Min <bhmin@samsung.com>
+ *
+ * S3C series device definition for i2c device 2
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ */
+
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/platform_device.h>
+
+#include <mach/cpu.h>
+#include <mach/irqs.h>
+#include <mach/map.h>
+
+#include <plat/regs-iic.h>
+#include <plat/iic.h>
+#include <plat/devs.h>
+
+static struct resource s3c_i2c_resource[] = {
+	[0] = {
+		.start = S3C_PA_IIC2,
+		.end   = S3C_PA_IIC2 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_I2C_PMIC_LINK,
+		.end   = IRQ_I2C_PMIC_LINK,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c2 = {
+	.name		  = "s3c2440-i2c",
+	.id		  = 2,
+	.num_resources	  = ARRAY_SIZE(s3c_i2c_resource),
+	.resource	  = s3c_i2c_resource,
+};
+
+static struct s3c2410_platform_i2c default_i2c_data2 __initdata = {
+	.flags		= 0,
+	.bus_num	= 2,
+	.slave_addr	= 0x10,
+	.frequency	= 400*1000,
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
-- 
1.6.4
