From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 12 Dec 2011 11:47:06 +0000
Subject: [PATCH v3 2/2] ARM: SMP: Refactor Kconfig to be more maintainable
In-Reply-To: <1323690426-6267-1-git-send-email-dave.martin@linaro.org>
References: <1323690426-6267-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1323690426-6267-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Making SMP depend on (huge list of MACH_ and ARCH_ configs) is
bothersome to maintain and likely to lead to merge conflicts.

This patch moves the knowledge of which platforms are SMP-capable
to the individual machines.  To enable this, a new HAVE_SMP config
option is introduced to allow machines to indicate that they have
such a cache controller independently of each other.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
This is the first version of this patch.  There is no version prior to
v3.

 arch/arm/Kconfig               |   15 +++++++++++----
 arch/arm/mach-exynos/Kconfig   |    1 +
 arch/arm/mach-imx/Kconfig      |    1 +
 arch/arm/mach-msm/Kconfig      |    1 +
 arch/arm/mach-omap2/Kconfig    |    1 +
 arch/arm/mach-realview/Kconfig |    4 ++++
 arch/arm/mach-vexpress/Kconfig |    1 +
 7 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7e621e..fae6703 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -345,6 +345,7 @@ config ARCH_HIGHBANK
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU
 	select HAVE_L2X0_L2CC
+	select HAVE_SMP
 	select USE_OF
 	help
 	  Support for the Calxeda Highbank SoC based boards.
@@ -637,6 +638,7 @@ config ARCH_TEGRA
 	select HAVE_CLK
 	select HAVE_L2X0_L2CC
 	select HAVE_SCHED_CLOCK
+	select HAVE_SMP
 	select ARCH_HAS_CPUFREQ
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
@@ -707,6 +709,7 @@ config ARCH_SHMOBILE
 	select CLKDEV_LOOKUP
 	select HAVE_L2X0_L2CC
 	select HAVE_MACH_CLKDEV
+	select HAVE_SMP
 	select GENERIC_CLOCKEVENTS
 	select NO_IOPORT
 	select SPARSE_IRQ
@@ -906,6 +909,7 @@ config ARCH_U8500
 	select CPU_V7
 	select ARM_AMBA
 	select HAVE_L2X0_L2CC
+	select HAVE_SMP
 	select GENERIC_CLOCKEVENTS
 	select CLKDEV_LOOKUP
 	select ARCH_REQUIRE_GPIOLIB
@@ -1430,14 +1434,17 @@ menu "Kernel Features"
 
 source "kernel/time/Kconfig"
 
+config HAVE_SMP
+	bool
+	help
+	  This option should be selected by machines which have an SMP-
+	  capable CPU.
+
 config SMP
 	bool "Symmetric Multi-Processing"
 	depends on CPU_V6K || CPU_V7
 	depends on GENERIC_CLOCKEVENTS
-	depends on REALVIEW_EB_ARM11MP || REALVIEW_EB_A9MP || \
-		 MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
-		 ARCH_EXYNOS4 || ARCH_TEGRA || ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || \
-		 ARCH_MSM_SCORPIONMP || ARCH_SHMOBILE || ARCH_HIGHBANK || SOC_IMX6Q
+	depends on HAVE_SMP
 	depends on MMU
 	select USE_GENERIC_SMP_HELPERS
 	select HAVE_ARM_SCU if !ARCH_MSM_SCORPIONMP
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index c4c9acf..9d43f62 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -18,6 +18,7 @@ choice
 config ARCH_EXYNOS4
 	bool "SAMSUNG EXYNOS4"
 	select CACHE_L2X0
+	select HAVE_SMP
 	help
 	  Samsung EXYNOS4 SoCs based systems
 
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 4234937..4aa7f7e 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -611,6 +611,7 @@ config SOC_IMX6Q
 	select ARM_GIC
 	select CPU_V7
 	select HAVE_ARM_SCU
+	select HAVE_SMP
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
 	select HAVE_IMX_SRC
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index ebde97f..e6beaff 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -67,6 +67,7 @@ config MSM_SOC_REV_A
 	bool
 config  ARCH_MSM_SCORPIONMP
 	bool
+	select HAVE_SMP
 
 config  ARCH_MSM_ARM11
 	bool
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0358159..f7bd89c 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -45,6 +45,7 @@ config ARCH_OMAP4
 	select ARM_GIC
 	select LOCAL_TIMERS if SMP
 	select CACHE_L2X0
+	select HAVE_SMP
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index 3dfd6b8..a1ca4a9 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -13,6 +13,7 @@ config REALVIEW_EB_A9MP
 	depends on MACH_REALVIEW_EB
 	select CPU_V7
 	select HAVE_L2X0_L2CC
+	select HAVE_SMP
 	help
 	  Enable support for the Cortex-A9MPCore tile fitted to the
 	  Realview(R) Emulation Baseboard platform.
@@ -22,6 +23,7 @@ config REALVIEW_EB_ARM11MP
 	depends on MACH_REALVIEW_EB
 	select CPU_V6K
 	select HAVE_L2X0_L2CC
+	select HAVE_SMP
 	select ARCH_HAS_BARRIERS if SMP
 	help
 	  Enable support for the ARM11MPCore tile fitted to the Realview(R)
@@ -41,6 +43,7 @@ config MACH_REALVIEW_PB11MP
 	select CPU_V6K
 	select ARM_GIC
 	select HAVE_L2X0_L2CC
+	select HAVE_SMP
 	select HAVE_PATA_PLATFORM
 	select ARCH_HAS_BARRIERS if SMP
 	help
@@ -83,6 +86,7 @@ config MACH_REALVIEW_PBX
 	select ARM_GIC
 	select HAVE_L2X0_L2CC
 	select HAVE_PATA_PLATFORM
+	select HAVE_SMP
 	select ARCH_SPARSEMEM_ENABLE if CPU_V7 && !REALVIEW_HIGH_PHYS_OFFSET
 	select ZONE_DMA if SPARSEMEM
 	help
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index d9f387e..8f81792 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -9,5 +9,6 @@ config ARCH_VEXPRESS_CA9X4
 	select ARM_ERRATA_751472
 	select ARM_ERRATA_753970
 	select HAVE_L2X0_L2CC
+	select HAVE_SMP
 
 endmenu
-- 
1.7.4.1
