From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:49:55 -0500
Subject: [PATCH 1/6] ARM: move ARCH config definitions into mach dirs
In-Reply-To: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346280600-29395-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation for mulit-platform support, convert all platforms' ARCH_
definition to a hidden option and create a new choice option.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig                 |  650 ++++++++------------------------------
 arch/arm/mach-at91/Kconfig       |    8 +
 arch/arm/mach-bcmring/Kconfig    |    9 +
 arch/arm/mach-clps711x/Kconfig   |    6 +
 arch/arm/mach-cns3xxx/Kconfig    |    9 +
 arch/arm/mach-davinci/Kconfig    |   12 +
 arch/arm/mach-dove/Kconfig       |    9 +
 arch/arm/mach-ebsa110/Kconfig    |    9 +
 arch/arm/mach-ep93xx/Kconfig     |   11 +
 arch/arm/mach-exynos/Kconfig     |   16 +
 arch/arm/mach-footbridge/Kconfig |    9 +
 arch/arm/mach-gemini/Kconfig     |    6 +
 arch/arm/mach-h720x/Kconfig      |    6 +
 arch/arm/mach-highbank/Kconfig   |   15 +
 arch/arm/mach-integrator/Kconfig |   16 +
 arch/arm/mach-iop13xx/Kconfig    |   11 +
 arch/arm/mach-iop32x/Kconfig     |   10 +
 arch/arm/mach-iop33x/Kconfig     |   10 +
 arch/arm/mach-ixp4xx/Kconfig     |   11 +
 arch/arm/mach-kirkwood/Kconfig   |    9 +
 arch/arm/mach-ks8695/Kconfig     |    7 +
 arch/arm/mach-lpc32xx/Kconfig    |   12 +
 arch/arm/mach-mmp/Kconfig        |   12 +
 arch/arm/mach-msm/Kconfig        |    7 +
 arch/arm/mach-mv78xx0/Kconfig    |    9 +
 arch/arm/mach-mvebu/Kconfig      |   10 +
 arch/arm/mach-mxs/Kconfig        |   11 +
 arch/arm/mach-netx/Kconfig       |    7 +
 arch/arm/mach-nomadik/Kconfig    |   11 +
 arch/arm/mach-orion5x/Kconfig    |    9 +
 arch/arm/mach-picoxcell/Kconfig  |   14 +
 arch/arm/mach-pnx4008/Kconfig    |    5 +
 arch/arm/mach-pxa/Kconfig        |   16 +
 arch/arm/mach-realview/Kconfig   |   15 +
 arch/arm/mach-rpc/Kconfig        |   13 +
 arch/arm/mach-s3c24xx/Kconfig    |   13 +
 arch/arm/mach-s3c64xx/Kconfig    |   26 ++
 arch/arm/mach-s5p64x0/Kconfig    |   13 +
 arch/arm/mach-s5pc100/Kconfig    |   12 +
 arch/arm/mach-s5pv210/Kconfig    |   17 +
 arch/arm/mach-sa1100/Kconfig     |   17 +
 arch/arm/mach-shark/Kconfig      |   11 +
 arch/arm/mach-shmobile/Kconfig   |   14 +
 arch/arm/mach-socfpga/Kconfig    |   16 +
 arch/arm/mach-tegra/Kconfig      |   13 +
 arch/arm/mach-u300/Kconfig       |   14 +
 arch/arm/mach-ux500/Kconfig      |   11 +
 arch/arm/mach-versatile/Kconfig  |   16 +
 arch/arm/mach-vexpress/Kconfig   |   16 +
 arch/arm/mach-vt8500/Kconfig     |    8 +
 arch/arm/mach-w90x900/Kconfig    |    8 +
 arch/arm/mach-zynq/Kconfig       |   10 +
 arch/arm/plat-mxc/Kconfig        |   11 +
 arch/arm/plat-omap/Kconfig       |    9 +
 arch/arm/plat-spear/Kconfig      |    9 +
 55 files changed, 742 insertions(+), 522 deletions(-)
 create mode 100644 arch/arm/mach-ebsa110/Kconfig
 create mode 100644 arch/arm/mach-highbank/Kconfig
 create mode 100644 arch/arm/mach-lpc32xx/Kconfig
 create mode 100644 arch/arm/mach-picoxcell/Kconfig
 create mode 100644 arch/arm/mach-pnx4008/Kconfig
 create mode 100644 arch/arm/mach-rpc/Kconfig
 create mode 100644 arch/arm/mach-shark/Kconfig
 create mode 100644 arch/arm/mach-socfpga/Kconfig
 create mode 100644 arch/arm/mach-zynq/Kconfig

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3557f12..3ad82c6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -256,424 +256,213 @@ choice
 	prompt "ARM system type"
 	default ARCH_VERSATILE
 
-config ARCH_SOCFPGA
+config ARCH_SOCFPGA_CHOICE
 	bool "Altera SOCFPGA family"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_AMBA
-	select ARM_GIC
-	select CACHE_L2X0
-	select CLKDEV_LOOKUP
-	select COMMON_CLK
-	select CPU_V7
-	select DW_APB_TIMER
-	select DW_APB_TIMER_OF
-	select GENERIC_CLOCKEVENTS
-	select GPIO_PL061 if GPIOLIB
-	select HAVE_ARM_SCU
-	select SPARSE_IRQ
-	select USE_OF
+	select ARCH_SOCFPGA
 	help
 	  This enables support for Altera SOCFPGA Cyclone V platform
 
-config ARCH_INTEGRATOR
+config ARCH_INTEGRATOR_CHOICE
 	bool "ARM Ltd. Integrator family"
-	select ARM_AMBA
-	select ARCH_HAS_CPUFREQ
-	select COMMON_CLK
-	select CLK_VERSATILE
-	select HAVE_TCM
-	select ICST
-	select GENERIC_CLOCKEVENTS
-	select PLAT_VERSATILE
-	select PLAT_VERSATILE_FPGA_IRQ
-	select NEED_MACH_IO_H
-	select NEED_MACH_MEMORY_H
-	select SPARSE_IRQ
-	select MULTI_IRQ_HANDLER
+	select ARCH_INTEGRATOR
 	help
 	  Support for ARM's Integrator platform.
 
-config ARCH_REALVIEW
+config ARCH_REALVIEW_CHOICE
 	bool "ARM Ltd. RealView family"
-	select ARM_AMBA
-	select CLKDEV_LOOKUP
-	select HAVE_MACH_CLKDEV
-	select ICST
-	select GENERIC_CLOCKEVENTS
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLOCK
-	select PLAT_VERSATILE_CLCD
-	select ARM_TIMER_SP804
-	select GPIO_PL061 if GPIOLIB
-	select NEED_MACH_MEMORY_H
+	select ARCH_REALVIEW
 	help
 	  This enables support for ARM Ltd RealView boards.
 
-config ARCH_VERSATILE
+config ARCH_VERSATILE_CHOICE
 	bool "ARM Ltd. Versatile family"
-	select ARM_AMBA
-	select ARM_VIC
-	select CLKDEV_LOOKUP
-	select HAVE_MACH_CLKDEV
-	select ICST
-	select GENERIC_CLOCKEVENTS
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select NEED_MACH_IO_H if PCI
-	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLOCK
-	select PLAT_VERSATILE_CLCD
-	select PLAT_VERSATILE_FPGA_IRQ
-	select ARM_TIMER_SP804
+	select ARCH_VERSATILE
 	help
 	  This enables support for ARM Ltd Versatile board.
 
-config ARCH_VEXPRESS
+config ARCH_VEXPRESS_CHOICE
 	bool "ARM Ltd. Versatile Express family"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_AMBA
-	select ARM_TIMER_SP804
-	select CLKDEV_LOOKUP
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
-	select HAVE_PATA_PLATFORM
-	select ICST
-	select NO_IOPORT
-	select PLAT_VERSATILE
-	select PLAT_VERSATILE_CLCD
-	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+	select ARCH_VEXPRESS
 	help
 	  This enables support for the ARM Ltd Versatile Express boards.
 
-config ARCH_AT91
+config ARCH_AT91_CHOICE
 	bool "Atmel AT91"
-	select ARCH_REQUIRE_GPIOLIB
-	select HAVE_CLK
-	select CLKDEV_LOOKUP
-	select IRQ_DOMAIN
-	select NEED_MACH_IO_H if PCCARD
+	select ARCH_AT91
 	help
 	  This enables support for systems based on Atmel
 	  AT91RM9200 and AT91SAM9* processors.
 
-config ARCH_BCMRING
+config ARCH_BCMRING_CHOICE
 	bool "Broadcom BCMRING"
 	depends on MMU
-	select CPU_V6
-	select ARM_AMBA
-	select ARM_TIMER_SP804
-	select CLKDEV_LOOKUP
-	select GENERIC_CLOCKEVENTS
-	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARCH_BCMRING
 	help
 	  Support for Broadcom's BCMRing platform.
 
