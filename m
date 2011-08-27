From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Aug 2011 01:32:50 +0200
Subject: [PATCH 1/5] ARM: Samsung: PWM: Allow to differentiate SoCs based on
 platform device name.
Message-ID: <mailman.110.1314794063.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a prerequisite to adding generic time support for S3C64xx.
It makes possible to differentiate SoCs, required to exclude timers 3 and 4
from PWM driver only on S3C64xx.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-s3c64xx/s3c6400.c               |    2 ++
 arch/arm/mach-s3c64xx/s3c6410.c               |    2 ++
 arch/arm/plat-samsung/dev-pwm.c               |    8 ++++++++
 arch/arm/plat-samsung/include/plat/pwm-core.h |   21 +++++++++++++++++++++
 arch/arm/plat-samsung/pwm.c                   |   19 ++++++++++++++++++-
 5 files changed, 51 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/plat-samsung/include/plat/pwm-core.h

diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 5e93fe3..6418832 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -38,6 +38,7 @@
 #include <plat/sdhci.h>
 #include <plat/iic-core.h>
 #include <plat/onenand-core.h>
+#include <plat/pwm-core.h>
 #include <mach/s3c6400.h>
 
 void __init s3c6400_map_io(void)
@@ -55,6 +56,7 @@ void __init s3c6400_map_io(void)
 
 	s3c_onenand_setname("s3c6400-onenand");
 	s3c64xx_onenand1_setname("s3c6400-onenand");
+	s3c_pwm_setname("s3c64xx-pwm");
 }
 
 void __init s3c6400_init_clocks(int xtal)
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index 312aa6b..4f66c25 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -41,6 +41,7 @@
 #include <plat/adc-core.h>
 #include <plat/iic-core.h>
 #include <plat/onenand-core.h>
+#include <plat/pwm-core.h>
 #include <mach/s3c6400.h>
 #include <mach/s3c6410.h>
 
@@ -60,6 +61,7 @@ void __init s3c6410_map_io(void)
 	s3c_onenand_setname("s3c6410-onenand");
 	s3c64xx_onenand1_setname("s3c6410-onenand");
 	s3c_cfcon_setname("s3c64xx-pata");
+	s3c_pwm_setname("s3c64xx-pwm");
 }
 
 void __init s3c6410_init_clocks(int xtal)
diff --git a/arch/arm/plat-samsung/dev-pwm.c b/arch/arm/plat-samsung/dev-pwm.c
index dab47b0..751286a 100644
--- a/arch/arm/plat-samsung/dev-pwm.c
+++ b/arch/arm/plat-samsung/dev-pwm.c
@@ -20,6 +20,7 @@
 #include <mach/irqs.h>
 
 #include <plat/devs.h>
+#include <plat/pwm-core.h>
 
 #define TIMER_RESOURCE_SIZE (1)
 
@@ -51,3 +52,10 @@ struct platform_device s3c_device_timer[] = {
 	[4] = { DEFINE_S3C_TIMER(4, IRQ_TIMER4) },
 };
 EXPORT_SYMBOL(s3c_device_timer);
+
+void s3c_pwm_setname(const char *name)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(s3c_device_timer); ++i)
+		s3c_device_timer[i].name = name;
+}
diff --git a/arch/arm/plat-samsung/include/plat/pwm-core.h b/arch/arm/plat-samsung/include/plat/pwm-core.h
new file mode 100644
index 0000000..651d7a4
--- /dev/null
+++ b/arch/arm/plat-samsung/include/plat/pwm-core.h
@@ -0,0 +1,21 @@
+/* arch/arm/plat-samsung/include/plat/pwm-core.h
+ *
+ * Copyright 2011 Tomasz Figa <tomasz.figa@gmail.com>
+ *
+ * S3C - PWM Controller core functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __ASM_ARCH_PWM_CORE_H
+#define __ASM_ARCH_PWM_CORE_H __FILE__
+
+/* These functions are only for use with the core support code, such as
+ * the cpu specific initialisation code
+ */
+
+extern void s3c_pwm_setname(const char *name);
+
+#endif /* __ASM_ARCH_PWM_H */
diff --git a/arch/arm/plat-samsung/pwm.c b/arch/arm/plat-samsung/pwm.c
index f37457c..27b5353 100644
--- a/arch/arm/plat-samsung/pwm.c
+++ b/arch/arm/plat-samsung/pwm.c
@@ -24,6 +24,11 @@
 
 #include <plat/regs-timer.h>
 
+enum soc_type {
+	TYPE_GENERIC,
+	TYPE_S3C64XX,
+};
+
 struct pwm_device {
 	struct list_head	 list;
 	struct platform_device	*pdev;
@@ -380,11 +385,23 @@ static int s3c_pwm_resume(struct platform_device *pdev)
 #define s3c_pwm_resume NULL
 #endif
 
+static struct platform_device_id s3c_pwm_driver_ids[] = {
+	{
+		.name		= "s3c24xx-pwm",
+		.driver_data	= TYPE_GENERIC,
+	}, {
+		.name		= "s3c64xx-pwm",
+		.driver_data	= TYPE_S3C64XX,
+	},
+};
+MODULE_DEVICE_TABLE(platform, s3c_pwm_driver_ids);
+
 static struct platform_driver s3c_pwm_driver = {
 	.driver		= {
-		.name	= "s3c24xx-pwm",
+		.name	= "samsung-pwm",
 		.owner	= THIS_MODULE,
 	},
+	.id_table	= s3c_pwm_driver_ids,
 	.probe		= s3c_pwm_probe,
 	.remove		= __devexit_p(s3c_pwm_remove),
 	.suspend	= s3c_pwm_suspend,
-- 
1.7.6.1
