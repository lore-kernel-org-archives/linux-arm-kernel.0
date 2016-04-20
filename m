From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 20 Apr 2016 10:58:01 +0200
Subject: [PATCH 03/23] ARM: do away with ARCH_[WANT_OPTIONAL|REQUIRE]_GPIOLIB
In-Reply-To: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
References: <1461142701-21096-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <1461142701-21096-4-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This replaces:

- "select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB" as this can
  now be selected directly.

- "select ARCH_WANT_OPTIONAL_GPIOLIB" with no dependency: GPIOLIB
  is now selectable by everyone, so we need not declare our
  intent to select it.

When ordering the symbols the following rationale was used:
if the selects were in alphabetical order, I moved select GPIOLIB
to be in alphabetical order, but if the selects were not
maintained in alphabetical order, I just replaced
"select ARCH_REQUIRE_GPIOLIB" with "select GPIOLIB".

Cc: Michael B?sch <m@bues.ch>
Cc: arm at kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Various arch maintainers:

either ACK this and I will merge it into the GPIO tree for v4.7
anticipating no clashes, or you wait until I have the enabling patch
upstream (patch 1 in this series, removing deps on
ARCH_[WANTS_OPTIONAL|REQUIRES]_GPIOLIB), and you will be able to
merge it to your arch trees yourselves for late v4.7
(post GPIO tree merge) or for v4.8.

You can also ask me for an immutable branch if you prefer that, I
will put the enabling patch on a branch and the patch for your arch
on top and ask you to pull it.

Select your option from the menu, silence probably means I will
merge it to the GPIO tree. Unless you are X86 or ARM in which case
I will be cautious.
---
 arch/arm/Kconfig                 | 34 ++++++++++++++++------------------
 arch/arm/mach-at91/Kconfig       |  2 +-
 arch/arm/mach-bcm/Kconfig        |  7 +++----
 arch/arm/mach-berlin/Kconfig     |  2 +-
 arch/arm/mach-digicolor/Kconfig  |  2 +-
 arch/arm/mach-exynos/Kconfig     |  2 +-
 arch/arm/mach-imx/Kconfig        |  2 +-
 arch/arm/mach-integrator/Kconfig |  4 ++--
 arch/arm/mach-meson/Kconfig      |  2 +-
 arch/arm/mach-mmp/Kconfig        |  2 +-
 arch/arm/mach-moxart/Kconfig     |  2 +-
 arch/arm/mach-mv78xx0/Kconfig    |  2 +-
 arch/arm/mach-mvebu/Kconfig      |  4 ++--
 arch/arm/mach-mxs/Kconfig        |  2 +-
 arch/arm/mach-nomadik/Kconfig    |  2 +-
 arch/arm/mach-omap2/Kconfig      |  2 +-
 arch/arm/mach-orion5x/Kconfig    |  2 +-
 arch/arm/mach-picoxcell/Kconfig  |  2 +-
 arch/arm/mach-prima2/Kconfig     |  2 +-
 arch/arm/mach-rockchip/Kconfig   |  2 +-
 arch/arm/mach-s3c24xx/Kconfig    |  2 +-
 arch/arm/mach-s3c64xx/Kconfig    |  2 +-
 arch/arm/mach-s5pv210/Kconfig    |  2 +-
 arch/arm/mach-shmobile/Kconfig   |  2 +-
 arch/arm/mach-spear/Kconfig      |  2 +-
 arch/arm/mach-sti/Kconfig        |  2 +-
 arch/arm/mach-sunxi/Kconfig      |  2 +-
 arch/arm/mach-tegra/Kconfig      |  2 +-
 arch/arm/mach-u300/Kconfig       |  2 +-
 arch/arm/mach-ux500/Kconfig      |  2 +-
 arch/arm/mach-vexpress/Kconfig   |  2 +-
 arch/arm/mach-vt8500/Kconfig     |  2 +-
 32 files changed, 51 insertions(+), 54 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cdfa6c2b7626..d752ac68741d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -325,7 +325,6 @@ choice
 config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
 	depends on MMU
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_HAS_SG_CHAIN
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
@@ -340,7 +339,6 @@ config ARCH_MULTIPLATFORM
 config ARM_SINGLE_ARMV7M
 	bool "ARMv7-M based platforms (Cortex-M0/M3/M4)"
 	depends on !MMU
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_NVIC
 	select AUTO_ZRELADDR
 	select CLKSRC_OF
