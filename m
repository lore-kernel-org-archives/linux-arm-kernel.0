From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 26 Feb 2016 12:54:12 +0100
Subject: [PATCH] ARM: imx: select ARM_CPU_SUSPEND only for imx6
Message-ID: <1456487657-3928107-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i.MX only needs to select ARM_CPU_SUSPEND manually for the
very specific case that CONFIG_PM_SLEEP is disabled and imx6
is used with CONFIG_PM enabled for runtime PM.

If we are building a kernel only for CPUs that are not using
the cpu_suspend() helper, we otherwise get a harmless
build warning:

warning: (ARCH_MXC && SOC_IMX23 && SOC_IMX28 && ARCH_PXA && MACH_MVEBU_V7 && ARCH_OMAP3 && ARCH_OMAP4 && SOC_OMAP5 && SOC_AM33XX && SOC_DRA7XX && ARCH_EXYNOS3 && ARCH_EXYNOS4 && EXYNOS5420_MCPM && EXYNOS_CPU_SUSPEND && ARCH_VEXPRESS_TC2_PM && ARM_BIG_LITTLE_CPUIDLE && ARM_HIGHBANK_CPUIDLE && QCOM_PM) selects ARM_CPU_SUSPEND which has unmet direct dependencies (ARCH_SUSPEND_POSSIBLE)

This moves the option to the SOC_IMX6 option that actually
requires it, in effect reverting commit f36b594f3754 ("ARM:
mach-imx: Select ARM_CPU_SUSPEND at ARCH_MXC level") that was
meant as a cleanup and unintentionally caused this warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 6c6b86cdeced..53fc0d4948a4 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -3,7 +3,6 @@ menuconfig ARCH_MXC
 	depends on ARCH_MULTIPLATFORM || ARM_SINGLE_ARMV7M
 	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_BIG_ENDIAN
-	select ARM_CPU_SUSPEND if PM
 	select CLKSRC_IMX_GPT
 	select GENERIC_IRQ_CHIP
 	select PINCTRL
@@ -512,6 +511,7 @@ config	SOC_IMX53
 
 config SOC_IMX6
 	bool
+	select ARM_CPU_SUSPEND if PM
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 	select ARM_GIC
-- 
2.7.0
