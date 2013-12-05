From: robherring2@gmail.com (Rob Herring)
Date: Thu,  5 Dec 2013 10:58:42 -0600
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
Message-ID: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Multi-platform requires various kconfig options to be selected, so
platforms don't need to select them individually.

A few more options could be selected because they are either on nearly
every platform or they just enable other kconfig options to be visible:

select ARM_AMBA
select ARM_GIC if CPU_V7
select HAVE_SMP if CPU_V7
select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
select ARCH_HAS_CPUFREQ
select ARCH_HAS_OPP

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                |  2 ++
 arch/arm/mach-bcm/Kconfig       |  5 -----
 arch/arm/mach-bcm2835/Kconfig   |  4 ----
 arch/arm/mach-cns3xxx/Kconfig   |  1 -
 arch/arm/mach-highbank/Kconfig  |  6 ------
 arch/arm/mach-imx/Kconfig       | 12 ------------
 arch/arm/mach-keystone/Kconfig  |  3 ---
 arch/arm/mach-mvebu/Kconfig     |  5 -----
 arch/arm/mach-mxs/Kconfig       |  4 ----
 arch/arm/mach-nomadik/Kconfig   |  5 -----
 arch/arm/mach-nspire/Kconfig    |  5 -----
 arch/arm/mach-omap2/Kconfig     | 16 ----------------
 arch/arm/mach-picoxcell/Kconfig |  4 ----
 arch/arm/mach-prima2/Kconfig    |  4 ----
 arch/arm/mach-rockchip/Kconfig  |  2 --
 arch/arm/mach-shmobile/Kconfig  |  3 ---
 arch/arm/mach-socfpga/Kconfig   |  5 -----
 arch/arm/mach-spear/Kconfig     |  8 --------
 arch/arm/mach-sunxi/Kconfig     |  4 ----
 arch/arm/mach-tegra/Kconfig     |  6 ------
 arch/arm/mach-u300/Kconfig      |  6 ------
 arch/arm/mach-ux500/Kconfig     |  3 ---
 arch/arm/mach-vexpress/Kconfig  |  3 ---
 arch/arm/mach-virt/Kconfig      |  4 ----
 arch/arm/mach-vt8500/Kconfig    |  4 ----
 arch/arm/mach-zynq/Kconfig      |  5 -----
 26 files changed, 2 insertions(+), 127 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index c1f1a7e..d871bdd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -302,9 +302,11 @@ choice
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
 	depends on MMU
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
 	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 9fe6d88..6a58980 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -16,12 +16,7 @@ config ARCH_BCM_MOBILE
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
-	select CPU_V7
-	select CLKSRC_OF
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_TIME
 	select GPIO_BCM_KONA
-	select SPARSE_IRQ
 	select TICK_ONESHOT
 	select CACHE_L2X0
 	select HAVE_ARM_ARCH_TIMER
diff --git a/arch/arm/mach-bcm2835/Kconfig b/arch/arm/mach-bcm2835/Kconfig
index 560045ca..acea0d8 100644
--- a/arch/arm/mach-bcm2835/Kconfig
+++ b/arch/arm/mach-bcm2835/Kconfig
@@ -4,10 +4,6 @@ config ARCH_BCM2835
 	select ARM_AMBA
 	select ARM_ERRATA_411920
 	select ARM_TIMER_SP804
-	select CLKDEV_LOOKUP
-	select CLKSRC_OF
-	select CPU_V6
-	select GENERIC_CLOCKEVENTS
 	select PINCTRL
 	select PINCTRL_BCM2835
 	help
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index dbf0df8..e346688 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -2,7 +2,6 @@ config ARCH_CNS3XXX
 	bool "Cavium Networks CNS3XXX family" if ARCH_MULTI_V6
 	select ARM_GIC
 	select CPU_V6K
-	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_CACHE_L2X0
 	select MIGHT_HAVE_PCI
 	select PCI_DOMAINS if PCI
diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
index 0aded64..59274a7 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -5,7 +5,6 @@ config ARCH_HIGHBANK
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_HAS_OPP
 	select ARCH_SUPPORTS_BIG_ENDIAN
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
@@ -14,14 +13,9 @@ config ARCH_HIGHBANK
 	select ARM_PSCI
 	select ARM_TIMER_SP804
 	select CACHE_L2X0
-	select COMMON_CLK
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select MAILBOX
 	select PL320_MBOX
-	select SPARSE_IRQ
-	select USE_OF
 	select ZONE_DMA if ARM_LPAE
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 7a6e6f7..5052c18 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -2,18 +2,11 @@ config ARCH_MXC
 	bool "Freescale i.MX family" if ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_CPU_SUSPEND if PM
-	select ARM_PATCH_PHYS_VIRT
-	select AUTO_ZRELADDR if !ZBOOT_ROM
 	select CLKSRC_MMIO
-	select COMMON_CLK
 	select GENERIC_ALLOCATOR
-	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
-	select MULTI_IRQ_HANDLER
 	select SOC_BUS
-	select SPARSE_IRQ
-	select USE_OF
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
@@ -139,7 +132,6 @@ config SOC_IMX5
 	select ARCH_HAS_CPUFREQ
 	select ARCH_HAS_OPP
 	select ARCH_MXC_IOMUX_V3
-	select CPU_V7
 	select MXC_TZIC
 
 config	SOC_IMX51
@@ -785,7 +777,6 @@ config SOC_IMX6Q
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
 	select ARM_GIC
-	select CPU_V7
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_IMX_ANATOP
@@ -811,7 +802,6 @@ config SOC_IMX6SL
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 	select ARM_GIC
-	select CPU_V7
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_GPC
 	select HAVE_IMX_MMDC
@@ -828,9 +818,7 @@ config SOC_IMX6SL
 
 config SOC_VF610
 	bool "Vybrid Family VF610 support"
-	select CPU_V7
 	select ARM_GIC
-	select CLKSRC_OF
 	select PINCTRL
 	select PINCTRL_VF610
 	select VF_PIT_TIMER
diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index f20c53e..ea35853 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -1,13 +1,10 @@
 config ARCH_KEYSTONE
 	bool "Texas Instruments Keystone Devices"
 	depends on ARCH_MULTI_V7
-	select CPU_V7
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	select HAVE_SMP
 	select CLKSRC_MMIO
-	select GENERIC_CLOCKEVENTS
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_ERRATA_798181 if SMP
 	select COMMON_CLK_KEYSTONE
 	select TI_EDMA
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 5e269d7..d581e84 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -2,15 +2,10 @@ config ARCH_MVEBU
 	bool "Marvell SOCs with Device Tree support" if ARCH_MULTI_V7
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CLKSRC_MMIO
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
-	select MULTI_IRQ_HANDLER
 	select PINCTRL
 	select PLAT_ORION
-	select SPARSE_IRQ
-	select CLKDEV_LOOKUP
 	select MVEBU_MBUS
 	select ZONE_DMA if ARM_LPAE
 	select ARCH_REQUIRE_GPIOLIB
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 8cde9e0..8479413 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -16,11 +16,7 @@ config ARCH_MXS
 	bool "Freescale MXS (i.MX23, i.MX28) support"
 	depends on ARCH_MULTI_V5
 	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
-	select CLKSRC_OF
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK_PREPARE
 	select PINCTRL
 	select SOC_BUS
 	select SOC_IMX23
diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 4d42da4..486d301 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -6,16 +6,11 @@ config ARCH_NOMADIK
 	select ARM_VIC
 	select CLKSRC_NOMADIK_MTU
 	select CLKSRC_NOMADIK_MTU_SCHED_CLOCK
-	select CLKSRC_OF
-	select COMMON_CLK
 	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_NOMADIK
 	select PINCTRL_STN8815
