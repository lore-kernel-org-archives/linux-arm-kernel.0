From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 12 May 2014 00:09:48 +0200
Subject: [PATCH v3 6/9] ARM: S3C24XX: add platform code for conversion to the
 common clock framework
In-Reply-To: <3427359.fjFAW0MSIR@phil>
References: <3427359.fjFAW0MSIR@phil>
Message-ID: <5113680.xIfXX9kibx@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the necessary init functions to init the clocks from the common
clock framework and necessary CONFIG_SAMSUNG_CLOCK ifdefs around the legacy
clock code.

This also includes empty stubs for the *_setup_clocks functions that are
called from the cpufreq driver on resume.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-s3c24xx/Kconfig   |  5 +++++
 arch/arm/mach-s3c24xx/common.c  | 25 +++++++++++++++++++++++++
 arch/arm/mach-s3c24xx/common.h  |  7 +++++++
 arch/arm/mach-s3c24xx/s3c2410.c |  6 ++++++
 arch/arm/mach-s3c24xx/s3c2442.c |  3 ++-
 arch/arm/mach-s3c24xx/s3c244x.c |  6 ++++++
 6 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index b4c055b..5c9cffd 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -18,6 +18,11 @@ config PLAT_S3C24XX
 	help
 	  Base platform code for any Samsung S3C24XX device
 
+config S3C2410_COMMON_CLK
+	bool
+	help
+	  Build the s3c2410 clock driver based on the common clock framework.
+
 config S3C2410_COMMON_DCLK
 	bool
 	select REGMAP_MMIO
diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 7cc6d94..35cf88e 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -53,6 +53,7 @@
 #include <plat/cpu-freq.h>
 #include <plat/pll.h>
 #include <plat/pwm-core.h>
+#include <plat/watchdog-reset.h>
 
 #include "common.h"
 
@@ -533,6 +534,14 @@ struct platform_device s3c2443_device_dma = {
 };
 #endif
 
+#if defined(CONFIG_COMMON_CLK) && defined(CONFIG_CPU_S3C2410)
+void __init s3c2410_init_clocks(int xtal)
+{
+	s3c2410_common_clk_init(NULL, xtal, 0, S3C24XX_VA_CLKPWR);
+	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
+}
+#endif
+
 #ifdef CONFIG_CPU_S3C2412
 void __init s3c2412_init_clocks(int xtal)
 {
@@ -547,6 +556,22 @@ void __init s3c2416_init_clocks(int xtal)
 }
 #endif
 
