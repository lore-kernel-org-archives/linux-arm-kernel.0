From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 30 Jun 2010 21:59:09 +0900
Subject: [PATCH] ARM: SAMSUNG: Implement set_name function for ADC devices
Message-ID: <1277902749-12882-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Naveen Krishna Ch <ch.naveen@samsung.com>

This patch implements s3c_adc_setname() for Samsung SoCs.
Also updates its usage in S3C64XX, S5P6440, and S5PV210.

Signed-off-by: Naveen Krishna Ch <ch.naveen@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-s3c64xx/s3c6410.c               |    4 +-
 arch/arm/mach-s5p6440/cpu.c                   |    3 +-
 arch/arm/mach-s5pv210/cpu.c                   |    7 ++---
 arch/arm/plat-samsung/include/plat/adc-core.h |   28 +++++++++++++++++++++++++
 4 files changed, 35 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/adc-core.h

diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 014401c..2b29ac0 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -37,8 +37,8 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/sdhci.h>
+#include <plat/adc-core.h>
 #include <plat/iic-core.h>
-#include <plat/adc.h>
 #include <plat/onenand-core.h>
 #include <mach/s3c6400.h>
 #include <mach/s3c6410.h>
@@ -54,7 +54,7 @@ void __init s3c6410_map_io(void)
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
 
-	s3c_device_adc.name	= "s3c64xx-adc";
+	s3c_adc_setname("s3c64xx-adc");
 	s3c_device_nand.name = "s3c6400-nand";
 	s3c_onenand_setname("s3c6410-onenand");
 	s3c64xx_onenand1_setname("s3c6410-onenand");
diff --git a/arch/arm/mach-s5p6440/cpu.c b/arch/arm/mach-s5p6440/cpu.c
index b2fe6a5..526f33a 100644
--- a/arch/arm/mach-s5p6440/cpu.c
+++ b/arch/arm/mach-s5p6440/cpu.c
@@ -37,6 +37,7 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/s5p6440.h>
+#include <plat/adc-core.h>
 
 static void s5p6440_idle(void)
 {
@@ -61,7 +62,7 @@ static void s5p6440_idle(void)
 void __init s5p6440_map_io(void)
 {
 	/* initialize any device information early */
-	s3c_device_adc.name	= "s3c64xx-adc";
+	s3c_adc_setname("s3c64xx-adc");
 }
 
 void __init s5p6440_init_clocks(int xtal)
diff --git a/arch/arm/mach-s5pv210/cpu.c b/arch/arm/mach-s5pv210/cpu.c
index 411a4a9..68317a4 100644
--- a/arch/arm/mach-s5pv210/cpu.c
+++ b/arch/arm/mach-s5pv210/cpu.c
@@ -32,6 +32,7 @@
 #include <plat/devs.h>
 #include <plat/clock.h>
 #include <plat/s5pv210.h>
+#include <plat/adc-core.h>
 #include <plat/iic-core.h>
 #include <plat/sdhci.h>
 
@@ -76,10 +77,6 @@ static void s5pv210_idle(void)
 
 void __init s5pv210_map_io(void)
 {
-#ifdef CONFIG_S3C_DEV_ADC
-	s3c_device_adc.name	= "s3c64xx-adc";
-#endif
-
 	iotable_init(s5pv210_iodesc, ARRAY_SIZE(s5pv210_iodesc));
 
 	/* initialise device information early */
@@ -87,6 +84,8 @@ void __init s5pv210_map_io(void)
 	s5pv210_default_sdhci1();
 	s5pv210_default_sdhci2();
 
+	s3c_adc_setname("s3c64xx-adc");
+
 	/* the i2c devices are directly compatible with s3c2440 */
 	s3c_i2c0_setname("s3c2440-i2c");
 	s3c_i2c1_setname("s3c2440-i2c");
diff --git a/arch/arm/plat-samsung/include/plat/adc-core.h b/arch/arm/plat-samsung/include/plat/adc-core.h
new file mode 100644
index 0000000..a281568
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/adc-core.h
@@ -0,0 +1,28 @@
+/* linux/arch/arm/plat-samsung/include/plat/adc-core.h
+ *
+ * Copyright (c) 2010 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com/
+ *
+ * Samsung ADC Controller core functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_PLAT_ADC_CORE_H
+#define __ASM_PLAT_ADC_CORE_H __FILE__
+
+/* These functions are only for use with the core support code, such as
+ * the cpu specific initialisation code
+ */
+
+/* re-define device name depending on support. */
+static inline void s3c_adc_setname(char *name)
+{
+#ifdef CONFIG_SAMSUNG_DEV_ADC
+	s3c_device_adc.name = name;
+#endif
+}
+
+#endif /* __ASM_PLAT_ADC_CORE_H */
-- 
1.6.2.5
