From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Nov 2015 17:06:49 +0100
Subject: [PATCH 04/10] ARM: s3c64xx: prepare initcalls for multiplatform
In-Reply-To: <1448467615-447097-1-git-send-email-arnd@arndb.de>
References: <1448467615-447097-1-git-send-email-arnd@arndb.de>
Message-ID: <1448467615-447097-5-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a multiplatform kernel, each initcall is run regardless
of the platform it is meant for, so it must not attempt to
access SoC-specific registers.

This adds 'if (soc_is_s3c64xx)' to all initcalls that are
specific to the s3c64xx platform, to prevent them from breaking
other platforms once we can build them into a combined kernel.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-s3c64xx/common.c               |  4 ++--
 arch/arm/mach-s3c64xx/cpuidle.c              |  5 ++++-
 arch/arm/mach-s3c64xx/irq-pm.c               |  2 +-
 arch/arm/mach-s3c64xx/mach-crag6410-module.c |  4 ++++
 arch/arm/mach-s3c64xx/pl080.c                |  4 ++++
 arch/arm/mach-s3c64xx/pm.c                   |  4 ++++
 arch/arm/mach-s3c64xx/s3c6400.c              |  2 +-
 arch/arm/mach-s3c64xx/s3c6410.c              |  2 +-
 arch/arm/plat-samsung/gpio-samsung.c         | 11 +++++------
 arch/arm/plat-samsung/init.c                 |  5 +++++
 10 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/common.c b/arch/arm/mach-s3c64xx/common.c
