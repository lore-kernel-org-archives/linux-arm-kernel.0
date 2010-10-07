From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 07 Oct 2010 14:46:41 +0200
Subject: [PATCH 3/3] ARM: S5PC210: add I2C{3, 4, 5, 6, 7} device support
In-Reply-To: <1286455601-25360-1-git-send-email-m.szyprowski@samsung.com>
References: <1286455601-25360-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1286455601-25360-4-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

S5PC210 support more I2C devices than previous SoCs.
Add the device support code for them.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig            |   25 +++++++++++
 arch/arm/mach-s5pv310/Makefile           |    5 ++
 arch/arm/mach-s5pv310/setup-i2c3.c       |   25 +++++++++++
 arch/arm/mach-s5pv310/setup-i2c4.c       |   25 +++++++++++
 arch/arm/mach-s5pv310/setup-i2c5.c       |   25 +++++++++++
 arch/arm/mach-s5pv310/setup-i2c6.c       |   25 +++++++++++
 arch/arm/mach-s5pv310/setup-i2c7.c       |   25 +++++++++++
 arch/arm/plat-samsung/Kconfig            |   25 +++++++++++
 arch/arm/plat-samsung/Makefile           |    5 ++
 arch/arm/plat-samsung/dev-i2c3.c         |   68 ++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/dev-i2c4.c         |   68 ++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/dev-i2c5.c         |   68 ++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/dev-i2c6.c         |   68 ++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/dev-i2c7.c         |   68 ++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/iic.h |    5 ++
 15 files changed, 530 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c3.c
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c4.c
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c5.c
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c6.c
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c7.c
 create mode 100644 arch/arm/plat-samsung/dev-i2c3.c
 create mode 100644 arch/arm/plat-samsung/dev-i2c4.c
 create mode 100644 arch/arm/plat-samsung/dev-i2c5.c
 create mode 100644 arch/arm/plat-samsung/dev-i2c6.c
 create mode 100644 arch/arm/plat-samsung/dev-i2c7.c

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 9941852..2457c17 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -24,6 +24,31 @@ config S5PV310_SETUP_I2C2
 	help
 	  Common setup code for i2c bus 2.
 
+config S5PV310_SETUP_I2C3
+	bool
+	help
+	  Common setup code for i2c bus 3.
+
+config S5PV310_SETUP_I2C4
+	bool
+	help
+	  Common setup code for i2c bus 4.
+
+config S5PV310_SETUP_I2C5
+	bool
+	help
+	  Common setup code for i2c bus 5.
+
+config S5PV310_SETUP_I2C6
+	bool
+	help
+	  Common setup code for i2c bus 6.
+
+config S5PV310_SETUP_I2C7
+	bool
+	help
+	  Common setup code for i2c bus 7.
+
 # machine support
 
 menu "S5PC210 Machines"
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index d17c8c7..d18febf 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -30,3 +30,8 @@ obj-$(CONFIG_MACH_UNIVERSAL_C210)	+= mach-universal_c210.o
 
 obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
 obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
