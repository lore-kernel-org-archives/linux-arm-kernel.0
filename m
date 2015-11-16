From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Nov 2015 18:01:19 +0100
Subject: [PATCH] ARM: zx: only build power domain code when CONFIG_PM=y
Message-ID: <5298444.vriZVZrvnf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added zx power domain code causes build errors in
some configurations:

warning: (PM_RMOBILE && SOC_ZX296702) selects PM_GENERIC_DOMAINS which has unmet direct dependencies (PM)
warning: (ARCH_EXYNOS) selects EXYNOS_THERMAL which has unmet direct dependencies (THERMAL && (ARCH_EXYNOS || COMPILE_TEST) && THERMAL_OF)
power/domain.c: In function 'genpd_queue_power_off_work':
power/domain.c:192:13: error: 'pm_wq' undeclared (first use in this function)
  queue_work(pm_wq, &genpd->power_off_work);
             ^
power/domain.c:192:13: note: each undeclared identifier is reported only once for each function it appears in

This ensures we don't try to enable it when CONFIG_PM is
disabled, mirroring what we do on most other platforms.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: f15107f41282 ("ARM: zx: Add power domains for ZX296702")

diff --git a/arch/arm/mach-zx/Kconfig b/arch/arm/mach-zx/Kconfig
index 7fdc5bf24f9b..446334a25cf5 100644
--- a/arch/arm/mach-zx/Kconfig
+++ b/arch/arm/mach-zx/Kconfig
@@ -13,7 +13,7 @@ config SOC_ZX296702
 	select ARM_GLOBAL_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
-	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS if PM
 	help
 	  Support for ZTE ZX296702 SoC which is a dual core CortexA9MP
 endif