-config ARCH_HIGHBANK
+config ARCH_HIGHBANK_CHOICE
 	bool "Calxeda Highbank-based"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_AMBA
-	select ARM_GIC
-	select ARM_TIMER_SP804
-	select CACHE_L2X0
-	select CLKDEV_LOOKUP
-	select COMMON_CLK
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
-	select HAVE_ARM_SCU
-	select HAVE_SMP
-	select SPARSE_IRQ
-	select USE_OF
+	select ARCH_HIGHBANK
 	help
 	  Support for the Calxeda Highbank SoC based boards.
 
-config ARCH_CLPS711X
+config ARCH_CLPS711X_CHOICE
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
-	select CPU_ARM720T
-	select ARCH_USES_GETTIMEOFFSET
-	select NEED_MACH_MEMORY_H
+	select ARCH_CLPS711X
 	help
 	  Support for Cirrus Logic 711x/721x/731x based boards.
 
-config ARCH_CNS3XXX
+config ARCH_CNS3XXX_CHOICE
 	bool "Cavium Networks CNS3XXX family"
-	select CPU_V6K
-	select GENERIC_CLOCKEVENTS
-	select ARM_GIC
-	select MIGHT_HAVE_CACHE_L2X0
-	select MIGHT_HAVE_PCI
-	select PCI_DOMAINS if PCI
+	select ARCH_CNS3XXX
 	help
 	  Support for Cavium Networks CNS3XXX platform.
 
-config ARCH_GEMINI
+config ARCH_GEMINI_CHOICE
 	bool "Cortina Systems Gemini"
-	select CPU_FA526
-	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_USES_GETTIMEOFFSET
+	select ARCH_GEMINI
 	help
 	  Support for the Cortina Systems Gemini family SoCs
 
-config ARCH_PRIMA2
+config ARCH_PRIMA2_CHOICE
 	bool "CSR SiRFSoC PRIMA2 ARM Cortex A9 Platform"
-	select CPU_V7
-	select NO_IOPORT
-	select ARCH_REQUIRE_GPIOLIB
-	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
-	select GENERIC_IRQ_CHIP
-	select MIGHT_HAVE_CACHE_L2X0
-	select PINCTRL
-	select PINCTRL_SIRF
-	select USE_OF
-	select ZONE_DMA
+	select ARCH_PRIMA2
 	help
           Support for CSR SiRFSoC ARM Cortex A9 Platform
 
-config ARCH_EBSA110
+config ARCH_EBSA110_CHOICE
 	bool "EBSA-110"
-	select CPU_SA110
-	select ISA
-	select NO_IOPORT
-	select ARCH_USES_GETTIMEOFFSET
-	select NEED_MACH_IO_H
-	select NEED_MACH_MEMORY_H
+	select ARCH_EBSA110
 	help
 	  This is an evaluation board for the StrongARM processor available
 	  from Digital. It has limited hardware on-board, including an
 	  Ethernet interface, two PCMCIA sockets, two serial ports and a
 	  parallel port.
 
-config ARCH_EP93XX
+config ARCH_EP93XX_CHOICE
 	bool "EP93xx-based"
-	select CPU_ARM920T
-	select ARM_AMBA
-	select ARM_VIC
-	select CLKDEV_LOOKUP
-	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_HOLES_MEMORYMODEL
-	select ARCH_USES_GETTIMEOFFSET
-	select NEED_MACH_MEMORY_H
+	select ARCH_EP93XX
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
-config ARCH_FOOTBRIDGE
+config ARCH_FOOTBRIDGE_CHOICE
 	bool "FootBridge"
-	select CPU_SA110
-	select FOOTBRIDGE
-	select GENERIC_CLOCKEVENTS
-	select HAVE_IDE
-	select NEED_MACH_IO_H
-	select NEED_MACH_MEMORY_H
+	select ARCH_FOOTBRIDGE
 	help
 	  Support for systems based on the DC21285 companion chip
 	  ("FootBridge"), such as the Simtec CATS and the Rebel NetWinder.
 
-config ARCH_MXC
+config ARCH_MXC_CHOICE
 	bool "Freescale MXC/iMX-based"
-	select GENERIC_CLOCKEVENTS
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select GENERIC_IRQ_CHIP
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-	select USE_OF
+	select ARCH_MXC
 	help
 	  Support for Freescale MXC/iMX-based family of processors
 
-config ARCH_MXS
+config ARCH_MXS_CHOICE
 	bool "Freescale MXS-based"
-	select GENERIC_CLOCKEVENTS
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select COMMON_CLK
-	select HAVE_CLK_PREPARE
-	select PINCTRL
-	select USE_OF
+	select ARCH_MXS
 	help
 	  Support for Freescale MXS-based family of processors
 
-config ARCH_NETX
+config ARCH_NETX_CHOICE
 	bool "Hilscher NetX based"
-	select CLKSRC_MMIO
-	select CPU_ARM926T
-	select ARM_VIC
-	select GENERIC_CLOCKEVENTS
+	select ARCH_NETX
 	help
 	  This enables support for systems based on the Hilscher NetX Soc
 
-config ARCH_H720X
+config ARCH_H720X_CHOICE
 	bool "Hynix HMS720x-based"
-	select CPU_ARM720T
-	select ISA_DMA_API
-	select ARCH_USES_GETTIMEOFFSET
+	select ARCH_H720X
 	help
 	  This enables support for systems based on the Hynix HMS720x
 
-config ARCH_IOP13XX
+config ARCH_IOP13XX_CHOICE
 	bool "IOP13xx-based"
 	depends on MMU
-	select CPU_XSC3
-	select PLAT_IOP
-	select PCI
-	select ARCH_SUPPORTS_MSI
-	select VMSPLIT_1G
-	select NEED_MACH_IO_H
-	select NEED_MACH_MEMORY_H
-	select NEED_RET_TO_USER
+	select ARCH_IOP13XX
 	help
 	  Support for Intel's IOP13XX (XScale) family of processors.
 
-config ARCH_IOP32X
+config ARCH_IOP32X_CHOICE
 	bool "IOP32x-based"
 	depends on MMU
-	select CPU_XSCALE
-	select NEED_MACH_GPIO_H
-	select NEED_MACH_IO_H
-	select NEED_RET_TO_USER
-	select PLAT_IOP
-	select PCI
-	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_IOP32X
 	help
 	  Support for Intel's 80219 and IOP32X (XScale) family of
 	  processors.
 
-config ARCH_IOP33X
+config ARCH_IOP33X_CHOICE
 	bool "IOP33x-based"
 	depends on MMU
-	select CPU_XSCALE
-	select NEED_MACH_GPIO_H
-	select NEED_MACH_IO_H
-	select NEED_RET_TO_USER
-	select PLAT_IOP
-	select PCI
-	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_IOP33X
 	help
 	  Support for Intel's IOP33X (XScale) family of processors.
 
-config ARCH_IXP4XX
+config ARCH_IXP4XX_CHOICE
 	bool "IXP4xx-based"
 	depends on MMU
-	select ARCH_HAS_DMA_SET_COHERENT_MASK
-	select CLKSRC_MMIO
-	select CPU_XSCALE
-	select ARCH_REQUIRE_GPIOLIB
-	select GENERIC_CLOCKEVENTS
-	select MIGHT_HAVE_PCI
-	select NEED_MACH_IO_H
-	select DMABOUNCE if PCI
+	select ARCH_IXP4XX
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 
-config ARCH_MVEBU
+config ARCH_MVEBU_CHOICE
 	bool "Marvell SOCs with Device Tree support"
-	select GENERIC_CLOCKEVENTS
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-	select CLKSRC_MMIO
-	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN
-	select COMMON_CLK
+	select ARCH_MVEBU
 	help
 	  Support for the Marvell SoC Family with device tree support
 
-config ARCH_DOVE
+config ARCH_DOVE_CHOICE
 	bool "Marvell Dove"
-	select CPU_V7
-	select PCI
-	select ARCH_REQUIRE_GPIOLIB
-	select GENERIC_CLOCKEVENTS
-	select NEED_MACH_IO_H
-	select PLAT_ORION
+	select ARCH_DOVE
 	help
 	  Support for the Marvell Dove SoC 88AP510
 
-config ARCH_KIRKWOOD
+config ARCH_KIRKWOOD_CHOICE
 	bool "Marvell Kirkwood"
-	select CPU_FEROCEON
-	select PCI
-	select ARCH_REQUIRE_GPIOLIB
-	select GENERIC_CLOCKEVENTS
-	select NEED_MACH_IO_H
-	select PLAT_ORION
+	select ARCH_KIRKWOOD
 	help
 	  Support for the following Marvell Kirkwood series SoCs:
 	  88F6180, 88F6192 and 88F6281.
 
