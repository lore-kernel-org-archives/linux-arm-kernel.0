From: arnd@arndb.de (Arnd Bergmann)
Date: Tue,  5 Mar 2013 18:42:31 +0100
Subject: [PATCH 21/23] ARM: exynos: hack to disable private clock code
In-Reply-To: <1362505353-8873-1-git-send-email-arnd@arndb.de>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
Message-ID: <1362505353-8873-22-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Multiplatform kernels rely on the common clock implementation,
which conflicts with Samsung's own implementation of the same
interface. This disables all code that provides or requires
the nonstandard version.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-exynos/Makefile        | 2 ++
 arch/arm/mach-exynos/common.c        | 6 ++++++
 arch/arm/plat-samsung/clock-clksrc.c | 3 +++
 arch/arm/plat-samsung/s5p-clock.c    | 3 +++
 drivers/cpufreq/Kconfig.arm          | 4 +++-
 drivers/devfreq/Kconfig              | 1 +
 6 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
index 435757e..b0dcf7d 100644
--- a/arch/arm/mach-exynos/Makefile
+++ b/arch/arm/mach-exynos/Makefile
@@ -13,10 +13,12 @@ obj-				:=
 # Core
 
 obj-$(CONFIG_ARCH_EXYNOS)	+= common.o
+ifdef CONFIG_SAMSUNG_CLOCK
 obj-$(CONFIG_ARCH_EXYNOS4)	+= clock-exynos4.o
 obj-$(CONFIG_CPU_EXYNOS4210)	+= clock-exynos4210.o
 obj-$(CONFIG_SOC_EXYNOS4212)	+= clock-exynos4212.o
 obj-$(CONFIG_SOC_EXYNOS5250)	+= clock-exynos5.o
+endif
 
 obj-$(CONFIG_PM)		+= pm.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o
diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index 4b4526d..504d50e 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -404,6 +404,9 @@ static void __init exynos5_map_io(void)
 
 static void __init exynos4_init_clocks(int xtal)
 {
+	if (!IS_ENABLED(CONFIG_SAMSUNG_CLOCK))
+		return;
+
 	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
 
 	s3c24xx_register_baseclocks(xtal);
@@ -425,6 +428,9 @@ static void __init exynos5440_map_io(void)
 
 static void __init exynos5_init_clocks(int xtal)
 {
+	if (!IS_ENABLED(CONFIG_SAMSUNG_CLOCK))
+		return;
+
 	printk(KERN_DEBUG "%s: initializing clocks\n", __func__);
 
 	/* EXYNOS5440 can support only common clock framework */
diff --git a/arch/arm/plat-samsung/clock-clksrc.c b/arch/arm/plat-samsung/clock-clksrc.c
index 786a410..094fde9 100644
--- a/arch/arm/plat-samsung/clock-clksrc.c
+++ b/arch/arm/plat-samsung/clock-clksrc.c
@@ -179,6 +179,9 @@ void __init s3c_register_clksrc(struct clksrc_clk *clksrc, int size)
 {
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_SAMSUNG_CLOCK))
+		return;
+
 	for (; size > 0; size--, clksrc++) {
 		if (!clksrc->reg_div.reg && !clksrc->reg_src.reg)
 			printk(KERN_ERR "%s: clock %s has no registers set\n",
diff --git a/arch/arm/plat-samsung/s5p-clock.c b/arch/arm/plat-samsung/s5p-clock.c
index 48a1599..0e22618 100644
--- a/arch/arm/plat-samsung/s5p-clock.c
+++ b/arch/arm/plat-samsung/s5p-clock.c
@@ -286,6 +286,9 @@ void __init s5p_register_clocks(unsigned long xtal_freq)
 {
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_SAMSUNG_CLOCK))
+		return;
+
 	clk_ext_xtal_mux.rate = xtal_freq;
 
 	ret = s3c24xx_register_clocks(s5p_clks, ARRAY_SIZE(s5p_clks));
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 030ddf6..b6fb4fa 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -51,7 +51,7 @@ config ARM_S5PV210_CPUFREQ
 
 config ARM_EXYNOS_CPUFREQ
 	bool "SAMSUNG EXYNOS SoCs"
-	depends on ARCH_EXYNOS
+	depends on ARCH_EXYNOS && SAMSUNG_CLOCK
 	default y
 	help
 	  This adds the CPUFreq driver common part for Samsung
@@ -59,6 +59,7 @@ config ARM_EXYNOS_CPUFREQ
 
 	  If in doubt, say N.
 
+if ARM_EXYNOS_CPUFREQ
 config ARM_EXYNOS4210_CPUFREQ
 	def_bool CPU_EXYNOS4210
 	help
@@ -76,6 +77,7 @@ config ARM_EXYNOS5250_CPUFREQ
 	help
 	  This adds the CPUFreq driver for Samsung EXYNOS5250
 	  SoC.
+endif
 
 config ARM_KIRKWOOD_CPUFREQ
 	def_bool ARCH_KIRKWOOD && OF
diff --git a/drivers/devfreq/Kconfig b/drivers/devfreq/Kconfig
index 0f079be..d4f9a24 100644
--- a/drivers/devfreq/Kconfig
+++ b/drivers/devfreq/Kconfig
@@ -68,6 +68,7 @@ comment "DEVFREQ Drivers"
 config ARM_EXYNOS4_BUS_DEVFREQ
 	bool "ARM Exynos4210/4212/4412 Memory Bus DEVFREQ Driver"
 	depends on CPU_EXYNOS4210 || CPU_EXYNOS4212 || CPU_EXYNOS4412
+	depends on SAMSUNG_CLOCK
 	select ARCH_HAS_OPP
 	select DEVFREQ_GOV_SIMPLE_ONDEMAND
 	help
-- 
1.8.1.2