@@ -354,12 +352,12 @@ config ARM_SINGLE_ARMV7M
 
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
-	select ARCH_REQUIRE_GPIOLIB
 	select AUTO_ZRELADDR
 	select CLKSRC_MMIO
 	select COMMON_CLK
 	select CPU_ARM720T
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	select MFD_SYSCON
 	select SOC_BUS
 	help
@@ -367,10 +365,10 @@ config ARCH_CLPS711X
 
 config ARCH_GEMINI
 	bool "Cortina Systems Gemini"
-	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select CPU_FA526
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
@@ -391,7 +389,6 @@ config ARCH_EBSA110
 config ARCH_EP93XX
 	bool "EP93xx-based"
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
@@ -400,6 +397,7 @@ config ARCH_EP93XX
 	select CLKSRC_MMIO
 	select CPU_ARM920T
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
@@ -440,9 +438,9 @@ config ARCH_IOP13XX
 config ARCH_IOP32X
 	bool "IOP32x-based"
 	depends on MMU
-	select ARCH_REQUIRE_GPIOLIB
 	select CPU_XSCALE
 	select GPIO_IOP
+	select GPIOLIB
 	select NEED_RET_TO_USER
 	select PCI
 	select PLAT_IOP
@@ -453,9 +451,9 @@ config ARCH_IOP32X
 config ARCH_IOP33X
 	bool "IOP33x-based"
 	depends on MMU
-	select ARCH_REQUIRE_GPIOLIB
 	select CPU_XSCALE
 	select GPIO_IOP
+	select GPIOLIB
 	select NEED_RET_TO_USER
 	select PCI
 	select PLAT_IOP
@@ -466,12 +464,12 @@ config ARCH_IXP4XX
 	bool "IXP4xx-based"
 	depends on MMU
 	select ARCH_HAS_DMA_SET_COHERENT_MASK
-	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CLKSRC_MMIO
 	select CPU_XSCALE
 	select DMABOUNCE if PCI
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	select MIGHT_HAVE_PCI
 	select NEED_MACH_IO_H
 	select USB_EHCI_BIG_ENDIAN_DESC
@@ -481,9 +479,9 @@ config ARCH_IXP4XX
 
 config ARCH_DOVE
 	bool "Marvell Dove"
-	select ARCH_REQUIRE_GPIOLIB
 	select CPU_PJ4
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	select MIGHT_HAVE_PCI
 	select MULTI_IRQ_HANDLER
 	select MVEBU_MBUS
@@ -497,10 +495,10 @@ config ARCH_DOVE
 
 config ARCH_KS8695
 	bool "Micrel/Kendin KS8695"
-	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select CPU_ARM922T
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	select NEED_MACH_MEMORY_H
 	help
 	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
@@ -508,11 +506,11 @@ config ARCH_KS8695
 
 config ARCH_W90X900
 	bool "Nuvoton W90X900 CPU"
-	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	help
 	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
 	  At present, the w90x900 has been renamed nuc900, regarding
@@ -524,13 +522,13 @@ config ARCH_W90X900
 
 config ARCH_LPC32XX
 	bool "NXP LPC32XX"
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select CLKDEV_LOOKUP
 	select CLKSRC_LPC32XX
 	select COMMON_CLK
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	select USE_OF
 	help
 	  Support for the NXP LPC32XX family of processors
@@ -539,7 +537,6 @@ config ARCH_PXA
 	bool "PXA2xx/PXA3xx-based"
 	depends on MMU
 	select ARCH_MTD_XIP
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_CPU_SUSPEND if PM
 	select AUTO_ZRELADDR
 	select COMMON_CLK
@@ -550,6 +547,7 @@ config ARCH_PXA
 	select CPU_XSCALE if !CPU_XSC3
 	select GENERIC_CLOCKEVENTS
 	select GPIO_PXA
+	select GPIOLIB
 	select HAVE_IDE
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
@@ -580,7 +578,6 @@ config ARCH_RPC
 config ARCH_SA1100
 	bool "SA1100-based"
 	select ARCH_MTD_XIP