-	select SPARSE_IRQ
-	select USE_OF
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
index 59d8f0a..bc41f26 100644
--- a/arch/arm/mach-nspire/Kconfig
+++ b/arch/arm/mach-nspire/Kconfig
@@ -3,14 +3,9 @@ config ARCH_NSPIRE
 	depends on ARCH_MULTI_V4_V5
 	depends on MMU
 	select CPU_ARM926T
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
-	select SPARSE_IRQ
 	select ARM_AMBA
 	select ARM_VIC
 	select ARM_TIMER_SP804
-	select USE_OF
-	select CLKSRC_OF
 	help
 	  This enables support for systems using the TI-NSPIRE CPU
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index dc21df1..c128792 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -5,8 +5,6 @@ config ARCH_OMAP2
 	bool "TI OMAP2"
 	depends on ARCH_MULTI_V6
 	select ARCH_OMAP2PLUS
-	select CPU_V6
-	select MULTI_IRQ_HANDLER
 	select SOC_HAS_OMAP2_SDRC
 
 config ARCH_OMAP3
@@ -15,8 +13,6 @@ config ARCH_OMAP3
 	select ARCH_OMAP2PLUS
 	select ARCH_HAS_OPP
 	select ARM_CPU_SUSPEND if PM
-	select CPU_V7
-	select MULTI_IRQ_HANDLER
 	select OMAP_INTERCONNECT
 	select PM_OPP if PM
 	select PM_RUNTIME if CPU_IDLE
@@ -33,7 +29,6 @@ config ARCH_OMAP4
 	select ARM_ERRATA_720789
 	select ARM_GIC
 	select CACHE_L2X0
-	select CPU_V7
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
@@ -52,7 +47,6 @@ config SOC_OMAP5
 	select ARCH_OMAP2PLUS
 	select ARM_CPU_SUSPEND if PM
 	select ARM_GIC
-	select CPU_V7
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_SMP
@@ -64,15 +58,11 @@ config SOC_AM33XX
 	depends on ARCH_MULTI_V7
 	select ARCH_OMAP2PLUS
 	select ARM_CPU_SUSPEND if PM
-	select CPU_V7
-	select MULTI_IRQ_HANDLER
 
 config SOC_AM43XX
 	bool "TI AM43x"
 	depends on ARCH_MULTI_V7
-	select CPU_V7
 	select ARCH_OMAP2PLUS
-	select MULTI_IRQ_HANDLER
 	select ARM_GIC
 	select MACH_OMAP_GENERIC
 
@@ -84,17 +74,13 @@ config ARCH_OMAP2PLUS
 	select ARCH_OMAP
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select MACH_OMAP_GENERIC
 	select OMAP_DM_TIMER
 	select PINCTRL
 	select PROC_DEVICETREE if PROC_FS
 	select SOC_BUS
-	select SPARSE_IRQ
 	select TI_PRIV_EDMA
-	select USE_OF
 	help
 	  Systems based on OMAP2, OMAP3, OMAP4 or OMAP5
 
@@ -131,10 +117,8 @@ config SOC_HAS_REALTIME_COUNTER
 config SOC_DRA7XX
 	bool "TI DRA7XX"
 	select ARM_ARCH_TIMER
-	select CPU_V7
 	select ARM_GIC
 	select HAVE_SMP
-	select COMMON_CLK
 
 comment "OMAP Core Type"
 	depends on ARCH_OMAP2
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
index b1022f4..c88ff74 100644
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -1,12 +1,8 @@
 config ARCH_PICOXCELL
 	bool "Picochip PicoXcell" if ARCH_MULTI_V6
 	select ARCH_REQUIRE_GPIOLIB
-	select ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
 	select CPU_V6K
 	select DW_APB_TIMER_OF
-	select GENERIC_CLOCKEVENTS
 	select HAVE_TCM
 	select NO_IOPORT
-	select SPARSE_IRQ
-	select USE_OF
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 6988b11..16c2d90 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -1,7 +1,6 @@
 config ARCH_SIRF
 	bool "CSR SiRF" if ARCH_MULTI_V7
 	select ARCH_REQUIRE_GPIOLIB
-	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select MIGHT_HAVE_CACHE_L2X0
 	select NO_IOPORT
