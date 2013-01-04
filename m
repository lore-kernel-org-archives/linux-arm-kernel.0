From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  4 Jan 2013 20:27:27 -0200
Subject: [PATCH] ARM: imx: Do not select some errata that depends on
 !ARCH_MULTIPLATFORM
Message-ID: <1357338447-6798-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 62e4d357a (ARM: 7609/1: disable errata work-arounds which access 
secure registers) ARM_ERRATA_743622/751472 depends on !ARCH_MULTIPLATFORM.

Since imx has been converted to multiplatform, the following warning happens:

$ make imx_v6_v7_defconfig
warning: (SOC_IMX6Q && ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects
ARM_ERRATA_751472 which has unmet direct dependencies (CPU_V7 &&
!ARCH_MULTIPLATFORM)
warning: (SOC_IMX6Q && ARCH_TEGRA_3x_SOC) selects ARM_ERRATA_743622
which has unmet direct dependencies (CPU_V7 && !ARCH_MULTIPLATFORM)
warning: (SOC_IMX6Q && ARCH_TEGRA_3x_SOC) selects ARM_ERRATA_743622
which has unmet direct dependencies (CPU_V7 && !ARCH_MULTIPLATFORM)
warning: (SOC_IMX6Q && ARCH_TEGRA_2x_SOC && ARCH_TEGRA_3x_SOC) selects
ARM_ERRATA_751472 which has unmet direct dependencies (CPU_V7 &&
!ARCH_MULTIPLATFORM)

Recommended approach is to remove ARM_ERRATA_743622/751472 from being selected
by SOC_IMX6Q and apply such workarounds into the bootloader.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-imx/Kconfig |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 1ad0d76..3e628fd 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -841,8 +841,6 @@ config SOC_IMX6Q
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
-	select ARM_ERRATA_743622
-	select ARM_ERRATA_751472
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
-- 
1.7.9.5
