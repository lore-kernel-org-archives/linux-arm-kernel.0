From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Fri, 02 Apr 2010 08:22:21 +0200
Subject: [PATCH 1/2] ARM: S5PV210: add common I2C device helpers
In-Reply-To: <1270189342-30798-1-git-send-email-m.szyprowski@samsung.com>
References: <1270189342-30798-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1270189342-30798-2-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds I2C platform helpers required by s3c2440-i2c driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5p6440/Makefile                   |    1 +
 arch/arm/{plat-s5p => mach-s5p6440}/setup-i2c0.c |    2 +-
 arch/arm/mach-s5p6442/Makefile                   |    1 +
 arch/arm/{plat-s5p => mach-s5p6442}/setup-i2c0.c |    2 +-
 arch/arm/mach-s5pv210/Kconfig                    |   10 +++++++
 arch/arm/mach-s5pv210/Makefile                   |    3 ++
 arch/arm/mach-s5pv210/cpu.c                      |    5 +++
 arch/arm/mach-s5pv210/include/mach/map.h         |    4 +++
 arch/arm/mach-s5pv210/setup-i2c0.c               |   30 +++++++++++++++++++++
 arch/arm/mach-s5pv210/setup-i2c1.c               |   30 +++++++++++++++++++++
 arch/arm/mach-s5pv210/setup-i2c2.c               |   31 ++++++++++++++++++++++
 arch/arm/plat-s5p/Makefile                       |    1 -
 12 files changed, 117 insertions(+), 3 deletions(-)
 copy arch/arm/{plat-s5p => mach-s5p6440}/setup-i2c0.c (92%)
 rename arch/arm/{plat-s5p => mach-s5p6442}/setup-i2c0.c (92%)
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c0.c
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c1.c
 create mode 100644 arch/arm/mach-s5pv210/setup-i2c2.c

diff --git a/arch/arm/mach-s5p6440/Makefile b/arch/arm/mach-s5p6440/Makefile
index 1ad894b..9646cdf 100644
--- a/arch/arm/mach-s5p6440/Makefile
+++ b/arch/arm/mach-s5p6440/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 # Core support for S5P6440 system
 
 obj-$(CONFIG_CPU_S5P6440)	+= cpu.o init.o clock.o gpio.o
+obj-$(CONFIG_CPU_S5P6440)	+= setup-i2c0.o
 
 # machine support
 
diff --git a/arch/arm/plat-s5p/setup-i2c0.c b/arch/arm/mach-s5p6440/setup-i2c0.c
similarity index 92%
copy from arch/arm/plat-s5p/setup-i2c0.c
copy to arch/arm/mach-s5p6440/setup-i2c0.c
index 67a66e0..69e8a66 100644
--- a/arch/arm/plat-s5p/setup-i2c0.c
+++ b/arch/arm/mach-s5p6440/setup-i2c0.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/setup-i2c0.c
+/* linux/arch/arm/mach-s5p6440/setup-i2c0.c
  *
  * Copyright (c) 2009 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
diff --git a/arch/arm/mach-s5p6442/Makefile b/arch/arm/mach-s5p6442/Makefile
index dde39a6..4942c14 100644
--- a/arch/arm/mach-s5p6442/Makefile
+++ b/arch/arm/mach-s5p6442/Makefile
@@ -13,6 +13,7 @@ obj-				:=
 # Core support for S5P6442 system
 
 obj-$(CONFIG_CPU_S5P6442)	+= cpu.o init.o clock.o
+obj-$(CONFIG_CPU_S5P6442)	+= setup-i2c0.o
 
 # machine support
 
diff --git a/arch/arm/plat-s5p/setup-i2c0.c b/arch/arm/mach-s5p6442/setup-i2c0.c
similarity index 92%
rename from arch/arm/plat-s5p/setup-i2c0.c
rename to arch/arm/mach-s5p6442/setup-i2c0.c
index 67a66e0..662695d 100644
--- a/arch/arm/plat-s5p/setup-i2c0.c
+++ b/arch/arm/mach-s5p6442/setup-i2c0.c
@@ -1,4 +1,4 @@
-/* linux/arch/arm/plat-s5p/setup-i2c0.c
+/* linux/arch/arm/mach-s5p6442/setup-i2c0.c
  *
  * Copyright (c) 2009 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
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
index 9a0af8b..fb54e2d 100644
--- a/arch/arm/mach-s5pv210/Makefile
+++ b/arch/arm/mach-s5pv210/Makefile
@@ -13,10 +13,13 @@ obj-				:=
 # Core support for S5PV210 system
 
 obj-$(CONFIG_CPU_S5PV210)	+= cpu.o init.o clock.o gpio.o
+obj-$(CONFIG_CPU_S5PV210)	+= setup-i2c0.o
 
 # Helper and device support
 
 obj-$(CONFIG_S5PV210_SETUP_FB_24BPP)	+= setup-fb-24bpp.o
+obj-$(CONFIG_S5PV210_SETUP_I2C1) 	+= setup-i2c1.o
+obj-$(CONFIG_S5PV210_SETUP_I2C2) 	+= setup-i2c2.o
 
 # machine support
 
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 0e0f8fd..fb80294 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -32,6 +32,7 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/s5pv210.h>
+#include <plat/iic-core.h>
 
 /* Initial IO mappings */
 
@@ -75,6 +76,10 @@ static void s5pv210_idle(void)
 void __init s5pv210_map_io(void)
 {
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
+
+	/* the i2c devices are directly compatible with s3c2440 */
+	s3c_i2c0_setname("s3c2440-i2c");
+	s3c_i2c1_setname("s3c2440-i2c");
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
diff --git a/arch/arm/mach-s5pv210/setup-i2c0.c b/arch/arm/mach-s5pv210/setup-i2c0.c
new file mode 100644
index 0000000..e965dbc
--- /dev/null
+++ b/arch/arm/mach-s5pv210/setup-i2c0.c
@@ -0,0 +1,30 @@
+/*
+ * linux/arch/arm/mach-s5pv210/setup-i2c2.c
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *
+ * Base S5PV210 I2C bus 0 gpio configuration
+ *
+ * Based on mach-s3c64xx/setup-i2c0.c
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
+	s3c_gpio_cfgpin(S5PV210_GPD1(0), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(0), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5PV210_GPD1(1), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5PV210_GPD1(1), S3C_GPIO_PULL_UP);
+}
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
diff --git a/arch/arm/plat-s5p/Makefile b/arch/arm/plat-s5p/Makefile
index a7c54b3..0ec09a9 100644
--- a/arch/arm/plat-s5p/Makefile
+++ b/arch/arm/plat-s5p/Makefile
@@ -16,4 +16,3 @@ obj-y				+= dev-uart.o
 obj-y				+= cpu.o
 obj-y				+= clock.o
 obj-y				+= irq.o
-obj-y				+= setup-i2c0.o
-- 
1.6.4