@@ -17,7 +16,6 @@ menu "CSR SiRF atlas6/primaII/Marco/Polo Specific Features"
 config ARCH_ATLAS6
 	bool "CSR SiRFSoC ATLAS6 ARM Cortex A9 Platform"
 	default y
-	select CPU_V7
 	select SIRF_IRQ
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
@@ -25,7 +23,6 @@ config ARCH_ATLAS6
 config ARCH_PRIMA2
 	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
 	default y
-	select CPU_V7
 	select SIRF_IRQ
 	select ZONE_DMA
 	help
@@ -35,7 +32,6 @@ config ARCH_MARCO
 	bool "CSR SiRFSoC MARCO ARM Cortex A9 Platform"
 	default y
 	select ARM_GIC
-	select CPU_V7
 	select HAVE_ARM_SCU if SMP
 	select HAVE_SMP
 	select SMP_ON_UP if SMP
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index cf073de..2a695bc 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -7,8 +7,6 @@ config ARCH_ROCKCHIP
 	select CACHE_L2X0
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
 	select DW_APB_TIMER_OF
 	select ARM_GLOBAL_TIMER
 	select CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index a4a4b75..de75560 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,8 +1,6 @@
 config ARCH_SHMOBILE_MULTI
 	bool "SH-Mobile Series" if ARCH_MULTI_V7
 	depends on MMU
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if LOCAL_TIMERS
 	select HAVE_SMP
@@ -11,7 +9,6 @@ config ARCH_SHMOBILE_MULTI
 	select NO_IOPORT
 	select PINCTRL
 	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
 
 if ARCH_SHMOBILE_MULTI
 
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 037100a..57e11cd 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -4,13 +4,8 @@ config ARCH_SOCFPGA
 	select ARM_AMBA
 	select ARM_GIC
 	select CACHE_L2X0
-	select COMMON_CLK
-	select CPU_V7
 	select DW_APB_TIMER_OF
-	select GENERIC_CLOCKEVENTS
 	select GPIO_PL061 if GPIOLIB
 	select HAVE_ARM_SCU
 	select HAVE_SMP
 	select MFD_SYSCON
-	select SPARSE_IRQ
-	select USE_OF
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index ac1710e6..a7a28ea 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -8,8 +8,6 @@ menuconfig PLAT_SPEAR
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select CLKSRC_MMIO
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
 
 if PLAT_SPEAR
 
@@ -18,14 +16,12 @@ config ARCH_SPEAR13XX
 	depends on ARCH_MULTI_V7 || PLAT_SPEAR_SINGLE
 	select ARCH_HAS_CPUFREQ
 	select ARM_GIC
-	select CPU_V7
 	select GPIO_SPEAR_SPICS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
-	select USE_OF
 	help
 	  Supports for ARM's SPEAR13XX family
 
@@ -50,9 +46,7 @@ config ARCH_SPEAR3XX
 	depends on ARCH_MULTI_V5 || PLAT_SPEAR_SINGLE
 	depends on !ARCH_SPEAR13XX
 	select ARM_VIC
-	select CPU_ARM926T
 	select PINCTRL
-	select USE_OF
 	help
 	  Supports for ARM's SPEAR3XX family
 
@@ -83,14 +77,12 @@ config ARCH_SPEAR6XX
 	depends on ARCH_MULTI_V5 || PLAT_SPEAR_SINGLE
 	depends on !ARCH_SPEAR13XX
 	select ARM_VIC
-	select CPU_ARM926T
 	help
 	  Supports for ARM's SPEAR6XX family
 
 config MACH_SPEAR600
 	def_bool y
 	depends on ARCH_SPEAR6XX
-	select USE_OF
 	help
 	  Supports ST SPEAr600 boards configured via the device-treesource "arch/arm/mach-spear6xx/Kconfig"
 
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index c9e72c8..ade43c9 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -3,12 +3,8 @@ config ARCH_SUNXI
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select CLKSRC_MMIO
-	select CLKSRC_OF
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
 	select HAVE_SMP
 	select PINCTRL
 	select PINCTRL_SUNXI
