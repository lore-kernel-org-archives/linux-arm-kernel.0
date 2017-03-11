From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 11 Mar 2017 22:26:14 +0200
Subject: [PATCH] ARM: tegra: Select SOC_TEGRA_PMC to fix linking error
Message-ID: <20170311202614.6052-1-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is possible to create a ARMv7 config with ARCH_TEGRA but without any
SoC specific flavors.  Such configs fails because mach-tegra/pm.c is
compiled always and it references SOC_TEGRA_PMC driver:

	arch/arm/mach-tegra/built-in.o: In function `tegra_pm_set':
	arch/arm/mach-tegra/pm.c:188: undefined reference to `tegra_pmc_enter_suspend_mode'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/mach-tegra/Kconfig | 1 +
 drivers/soc/tegra/Kconfig   | 4 ----
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 329f01c5b6f8..eabf101979cc 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -13,5 +13,6 @@ menuconfig ARCH_TEGRA
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
 	select SOC_BUS
+	select SOC_TEGRA_PMC
 	help
 	  This enables support for NVIDIA Tegra based systems.
diff --git a/drivers/soc/tegra/Kconfig b/drivers/soc/tegra/Kconfig
index 208d6edb3fdb..cfde6d666d4b 100644
--- a/drivers/soc/tegra/Kconfig
+++ b/drivers/soc/tegra/Kconfig
@@ -12,7 +12,6 @@ config ARCH_TEGRA_2x_SOC
 	select PINCTRL_TEGRA20
 	select PL310_ERRATA_727915 if CACHE_L2X0
 	select PL310_ERRATA_769419 if CACHE_L2X0
-	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
@@ -24,7 +23,6 @@ config ARCH_TEGRA_3x_SOC
 	select ARM_ERRATA_764369 if SMP
 	select PINCTRL_TEGRA30
 	select PL310_ERRATA_769419 if CACHE_L2X0
-	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra T30 processor family, based on the
@@ -35,7 +33,6 @@ config ARCH_TEGRA_114_SOC
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA114
-	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra T114 processor family, based on the
@@ -45,7 +42,6 @@ config ARCH_TEGRA_124_SOC
 	bool "Enable support for Tegra124 family"
 	select HAVE_ARM_ARCH_TIMER
 	select PINCTRL_TEGRA124
-	select SOC_TEGRA_PMC
 	select TEGRA_TIMER
 	help
 	  Support for NVIDIA Tegra T124 processor family, based on the
-- 
2.9.3