index ddb30b8434c5..3dea4a4ef165 100644
--- a/arch/arm/mach-s3c64xx/common.c
+++ b/arch/arm/mach-s3c64xx/common.c
@@ -208,7 +208,7 @@ void __init s3c64xx_init_io(struct map_desc *mach_desc, int size)
 static __init int s3c64xx_dev_init(void)
 {
 	/* Not applicable when using DT. */
-	if (of_have_populated_dt())
+	if (of_have_populated_dt() || !soc_is_s3c64xx())
 		return 0;
 
 	subsys_system_register(&s3c64xx_subsys, NULL);
@@ -413,7 +413,7 @@ static int __init s3c64xx_init_irq_eint(void)
 	int irq;
 
 	/* On DT-enabled systems EINTs are handled by pinctrl-s3c64xx driver. */
-	if (of_have_populated_dt())
+	if (of_have_populated_dt() || !soc_is_s3c64xx())
 		return -ENODEV;
 
 	for (irq = IRQ_EINT(0); irq <= IRQ_EINT(27); irq++) {
diff --git a/arch/arm/mach-s3c64xx/cpuidle.c b/arch/arm/mach-s3c64xx/cpuidle.c
index 93aa8cb70195..5322db51150e 100644
--- a/arch/arm/mach-s3c64xx/cpuidle.c
+++ b/arch/arm/mach-s3c64xx/cpuidle.c
@@ -18,6 +18,7 @@
 
 #include <asm/cpuidle.h>
 
+#include <plat/cpu.h>
 #include <mach/map.h>
 
 #include "regs-sys.h"
@@ -57,6 +58,8 @@ static struct cpuidle_driver s3c64xx_cpuidle_driver = {
 
 static int __init s3c64xx_init_cpuidle(void)
 {
-	return cpuidle_register(&s3c64xx_cpuidle_driver, NULL);
+	if (soc_is_s3c64xx())
+		return cpuidle_register(&s3c64xx_cpuidle_driver, NULL);
+	return 0;
 }
 device_initcall(s3c64xx_init_cpuidle);
diff --git a/arch/arm/mach-s3c64xx/irq-pm.c b/arch/arm/mach-s3c64xx/irq-pm.c
index ae4ea7601f60..0bbf1faaee42 100644
--- a/arch/arm/mach-s3c64xx/irq-pm.c
+++ b/arch/arm/mach-s3c64xx/irq-pm.c
@@ -113,7 +113,7 @@ static struct syscore_ops s3c64xx_irq_syscore_ops = {
 static __init int s3c64xx_syscore_init(void)
 {
 	/* Appropriate drivers (pinctrl, uart) handle this when using DT. */
-	if (of_have_populated_dt())
+	if (of_have_populated_dt() || !soc_is_s3c64xx())
 		return 0;
 
 	register_syscore_ops(&s3c64xx_irq_syscore_ops);
diff --git a/arch/arm/mach-s3c64xx/mach-crag6410-module.c b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
index 9c00d83f7151..be21f06e6b3f 100644
--- a/arch/arm/mach-s3c64xx/mach-crag6410-module.c
+++ b/arch/arm/mach-s3c64xx/mach-crag6410-module.c
@@ -29,6 +29,7 @@
 
 #include <linux/platform_data/spi-s3c64xx.h>
 
+#include <plat/cpu.h>
 #include "crag6410.h"
 
 static struct s3c64xx_spi_csinfo wm0010_spi_csinfo = {
@@ -399,6 +400,9 @@ static struct i2c_driver wlf_gf_module_driver = {
 
 static int __init wlf_gf_module_register(void)
 {
+	if (!soc_is_s3c64xx())
+		return 0;
+
 	return i2c_add_driver(&wlf_gf_module_driver);
 }
 device_initcall(wlf_gf_module_register);
diff --git a/arch/arm/mach-s3c64xx/pl080.c b/arch/arm/mach-s3c64xx/pl080.c
index 901a984bddc2..89c5a62830a7 100644
--- a/arch/arm/mach-s3c64xx/pl080.c
+++ b/arch/arm/mach-s3c64xx/pl080.c
@@ -14,6 +14,7 @@
 #include <linux/amba/pl08x.h>
 #include <linux/of.h>
 
+#include <plat/cpu.h>
 #include <mach/irqs.h>
 #include <mach/map.h>
 
@@ -230,6 +231,9 @@ static AMBA_AHB_DEVICE(s3c64xx_dma1, "dma-pl080s.1", 0,
 
 static int __init s3c64xx_pl080_init(void)
 {
+	if (!soc_is_s3c64xx())
+		return 0;
+
 	/* Set all DMA configuration to be DMA, not SDMA */
 	writel(0xffffff, S3C64XX_SDMA_SEL);
 
diff --git a/arch/arm/mach-s3c64xx/pm.c b/arch/arm/mach-s3c64xx/pm.c
index 75b14e756383..59d91b83b03d 100644
--- a/arch/arm/mach-s3c64xx/pm.c
+++ b/arch/arm/mach-s3c64xx/pm.c
@@ -22,6 +22,7 @@
 #include <mach/map.h>
 #include <mach/irqs.h>
 
+#include <plat/cpu.h>
 #include <plat/devs.h>
 #include <plat/pm.h>
 #include <plat/wakeup-mask.h>
@@ -332,6 +333,9 @@ int __init s3c64xx_pm_init(void)
 
 static __init int s3c64xx_pm_initcall(void)
 {
+	if (!soc_is_s3c64xx())
+		return 0;
+
 	pm_cpu_prep = s3c64xx_pm_prepare;
 	pm_cpu_sleep = s3c64xx_cpu_suspend;
 
diff --git a/arch/arm/mach-s3c64xx/s3c6400.c b/arch/arm/mach-s3c64xx/s3c6400.c
index 33273abef669..5ea82accc773 100644
--- a/arch/arm/mach-s3c64xx/s3c6400.c
+++ b/arch/arm/mach-s3c64xx/s3c6400.c
@@ -81,7 +81,7 @@ static struct device s3c6400_dev = {
 static int __init s3c6400_core_init(void)
 {
 	/* Not applicable when using DT. */
-	if (of_have_populated_dt())
+	if (of_have_populated_dt() || soc_is_s3c64xx())
 		return 0;
 
 	return subsys_system_register(&s3c6400_subsys, NULL);
diff --git a/arch/arm/mach-s3c64xx/s3c6410.c b/arch/arm/mach-s3c64xx/s3c6410.c
index eadc48dee0e4..92bb927c4478 100644
--- a/arch/arm/mach-s3c64xx/s3c6410.c
+++ b/arch/arm/mach-s3c64xx/s3c6410.c
@@ -84,7 +84,7 @@ static struct device s3c6410_dev = {
 static int __init s3c6410_core_init(void)
 {
 	/* Not applicable when using DT. */
-	if (of_have_populated_dt())
+	if (of_have_populated_dt() || !soc_is_s3c64xx())
 		return 0;
 
 	return subsys_system_register(&s3c6410_subsys, NULL);
diff --git a/arch/arm/plat-samsung/gpio-samsung.c b/arch/arm/plat-samsung/gpio-samsung.c
index 7c288ba4dc87..37faa8eab78f 100644
--- a/arch/arm/plat-samsung/gpio-samsung.c
+++ b/arch/arm/plat-samsung/gpio-samsung.c
@@ -1176,14 +1176,16 @@ static __init int samsung_gpiolib_init(void)
 	 * interfaces. For legacy (non-DT) platforms this driver is used.
 	 */
 	if (of_have_populated_dt())
-		return -ENODEV;
-
-	samsung_gpiolib_set_cfg(samsung_gpio_cfgs, ARRAY_SIZE(samsung_gpio_cfgs));
+		return 0;
 
 	if (soc_is_s3c24xx()) {
+		samsung_gpiolib_set_cfg(samsung_gpio_cfgs,
+				ARRAY_SIZE(samsung_gpio_cfgs));
 		s3c24xx_gpiolib_add_chips(s3c24xx_gpios,
 				ARRAY_SIZE(s3c24xx_gpios), S3C24XX_VA_GPIO);
 	} else if (soc_is_s3c64xx()) {
+		samsung_gpiolib_set_cfg(samsung_gpio_cfgs,
+				ARRAY_SIZE(samsung_gpio_cfgs));
 		samsung_gpiolib_add_2bit_chips(s3c64xx_gpios_2bit,
 				ARRAY_SIZE(s3c64xx_gpios_2bit),
 				S3C64XX_VA_GPIO + 0xE0, 0x20);
@@ -1192,9 +1194,6 @@ static __init int samsung_gpiolib_init(void)
 				S3C64XX_VA_GPIO);
 		samsung_gpiolib_add_4bit2_chips(s3c64xx_gpios_4bit2,
 				ARRAY_SIZE(s3c64xx_gpios_4bit2));
-	} else {
-		WARN(1, "Unknown SoC in gpio-samsung, no GPIOs added\n");
-		return -ENODEV;
 	}
 
 	return 0;
diff --git a/arch/arm/plat-samsung/init.c b/arch/arm/plat-samsung/init.c
index 11fbbc26e49f..3776f7e752f0 100644
--- a/arch/arm/plat-samsung/init.c
+++ b/arch/arm/plat-samsung/init.c
@@ -152,6 +152,11 @@ static int __init s3c_arch_init(void)
 {
 	int ret;
 
+	/* init is only needed for ATAGS based platforms */
+	if (!IS_ENABLED(CONFIG_ATAGS) ||
+	    (!soc_is_s3c24xx() && !soc_is_s3c64xx()))
+		return 0;
+
 	// do the correct init for cpu
 
 	if (cpu == NULL) {
-- 
2.1.0.rc2