+#if defined(CONFIG_COMMON_CLK) && defined(CONFIG_CPU_S3C2440)
+void __init s3c2440_init_clocks(int xtal)
+{
+	s3c2410_common_clk_init(NULL, xtal, 1, S3C24XX_VA_CLKPWR);
+	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
+}
+#endif
+
+#if defined(CONFIG_COMMON_CLK) && defined(CONFIG_CPU_S3C2442)
+void __init s3c2442_init_clocks(int xtal)
+{
+	s3c2410_common_clk_init(NULL, xtal, 2, S3C24XX_VA_CLKPWR);
+	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
+}
+#endif
+
 #ifdef CONFIG_CPU_S3C2443
 void __init s3c2443_init_clocks(int xtal)
 {
diff --git a/arch/arm/mach-s3c24xx/common.h b/arch/arm/mach-s3c24xx/common.h
index 50504c7..2d65541 100644
--- a/arch/arm/mach-s3c24xx/common.h
+++ b/arch/arm/mach-s3c24xx/common.h
@@ -77,6 +77,7 @@ extern void s3c244x_restart(enum reboot_mode mode, const char *cmd);
 #ifdef CONFIG_CPU_S3C2440
 extern  int s3c2440_init(void);
 extern void s3c2440_map_io(void);
+extern void s3c2440_init_clocks(int xtal);
 extern void s3c2440_init_irq(void);
 #else
 #define s3c2440_init NULL
@@ -86,6 +87,7 @@ extern void s3c2440_init_irq(void);
 #ifdef CONFIG_CPU_S3C2442
 extern  int s3c2442_init(void);
 extern void s3c2442_map_io(void);
+extern void s3c2442_init_clocks(int xtal);
 extern void s3c2442_init_irq(void);
 #else
 #define s3c2442_init NULL
@@ -116,6 +118,11 @@ extern struct platform_device s3c2443_device_dma;
 
 extern struct platform_device s3c2410_device_dclk;
 
+#ifdef CONFIG_S3C2410_COMMON_CLK
+void __init s3c2410_common_clk_init(struct device_node *np, unsigned long xti_f,
+				    int current_soc,
+				    void __iomem *reg_base);
+#endif
 #ifdef CONFIG_S3C2412_COMMON_CLK
 void __init s3c2412_common_clk_init(struct device_node *np, unsigned long xti_f,
 				unsigned long ext_f, void __iomem *reg_base);
diff --git a/arch/arm/mach-s3c24xx/s3c2410.c b/arch/arm/mach-s3c24xx/s3c2410.c
index 04b58cb..5280173 100644
--- a/arch/arm/mach-s3c24xx/s3c2410.c
+++ b/arch/arm/mach-s3c24xx/s3c2410.c
@@ -83,6 +83,7 @@ void __init s3c2410_map_io(void)
 	iotable_init(s3c2410_iodesc, ARRAY_SIZE(s3c2410_iodesc));
 }
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 void __init_or_cpufreq s3c2410_setup_clocks(void)
 {
 	struct clk *xtal_clk;
@@ -142,6 +143,11 @@ void __init s3c2410_init_clocks(int xtal)
 	clkdev_add_table(s3c2410_clk_lookup, ARRAY_SIZE(s3c2410_clk_lookup));
 	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
 }
+#else
+void __init_or_cpufreq s3c2410_setup_clocks(void)
+{
+}
+#endif
 
 struct bus_type s3c2410_subsys = {
 	.name = "s3c2410-core",
diff --git a/arch/arm/mach-s3c24xx/s3c2442.c b/arch/arm/mach-s3c24xx/s3c2442.c
index 2c8adc0..564c6503 100644
--- a/arch/arm/mach-s3c24xx/s3c2442.c
+++ b/arch/arm/mach-s3c24xx/s3c2442.c
@@ -53,6 +53,7 @@
 
 #include "common.h"
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 /* S3C2442 extended clock support */
 
 static unsigned long s3c2442_camif_upll_round(struct clk *clk,
@@ -162,7 +163,7 @@ static __init int s3c2442_clk_init(void)
 }
 
 arch_initcall(s3c2442_clk_init);
-
+#endif
 
 static struct device s3c2442_dev = {
 	.bus		= &s3c2442_subsys,
diff --git a/arch/arm/mach-s3c24xx/s3c244x.c b/arch/arm/mach-s3c24xx/s3c244x.c
index 76b691b..1d665d5 100644
--- a/arch/arm/mach-s3c24xx/s3c244x.c
+++ b/arch/arm/mach-s3c24xx/s3c244x.c
@@ -78,6 +78,7 @@ void __init s3c244x_map_io(void)
 	s3c2410_device_dclk.name = "s3c2440-dclk";
 }
 
+#ifdef CONFIG_SAMSUNG_CLOCK
 void __init_or_cpufreq s3c244x_setup_clocks(void)
 {
 	struct clk *xtal_clk;
@@ -138,6 +139,11 @@ void __init s3c244x_init_clocks(int xtal)
 	s3c2410_baseclk_add();
 	samsung_wdt_reset_init(S3C24XX_VA_WATCHDOG);
 }
+#else
+void __init_or_cpufreq s3c244x_setup_clocks(void)
+{
+}
+#endif
 
 /* Since the S3C2442 and S3C2440 share items, put both subsystems here */
 
-- 
1.9.0
