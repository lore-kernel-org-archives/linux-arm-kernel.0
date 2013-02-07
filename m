From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  7 Feb 2013 14:43:23 -0700
Subject: [PATCH 1/2] ARM: tegra: enable ARCH_REQUIRE_GPIOLIB for Tegra114
Message-ID: <1360273404-32397-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

CONFIG_ARCH_TEGRA_114_SOC doesn't currently enable gpiolib, which causes
numerous build problems building a Tegra kernel with only Tegra114
enabled, and not Tegra20 or Tegra30. Enable ARCH_REQUIRE_GPIOLIB to
solve this. However, all Tegra will use gpiolib, so select this option
from ARCH_TEGRA rather than each individual ARCH_TEGRA_*_SOC, to
prevent this problem for any future chips.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
Olof, Arnd, These two patches can be applied on top of Tegra's previous
tegra-for-3.9-soc-t114 branch.

I think this (coupled with Hiroshi's "ARM: tegra: Fix build error w/
ARCH_TEGRA_114_SOC w/o ARCH_TEGRA_3x_SOC" is it for build failure fixes,
although I'm queueing up a number of clock driver patches for which I'll
send a pull request in the next few days.

 arch/arm/Kconfig            |    1 +
 arch/arm/mach-tegra/Kconfig |    2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4265a26..7ea0866 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -643,6 +643,7 @@ config ARCH_LPC32XX
 config ARCH_TEGRA
 	bool "NVIDIA Tegra"
 	select ARCH_HAS_CPUFREQ
+	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_OF
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index bde8197..8654324 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -5,7 +5,6 @@ comment "NVIDIA Tegra options"
 config ARCH_TEGRA_2x_SOC
 	bool "Enable support for Tegra20 family"
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_720789
 	select ARM_ERRATA_742230 if SMP
 	select ARM_ERRATA_751472
@@ -27,7 +26,6 @@ config ARCH_TEGRA_2x_SOC
 
 config ARCH_TEGRA_3x_SOC
 	bool "Enable support for Tegra30 family"
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_ERRATA_743622
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_754322
-- 
1.7.10.4
