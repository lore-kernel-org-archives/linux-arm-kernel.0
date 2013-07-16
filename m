From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 16 Jul 2013 16:17:20 -0600
Subject: [PATCH 1/4] ARM: tegra: hide CONFIG_ARCH_TEGRA_*_SOC
Message-ID: <1374013043-4693-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Enable all or none of Tegra support, rather than using separate Kconfig
options for individual SoCs. This will allow various conditional logic
to be simplified, as well as presenting fewer Kconfig options to the
user.

Once all use of ARCH_TEGRA_*_SOC has been replaced with ARCH_TEGRA, the
SoC-specific options will be removed.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I'll follow this up with patches for driver/memory, iommu, clk, pinctrl
and sound/soc which remove use of ARCH_TEGRA_*_SOC, and finally with a
series to remove those config options from the Tegra tree; that can be
applied once everything else is merged together.

 arch/arm/configs/tegra_defconfig |  3 --
 arch/arm/mach-tegra/Kconfig      | 67 +++++++++++++++-------------------------
 2 files changed, 25 insertions(+), 45 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index efb03b3..9760a0f 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -24,9 +24,6 @@ CONFIG_PARTITION_ADVANCED=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_GPIO_PCA953X=y
 CONFIG_ARCH_TEGRA=y
-CONFIG_ARCH_TEGRA_2x_SOC=y
-CONFIG_ARCH_TEGRA_3x_SOC=y
-CONFIG_ARCH_TEGRA_114_SOC=y
 CONFIG_TEGRA_PCI=y
 CONFIG_TEGRA_EMC_SCALING_ENABLE=y
 CONFIG_SMP=y
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index add345e..44cb28c 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -1,19 +1,41 @@
 config ARCH_TEGRA
 	bool "NVIDIA Tegra" if ARCH_MULTI_V7
 	select ARCH_HAS_CPUFREQ
+	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_TEGRA_2x_SOC
+	select ARCH_TEGRA_3x_SOC
+	select ARCH_TEGRA_114_SOC
+	select ARM_ERRATA_720789
+	select ARM_ERRATA_754322
+	select ARM_ERRATA_754327 if SMP
+	select ARM_ERRATA_764369 if SMP
+	select ARM_ERRATA_798181
+	select ARM_GIC
+	select ARM_L1_CACHE_SHIFT_6
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CLKSRC_OF
 	select COMMON_CLK
+	select CPU_V7
 	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_ARCH_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_CLK
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
+	select PINCTRL
+	select PINCTRL_TEGRA114
+	select PINCTRL_TEGRA20
+	select PINCTRL_TEGRA30
+	select PL310_ERRATA_727915 if CACHE_L2X0
+	select PL310_ERRATA_769419 if CACHE_L2X0
 	select SOC_BUS
 	select SPARSE_IRQ
+	select USB_ARCH_HAS_EHCI if USB_SUPPORT
+	select USB_ULPI if USB_PHY
+	select USB_ULPI_VIEWPORT if USB_PHY
 	select USE_OF
 	help
 	  This enables support for NVIDIA Tegra based systems.
@@ -22,52 +44,13 @@ menu "NVIDIA Tegra options"
 	depends on ARCH_TEGRA
 
 config ARCH_TEGRA_2x_SOC
-	bool "Enable support for Tegra20 family"
-	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
-	select ARM_ERRATA_720789
-	select ARM_ERRATA_754327 if SMP
-	select ARM_ERRATA_764369 if SMP
-	select ARM_GIC
-	select CPU_V7
-	select PINCTRL
-	select PINCTRL_TEGRA20
-	select PL310_ERRATA_727915 if CACHE_L2X0
-	select PL310_ERRATA_769419 if CACHE_L2X0
-	select USB_ARCH_HAS_EHCI if USB_SUPPORT
-	select USB_ULPI if USB_PHY
-	select USB_ULPI_VIEWPORT if USB_PHY
-	help
-	  Support for NVIDIA Tegra AP20 and T20 processors, based on the
-	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
+	bool
 
 config ARCH_TEGRA_3x_SOC
-	bool "Enable support for Tegra30 family"
-	select ARM_ERRATA_754322
-	select ARM_ERRATA_764369 if SMP
-	select ARM_GIC
-	select CPU_V7
-	select PINCTRL
-	select PINCTRL_TEGRA30
-	select PL310_ERRATA_769419 if CACHE_L2X0
-	select USB_ARCH_HAS_EHCI if USB_SUPPORT
-	select USB_ULPI if USB_PHY
-	select USB_ULPI_VIEWPORT if USB_PHY
-	help
-	  Support for NVIDIA Tegra T30 processor family, based on the
-	  ARM CortexA9MP CPU and the ARM PL310 L2 cache controller
+	bool
 
 config ARCH_TEGRA_114_SOC
-	bool "Enable support for Tegra114 family"
-	select HAVE_ARM_ARCH_TIMER
-	select ARM_ERRATA_798181
-	select ARM_GIC
-	select ARM_L1_CACHE_SHIFT_6
-	select CPU_V7
-	select PINCTRL
-	select PINCTRL_TEGRA114
-	help
-	  Support for NVIDIA Tegra T114 processor family, based on the
-	  ARM CortexA15MP CPU
+	bool
 
 config TEGRA_PCI
 	bool "PCI Express support"
-- 
1.8.1.5