-	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SPARSEMEM_ENABLE
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
@@ -589,6 +586,7 @@ config ARCH_SA1100
 	select CPU_FREQ
 	select CPU_SA1100
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	select HAVE_IDE
 	select IRQ_DOMAIN
 	select ISA
@@ -600,12 +598,12 @@ config ARCH_SA1100
 
 config ARCH_S3C24XX
 	bool "Samsung S3C24XX SoCs"
-	select ARCH_REQUIRE_GPIOLIB
 	select ATAGS
 	select CLKDEV_LOOKUP
 	select CLKSRC_SAMSUNG_PWM
 	select GENERIC_CLOCKEVENTS
 	select GPIO_SAMSUNG
+	select GPIOLIB
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
@@ -621,12 +619,12 @@ config ARCH_S3C24XX
 config ARCH_DAVINCI
 	bool "TI DaVinci"
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CPU_ARM926T
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select GPIOLIB
 	select HAVE_IDE
 	select USE_OF
 	select ZONE_DMA
@@ -638,11 +636,11 @@ config ARCH_OMAP1
 	depends on MMU
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_OMAP
-	select ARCH_REQUIRE_GPIOLIB
 	select CLKDEV_LOOKUP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select GPIOLIB
 	select HAVE_IDE
 	select IRQ_DOMAIN
 	select MULTI_IRQ_HANDLER
@@ -860,7 +858,7 @@ source "arch/arm/mach-zynq/Kconfig"
 config ARCH_EFM32
 	bool "Energy Micro efm32"
 	depends on ARM_SINGLE_ARMV7M
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	help
 	  Support for Energy Micro's (now Silicon Labs) efm32 Giant Gecko
 	  processors.
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 08047afdf38e..5204395efda8 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,8 +1,8 @@
 menuconfig ARCH_AT91
 	bool "Atmel SoCs"
 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7
-	select ARCH_REQUIRE_GPIOLIB
 	select COMMON_CLK_AT91
+	select GPIOLIB
 	select PINCTRL
 	select SOC_BUS
 
diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index 7ef121472cdd..43fd72727173 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -17,7 +17,7 @@ config ARCH_BCM_IPROC
 	select ARM_GLOBAL_TIMER
 	select COMMON_CLK_IPROC
 	select CLKSRC_MMIO
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select ARM_AMBA
 	select PINCTRL
 	help
@@ -80,7 +80,7 @@ comment "KONA architected SoCs"
 
 config ARCH_BCM_MOBILE
 	bool
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_775420
 	select ARM_GIC
@@ -137,7 +137,7 @@ comment "Other Architectures"
 config ARCH_BCM2835
 	bool "Broadcom BCM2835 family"
 	depends on ARCH_MULTI_V6 || ARCH_MULTI_V7
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select ARM_AMBA
 	select ARM_ERRATA_411920 if ARCH_MULTI_V6
 	select ARM_TIMER_SP804
@@ -177,7 +177,6 @@ config ARCH_BRCMSTB
 	select BRCMSTB_L2_IRQ
 	select BCM7120_L2_IRQ
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
-	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select SOC_BRCMSTB
 	help
 	  Say Y if you intend to run the kernel on a Broadcom ARM-based STB
diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
index ffbfa0bd091b..63ab1d368625 100644
--- a/arch/arm/mach-berlin/Kconfig
+++ b/arch/arm/mach-berlin/Kconfig
@@ -2,11 +2,11 @@ menuconfig ARCH_BERLIN
 	bool "Marvell Berlin SoCs"
 	depends on ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_GIC
 	select DW_APB_ICTL
 	select DW_APB_TIMER_OF
 	select GENERIC_IRQ_CHIP
+	select GPIOLIB
 	select MFD_SYSCON
 	select PINCTRL
 
diff --git a/arch/arm/mach-digicolor/Kconfig b/arch/arm/mach-digicolor/Kconfig
index fc65b0f1db48..9d05c6c4181d 100644
--- a/arch/arm/mach-digicolor/Kconfig
+++ b/arch/arm/mach-digicolor/Kconfig
@@ -1,10 +1,10 @@
 config ARCH_DIGICOLOR
 	bool "Conexant Digicolor SoC Support"
 	depends on ARCH_MULTI_V7
