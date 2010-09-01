From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed,  1 Sep 2010 16:09:16 +0900
Subject: [PATCH 09/13] ARM: S5P64X0: Add S5P6450 I2C support
In-Reply-To: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
References: <1283324960-21629-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1283324960-21629-10-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds S5P6450 I2C support in the ARCH_S5P64X0. And
moves S5P6440 I2C support files into the mach-s5p64x0 together.

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s5p64x0/include/mach/i2c.h           |   17 ++++++++++++++
 .../{mach-s5p6440 => mach-s5p64x0}/setup-i2c0.c    |   24 +++++++++++++++-----
 .../{mach-s5p6440 => mach-s5p64x0}/setup-i2c1.c    |   20 +++++++++++++---
 3 files changed, 51 insertions(+), 10 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/i2c.h
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/setup-i2c0.c (52%)
 rename arch/arm/{mach-s5p6440 => mach-s5p64x0}/setup-i2c1.c (55%)

diff --git a/arch/arm/mach-s5p64x0/include/mach/i2c.h b/arch/arm/mach-s5p64x0/include/mach/i2c.h
new file mode 100644
index 0000000..887d252
--- /dev/null
+++ b/arch/arm/mach-s5p64x0/include/mach/i2c.h
@@ -0,0 +1,17 @@
+/* linux/arch/arm/mach-s5p64x0/include/mach/i2c.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * S5P64X0 I2C configuration
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+extern void s5p6440_i2c0_cfg_gpio(struct platform_device *dev);
+extern void s5p6440_i2c1_cfg_gpio(struct platform_device *dev);
+
+extern void s5p6450_i2c0_cfg_gpio(struct platform_device *dev);
+extern void s5p6450_i2c1_cfg_gpio(struct platform_device *dev);
diff --git a/arch/arm/mach-s5p6440/setup-i2c0.c b/arch/arm/mach-s5p64x0/setup-i2c0.c
similarity index 52%
rename from arch/arm/mach-s5p6440/setup-i2c0.c
rename to arch/arm/mach-s5p64x0/setup-i2c0.c
index 2c99d14..dc4cc65 100644
--- a/arch/arm/mach-s5p6440/setup-i2c0.c
+++ b/arch/arm/mach-s5p64x0/setup-i2c0.c
@@ -1,11 +1,11 @@
-/* linux/arch/arm/mach-s5p6440/setup-i2c0.c
+/* linux/arch/arm/mach-s5p64x0/setup-i2c0.c
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * I2C0 GPIO configuration.
  *
- * Based on plat-s3c64xx/setup-i2c0.c
+ * Based on plat-s3c64x0/setup-i2c0.c
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -14,17 +14,29 @@
 
 #include <linux/kernel.h>
 #include <linux/types.h>
+#include <linux/gpio.h>
 
 struct platform_device; /* don't need the contents */
 
-#include <linux/gpio.h>
 #include <plat/gpio-cfg.h>
 #include <plat/iic.h>
 
-void s3c_i2c0_cfg_gpio(struct platform_device *dev)
+#include <mach/i2c.h>
+
+void s5p6440_i2c0_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgpin(S5P6440_GPB(5), S3C_GPIO_SFN(2));
 	s3c_gpio_setpull(S5P6440_GPB(5), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S5P6440_GPB(6), S3C_GPIO_SFN(2));
 	s3c_gpio_setpull(S5P6440_GPB(6), S3C_GPIO_PULL_UP);
 }
+
+void s5p6450_i2c0_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5P6450_GPB(5), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5P6450_GPB(5), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5P6450_GPB(6), S3C_GPIO_SFN(2));
+	s3c_gpio_setpull(S5P6450_GPB(6), S3C_GPIO_PULL_UP);
+}
+
+void s3c_i2c0_cfg_gpio(struct platform_device *dev) { }
diff --git a/arch/arm/mach-s5p6440/setup-i2c1.c b/arch/arm/mach-s5p64x0/setup-i2c1.c
similarity index 55%
rename from arch/arm/mach-s5p6440/setup-i2c1.c
rename to arch/arm/mach-s5p64x0/setup-i2c1.c
index 9a1537f..2edd791 100644
--- a/arch/arm/mach-s5p6440/setup-i2c1.c
+++ b/arch/arm/mach-s5p64x0/setup-i2c1.c
@@ -1,7 +1,7 @@
-/* linux/arch/arm/mach-s5p6440/setup-i2c1.c
+/* linux/arch/arm/mach-s5p64xx/setup-i2c1.c
  *
- * Copyright (c) 2009 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com/
+ * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
  *
  * I2C1 GPIO configuration.
  *
@@ -21,10 +21,22 @@ struct platform_device; /* don't need the contents */
 #include <plat/gpio-cfg.h>
 #include <plat/iic.h>
 
-void s3c_i2c1_cfg_gpio(struct platform_device *dev)
+#include <mach/i2c.h>
+
+void s5p6440_i2c1_cfg_gpio(struct platform_device *dev)
 {
 	s3c_gpio_cfgpin(S5P6440_GPR(9), S3C_GPIO_SFN(6));
 	s3c_gpio_setpull(S5P6440_GPR(9), S3C_GPIO_PULL_UP);
 	s3c_gpio_cfgpin(S5P6440_GPR(10), S3C_GPIO_SFN(6));
 	s3c_gpio_setpull(S5P6440_GPR(10), S3C_GPIO_PULL_UP);
 }
+
+void s5p6450_i2c1_cfg_gpio(struct platform_device *dev)
+{
+	s3c_gpio_cfgpin(S5P6450_GPR(9), S3C_GPIO_SFN(6));
+	s3c_gpio_setpull(S5P6450_GPR(9), S3C_GPIO_PULL_UP);
+	s3c_gpio_cfgpin(S5P6450_GPR(10), S3C_GPIO_SFN(6));
+	s3c_gpio_setpull(S5P6450_GPR(10), S3C_GPIO_PULL_UP);
+}
+
+void s3c_i2c1_cfg_gpio(struct platform_device *dev) { }
-- 
1.6.2.5