-	select SPARSE_IRQ
 	select SUN4I_TIMER
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 09e740f..8f97cf0 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -4,10 +4,6 @@ config ARCH_TEGRA
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select CLKSRC_MMIO
-	select CLKSRC_OF
-	select COMMON_CLK
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
@@ -15,11 +11,9 @@ config ARCH_TEGRA
 	select MIGHT_HAVE_PCI
 	select PINCTRL
 	select SOC_BUS
-	select SPARSE_IRQ
 	select USB_ARCH_HAS_EHCI if USB_SUPPORT
 	select USB_ULPI if USB_PHY
 	select USB_ULPI_VIEWPORT if USB_PHY
-	select USE_OF
 	help
 	  This enables support for NVIDIA Tegra based systems.
 
diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 8e23071..e3a96d7 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -3,20 +3,14 @@ config ARCH_U300
 	depends on MMU
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
-	select ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
 	select CLKSRC_MMIO
-	select CLKSRC_OF
-	select COMMON_CLK
 	select CPU_ARM926T
-	select GENERIC_CLOCKEVENTS
 	select HAVE_TCM
 	select PINCTRL
 	select PINCTRL_COH901
 	select PINCTRL_U300
-	select SPARSE_IRQ
 	select MFD_SYSCON
-	select USE_OF
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
 
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 0034d2c..5292f7b 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -11,9 +11,6 @@ config ARCH_U8500
 	select ARM_GIC
 	select CACHE_L2X0
 	select CLKSRC_NOMADIK_MTU
-	select COMMON_CLK
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_SMP
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 4a70be4..fa29222 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -5,10 +5,7 @@ config ARCH_VEXPRESS
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
-	select COMMON_CLK
 	select COMMON_CLK_VERSATILE
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_PATA_PLATFORM
diff --git a/arch/arm/mach-virt/Kconfig b/arch/arm/mach-virt/Kconfig
index 081d469..eaad072 100644
--- a/arch/arm/mach-virt/Kconfig
+++ b/arch/arm/mach-virt/Kconfig
@@ -1,10 +1,6 @@
 config ARCH_VIRT
 	bool "Dummy Virtual Machine" if ARCH_MULTI_V7
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	select ARM_PSCI
 	select HAVE_SMP
-	select CPU_V7
-	select SPARSE_IRQ
-	select USE_OF
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index 927be93..08f56a4 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -3,8 +3,6 @@ config ARCH_VT8500
 	select ARCH_HAS_CPUFREQ
 	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
-	select CLKSRC_OF
-	select GENERIC_CLOCKEVENTS
 	select VT8500_TIMER
 	select PINCTRL
 	help
@@ -21,7 +19,6 @@ config ARCH_WM8750
 	bool "WonderMedia WM8750"
 	depends on ARCH_MULTI_V6
 	select ARCH_VT8500
-	select CPU_V6
 	help
 	  Support for WonderMedia WM8750 System-on-Chip.
 
@@ -29,6 +26,5 @@ config ARCH_WM8850
 	bool "WonderMedia WM8850"
 	depends on ARCH_MULTI_V7
 	select ARCH_VT8500
-	select CPU_V7
 	help
 	  Support for WonderMedia WM8850 System-on-Chip.
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
index 6b04260..85d1805 100644
--- a/arch/arm/mach-zynq/Kconfig
+++ b/arch/arm/mach-zynq/Kconfig
@@ -2,16 +2,11 @@ config ARCH_ZYNQ
 	bool "Xilinx Zynq ARM Cortex A9 Platform" if ARCH_MULTI_V7
 	select ARM_AMBA
 	select ARM_GIC
-	select COMMON_CLK
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ICST
 	select MIGHT_HAVE_CACHE_L2X0
-	select USE_OF
 	select HAVE_SMP
-	select SPARSE_IRQ
 	select CADENCE_TTC_TIMER
 	select ARM_GLOBAL_TIMER
 	help
-- 
1.8.3.2