-	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select DIGICOLOR_TIMER
 	select GENERIC_IRQ_CHIP
+	select GPIOLIB
 	select MFD_SYSCON
 	select PINCTRL
 	select PINCTRL_DIGICOLOR
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 207fa2c737a6..80d57e5dfd2b 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -12,12 +12,12 @@ menuconfig ARCH_EXYNOS
 	depends on ARCH_MULTI_V7
 	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
 	select COMMON_CLK_SAMSUNG
 	select EXYNOS_THERMAL
 	select EXYNOS_PMU
+	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 8973fae25436..879bc59545f6 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -1,10 +1,10 @@
 menuconfig ARCH_MXC
 	bool "Freescale i.MX family"
 	depends on ARCH_MULTI_V4_V5 || ARCH_MULTI_V6_V7 || ARM_SINGLE_ARMV7M
-	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select CLKSRC_IMX_GPT
 	select GENERIC_IRQ_CHIP
+	select GPIOLIB
 	select PINCTRL
 	select PM_OPP if PM
 	select SOC_BUS
diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index b2a85ba13f08..bc764a89615e 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -32,9 +32,9 @@ config ARCH_INTEGRATOR_AP
 config INTEGRATOR_IMPD1
 	bool "Include support for Integrator/IM-PD1"
 	depends on ARCH_INTEGRATOR_AP
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_VIC
-	select GPIO_PL061 if GPIOLIB
+	select GPIO_PL061
+	select GPIOLIB
 	help
 	  The IM-PD1 is an add-on logic module for the Integrator which
 	  allows ARM(R) Ltd PrimeCells to be developed and evaluated.
diff --git a/arch/arm/mach-meson/Kconfig b/arch/arm/mach-meson/Kconfig
index 31bdd91098b6..fbce42d7390f 100644
--- a/arch/arm/mach-meson/Kconfig
+++ b/arch/arm/mach-meson/Kconfig
@@ -1,7 +1,7 @@
 menuconfig ARCH_MESON
 	bool "Amlogic Meson SoCs"
 	depends on ARCH_MULTI_V7
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select GENERIC_IRQ_CHIP
 	select ARM_GIC
 	select CACHE_L2X0
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 01c57d369462..94500bed56ab 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -1,8 +1,8 @@
 menuconfig ARCH_MMP
 	bool "Marvell PXA168/910/MMP2"
 	depends on ARCH_MULTI_V5 || ARCH_MULTI_V7
-	select ARCH_REQUIRE_GPIOLIB
 	select GPIO_PXA
+	select GPIOLIB
 	select PINCTRL
 	select PLAT_PXA
 	help
diff --git a/arch/arm/mach-moxart/Kconfig b/arch/arm/mach-moxart/Kconfig
index 180d9d216719..6eca2363b81a 100644
--- a/arch/arm/mach-moxart/Kconfig
+++ b/arch/arm/mach-moxart/Kconfig
@@ -5,7 +5,7 @@ menuconfig ARCH_MOXART
 	select ARM_DMA_MEM_BUFFERABLE
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select PHYLIB if NETDEVICES
 	help
 	  Say Y here if you want to run your kernel on hardware with a
diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-mv78xx0/Kconfig
index c32f85559c65..81c0f08a2684 100644
--- a/arch/arm/mach-mv78xx0/Kconfig
+++ b/arch/arm/mach-mv78xx0/Kconfig
@@ -1,8 +1,8 @@
 menuconfig ARCH_MV78XX0
 	bool "Marvell MV78xx0"
 	depends on ARCH_MULTI_V5
-	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
+	select GPIOLIB
 	select MVEBU_MBUS
 	select PCI
 	select PLAT_ORION_LEGACY
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 348044ea650c..f9b6bd306cfe 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -8,7 +8,7 @@ menuconfig ARCH_MVEBU
 	select SOC_BUS
 	select MVEBU_MBUS
 	select ZONE_DMA if ARM_LPAE
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select PCI_QUIRKS if PCI
 	select OF_ADDRESS_PCI
 
@@ -119,8 +119,8 @@ config MACH_DOVE
 config MACH_KIRKWOOD
 	bool "Marvell Kirkwood boards"
 	depends on ARCH_MULTI_V5