-config ARCH_LPC32XX
+config ARCH_LPC32XX_CHOICE
 	bool "NXP LPC32XX"
-	select CLKSRC_MMIO
-	select CPU_ARM926T
-	select ARCH_REQUIRE_GPIOLIB
-	select HAVE_IDE
-	select ARM_AMBA
-	select USB_ARCH_HAS_OHCI
-	select CLKDEV_LOOKUP
-	select GENERIC_CLOCKEVENTS
-	select USE_OF
-	select HAVE_PWM
+	select ARCH_LPC32XX
 	help
 	  Support for the NXP LPC32XX family of processors
 
-config ARCH_MV78XX0
+config ARCH_MV78XX0_CHOICE
 	bool "Marvell MV78xx0"
-	select CPU_FEROCEON
-	select PCI
-	select ARCH_REQUIRE_GPIOLIB
-	select GENERIC_CLOCKEVENTS
-	select NEED_MACH_IO_H
-	select PLAT_ORION
+	select ARCH_MV78XX0
 	help
 	  Support for the following Marvell MV78xx0 series SoCs:
 	  MV781x0, MV782x0.
 
-config ARCH_ORION5X
+config ARCH_ORION5X_CHOICE
 	bool "Marvell Orion"
 	depends on MMU
-	select CPU_FEROCEON
-	select PCI
-	select ARCH_REQUIRE_GPIOLIB
-	select GENERIC_CLOCKEVENTS
-	select NEED_MACH_IO_H
-	select PLAT_ORION
+	select ARCH_ORION5X
 	help
 	  Support for the following Marvell Orion 5x series SoCs:
 	  Orion-1 (5181), Orion-VoIP (5181L), Orion-NAS (5182),
 	  Orion-2 (5281), Orion-1-90 (6183).
 
-config ARCH_MMP
+config ARCH_MMP_CHOICE
 	bool "Marvell PXA168/910/MMP2"
 	depends on MMU
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select GENERIC_CLOCKEVENTS
-	select GPIO_PXA
-	select IRQ_DOMAIN
-	select PLAT_PXA
-	select SPARSE_IRQ
-	select GENERIC_ALLOCATOR
+	select ARCH_MMP
 	help
 	  Support for Marvell's PXA168/PXA910(MMP) and MMP2 processor line.
 
-config ARCH_KS8695
+config ARCH_KS8695_CHOICE
 	bool "Micrel/Kendin KS8695"
-	select CPU_ARM922T
-	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_USES_GETTIMEOFFSET
-	select NEED_MACH_MEMORY_H
+	select ARCH_KS8695
 	help
 	  Support for Micrel/Kendin KS8695 "Centaur" (ARM922T) based
 	  System-on-Chip devices.
 
-config ARCH_W90X900
+config ARCH_W90X900_CHOICE
 	bool "Nuvoton W90X900 CPU"
-	select CPU_ARM926T
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select GENERIC_CLOCKEVENTS
+	select ARCH_W90X900
 	help
 	  Support for Nuvoton (Winbond logic dept.) ARM9 processor,
 	  At present, the w90x900 has been renamed nuc900, regarding
@@ -683,74 +472,37 @@ config ARCH_W90X900
 	  <http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/
 		ConsumerElectronicsIC/ARMMicrocontroller/ARMMicrocontroller>
 
-config ARCH_TEGRA
+config ARCH_TEGRA_CHOICE
 	bool "NVIDIA Tegra"
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
-	select HAVE_CLK
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
-	select NEED_MACH_IO_H if PCI
-	select ARCH_HAS_CPUFREQ
-	select USE_OF
+	select ARCH_TEGRA
 	help
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
 	  Tegra 6xx and Tegra 2 series).
 
-config ARCH_PICOXCELL
+config ARCH_PICOXCELL_CHOICE
 	bool "Picochip picoXcell"
-	select ARCH_REQUIRE_GPIOLIB
-	select ARM_PATCH_PHYS_VIRT
-	select ARM_VIC
-	select CPU_V6K
-	select DW_APB_TIMER
-	select DW_APB_TIMER_OF
-	select GENERIC_CLOCKEVENTS
-	select GENERIC_GPIO
-	select HAVE_TCM
-	select NO_IOPORT
-	select SPARSE_IRQ
-	select USE_OF
+	select ARCH_PICOXCELL
 	help
 	  This enables support for systems based on the Picochip picoXcell
 	  family of Femtocell devices.  The picoxcell support requires device tree
 	  for all boards.
 
-config ARCH_PNX4008
+config ARCH_PNX4008_CHOICE
 	bool "Philips Nexperia PNX4008 Mobile"
-	select CPU_ARM926T
-	select CLKDEV_LOOKUP
-	select ARCH_USES_GETTIMEOFFSET
+	select ARCH_PNX4008
 	help
 	  This enables support for Philips PNX4008 mobile platform.
 
-config ARCH_PXA
+config ARCH_PXA_CHOICE
 	bool "PXA2xx/PXA3xx-based"
 	depends on MMU
-	select ARCH_MTD_XIP
-	select ARCH_HAS_CPUFREQ
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select ARCH_REQUIRE_GPIOLIB
-	select GENERIC_CLOCKEVENTS
-	select GPIO_PXA
-	select PLAT_PXA
-	select SPARSE_IRQ
-	select AUTO_ZRELADDR
-	select MULTI_IRQ_HANDLER
-	select ARM_CPU_SUSPEND if PM
-	select HAVE_IDE
+	select ARCH_PXA
 	help
 	  Support for Intel/Marvell's PXA2xx/PXA3xx processor line.
 
-config ARCH_MSM
+config ARCH_MSM_CHOICE
 	bool "Qualcomm MSM"
-	select HAVE_CLK
-	select GENERIC_CLOCKEVENTS
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
+	select ARCH_MSM
 	help
 	  Support for Qualcomm MSM/QSD based systems.  This runs on the
 	  apps processor of the MSM/QSD and depends on a shared memory
@@ -758,283 +510,121 @@ config ARCH_MSM
 	  stack and controls some vital subsystems
 	  (clock and power control, etc).
 
-config ARCH_SHMOBILE
+config ARCH_SHMOBILE_CHOICE
 	bool "Renesas SH-Mobile / R-Mobile"
-	select HAVE_CLK
-	select CLKDEV_LOOKUP
-	select HAVE_MACH_CLKDEV
-	select HAVE_SMP
-	select GENERIC_CLOCKEVENTS
-	select MIGHT_HAVE_CACHE_L2X0
-	select NO_IOPORT
-	select SPARSE_IRQ
-	select MULTI_IRQ_HANDLER
-	select PM_GENERIC_DOMAINS if PM
-	select NEED_MACH_MEMORY_H
+	select ARCH_SHMOBILE
 	help
 	  Support for Renesas's SH-Mobile and R-Mobile ARM platforms.
 
-config ARCH_RPC
+config ARCH_RPC_CHOICE
 	bool "RiscPC"
-	select ARCH_ACORN
-	select FIQ
-	select ARCH_MAY_HAVE_PC_FDC
-	select HAVE_PATA_PLATFORM
-	select ISA_DMA_API
-	select NO_IOPORT
-	select ARCH_SPARSEMEM_ENABLE
-	select ARCH_USES_GETTIMEOFFSET
-	select HAVE_IDE
-	select NEED_MACH_IO_H
-	select NEED_MACH_MEMORY_H
+	select ARCH_RPC
 	help
 	  On the Acorn Risc-PC, Linux can support the internal IDE disk and
 	  CD-ROM interface, serial and parallel port, and the floppy drive.
 
-config ARCH_SA1100
+config ARCH_SA1100_CHOICE
 	bool "SA1100-based"
-	select CLKSRC_MMIO
-	select CPU_SA1100
-	select ISA
-	select ARCH_SPARSEMEM_ENABLE
-	select ARCH_MTD_XIP
-	select ARCH_HAS_CPUFREQ
-	select CPU_FREQ
-	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
-	select ARCH_REQUIRE_GPIOLIB
-	select HAVE_IDE
-	select NEED_MACH_GPIO_H
-	select NEED_MACH_MEMORY_H
-	select SPARSE_IRQ
+	select ARCH_SA1100
 	help
 	  Support for StrongARM 11x0 based boards.
 
-config ARCH_S3C24XX
+config ARCH_S3C24XX_CHOICE
 	bool "Samsung S3C24XX SoCs"
