From: kmpark@infradead.org (Kyungmin Park)
Date: Fri, 30 Jul 2010 19:55:35 +0900
Subject: [PATCH] S5V310: I2C0/I2C1/I2C2 support
Message-ID: <20100730105535.GA15067@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Configure proper mux pins and define i2c0/i2c1/i2c2.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv310/Kconfig      |   10 ++++++++++
 arch/arm/mach-s5pv310/Makefile     |    5 +++++
 arch/arm/mach-s5pv310/setup-i2c0.c |   12 ++++++++++--
 arch/arm/mach-s5pv310/setup-i2c1.c |   25 +++++++++++++++++++++++++
 arch/arm/mach-s5pv310/setup-i2c2.c |   26 ++++++++++++++++++++++++++
 5 files changed, 76 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c1.c
 create mode 100644 arch/arm/mach-s5pv310/setup-i2c2.c

diff --git a/arch/arm/mach-s5pv310/Kconfig b/arch/arm/mach-s5pv310/Kconfig
index 2fe8149..faa3436 100644
--- a/arch/arm/mach-s5pv310/Kconfig
+++ b/arch/arm/mach-s5pv310/Kconfig
@@ -15,6 +15,16 @@ config CPU_S5PV310
 	help
 	  Enable S5PV310 CPU support
 
+config S5PV310_SETUP_I2C1
+	bool
+	help
+	  Common setup code for i2c bus 1.
+
+config S5PV310_SETUP_I2C2
+	bool
+	help
+	  Common setup code for i2c bus 2.
+
 # machine support
 
 config MACH_SMDKV310
diff --git a/arch/arm/mach-s5pv310/Makefile b/arch/arm/mach-s5pv310/Makefile
index 5b52132..82dbbaa 100644
--- a/arch/arm/mach-s5pv310/Makefile
+++ b/arch/arm/mach-s5pv310/Makefile
@@ -23,3 +23,8 @@ obj-$(CONFIG_HOTPLUG_CPU)	+= hotplug.o
 
 obj-$(CONFIG_MACH_SMDKV310)	+= mach-smdkv310.o
 obj-$(CONFIG_MACH_UNIVERSAL)	+= mach-universal.o
+
+# device support
+
+obj-$(CONFIG_S5PV310_SETUP_I2C1)	+= setup-i2c1.o
+obj-$(CONFIG_S5PV310_SETUP_I2C2)	+= setup-i2c2.o
diff --git a/arch/arm/mach-s5pv310/setup-i2c0.c b/arch/arm/mach-s5pv310/setup-i2c0.c
index d4f5a81..b14dea7 100644
--- a/arch/arm/mach-s5pv310/setup-i2c0.c
+++ b/arch/arm/mach-s5pv310/setup-i2c0.c
@@ -1,4 +1,5 @@
-/* linux/arch/arm/mach-s5pv210/setup-i2c0.c
+/*
+ * linux/arch/arm/mach-s5pv310/setup-i2c0.c
  *
  * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
  *		http://www.samsung.com/
@@ -14,7 +15,14 @@
 
 struct platform_device; /* don't need the contents */
 
+#include <mach/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
 void s3c_i2c0_cfg_gpio(struct platform_device *dev)
 {
-/* will be implemented later */
+        s3c_gpio_cfgpin(S5PV310_GPD1(0), S3C_GPIO_SFN(2));
+        s3c_gpio_setpull(S5PV310_GPD1(0), S3C_GPIO_PULL_UP);
+        s3c_gpio_cfgpin(S5PV310_GPD1(1), S3C_GPIO_SFN(2));
+        s3c_gpio_setpull(S5PV310_GPD1(1), S3C_GPIO_PULL_UP);
 }
diff --git a/arch/arm/mach-s5pv310/setup-i2c1.c b/arch/arm/mach-s5pv310/setup-i2c1.c
new file mode 100644
index 0000000..76099ff
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-i2c1.c
@@ -0,0 +1,25 @@
+/*
+ * linux/arch/arm/mach-s5pv310/setup-i2c1.c
+ *
+ * Copyright (C) 2010 Samsung Electronics Co., Ltd.
+ *
+ * I2C1 GPIO configuration.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+struct platform_device; /* don't need the contents */
+
+#include <mach/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c1_cfg_gpio(struct platform_device *dev)
+{
+        s3c_gpio_cfgpin(S5PV310_GPD1(2), S3C_GPIO_SFN(2));
+        s3c_gpio_setpull(S5PV310_GPD1(2), S3C_GPIO_PULL_UP);
+        s3c_gpio_cfgpin(S5PV310_GPD1(3), S3C_GPIO_SFN(2));
+        s3c_gpio_setpull(S5PV310_GPD1(3), S3C_GPIO_PULL_UP);
+}
diff --git a/arch/arm/mach-s5pv310/setup-i2c2.c b/arch/arm/mach-s5pv310/setup-i2c2.c
new file mode 100644
index 0000000..2f1ca7e
--- /dev/null
+++ b/arch/arm/mach-s5pv310/setup-i2c2.c
@@ -0,0 +1,26 @@
+/*
+ * linux/arch/arm/mach-s5pv310/setup-i2c2.c
+ *
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * I2C2 GPIO configuration.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+struct platform_device; /* don't need the contents */
+
+#include <mach/gpio.h>
+#include <plat/iic.h>
+#include <plat/gpio-cfg.h>
+
+void s3c_i2c2_cfg_gpio(struct platform_device *dev)
+{
+        s3c_gpio_cfgpin(S5PV310_GPA0(6), S3C_GPIO_SFN(3));
+        s3c_gpio_setpull(S5PV310_GPA0(6), S3C_GPIO_PULL_UP);
+        s3c_gpio_cfgpin(S5PV310_GPA0(7), S3C_GPIO_SFN(3));
+        s3c_gpio_setpull(S5PV310_GPA0(7), S3C_GPIO_PULL_UP);
+}