-	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
+	select GPIOLIB
 	select KIRKWOOD_CLK
 	select MACH_MVEBU_ANY
 	select ORION_IRQCHIP
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 84794137b175..5d9e5fce7937 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -15,8 +15,8 @@ config SOC_IMX28
 config ARCH_MXS
 	bool "Freescale MXS (i.MX23, i.MX28) support"
 	depends on ARCH_MULTI_V5
-	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
+	select GPIOLIB
 	select PINCTRL
 	select SOC_BUS
 	select SOC_IMX23
diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 3c61096c8627..b7e9801fdaa4 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -1,12 +1,12 @@
 menuconfig ARCH_NOMADIK
 	bool "ST-Ericsson Nomadik"
 	depends on ARCH_MULTI_V5
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKSRC_NOMADIK_MTU
 	select CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 	select CPU_ARM926T
+	select GPIOLIB
 	select MIGHT_HAVE_CACHE_L2X0
 	select PINCTRL
 	select PINCTRL_NOMADIK
diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 0517f0c1581a..b5d3c4c75626 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -88,9 +88,9 @@ config ARCH_OMAP2PLUS
 	select ARCH_HAS_BANDGAP
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_OMAP
-	select ARCH_REQUIRE_GPIOLIB
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
+	select GPIOLIB
 	select MACH_OMAP_GENERIC
 	select MEMORY
 	select MFD_SYSCON
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index a2af15822fcb..89bb0fc796bd 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -1,9 +1,9 @@
 menuconfig ARCH_ORION5X
 	bool "Marvell Orion"
 	depends on MMU && ARCH_MULTI_V5
-	select ARCH_REQUIRE_GPIOLIB
 	select CPU_FEROCEON
 	select GENERIC_CLOCKEVENTS
+	select GPIOLIB
 	select MVEBU_MBUS
 	select PCI
 	select PLAT_ORION_LEGACY
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
index aef92ba0eacd..1c8f701526c9 100644
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -1,8 +1,8 @@
 config ARCH_PICOXCELL
 	bool "Picochip PicoXcell"
 	depends on ARCH_MULTI_V6
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_VIC
 	select DW_APB_TIMER_OF
+	select GPIOLIB
 	select HAVE_TCM
 	select NO_IOPORT_MAP
diff --git a/arch/arm/mach-prima2/Kconfig b/arch/arm/mach-prima2/Kconfig
index 0cf4426183cf..3c4717c4b16b 100644
--- a/arch/arm/mach-prima2/Kconfig
+++ b/arch/arm/mach-prima2/Kconfig
@@ -3,8 +3,8 @@ menuconfig ARCH_SIRF
 	depends on ARCH_MULTI_V7
 	select ARCH_HAS_RESET_CONTROLLER
 	select RESET_CONTROLLER
-	select ARCH_REQUIRE_GPIOLIB
 	select GENERIC_IRQ_CHIP
+	select GPIOLIB
 	select NO_IOPORT_MAP
 	select REGMAP
 	select PINCTRL
diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index cef42fd886d1..9ad84cd01ba0 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -4,10 +4,10 @@ config ARCH_ROCKCHIP
 	select PINCTRL
 	select PINCTRL_ROCKCHIP
 	select ARCH_HAS_RESET_CONTROLLER
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
 	select CACHE_L2X0
+	select GPIOLIB
 	select HAVE_ARM_ARCH_TIMER
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index b91aee406c74..4b1690acb6a5 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -11,7 +11,7 @@ if ARCH_S3C24XX
 
 config PLAT_S3C24XX
 	def_bool y
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select NO_IOPORT_MAP
 	select S3C_DEV_NAND
 	select IRQ_DOMAIN
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index e5c1888fc67b..459214fa20b4 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -5,12 +5,12 @@
 menuconfig ARCH_S3C64XX
 	bool "Samsung S3C64XX"
 	depends on ARCH_MULTI_V6
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKSRC_SAMSUNG_PWM
 	select COMMON_CLK_SAMSUNG
 	select GPIO_SAMSUNG if ATAGS
+	select GPIOLIB
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_TCM
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 13bc9820ff22..4cec11cf5e6f 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -11,10 +11,10 @@ config ARCH_S5PV210
 	bool "Samsung S5PV210/S5PC110"
 	depends on ARCH_MULTI_V7
 	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_VIC
 	select CLKSRC_SAMSUNG_PWM
 	select COMMON_CLK_SAMSUNG