-	select GENERIC_GPIO
-	select ARCH_HAS_CPUFREQ
-	select HAVE_CLK
-	select CLKDEV_LOOKUP
-	select ARCH_USES_GETTIMEOFFSET
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C_RTC if RTC_CLASS
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select NEED_MACH_GPIO_H
-	select NEED_MACH_IO_H
+	select ARCH_S3C24XX
 	help
 	  Samsung S3C2410, S3C2412, S3C2413, S3C2416, S3C2440, S3C2442, S3C2443
 	  and S3C2450 SoCs based systems, such as the Simtec Electronics BAST
 	  (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or the
 	  Samsung SMDK2410 development board (and derivatives).
 
-config ARCH_S3C64XX
+config ARCH_S3C64XX_CHOICE
 	bool "Samsung S3C64XX"
-	select PLAT_SAMSUNG
-	select CPU_V6
-	select ARM_VIC
-	select HAVE_CLK
-	select HAVE_TCM
-	select CLKDEV_LOOKUP
-	select NO_IOPORT
-	select ARCH_USES_GETTIMEOFFSET
-	select ARCH_HAS_CPUFREQ
-	select ARCH_REQUIRE_GPIOLIB
-	select SAMSUNG_CLKSRC
-	select SAMSUNG_IRQ_VIC_TIMER
-	select S3C_GPIO_TRACK
-	select S3C_DEV_NAND
-	select USB_ARCH_HAS_OHCI
-	select SAMSUNG_GPIOLIB_4BIT
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select NEED_MACH_GPIO_H
+	select ARCH_S3C64XX
 	help
 	  Samsung S3C64XX series based systems
 
-config ARCH_S5P64X0
+config ARCH_S5P64X0_CHOICE
 	bool "Samsung S5P6440 S5P6450"
-	select CPU_V6
-	select GENERIC_GPIO
-	select HAVE_CLK
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select GENERIC_CLOCKEVENTS
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C_RTC if RTC_CLASS
-	select NEED_MACH_GPIO_H
+	select ARCH_S5P64X0
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
 
-config ARCH_S5PC100
+config ARCH_S5PC100_CHOICE
 	bool "Samsung S5PC100"
-	select GENERIC_GPIO
-	select HAVE_CLK
-	select CLKDEV_LOOKUP
-	select CPU_V7
-	select ARCH_USES_GETTIMEOFFSET
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C_RTC if RTC_CLASS
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select NEED_MACH_GPIO_H
+	select ARCH_S5PC100
 	help
 	  Samsung S5PC100 series based systems
 
-config ARCH_S5PV210
+config ARCH_S5PV210_CHOICE
 	bool "Samsung S5PV210/S5PC110"
-	select CPU_V7
-	select ARCH_SPARSEMEM_ENABLE
-	select ARCH_HAS_HOLES_MEMORYMODEL
-	select GENERIC_GPIO
-	select HAVE_CLK
-	select CLKDEV_LOOKUP
-	select CLKSRC_MMIO
-	select ARCH_HAS_CPUFREQ
-	select GENERIC_CLOCKEVENTS
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C_RTC if RTC_CLASS
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select NEED_MACH_GPIO_H
-	select NEED_MACH_MEMORY_H
+	select ARCH_S5PV210
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
-config ARCH_EXYNOS
+config ARCH_EXYNOS_CHOICE
 	bool "SAMSUNG EXYNOS"
-	select CPU_V7
-	select ARCH_SPARSEMEM_ENABLE
-	select ARCH_HAS_HOLES_MEMORYMODEL
-	select GENERIC_GPIO
-	select HAVE_CLK
-	select CLKDEV_LOOKUP
-	select ARCH_HAS_CPUFREQ
-	select GENERIC_CLOCKEVENTS
-	select HAVE_S3C_RTC if RTC_CLASS
-	select HAVE_S3C2410_I2C if I2C
-	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select NEED_MACH_GPIO_H
-	select NEED_MACH_MEMORY_H
+	select ARCH_EXYNOS
 	help
 	  Support for SAMSUNG's EXYNOS SoCs (EXYNOS4/5)
 
-config ARCH_SHARK
+config ARCH_SHARK_CHOICE
 	bool "Shark"
-	select CPU_SA110
-	select ISA
-	select ISA_DMA
-	select ZONE_DMA
-	select PCI
-	select ARCH_USES_GETTIMEOFFSET
-	select NEED_MACH_MEMORY_H
-	select NEED_MACH_IO_H
+	select ARCH_SHARK
 	help
 	  Support for the StrongARM based Digital DNARD machine, also known
 	  as "Shark" (<http://www.shark-linux.de/shark.html>).
 
-config ARCH_U300
+config ARCH_U300_CHOICE
 	bool "ST-Ericsson U300 Series"
 	depends on MMU
-	select CLKSRC_MMIO
-	select CPU_ARM926T
-	select HAVE_TCM
-	select ARM_AMBA
-	select ARM_PATCH_PHYS_VIRT
-	select ARM_VIC
-	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
-	select COMMON_CLK
-	select GENERIC_GPIO
-	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_U300
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
 
-config ARCH_U8500
+config ARCH_U8500_CHOICE
 	bool "ST-Ericsson U8500 Series"
 	depends on MMU
-	select CPU_V7
-	select ARM_AMBA
-	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
-	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_CPUFREQ
-	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
+	select ARCH_U8500
 	help
 	  Support for ST-Ericsson's Ux500 architecture
 
-config ARCH_NOMADIK
+config ARCH_NOMADIK_CHOICE
 	bool "STMicroelectronics Nomadik"
-	select ARM_AMBA
-	select ARM_VIC
-	select CPU_ARM926T
-	select COMMON_CLK
-	select GENERIC_CLOCKEVENTS
-	select PINCTRL
-	select MIGHT_HAVE_CACHE_L2X0
-	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_NOMADIK
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
-config ARCH_DAVINCI
+config ARCH_DAVINCI_CHOICE
 	bool "TI DaVinci"
-	select GENERIC_CLOCKEVENTS
-	select ARCH_REQUIRE_GPIOLIB
-	select ZONE_DMA
-	select HAVE_IDE
-	select CLKDEV_LOOKUP
-	select GENERIC_ALLOCATOR
-	select GENERIC_IRQ_CHIP
-	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_DAVINCI
 	select NEED_MACH_GPIO_H
 	help
 	  Support for TI's DaVinci platform.
 
-config ARCH_OMAP
+config ARCH_OMAP_CHOICE
 	bool "TI OMAP"
 	depends on MMU
-	select HAVE_CLK
-	select ARCH_REQUIRE_GPIOLIB
-	select ARCH_HAS_CPUFREQ
-	select CLKSRC_MMIO
-	select GENERIC_CLOCKEVENTS
-	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_OMAP
 	help
 	  Support for TI's OMAP platform (OMAP1/2/3/4).
 
-config PLAT_SPEAR
+config PLAT_SPEAR_CHOICE
 	bool "ST SPEAr"
-	select ARM_AMBA
-	select ARCH_REQUIRE_GPIOLIB
-	select CLKDEV_LOOKUP
-	select COMMON_CLK
-	select CLKSRC_MMIO
-	select GENERIC_CLOCKEVENTS
-	select HAVE_CLK
+	select PLAT_SPEAR
 	help
 	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
 
-config ARCH_VT8500
+config ARCH_VT8500_CHOICE
 	bool "VIA/WonderMedia 85xx"
-	select CPU_ARM926T
-	select GENERIC_GPIO
-	select ARCH_HAS_CPUFREQ
-	select GENERIC_CLOCKEVENTS
-	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_VT8500
 	help
 	  Support for VIA/WonderMedia VT8500/WM85xx System-on-Chip.
 
-config ARCH_ZYNQ
+config ARCH_ZYNQ_CHOICE
 	bool "Xilinx Zynq ARM Cortex A9 Platform"
-	select CPU_V7
-	select GENERIC_CLOCKEVENTS
-	select CLKDEV_LOOKUP
-	select ARM_GIC
-	select ARM_AMBA
-	select ICST
-	select MIGHT_HAVE_CACHE_L2X0
-	select USE_OF
+	select ARCH_ZYNQ
 	help
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
 endchoice
@@ -1058,6 +648,8 @@ source "arch/arm/mach-davinci/Kconfig"
 
 source "arch/arm/mach-dove/Kconfig"
 
+source "arch/arm/mach-ebsa110/Kconfig"
+
 source "arch/arm/mach-ep93xx/Kconfig"
 
 source "arch/arm/mach-footbridge/Kconfig"
@@ -1066,6 +658,8 @@ source "arch/arm/mach-gemini/Kconfig"
 
 source "arch/arm/mach-h720x/Kconfig"
 
+source "arch/arm/mach-highbank/Kconfig"
+
 source "arch/arm/mach-integrator/Kconfig"
 
 source "arch/arm/mach-iop32x/Kconfig"
@@ -1080,6 +674,8 @@ source "arch/arm/mach-kirkwood/Kconfig"
 
 source "arch/arm/mach-ks8695/Kconfig"
 
+source "arch/arm/mach-lpc32xx/Kconfig"
+
 source "arch/arm/mach-msm/Kconfig"
 
 source "arch/arm/mach-mv78xx0/Kconfig"
@@ -1101,6 +697,10 @@ source "arch/arm/mach-omap2/Kconfig"
 
 source "arch/arm/mach-orion5x/Kconfig"
 
+source "arch/arm/mach-picoxcell/Kconfig"
+
+source "arch/arm/mach-pnx4008/Kconfig"
+
 source "arch/arm/mach-pxa/Kconfig"
 source "arch/arm/plat-pxa/Kconfig"
 
@@ -1108,11 +708,17 @@ source "arch/arm/mach-mmp/Kconfig"
 
 source "arch/arm/mach-realview/Kconfig"
 
+source "arch/arm/mach-rpc/Kconfig"
+
 source "arch/arm/mach-sa1100/Kconfig"
 
 source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
 
+source "arch/arm/mach-shark/Kconfig"
+
+source "arch/arm/mach-socfpga/Kconfig"
+
 source "arch/arm/plat-spear/Kconfig"
 
 source "arch/arm/mach-s3c24xx/Kconfig"
@@ -1121,9 +727,7 @@ source "arch/arm/mach-s3c2412/Kconfig"
 source "arch/arm/mach-s3c2440/Kconfig"
 endif
 
-if ARCH_S3C64XX
 source "arch/arm/mach-s3c64xx/Kconfig"
-endif
 
 source "arch/arm/mach-s5p64x0/Kconfig"
 
@@ -1150,6 +754,8 @@ source "arch/arm/mach-vt8500/Kconfig"
 
 source "arch/arm/mach-w90x900/Kconfig"
 
+source "arch/arm/mach-zynq/Kconfig"
+
 # Definitions to make life easier
 config ARCH_ACORN
 	bool
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c8050b1..835886a 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -1,3 +1,11 @@
+config ARCH_AT91
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select HAVE_CLK
+	select IRQ_DOMAIN
+	select NEED_MACH_IO_H if PCCARD
+
 if ARCH_AT91
 
 config HAVE_AT91_DATAFLASH_CARD
diff --git a/arch/arm/mach-bcmring/Kconfig b/arch/arm/mach-bcmring/Kconfig
index 9170d16..7a8c869 100644
--- a/arch/arm/mach-bcmring/Kconfig
+++ b/arch/arm/mach-bcmring/Kconfig
@@ -1,3 +1,12 @@
+config ARCH_BCMRING
+	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
+	select ARM_TIMER_SP804
+	select CLKDEV_LOOKUP
+	select CPU_V6
+	select GENERIC_CLOCKEVENTS
+
 choice
 	prompt "Processor selection in BCMRING family of devices"
 	depends on ARCH_BCMRING
diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index ea036d6..2d3dba9 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -1,3 +1,9 @@
+config ARCH_CLPS711X
+	bool
+	select ARCH_USES_GETTIMEOFFSET
+	select CPU_ARM720T
+	select NEED_MACH_MEMORY_H
+
 if ARCH_CLPS711X
 
 menu "CLPS711X/EP721X/EP731X Implementations"
diff --git a/arch/arm/mach-cns3xxx/Kconfig b/arch/arm/mach-cns3xxx/Kconfig
index 29b13f2..0dab723 100644
--- a/arch/arm/mach-cns3xxx/Kconfig
+++ b/arch/arm/mach-cns3xxx/Kconfig
@@ -1,3 +1,12 @@
+config ARCH_CNS3XXX
+	bool
+	select CPU_V6K
+	select GENERIC_CLOCKEVENTS
+	select ARM_GIC
+	select MIGHT_HAVE_CACHE_L2X0
+	select MIGHT_HAVE_PCI
+	select PCI_DOMAINS if PCI
+
 menu "CNS3XXX platform type"
 	depends on ARCH_CNS3XXX
 
diff --git a/arch/arm/mach-davinci/Kconfig b/arch/arm/mach-davinci/Kconfig
index ab99c3c..3e0102b 100644
--- a/arch/arm/mach-davinci/Kconfig
+++ b/arch/arm/mach-davinci/Kconfig
@@ -1,3 +1,15 @@
+config ARCH_DAVINCI
+	bool
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select GENERIC_ALLOCATOR
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
+	select HAVE_IDE
+	select NEED_MACH_GPIO_H
+	select ZONE_DMA
+
 if ARCH_DAVINCI
 
 config AINTC
diff --git a/arch/arm/mach-dove/Kconfig b/arch/arm/mach-dove/Kconfig
index dd937c5..34b7bdb 100644
--- a/arch/arm/mach-dove/Kconfig
+++ b/arch/arm/mach-dove/Kconfig
@@ -1,3 +1,12 @@
+config ARCH_DOVE
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select NEED_MACH_IO_H
+	select PCI
+	select PLAT_ORION
+
 if ARCH_DOVE
 
 menu "Marvell Dove Implementations"
diff --git a/arch/arm/mach-ebsa110/Kconfig b/arch/arm/mach-ebsa110/Kconfig
new file mode 100644
index 0000000..3ca0f58
--- /dev/null
+++ b/arch/arm/mach-ebsa110/Kconfig
@@ -0,0 +1,9 @@
+config ARCH_EBSA110
+	bool
+	select CPU_SA110
+	select ISA
+	select NO_IOPORT
+	select ARCH_USES_GETTIMEOFFSET
+	select NEED_MACH_IO_H
+	select NEED_MACH_MEMORY_H
+
diff --git a/arch/arm/mach-ep93xx/Kconfig b/arch/arm/mach-ep93xx/Kconfig
index fe3c1fa..4cf770c 100644
--- a/arch/arm/mach-ep93xx/Kconfig
+++ b/arch/arm/mach-ep93xx/Kconfig
@@ -1,3 +1,14 @@
+config ARCH_EP93XX
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select ARCH_USES_GETTIMEOFFSET
+	select ARM_AMBA
+	select ARM_VIC
+	select CLKDEV_LOOKUP
+	select CPU_ARM920T
+	select NEED_MACH_MEMORY_H
+
 if ARCH_EP93XX
 
 menu "Cirrus EP93xx Implementation Options"
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b5b4c8c..4e78a4a 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -7,6 +7,22 @@
 
 # Configuration options for the EXYNOS4
 
+config ARCH_EXYNOS
+	bool
+	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_HAS_CPUFREQ
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select CLKDEV_LOOKUP
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
+	select HAVE_CLK
+	select HAVE_S3C_RTC if RTC_CLASS
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
+	select NEED_MACH_MEMORY_H
+
 if ARCH_EXYNOS
 
 menu "SAMSUNG EXYNOS SoCs Support"
diff --git a/arch/arm/mach-footbridge/Kconfig b/arch/arm/mach-footbridge/Kconfig
index f643ef8..6690953 100644
--- a/arch/arm/mach-footbridge/Kconfig
+++ b/arch/arm/mach-footbridge/Kconfig
@@ -1,3 +1,12 @@
+config ARCH_FOOTBRIDGE
+	bool
+	select CPU_SA110
+	select FOOTBRIDGE
+	select GENERIC_CLOCKEVENTS
+	select HAVE_IDE
+	select NEED_MACH_IO_H
+	select NEED_MACH_MEMORY_H
+
 if ARCH_FOOTBRIDGE
 
 menu "Footbridge Implementations"
diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
index 6f066ee..54d4cee 100644
--- a/arch/arm/mach-gemini/Kconfig
+++ b/arch/arm/mach-gemini/Kconfig
@@ -1,3 +1,9 @@
+config ARCH_GEMINI
+	bool
+	select ARCH_USES_GETTIMEOFFSET
+	select ARCH_REQUIRE_GPIOLIB
+	select CPU_FA526
+
 if ARCH_GEMINI
 
 menu "Cortina Systems Gemini Implementations"
diff --git a/arch/arm/mach-h720x/Kconfig b/arch/arm/mach-h720x/Kconfig
index abf356c..566a4ed 100644
--- a/arch/arm/mach-h720x/Kconfig
+++ b/arch/arm/mach-h720x/Kconfig
@@ -1,3 +1,9 @@
+config ARCH_H720X
+	bool
+	select CPU_ARM720T
+	select ISA_DMA_API
+	select ARCH_USES_GETTIMEOFFSET
+
 if ARCH_H720X
 
 menu "h720x Implementations"
diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
new file mode 100644
index 0000000..d4f1b23
--- /dev/null
+++ b/arch/arm/mach-highbank/Kconfig
@@ -0,0 +1,15 @@
+config ARCH_HIGHBANK
+	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
+	select ARM_GIC
+	select ARM_TIMER_SP804
+	select CACHE_L2X0
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select HAVE_ARM_SCU
+	select HAVE_SMP
+	select SPARSE_IRQ
+	select USE_OF
diff --git a/arch/arm/mach-integrator/Kconfig b/arch/arm/mach-integrator/Kconfig
index 350e266..88afd42 100644
--- a/arch/arm/mach-integrator/Kconfig
+++ b/arch/arm/mach-integrator/Kconfig
@@ -1,3 +1,19 @@
+config ARCH_INTEGRATOR
+	bool
+	select ARM_AMBA
+	select ARCH_HAS_CPUFREQ
+	select COMMON_CLK
+	select CLK_VERSATILE
+	select HAVE_TCM
+	select ICST
+	select GENERIC_CLOCKEVENTS
+	select PLAT_VERSATILE
+	select PLAT_VERSATILE_FPGA_IRQ
+	select NEED_MACH_IO_H
+	select NEED_MACH_MEMORY_H
+	select SPARSE_IRQ
+	select MULTI_IRQ_HANDLER
+
 if ARCH_INTEGRATOR
 
 menu "Integrator Options"
diff --git a/arch/arm/mach-iop13xx/Kconfig b/arch/arm/mach-iop13xx/Kconfig
index 40c2d68..d004752 100644
--- a/arch/arm/mach-iop13xx/Kconfig
+++ b/arch/arm/mach-iop13xx/Kconfig
@@ -1,3 +1,14 @@
+config ARCH_IOP13XX
+	bool
+	select CPU_XSC3
+	select PLAT_IOP
+	select PCI
+	select ARCH_SUPPORTS_MSI
+	select VMSPLIT_1G
+	select NEED_MACH_IO_H
+	select NEED_MACH_MEMORY_H
+	select NEED_RET_TO_USER
+
 if ARCH_IOP13XX
 
 menu "IOP13XX Implementation Options"
diff --git a/arch/arm/mach-iop32x/Kconfig b/arch/arm/mach-iop32x/Kconfig
index 5e8c6f7..f438f73 100644
--- a/arch/arm/mach-iop32x/Kconfig
+++ b/arch/arm/mach-iop32x/Kconfig
@@ -1,3 +1,13 @@
+config ARCH_IOP32X
+	bool
+	select CPU_XSCALE
+	select NEED_MACH_GPIO_H
+	select NEED_MACH_IO_H
+	select NEED_RET_TO_USER
+	select PLAT_IOP
+	select PCI
+	select ARCH_REQUIRE_GPIOLIB
+
 if ARCH_IOP32X
 
 menu "IOP32x Implementation Options"
diff --git a/arch/arm/mach-iop33x/Kconfig b/arch/arm/mach-iop33x/Kconfig
index 9aa016b..20b3dbe 100644
--- a/arch/arm/mach-iop33x/Kconfig
+++ b/arch/arm/mach-iop33x/Kconfig
@@ -1,3 +1,13 @@
+config ARCH_IOP33X
+	bool
+	select CPU_XSCALE
+	select NEED_MACH_GPIO_H
+	select NEED_MACH_IO_H
+	select NEED_RET_TO_USER
+	select PLAT_IOP
+	select PCI
+	select ARCH_REQUIRE_GPIOLIB
+
 if ARCH_IOP33X
 
 menu "IOP33x Implementation Options"
diff --git a/arch/arm/mach-ixp4xx/Kconfig b/arch/arm/mach-ixp4xx/Kconfig
index fd5e7b6..48f9978 100644
--- a/arch/arm/mach-ixp4xx/Kconfig
+++ b/arch/arm/mach-ixp4xx/Kconfig
@@ -1,3 +1,14 @@
+config ARCH_IXP4XX
+	bool
+	select ARCH_HAS_DMA_SET_COHERENT_MASK
+	select CLKSRC_MMIO
+	select CPU_XSCALE
+	select ARCH_REQUIRE_GPIOLIB
+	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_PCI
+	select NEED_MACH_IO_H
+	select DMABOUNCE if PCI
+
 if ARCH_IXP4XX
 
 config ARCH_SUPPORTS_BIG_ENDIAN
diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
index ca5c15a..2fedc99 100644
--- a/arch/arm/mach-kirkwood/Kconfig
+++ b/arch/arm/mach-kirkwood/Kconfig
@@ -1,3 +1,12 @@
+config ARCH_KIRKWOOD
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select CPU_FEROCEON
+	select GENERIC_CLOCKEVENTS
+	select NEED_MACH_IO_H
+	select PCI
+	select PLAT_ORION
+
 if ARCH_KIRKWOOD
 
 menu "Marvell Kirkwood Implementations"
diff --git a/arch/arm/mach-ks8695/Kconfig b/arch/arm/mach-ks8695/Kconfig
index f5c39a8..f73a02f 100644
--- a/arch/arm/mach-ks8695/Kconfig
+++ b/arch/arm/mach-ks8695/Kconfig
@@ -1,3 +1,10 @@
+config ARCH_KS8695
+	bool
+	select ARCH_USES_GETTIMEOFFSET
+	select ARCH_REQUIRE_GPIOLIB
+	select CPU_ARM922T
+	select NEED_MACH_MEMORY_H
+
 if ARCH_KS8695
 
 menu "Kendin/Micrel KS8695 Implementations"
diff --git a/arch/arm/mach-lpc32xx/Kconfig b/arch/arm/mach-lpc32xx/Kconfig
new file mode 100644
index 0000000..7975c48
--- /dev/null
+++ b/arch/arm/mach-lpc32xx/Kconfig
@@ -0,0 +1,12 @@
+config ARCH_LPC32XX
+	bool
+	select CLKSRC_MMIO
+	select CPU_ARM926T
+	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_IDE
+	select ARM_AMBA
+	select USB_ARCH_HAS_OHCI
+	select CLKDEV_LOOKUP
+	select GENERIC_CLOCKEVENTS
+	select USE_OF
+	select HAVE_PWM
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
index 7fddd01..2c586fd 100644
--- a/arch/arm/mach-mmp/Kconfig
+++ b/arch/arm/mach-mmp/Kconfig
@@ -1,3 +1,15 @@
+config ARCH_MMP
+	bool
+	depends on MMU
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select GENERIC_CLOCKEVENTS
+	select GPIO_PXA
+	select IRQ_DOMAIN
+	select PLAT_PXA
+	select SPARSE_IRQ
+	select GENERIC_ALLOCATOR
+
 if ARCH_MMP
 
 menu "Marvell PXA168/910/MMP2 Implmentations"
diff --git a/arch/arm/mach-msm/Kconfig b/arch/arm/mach-msm/Kconfig
index 1cd40ad..8b6994e 100644
--- a/arch/arm/mach-msm/Kconfig
+++ b/arch/arm/mach-msm/Kconfig
@@ -1,3 +1,10 @@
+config ARCH_MSM
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+
 if ARCH_MSM
 
 choice
diff --git a/arch/arm/mach-mv78xx0/Kconfig b/arch/arm/mach-mv78xx0/Kconfig
index f2d309d..6c09349 100644
--- a/arch/arm/mach-mv78xx0/Kconfig
+++ b/arch/arm/mach-mv78xx0/Kconfig
@@ -1,3 +1,12 @@
+config ARCH_MV78XX0
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select CPU_FEROCEON
+	select GENERIC_CLOCKEVENTS
+	select NEED_MACH_IO_H
+	select PCI
+	select PLAT_ORION
+
 if ARCH_MV78XX0
 
 menu "Marvell MV78xx0 Implementations"
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index caa2c5e..1ed7d15 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -1,3 +1,13 @@
+config ARCH_MVEBU
+	bool
+	select CLKSRC_MMIO
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_CHIP
+	select IRQ_DOMAIN
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
+
 if ARCH_MVEBU
 
 menu "Marvell SOC with device tree"
diff --git a/arch/arm/mach-mxs/Kconfig b/arch/arm/mach-mxs/Kconfig
index 9a8bbda..cea9703 100644
--- a/arch/arm/mach-mxs/Kconfig
+++ b/arch/arm/mach-mxs/Kconfig
@@ -1,3 +1,14 @@
+config ARCH_MXS
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK_PREPARE
+	select PINCTRL
+	select USE_OF
+
 if ARCH_MXS
 
 source "arch/arm/mach-mxs/devices/Kconfig"
diff --git a/arch/arm/mach-netx/Kconfig b/arch/arm/mach-netx/Kconfig
index 3d90ef1..29b1d56 100644
--- a/arch/arm/mach-netx/Kconfig
+++ b/arch/arm/mach-netx/Kconfig
@@ -1,3 +1,10 @@
+config ARCH_NETX
+	bool
+	select ARM_VIC
+	select CLKSRC_MMIO
+	select CPU_ARM926T
+	select GENERIC_CLOCKEVENTS
+
 menu "NetX Implementations"
 	depends on ARCH_NETX
 
diff --git a/arch/arm/mach-nomadik/Kconfig b/arch/arm/mach-nomadik/Kconfig
index 365879b..af0821d 100644
--- a/arch/arm/mach-nomadik/Kconfig
+++ b/arch/arm/mach-nomadik/Kconfig
@@ -1,3 +1,14 @@
+config ARCH_NOMADIK
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_AMBA
+	select ARM_VIC
+	select COMMON_CLK
+	select CPU_ARM926T
+	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_CACHE_L2X0
+	select PINCTRL
+
 if ARCH_NOMADIK
 
 menu "Nomadik boards"
diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
index 0673f0c..c8470c7 100644
--- a/arch/arm/mach-orion5x/Kconfig
+++ b/arch/arm/mach-orion5x/Kconfig
@@ -1,3 +1,12 @@
+config ARCH_ORION5X
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select CPU_FEROCEON
+	select GENERIC_CLOCKEVENTS
+	select NEED_MACH_IO_H
+	select PCI
+	select PLAT_ORION
+
 if ARCH_ORION5X
 
 menu "Orion Implementations"
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
new file mode 100644
index 0000000..b0fd5a1
--- /dev/null
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -0,0 +1,14 @@
+config ARCH_PICOXCELL
+	bool
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_PATCH_PHYS_VIRT
+	select ARM_VIC
+	select CPU_V6K
+	select DW_APB_TIMER
+	select DW_APB_TIMER_OF
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
+	select HAVE_TCM
+	select NO_IOPORT
+	select SPARSE_IRQ
+	select USE_OF
diff --git a/arch/arm/mach-pnx4008/Kconfig b/arch/arm/mach-pnx4008/Kconfig
new file mode 100644
index 0000000..b654cff
--- /dev/null
+++ b/arch/arm/mach-pnx4008/Kconfig
@@ -0,0 +1,5 @@
+config ARCH_PNX4008
+	bool
+	select CPU_ARM926T
+	select CLKDEV_LOOKUP
+	select ARCH_USES_GETTIMEOFFSET
diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index fe2d1f8..1c89e24 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -1,3 +1,19 @@
+config ARCH_PXA
+	bool
+	select ARCH_HAS_CPUFREQ
+	select ARCH_MTD_XIP
+	select ARCH_REQUIRE_GPIOLIB
+	select ARM_CPU_SUSPEND if PM
+	select AUTO_ZRELADDR
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
+	select GPIO_PXA
+	select HAVE_IDE
+	select MULTI_IRQ_HANDLER
+	select PLAT_PXA
+	select SPARSE_IRQ
+
 if ARCH_PXA
 
 menu "Intel PXA2xx/PXA3xx Implementations"
diff --git a/arch/arm/mach-realview/Kconfig b/arch/arm/mach-realview/Kconfig
index c593be4..2018527 100644
--- a/arch/arm/mach-realview/Kconfig
+++ b/arch/arm/mach-realview/Kconfig
@@ -1,3 +1,18 @@
+config ARCH_REALVIEW
+	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
+	select ARM_TIMER_SP804
+	select CLKDEV_LOOKUP
+	select GENERIC_CLOCKEVENTS
+	select GPIO_PL061 if GPIOLIB
+	select HAVE_MACH_CLKDEV
+	select ICST
+	select NEED_MACH_MEMORY_H
+	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLOCK
+	select PLAT_VERSATILE_CLCD
+
 menu "RealView platform type"
 	depends on ARCH_REALVIEW
 
diff --git a/arch/arm/mach-rpc/Kconfig b/arch/arm/mach-rpc/Kconfig
new file mode 100644
index 0000000..478d213
--- /dev/null
+++ b/arch/arm/mach-rpc/Kconfig
@@ -0,0 +1,13 @@
+config ARCH_RPC
+	bool
+	select ARCH_ACORN
+	select FIQ
+	select ARCH_MAY_HAVE_PC_FDC
+	select HAVE_PATA_PLATFORM
+	select ISA_DMA_API
+	select NO_IOPORT
+	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_USES_GETTIMEOFFSET
+	select HAVE_IDE
+	select NEED_MACH_IO_H
+	select NEED_MACH_MEMORY_H
diff --git a/arch/arm/mach-s3c24xx/Kconfig b/arch/arm/mach-s3c24xx/Kconfig
index d56b0f7..21dd369 100644
--- a/arch/arm/mach-s3c24xx/Kconfig
+++ b/arch/arm/mach-s3c24xx/Kconfig
@@ -7,6 +7,19 @@
 #
 # Licensed under GPLv2
 
+config ARCH_S3C24XX
+	bool
+	select ARCH_HAS_CPUFREQ
+	select ARCH_USES_GETTIMEOFFSET
+	select CLKDEV_LOOKUP
+	select GENERIC_GPIO
+	select HAVE_CLK
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C_RTC if RTC_CLASS
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
+	select NEED_MACH_IO_H
+
 if ARCH_S3C24XX
 
 menu "SAMSUNG S3C24XX SoCs Support"
diff --git a/arch/arm/mach-s3c64xx/Kconfig b/arch/arm/mach-s3c64xx/Kconfig
index 06ca1cd..4a0cdbb 100644
--- a/arch/arm/mach-s3c64xx/Kconfig
+++ b/arch/arm/mach-s3c64xx/Kconfig
@@ -3,6 +3,30 @@
 #
 # Licensed under GPLv2
 
+config ARCH_S3C64XX
+	bool
+	select PLAT_SAMSUNG
+	select CPU_V6
+	select ARM_VIC
+	select HAVE_CLK
+	select HAVE_TCM
+	select CLKDEV_LOOKUP
+	select NO_IOPORT
+	select ARCH_USES_GETTIMEOFFSET
+	select ARCH_HAS_CPUFREQ
+	select ARCH_REQUIRE_GPIOLIB
+	select SAMSUNG_CLKSRC
+	select SAMSUNG_IRQ_VIC_TIMER
+	select S3C_GPIO_TRACK
+	select S3C_DEV_NAND
+	select USB_ARCH_HAS_OHCI
+	select SAMSUNG_GPIOLIB_4BIT
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
+
+if ARCH_S3C64XX
+
 # temporary until we can eliminate all drivers using it.
 config PLAT_S3C64XX
 	bool
@@ -307,3 +331,5 @@ config MACH_WLF_CRAGG_6410
 	select LEDS_GPIO_REGISTER
 	help
 	  Machine support for the Wolfson Cragganmore S3C6410 variant.
+
+endif
diff --git a/arch/arm/mach-s5p64x0/Kconfig b/arch/arm/mach-s5p64x0/Kconfig
index c87f610..8215c54 100644
--- a/arch/arm/mach-s5p64x0/Kconfig
+++ b/arch/arm/mach-s5p64x0/Kconfig
@@ -5,6 +5,19 @@
 #
 # Licensed under GPLv2
 
+config ARCH_S5P64X0
+	bool
+	select CPU_V6
+	select GENERIC_GPIO
+	select HAVE_CLK
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select GENERIC_CLOCKEVENTS
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C_RTC if RTC_CLASS
+	select NEED_MACH_GPIO_H
+
 if ARCH_S5P64X0
 
 config CPU_S5P6440
diff --git a/arch/arm/mach-s5pc100/Kconfig b/arch/arm/mach-s5pc100/Kconfig
index 75a26ea..8114a81 100644
--- a/arch/arm/mach-s5pc100/Kconfig
+++ b/arch/arm/mach-s5pc100/Kconfig
@@ -5,6 +5,18 @@
 
 # Configuration options for the S5PC100 CPU
 
+config ARCH_S5PC100
+	bool
+	select GENERIC_GPIO
+	select HAVE_CLK
+	select CLKDEV_LOOKUP
+	select CPU_V7
+	select ARCH_USES_GETTIMEOFFSET
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C_RTC if RTC_CLASS
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
+
 if ARCH_S5PC100
 
 config CPU_S5PC100
diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index 77185c3..5633743 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -7,6 +7,23 @@
 
 # Configuration options for the S5PV210/S5PC110
 
+config ARCH_S5PV210
+	bool
+	select CPU_V7
+	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_HAS_HOLES_MEMORYMODEL
+	select GENERIC_GPIO
+	select HAVE_CLK
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select ARCH_HAS_CPUFREQ
+	select GENERIC_CLOCKEVENTS
+	select HAVE_S3C2410_I2C if I2C
+	select HAVE_S3C_RTC if RTC_CLASS
+	select HAVE_S3C2410_WATCHDOG if WATCHDOG
+	select NEED_MACH_GPIO_H
+	select NEED_MACH_MEMORY_H
+
 if ARCH_S5PV210
 
 config CPU_S5PV210
diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index 42625e4..37c31a3 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -1,3 +1,20 @@
+config ARCH_SA1100
+	bool
+	select CLKSRC_MMIO
+	select CPU_SA1100
+	select ISA
+	select ARCH_SPARSEMEM_ENABLE
+	select ARCH_MTD_XIP
+	select ARCH_HAS_CPUFREQ
+	select CPU_FREQ
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select ARCH_REQUIRE_GPIOLIB
+	select HAVE_IDE
+	select NEED_MACH_GPIO_H
+	select NEED_MACH_MEMORY_H
+	select SPARSE_IRQ
+
 if ARCH_SA1100
 
 menu "SA11x0 Implementations"
diff --git a/arch/arm/mach-shark/Kconfig b/arch/arm/mach-shark/Kconfig
new file mode 100644
index 0000000..93d03db
--- /dev/null
+++ b/arch/arm/mach-shark/Kconfig
@@ -0,0 +1,11 @@
+config ARCH_SHARK
+	bool
+	select CPU_SA110
+	select ISA
+	select ISA_DMA
+	select ZONE_DMA
+	select PCI
+	select ARCH_USES_GETTIMEOFFSET
+	select NEED_MACH_MEMORY_H
+	select NEED_MACH_IO_H
+
diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 4cacc2d..ee807ad 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -1,3 +1,17 @@
+config ARCH_SHMOBILE
+	bool
+	select HAVE_CLK
+	select CLKDEV_LOOKUP
+	select HAVE_MACH_CLKDEV
+	select HAVE_SMP
+	select GENERIC_CLOCKEVENTS
+	select MIGHT_HAVE_CACHE_L2X0
+	select NO_IOPORT
+	select SPARSE_IRQ
+	select MULTI_IRQ_HANDLER
+	select PM_GENERIC_DOMAINS if PM
+	select NEED_MACH_MEMORY_H
+
 if ARCH_SHMOBILE
 
 comment "SH-Mobile System Type"
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
new file mode 100644
index 0000000..51b04ba
--- /dev/null
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -0,0 +1,16 @@
+config ARCH_SOCFPGA
+	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
+	select ARM_GIC
+	select CACHE_L2X0
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select CPU_V7
+	select DW_APB_TIMER
+	select DW_APB_TIMER_OF
+	select GENERIC_CLOCKEVENTS
+	select GPIO_PL061 if GPIOLIB
+	select HAVE_ARM_SCU
+	select SPARSE_IRQ
+	select USE_OF
diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 9077aaa..d6ee9f5 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -1,3 +1,16 @@
+config ARCH_TEGRA
+	bool
+	select ARCH_HAS_CPUFREQ
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
+	select GENERIC_GPIO
+	select HAVE_CLK
+	select HAVE_SMP
+	select MIGHT_HAVE_CACHE_L2X0
+	select NEED_MACH_IO_H if PCI
+	select USE_OF
+
 if ARCH_TEGRA
 
 comment "NVIDIA Tegra options"
diff --git a/arch/arm/mach-u300/Kconfig b/arch/arm/mach-u300/Kconfig
index 54d8f34..bd442a0 100644
--- a/arch/arm/mach-u300/Kconfig
+++ b/arch/arm/mach-u300/Kconfig
@@ -1,3 +1,17 @@
+config ARCH_U300
+	bool
+	select CLKSRC_MMIO
+	select CPU_ARM926T
+	select HAVE_TCM
+	select ARM_AMBA
+	select ARM_PATCH_PHYS_VIRT
+	select ARM_VIC
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select GENERIC_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+
 if ARCH_U300
 
 menu "ST-Ericsson AB U300/U330/U335/U365 Platform"
diff --git a/arch/arm/mach-ux500/Kconfig b/arch/arm/mach-ux500/Kconfig
index c013bbf..6b40959 100644
--- a/arch/arm/mach-ux500/Kconfig
+++ b/arch/arm/mach-ux500/Kconfig
@@ -1,3 +1,14 @@
+config ARCH_U8500
+	bool
+	select CPU_V7
+	select ARM_AMBA
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_CPUFREQ
+	select HAVE_SMP
+	select MIGHT_HAVE_CACHE_L2X0
+
 if ARCH_U8500
 
 config UX500_SOC_COMMON
diff --git a/arch/arm/mach-versatile/Kconfig b/arch/arm/mach-versatile/Kconfig
index c1f38f6..cd63ea6 100644
--- a/arch/arm/mach-versatile/Kconfig
+++ b/arch/arm/mach-versatile/Kconfig
@@ -1,3 +1,19 @@
+config ARCH_VERSATILE
+	bool
+	select ARM_AMBA
+	select ARM_VIC
+	select CLKDEV_LOOKUP
+	select HAVE_MACH_CLKDEV
+	select ICST
+	select GENERIC_CLOCKEVENTS
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select NEED_MACH_IO_H if PCI
+	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLOCK
+	select PLAT_VERSATILE_CLCD
+	select PLAT_VERSATILE_FPGA_IRQ
+	select ARM_TIMER_SP804
+
 menu "Versatile platform type"
 	depends on ARCH_VERSATILE
 
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index fc3730f..8ce13a7 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,3 +1,19 @@
+config ARCH_VEXPRESS
+	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_AMBA
+	select ARM_TIMER_SP804
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
+	select HAVE_PATA_PLATFORM
+	select ICST
+	select NO_IOPORT
+	select PLAT_VERSATILE
+	select PLAT_VERSATILE_CLCD
+	select REGULATOR_FIXED_VOLTAGE if REGULATOR
+
 menu "Versatile Express platform type"
 	depends on ARCH_VEXPRESS
 
diff --git a/arch/arm/mach-vt8500/Kconfig b/arch/arm/mach-vt8500/Kconfig
index 2c20a34..fa22d24 100644
--- a/arch/arm/mach-vt8500/Kconfig
+++ b/arch/arm/mach-vt8500/Kconfig
@@ -1,3 +1,11 @@
+config ARCH_VT8500
+	bool
+	select CPU_ARM926T
+	select GENERIC_GPIO
+	select ARCH_HAS_CPUFREQ
+	select GENERIC_CLOCKEVENTS
+	select ARCH_REQUIRE_GPIOLIB
+
 if ARCH_VT8500
 
 config VTWM_VERSION_VT8500
diff --git a/arch/arm/mach-w90x900/Kconfig b/arch/arm/mach-w90x900/Kconfig
index 69bab32..ab4b2fc 100644
--- a/arch/arm/mach-w90x900/Kconfig
+++ b/arch/arm/mach-w90x900/Kconfig
@@ -1,3 +1,11 @@
+config ARCH_W90X900
+	bool
+	select CPU_ARM926T
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
+
 if ARCH_W90X900
 
 config CPU_W90P910
diff --git a/arch/arm/mach-zynq/Kconfig b/arch/arm/mach-zynq/Kconfig
new file mode 100644
index 0000000..1560167
--- /dev/null
+++ b/arch/arm/mach-zynq/Kconfig
@@ -0,0 +1,10 @@
+config ARCH_ZYNQ
+	bool
+	select CPU_V7
+	select GENERIC_CLOCKEVENTS
+	select CLKDEV_LOOKUP
+	select ARM_GIC
+	select ARM_AMBA
+	select ICST
+	select MIGHT_HAVE_CACHE_L2X0
+	select USE_OF
diff --git a/arch/arm/plat-mxc/Kconfig b/arch/arm/plat-mxc/Kconfig
index baf9064..84af663 100644
--- a/arch/arm/plat-mxc/Kconfig
+++ b/arch/arm/plat-mxc/Kconfig
@@ -1,3 +1,14 @@
+config ARCH_MXC
+	bool
+	select GENERIC_CLOCKEVENTS
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select CLKSRC_MMIO
+	select GENERIC_IRQ_CHIP
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
+	select USE_OF
+
 if ARCH_MXC
 
 source "arch/arm/plat-mxc/devices/Kconfig"
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index dd36eba..8b86fca 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -1,3 +1,12 @@
+config ARCH_OMAP
+	bool
+	select HAVE_CLK
+	select ARCH_REQUIRE_GPIOLIB
+	select ARCH_HAS_CPUFREQ
+	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
+	select ARCH_HAS_HOLES_MEMORYMODEL
+
 if ARCH_OMAP
 
 menu "TI OMAP Common Features"
diff --git a/arch/arm/plat-spear/Kconfig b/arch/arm/plat-spear/Kconfig
index 4404f82..50088bb 100644
--- a/arch/arm/plat-spear/Kconfig
+++ b/arch/arm/plat-spear/Kconfig
@@ -1,6 +1,15 @@
 #
 # SPEAr Platform configuration file
 #
+config PLAT_SPEAR
+	bool
+	select ARM_AMBA
+	select ARCH_REQUIRE_GPIOLIB
+	select CLKDEV_LOOKUP
+	select COMMON_CLK
+	select CLKSRC_MMIO
+	select GENERIC_CLOCKEVENTS
+	select HAVE_CLK
 
 if PLAT_SPEAR
 
-- 
1.7.9.5