+obj-$(CONFIG_S5PV310_SETUP_I2C3)	+= setup-i2c3.o
+obj-$(CONFIG_S5PV310_SETUP_I2C4)	+= setup-i2c4.o
+obj-$(CONFIG_S5PV310_SETUP_I2C5)	+= setup-i2c5.o
+obj-$(CONFIG_S5PV310_SETUP_I2C6)	+= setup-i2c6.o
+obj-$(CONFIG_S5PV310_SETUP_I2C7)	+= setup-i2c7.o
diff --git a/arch/arm/mach-s5pv310/setup-i2c3.c b/arch/arm/mach-s5pv310/setup-i2c3.c
new file mode 100644
index 0000000..e13b351
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-i2c3.c
@@ -0,0 +1,25 @@
+/*
+ * linux/arch/arm/mach-s5pv310/setup-i2c3.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *
+ * I2C3 GPIO configuration.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+struct platform_device; /* don't need the contents */
+
+#include <linux/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c3_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV310_GPA1(2), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PV310_GPA1(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV310_GPA1(3), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PV310_GPA1(3), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pv310/setup-i2c4.c b/arch/arm/mach-s5pv310/setup-i2c4.c
new file mode 100644
index 0000000..ca7fd98
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-i2c4.c
@@ -0,0 +1,25 @@
+/*
+ * linux/arch/arm/mach-s5pv310/setup-i2c4.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *
+ * I2C4 GPIO configuration.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+struct platform_device; /* don't need the contents */
+
+#include <linux/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c4_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV310_GPB(0), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PV310_GPB(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV310_GPB(1), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PV310_GPB(1), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pv310/setup-i2c5.c b/arch/arm/mach-s5pv310/setup-i2c5.c
new file mode 100644
index 0000000..f1974b8
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-i2c5.c
@@ -0,0 +1,25 @@
+/*
+ * linux/arch/arm/mach-s5pv310/setup-i2c5.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *
+ * I2C5 GPIO configuration.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+struct platform_device; /* don't need the contents */
+
+#include <linux/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c5_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV310_GPB(6), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PV310_GPB(6), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV310_GPB(7), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PV310_GPB(7), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pv310/setup-i2c6.c b/arch/arm/mach-s5pv310/setup-i2c6.c
new file mode 100644
index 0000000..d0d1338
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-i2c6.c
@@ -0,0 +1,25 @@
+/*
+ * linux/arch/arm/mach-s5pv310/setup-i2c6.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *
+ * I2C6 GPIO configuration.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+struct platform_device; /* don't need the contents */
+
+#include <linux/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c6_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV310_GPC1(3), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV310_GPC1(3), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV310_GPC1(4), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV310_GPC1(4), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pv310/setup-i2c7.c b/arch/arm/mach-s5pv310/setup-i2c7.c
new file mode 100644
index 0000000..b77236b
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-i2c7.c
@@ -0,0 +1,25 @@
+/*
+ * linux/arch/arm/mach-s5pv310/setup-i2c7.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *
+ * I2C7 GPIO configuration.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+struct platform_device; /* don't need the contents */
+
+#include <linux/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c7_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5PV310_GPD0(2), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PV310_GPD0(2), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV310_GPD0(3), S3C_GPIO_SFN(3));
+	s3c_gpio_setpull(S5PV310_GPD0(3), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 7c0bde7..dcd6eff 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -180,6 +180,31 @@ config S3C_DEV_I2C2
 	help
 	  Compile in platform device definitions for I2C channel 2
 
+config S3C_DEV_I2C3
+	bool
+	help
+	  Compile in platform device definition for I2C controller 3
+
+config S3C_DEV_I2C4
+	bool
+	help
+	  Compile in platform device definition for I2C controller 4
+
+config S3C_DEV_I2C5
+	bool
+	help
+	  Compile in platform device definition for I2C controller 5
+
+config S3C_DEV_I2C6
+	bool
+	help
+	  Compile in platform device definition for I2C controller 6
+
+config S3C_DEV_I2C7
+	bool
+	help
+	  Compile in platform device definition for I2C controller 7
+
 config S3C_DEV_FB
 	bool
 	help
diff --git a/arch/arm/plat-samsung/Makefile b/arch/arm/plat-samsung/Makefile
index 4d8ff92..afcce47 100644
--- a/arch/arm/plat-samsung/Makefile
+++ b/arch/arm/plat-samsung/Makefile
@@ -40,6 +40,11 @@ obj-$(CONFIG_S3C_DEV_HWMON)	+= dev-hwmon.o
 obj-y				+= dev-i2c0.o
 obj-$(CONFIG_S3C_DEV_I2C1)	+= dev-i2c1.o
 obj-$(CONFIG_S3C_DEV_I2C2)	+= dev-i2c2.o
+obj-$(CONFIG_S3C_DEV_I2C3)	+= dev-i2c3.o
+obj-$(CONFIG_S3C_DEV_I2C4)	+= dev-i2c4.o
+obj-$(CONFIG_S3C_DEV_I2C5)	+= dev-i2c5.o
+obj-$(CONFIG_S3C_DEV_I2C6)	+= dev-i2c6.o
+obj-$(CONFIG_S3C_DEV_I2C7)	+= dev-i2c7.o
 obj-$(CONFIG_S3C_DEV_FB)	+= dev-fb.o
 obj-y				+= dev-uart.o
 obj-$(CONFIG_S3C_DEV_USB_HOST)	+= dev-usb.o
diff --git a/arch/arm/plat-samsung/dev-i2c3.c b/arch/arm/plat-samsung/dev-i2c3.c
new file mode 100644
index 0000000..8144c6c
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-i2c3.c
@@ -0,0 +1,68 @@
+/* linux/arch/arm/plat-samsung/dev-i2c3.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P series device definition for i2c device 3
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
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
+		.start = S3C_PA_IIC3,
+		.end   = S3C_PA_IIC3 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IIC3,
+		.end   = IRQ_IIC3,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c3 = {
+	.name		= "s3c2440-i2c",
+	.id		= 3,
+	.num_resources	= ARRAY_SIZE(s3c_i2c_resource),
+	.resource	= s3c_i2c_resource,
+};
+
+static struct s3c2410_platform_i2c default_i2c_data3 __initdata = {
+	.flags		= 0,
+	.bus_num	= 3,
+	.slave_addr	= 0x10,
+	.frequency	= 100*1000,
+	.sda_delay	= 100,
+};
+
+void __init s3c_i2c3_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd)
+		pd = &default_i2c_data3;
+
+	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	else if (!npd->cfg_gpio)
+		npd->cfg_gpio = s5p_i2c3_cfg_gpio;
+
+	s3c_device_i2c3.dev.platform_data = npd;
+}
diff --git a/arch/arm/plat-samsung/dev-i2c4.c b/arch/arm/plat-samsung/dev-i2c4.c
new file mode 100644
index 0000000..8c796f9
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-i2c4.c
@@ -0,0 +1,68 @@
+/* linux/arch/arm/plat-samsung/dev-i2c4.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P series device definition for i2c device 3
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
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
+		.start = S3C_PA_IIC4,
+		.end   = S3C_PA_IIC4 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IIC4,
+		.end   = IRQ_IIC4,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c4 = {
+	.name		= "s3c2440-i2c",
+	.id		= 4,
+	.num_resources	= ARRAY_SIZE(s3c_i2c_resource),
+	.resource	= s3c_i2c_resource,
+};
+
+static struct s3c2410_platform_i2c default_i2c_data4 __initdata = {
+	.flags		= 0,
+	.bus_num	= 4,
+	.slave_addr	= 0x10,
+	.frequency	= 100*1000,
+	.sda_delay	= 100,
+};
+
+void __init s3c_i2c4_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd)
+		pd = &default_i2c_data4;
+
+	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	else if (!npd->cfg_gpio)
+		npd->cfg_gpio = s5p_i2c4_cfg_gpio;
+
+	s3c_device_i2c4.dev.platform_data = npd;
+}
diff --git a/arch/arm/plat-samsung/dev-i2c5.c b/arch/arm/plat-samsung/dev-i2c5.c
new file mode 100644
index 0000000..7d27ab4
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-i2c5.c
@@ -0,0 +1,68 @@
+/* linux/arch/arm/plat-samsung/dev-i2c3.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P series device definition for i2c device 3
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
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
+		.start = S3C_PA_IIC5,
+		.end   = S3C_PA_IIC5 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IIC5,
+		.end   = IRQ_IIC5,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c5 = {
+	.name		= "s3c2440-i2c",
+	.id		= 5,
+	.num_resources	= ARRAY_SIZE(s3c_i2c_resource),
+	.resource	= s3c_i2c_resource,
+};
+
+static struct s3c2410_platform_i2c default_i2c_data5 __initdata = {
+	.flags		= 0,
+	.bus_num	= 5,
+	.slave_addr	= 0x10,
+	.frequency	= 100*1000,
+	.sda_delay	= 100,
+};
+
+void __init s3c_i2c5_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd)
+		pd = &default_i2c_data5;
+
+	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	else if (!npd->cfg_gpio)
+		npd->cfg_gpio = s5p_i2c5_cfg_gpio;
+
+	s3c_device_i2c5.dev.platform_data = npd;
+}
diff --git a/arch/arm/plat-samsung/dev-i2c6.c b/arch/arm/plat-samsung/dev-i2c6.c
new file mode 100644
index 0000000..230713e
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-i2c6.c
@@ -0,0 +1,68 @@
+/* linux/arch/arm/plat-samsung/dev-i2c6.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P series device definition for i2c device 6
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
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
+		.start = S3C_PA_IIC6,
+		.end   = S3C_PA_IIC6 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IIC6,
+		.end   = IRQ_IIC6,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c6 = {
+	.name		= "s3c2440-i2c",
+	.id		= 6,
+	.num_resources	= ARRAY_SIZE(s3c_i2c_resource),
+	.resource	= s3c_i2c_resource,
+};
+
+static struct s3c2410_platform_i2c default_i2c_data6 __initdata = {
+	.flags		= 0,
+	.bus_num	= 6,
+	.slave_addr	= 0x10,
+	.frequency	= 100*1000,
+	.sda_delay	= 100,
+};
+
+void __init s3c_i2c6_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd)
+		pd = &default_i2c_data6;
+
+	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	else if (!npd->cfg_gpio)
+		npd->cfg_gpio = s5p_i2c6_cfg_gpio;
+
+	s3c_device_i2c6.dev.platform_data = npd;
+}
diff --git a/arch/arm/plat-samsung/dev-i2c7.c b/arch/arm/plat-samsung/dev-i2c7.c
new file mode 100644
index 0000000..4c85def
--- /dev/null
+++ b/arch/arm/plat-samsung/dev-i2c7.c
@@ -0,0 +1,68 @@
+/* linux/arch/arm/plat-samsung/dev-i2c7.c
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * S5P series device definition for i2c device 7
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
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
+		.start = S3C_PA_IIC7,
+		.end   = S3C_PA_IIC7 + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
+	[1] = {
+		.start = IRQ_IIC7,
+		.end   = IRQ_IIC7,
+		.flags = IORESOURCE_IRQ,
+	},
+};
+
+struct platform_device s3c_device_i2c7 = {
+	.name		= "s3c2440-i2c",
+	.id		= 7,
+	.num_resources	= ARRAY_SIZE(s3c_i2c_resource),
+	.resource	= s3c_i2c_resource,
+};
+
+static struct s3c2410_platform_i2c default_i2c_data7 __initdata = {
+	.flags		= 0,
+	.bus_num	= 7,
+	.slave_addr	= 0x10,
+	.frequency	= 100*1000,
+	.sda_delay	= 100,
+};
+
+void __init s3c_i2c7_set_platdata(struct s3c2410_platform_i2c *pd)
+{
+	struct s3c2410_platform_i2c *npd;
+
+	if (!pd)
+		pd = &default_i2c_data7;
+
+	npd = kmemdup(pd, sizeof(struct s3c2410_platform_i2c), GFP_KERNEL);
+	if (!npd)
+		printk(KERN_ERR "%s: no memory for platform data\n", __func__);
+	else if (!npd->cfg_gpio)
+		npd->cfg_gpio = s5p_i2c7_cfg_gpio;
+
+	s3c_device_i2c7.dev.platform_data = npd;
+}
diff --git a/arch/arm/plat-samsung/include/plat/iic.h b/arch/arm/plat-samsung/include/plat/iic.h
index 133308b..96fd0cb 100644
--- a/arch/arm/plat-samsung/include/plat/iic.h
+++ b/arch/arm/plat-samsung/include/plat/iic.h
@@ -60,5 +60,10 @@ extern void s3c_i2c2_set_platdata(struct s3c2410_platform_i2c *i2c);
 extern void s3c_i2c0_cfg_gpio(struct platform_device *dev);
 extern void s3c_i2c1_cfg_gpio(struct platform_device *dev);
 extern void s3c_i2c2_cfg_gpio(struct platform_device *dev);
+extern void s3c_i2c3_cfg_gpio(struct platform_device *dev);
+extern void s3c_i2c4_cfg_gpio(struct platform_device *dev);
+extern void s3c_i2c5_cfg_gpio(struct platform_device *dev);
+extern void s3c_i2c6_cfg_gpio(struct platform_device *dev);
+extern void s3c_i2c7_cfg_gpio(struct platform_device *dev);
 
 #endif /* __ASM_ARCH_IIC_H */
-- 
1.7.1.569.g6f426