+	select GPIOLIB
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select HAVE_S3C_RTC if RTC_CLASS
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index f2bc5c353119..eabbe83b93b8 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -44,7 +44,7 @@ menuconfig ARCH_RENESAS
 	select ARCH_DMA_ADDR_T_64BIT if ARM_LPAE
 	select NO_IOPORT_MAP
 	select PINCTRL
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select ZONE_DMA if ARM_LPAE
 
 if ARCH_RENESAS
diff --git a/arch/arm/mach-spear/Kconfig b/arch/arm/mach-spear/Kconfig
index ea9ea95630bd..b7260c2b510c 100644
--- a/arch/arm/mach-spear/Kconfig
+++ b/arch/arm/mach-spear/Kconfig
@@ -5,9 +5,9 @@
 menuconfig PLAT_SPEAR
 	bool "ST SPEAr Family"
 	depends on ARCH_MULTI_V7 || ARCH_MULTI_V5
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select CLKSRC_MMIO
+	select GPIOLIB
 
 if PLAT_SPEAR
 
diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index a196d14f65f5..785aa3c093fc 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -10,7 +10,7 @@ menuconfig ARCH_STI
 	select MFD_SYSCON
 	select ARCH_HAS_RESET_CONTROLLER
 	select HAVE_ARM_SCU if SMP
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_ERRATA_775420
diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index c124d658b350..096ed216c6d5 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1,10 +1,10 @@
 menuconfig ARCH_SUNXI
 	bool "Allwinner SoCs"
 	depends on ARCH_MULTI_V7
-	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_HAS_RESET_CONTROLLER
 	select CLKSRC_MMIO
 	select GENERIC_IRQ_CHIP
+	select GPIOLIB
 	select PINCTRL
 	select SUN4I_TIMER
 	select RESET_CONTROLLER
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 0fa8b84ed657..329f01c5b6f8 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -1,11 +1,11 @@
 menuconfig ARCH_TEGRA
 	bool "NVIDIA Tegra"
 	depends on ARCH_MULTI_V7
-	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_TRUSTED_FOUNDATIONS
 	select ARM_AMBA
 	select ARM_GIC
 	select CLKSRC_MMIO
+	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 301a98498453..56e0ef680b79 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -1,11 +1,11 @@
 menuconfig ARCH_U300
 	bool "ST-Ericsson U300 Series"
 	depends on ARCH_MULTI_V5 && MMU
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_VIC
 	select CLKSRC_MMIO
 	select CPU_ARM926T
+	select GPIOLIB
 	select HAVE_TCM
 	select PINCTRL
 	select PINCTRL_COH901
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index 3185081bdb2c..4740ac393297 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -3,13 +3,13 @@ menuconfig ARCH_U8500
 	depends on ARCH_MULTI_V7 && MMU
 	select AB8500_CORE
 	select ABX500_CORE
-	select ARCH_REQUIRE_GPIOLIB
 	select ARM_AMBA
 	select ARM_ERRATA_754322
 	select ARM_ERRATA_764369 if SMP
 	select ARM_GIC
 	select CACHE_L2X0
 	select CLKSRC_NOMADIK_MTU
+	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select PINCTRL
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 398a297b7e09..7c728ebc0b33 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,13 +1,13 @@
 menuconfig ARCH_VEXPRESS
 	bool "ARM Ltd. Versatile Express family"
 	depends on ARCH_MULTI_V7
-	select ARCH_REQUIRE_GPIOLIB
 	select ARCH_SUPPORTS_BIG_ENDIAN
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_GLOBAL_TIMER
 	select ARM_TIMER_SP804
 	select COMMON_CLK_VERSATILE
+	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select HAVE_PATA_PLATFORM
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index aaaa24fe4d71..c4f1dba7bd8a 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -1,6 +1,6 @@
 config ARCH_VT8500
 	bool
-	select ARCH_REQUIRE_GPIOLIB
+	select GPIOLIB
 	select CLKDEV_LOOKUP
 	select VT8500_TIMER
 	select PINCTRL
-- 
2.4.11
