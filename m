From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 15:12:54 -0500
Subject: [PATCH 11/12] ARM: initial multiplatform support
In-Reply-To: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346962375-26163-12-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This lets us build a multiplatform kernel for experimental purposes.
However, it will not be useful for any real work, because it relies
on a number of useful things to be disabled for now:

* SMP support must be turned off because of conflicting symbols.
  Marc Zyngier has proposed a solution by adding a new SOC
  operations structure to hold indirect function pointers
  for these, but that work is currently stalled

* We turn on SPARSE_IRQ unconditionally, which is not supported
  on most platforms. Each of them is currently in a different
  state, but most are being worked on.

* A common clock framework is in place since v3.4 but not yet
  being used. Work on this is on its way.

* DEBUG_LL for early debugging is currently disabled.

* THUMB2_KERNEL does not work with allyesconfig because the
  kernel gets too big

[Rob Herring]: Rebased to not be dependent on the mass mach header rename.
As a result, omap2plus, imx, mxs and ux500 are not converted. Highbank,
picoxcell, mvebu, and socfpga are converted.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jamie Iles <jamie@jamieiles.com>
Cc: Dinh Nguyen <dinguyen@altera.com>
---
 arch/arm/Kconfig                                  |  123 ++++++++--------
 arch/arm/Kconfig.debug                            |    1 +
 arch/arm/Makefile                                 |  155 +++++++++++----------
 arch/arm/boot/compressed/misc.c                   |    6 +
 arch/arm/include/asm/timex.h                      |    4 +
 arch/arm/mach-highbank/Kconfig                    |   15 ++
 arch/arm/mach-highbank/Makefile.boot              |    1 -
 arch/arm/mach-highbank/include/mach/timex.h       |    6 -
 arch/arm/mach-highbank/include/mach/uncompress.h  |    9 --
 arch/arm/mach-mvebu/Kconfig                       |   10 ++
 arch/arm/mach-mvebu/Makefile                      |    2 +
 arch/arm/mach-mvebu/Makefile.boot                 |    1 -
 arch/arm/mach-mvebu/include/mach/timex.h          |   13 --
 arch/arm/mach-mvebu/include/mach/uncompress.h     |   43 ------
 arch/arm/mach-picoxcell/Kconfig                   |   14 ++
 arch/arm/mach-picoxcell/Makefile.boot             |    1 -
 arch/arm/mach-picoxcell/include/mach/hardware.h   |   21 ---
 arch/arm/mach-picoxcell/include/mach/timex.h      |   25 ----
 arch/arm/mach-picoxcell/include/mach/uncompress.h |   21 ---
 arch/arm/mach-socfpga/Kconfig                     |   16 +++
 arch/arm/mach-socfpga/Makefile.boot               |    1 -
 arch/arm/mach-socfpga/include/mach/timex.h        |   19 ---
 arch/arm/mach-socfpga/include/mach/uncompress.h   |    9 --
 23 files changed, 205 insertions(+), 311 deletions(-)
 create mode 100644 arch/arm/mach-highbank/Kconfig
 delete mode 100644 arch/arm/mach-highbank/Makefile.boot
 delete mode 100644 arch/arm/mach-highbank/include/mach/timex.h
 delete mode 100644 arch/arm/mach-highbank/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-mvebu/Makefile.boot
 delete mode 100644 arch/arm/mach-mvebu/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mvebu/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-picoxcell/Kconfig
 delete mode 100644 arch/arm/mach-picoxcell/Makefile.boot
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/timex.h
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-socfpga/Kconfig
 delete mode 100644 arch/arm/mach-socfpga/Makefile.boot
 delete mode 100644 arch/arm/mach-socfpga/include/mach/timex.h
 delete mode 100644 arch/arm/mach-socfpga/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4f5652d..ebaf088 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -254,26 +254,17 @@ config MMU
 #
 choice
 	prompt "ARM system type"
-	default ARCH_VERSATILE
+	default ARCH_MULTIPLATFORM
 
-config ARCH_SOCFPGA
-	bool "Altera SOCFPGA family"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_AMBA
-	select ARM_GIC
-	select CACHE_L2X0
-	select CLKDEV_LOOKUP
+config ARCH_MULTIPLATFORM
+	bool "Allow multiple platforms to be selected"
+	select ARM_PATCH_PHYS_VIRT
+	select AUTO_ZRELADDR
 	select COMMON_CLK
-	select CPU_V7
-	select DW_APB_TIMER
-	select DW_APB_TIMER_OF
-	select GENERIC_CLOCKEVENTS
-	select GPIO_PL061 if GPIOLIB
-	select HAVE_ARM_SCU
+	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
-	help
-	  This enables support for Altera SOCFPGA Cyclone V platform
+	depends on MMU
 
 config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
@@ -370,24 +361,6 @@ config ARCH_BCMRING
 	help
 	  Support for Broadcom's BCMRing platform.
 
-config ARCH_HIGHBANK
-	bool "Calxeda Highbank-based"
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
-	help
-	  Support for the Calxeda Highbank SoC based boards.
-
 config ARCH_CLPS711X
 	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
 	select CPU_ARM720T
@@ -568,18 +541,6 @@ config ARCH_IXP4XX
 	help
 	  Support for Intel's IXP4XX (XScale) family of processors.
 
-config ARCH_MVEBU
-	bool "Marvell SOCs with Device Tree support"
-	select GENERIC_CLOCKEVENTS
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-	select CLKSRC_MMIO
-	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN
-	select COMMON_CLK
-	help
-	  Support for the Marvell SoC Family with device tree support
-
 config ARCH_DOVE
 	bool "Marvell Dove"
 	select CPU_V7
@@ -701,25 +662,6 @@ config ARCH_TEGRA
 	  This enables support for NVIDIA Tegra based systems (Tegra APX,
 	  Tegra 6xx and Tegra 2 series).
 
-config ARCH_PICOXCELL
-	bool "Picochip picoXcell"
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
-	help
-	  This enables support for systems based on the Picochip picoXcell
-	  family of Femtocell devices.  The picoxcell support requires device tree
-	  for all boards.
-
 config ARCH_PNX4008
 	bool "Philips Nexperia PNX4008 Mobile"
 	select CPU_ARM926T
@@ -1043,6 +985,49 @@ config ARCH_ZYNQ
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
 endchoice
 
+menu "Multiple platform selection"
+	depends on ARCH_MULTIPLATFORM
+
+comment "CPU Core family selection"
+
+config ARCH_MULTI_V4
+	bool "ARMv4 based platforms (FA526, StrongARM)"
+	select ARCH_MULTI_V4_V5
+	depends on !ARCH_MULTI_V6_V7
+
+config ARCH_MULTI_V4T
+	bool "ARMv4T based platforms (ARM720T, ARM920T, ...)"
+	select ARCH_MULTI_V4_V5
+	depends on !ARCH_MULTI_V6_V7
+
+config ARCH_MULTI_V5
+	bool "ARMv5 based platforms (ARM926T, XSCALE, PJ1, ...)"
+	select ARCH_MULTI_V4_V5
+	depends on !ARCH_MULTI_V6_V7
+
+config ARCH_MULTI_V4_V5
+	bool
+
+config ARCH_MULTI_V6
+	bool "ARMv6 based platforms (ARM11, Scorpion, ...)"
+	select CPU_V6
+	select ARCH_MULTI_V6_V7
+
+config ARCH_MULTI_V7
+	bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
+	select CPU_V7
+	default y
+	select ARCH_MULTI_V6_V7
+
+config ARCH_MULTI_V6_V7
+	bool
+
+config ARCH_MULTI_CPU_AUTO
+	def_bool !(ARCH_MULTI_V4 || ARCH_MULTI_V4T || ARCH_MULTI_V6_V7)
+	select ARCH_MULTI_V5
+
+endmenu
+
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
 # Kconfigs may be included either alphabetically (according to the
@@ -1070,6 +1055,8 @@ source "arch/arm/mach-gemini/Kconfig"
 
 source "arch/arm/mach-h720x/Kconfig"
 
+source "arch/arm/mach-highbank/Kconfig"
+
 source "arch/arm/mach-integrator/Kconfig"
 
 source "arch/arm/mach-iop32x/Kconfig"
@@ -1105,6 +1092,8 @@ source "arch/arm/mach-omap2/Kconfig"
 
 source "arch/arm/mach-orion5x/Kconfig"
 
+source "arch/arm/mach-picoxcell/Kconfig"
+
 source "arch/arm/mach-pxa/Kconfig"
 source "arch/arm/plat-pxa/Kconfig"
 
@@ -1117,6 +1106,8 @@ source "arch/arm/mach-sa1100/Kconfig"
 source "arch/arm/plat-samsung/Kconfig"
 source "arch/arm/plat-s3c24xx/Kconfig"
 
+source "arch/arm/mach-socfpga/Kconfig"
+
 source "arch/arm/plat-spear/Kconfig"
 
 source "arch/arm/mach-s3c24xx/Kconfig"
@@ -2081,7 +2072,7 @@ endchoice
 
 config XIP_KERNEL
 	bool "Kernel Execute-In-Place from ROM"
-	depends on !ZBOOT_ROM && !ARM_LPAE
+	depends on !ZBOOT_ROM && !ARM_LPAE && !ARCH_MULTIPLATFORM
 	help
 	  Execute-In-Place allows the kernel to run from non-volatile storage
 	  directly addressable by the CPU, such as NOR flash. This saves RAM
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index b74ed97..3e57e9a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -359,6 +359,7 @@ choice
 
 	config DEBUG_LL_UART_NONE
 		bool "No low-level debugging UART"
+		depends on !ARCH_MULTIPLATFORM
 		help
 		  Say Y here if your platform doesn't provide a UART option
 		  below. This relies on your platform choosing the right UART
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30eae87..fe6e05e 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -135,84 +135,84 @@ textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
-machine-$(CONFIG_ARCH_AT91)		:= at91
-machine-$(CONFIG_ARCH_BCMRING)		:= bcmring
-machine-$(CONFIG_ARCH_CLPS711X)		:= clps711x
-machine-$(CONFIG_ARCH_CNS3XXX)		:= cns3xxx
-machine-$(CONFIG_ARCH_DAVINCI)		:= davinci
-machine-$(CONFIG_ARCH_DOVE)		:= dove
-machine-$(CONFIG_ARCH_EBSA110)		:= ebsa110
-machine-$(CONFIG_ARCH_EP93XX)		:= ep93xx
-machine-$(CONFIG_ARCH_GEMINI)		:= gemini
-machine-$(CONFIG_ARCH_H720X)		:= h720x
-machine-$(CONFIG_ARCH_HIGHBANK)		:= highbank
-machine-$(CONFIG_ARCH_INTEGRATOR)	:= integrator
-machine-$(CONFIG_ARCH_IOP13XX)		:= iop13xx
-machine-$(CONFIG_ARCH_IOP32X)		:= iop32x
-machine-$(CONFIG_ARCH_IOP33X)		:= iop33x
-machine-$(CONFIG_ARCH_IXP4XX)		:= ixp4xx
-machine-$(CONFIG_ARCH_KIRKWOOD)		:= kirkwood
-machine-$(CONFIG_ARCH_KS8695)		:= ks8695
-machine-$(CONFIG_ARCH_LPC32XX)		:= lpc32xx
-machine-$(CONFIG_ARCH_MMP)		:= mmp
-machine-$(CONFIG_ARCH_MSM)		:= msm
-machine-$(CONFIG_ARCH_MV78XX0)		:= mv78xx0
-machine-$(CONFIG_ARCH_IMX_V4_V5)	:= imx
-machine-$(CONFIG_ARCH_IMX_V6_V7)	:= imx
-machine-$(CONFIG_ARCH_MXS)		:= mxs
-machine-$(CONFIG_ARCH_MVEBU)		:= mvebu
-machine-$(CONFIG_ARCH_NETX)		:= netx
-machine-$(CONFIG_ARCH_NOMADIK)		:= nomadik
-machine-$(CONFIG_ARCH_OMAP1)		:= omap1
-machine-$(CONFIG_ARCH_OMAP2PLUS)	:= omap2
-machine-$(CONFIG_ARCH_ORION5X)		:= orion5x
-machine-$(CONFIG_ARCH_PICOXCELL)	:= picoxcell
-machine-$(CONFIG_ARCH_PNX4008)		:= pnx4008
-machine-$(CONFIG_ARCH_PRIMA2)		:= prima2
-machine-$(CONFIG_ARCH_PXA)		:= pxa
-machine-$(CONFIG_ARCH_REALVIEW)		:= realview
-machine-$(CONFIG_ARCH_RPC)		:= rpc
-machine-$(CONFIG_ARCH_S3C24XX)		:= s3c24xx s3c2412 s3c2440
-machine-$(CONFIG_ARCH_S3C64XX)		:= s3c64xx
-machine-$(CONFIG_ARCH_S5P64X0)		:= s5p64x0
-machine-$(CONFIG_ARCH_S5PC100)		:= s5pc100
-machine-$(CONFIG_ARCH_S5PV210)		:= s5pv210
-machine-$(CONFIG_ARCH_EXYNOS4)		:= exynos
-machine-$(CONFIG_ARCH_EXYNOS5)		:= exynos
-machine-$(CONFIG_ARCH_SA1100)		:= sa1100
-machine-$(CONFIG_ARCH_SHARK)		:= shark
-machine-$(CONFIG_ARCH_SHMOBILE) 	:= shmobile
-machine-$(CONFIG_ARCH_TEGRA)		:= tegra
-machine-$(CONFIG_ARCH_U300)		:= u300
-machine-$(CONFIG_ARCH_U8500)		:= ux500
-machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
-machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
-machine-$(CONFIG_ARCH_VT8500)		:= vt8500
-machine-$(CONFIG_ARCH_W90X900)		:= w90x900
-machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
-machine-$(CONFIG_ARCH_SOCFPGA)		:= socfpga
-machine-$(CONFIG_MACH_SPEAR1310)	:= spear13xx
-machine-$(CONFIG_MACH_SPEAR1340)	:= spear13xx
-machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
-machine-$(CONFIG_MACH_SPEAR310)		:= spear3xx
-machine-$(CONFIG_MACH_SPEAR320)		:= spear3xx
-machine-$(CONFIG_MACH_SPEAR600)		:= spear6xx
-machine-$(CONFIG_ARCH_ZYNQ)		:= zynq
+machine-$(CONFIG_ARCH_AT91)		+= at91
+machine-$(CONFIG_ARCH_BCMRING)		+= bcmring
+machine-$(CONFIG_ARCH_CLPS711X)		+= clps711x
+machine-$(CONFIG_ARCH_CNS3XXX)		+= cns3xxx
+machine-$(CONFIG_ARCH_DAVINCI)		+= davinci
+machine-$(CONFIG_ARCH_DOVE)		+= dove
+machine-$(CONFIG_ARCH_EBSA110)		+= ebsa110
+machine-$(CONFIG_ARCH_EP93XX)		+= ep93xx
+machine-$(CONFIG_ARCH_GEMINI)		+= gemini
+machine-$(CONFIG_ARCH_H720X)		+= h720x
+machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
+machine-$(CONFIG_ARCH_INTEGRATOR)	+= integrator
+machine-$(CONFIG_ARCH_IOP13XX)		+= iop13xx
+machine-$(CONFIG_ARCH_IOP32X)		+= iop32x
+machine-$(CONFIG_ARCH_IOP33X)		+= iop33x
+machine-$(CONFIG_ARCH_IXP4XX)		+= ixp4xx
+machine-$(CONFIG_ARCH_KIRKWOOD)		+= kirkwood
+machine-$(CONFIG_ARCH_KS8695)		+= ks8695
+machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
+machine-$(CONFIG_ARCH_MMP)		+= mmp
+machine-$(CONFIG_ARCH_MSM)		+= msm
+machine-$(CONFIG_ARCH_MV78XX0)		+= mv78xx0
+machine-$(CONFIG_ARCH_IMX_V4_V5)	+= imx
+machine-$(CONFIG_ARCH_IMX_V6_V7)	+= imx
+machine-$(CONFIG_ARCH_MXS)		+= mxs
+machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
+machine-$(CONFIG_ARCH_NETX)		+= netx
+machine-$(CONFIG_ARCH_NOMADIK)		+= nomadik
+machine-$(CONFIG_ARCH_OMAP1)		+= omap1
+machine-$(CONFIG_ARCH_OMAP2PLUS)	+= omap2
+machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
+machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
+machine-$(CONFIG_ARCH_PNX4008)		+= pnx4008
+machine-$(CONFIG_ARCH_PRIMA2)		+= prima2
+machine-$(CONFIG_ARCH_PXA)		+= pxa
+machine-$(CONFIG_ARCH_REALVIEW)		+= realview
+machine-$(CONFIG_ARCH_RPC)		+= rpc
+machine-$(CONFIG_ARCH_S3C24XX)		+= s3c24xx s3c2412 s3c2440
+machine-$(CONFIG_ARCH_S3C64XX)		+= s3c64xx
+machine-$(CONFIG_ARCH_S5P64X0)		+= s5p64x0
+machine-$(CONFIG_ARCH_S5PC100)		+= s5pc100
+machine-$(CONFIG_ARCH_S5PV210)		+= s5pv210
+machine-$(CONFIG_ARCH_EXYNOS4)		+= exynos
+machine-$(CONFIG_ARCH_EXYNOS5)		+= exynos
+machine-$(CONFIG_ARCH_SA1100)		+= sa1100
+machine-$(CONFIG_ARCH_SHARK)		+= shark
+machine-$(CONFIG_ARCH_SHMOBILE) 	+= shmobile
+machine-$(CONFIG_ARCH_TEGRA)		+= tegra
+machine-$(CONFIG_ARCH_U300)		+= u300
+machine-$(CONFIG_ARCH_U8500)		+= ux500
+machine-$(CONFIG_ARCH_VERSATILE)	+= versatile
+machine-$(CONFIG_ARCH_VEXPRESS)		+= vexpress
+machine-$(CONFIG_ARCH_VT8500)		+= vt8500
+machine-$(CONFIG_ARCH_W90X900)		+= w90x900
+machine-$(CONFIG_FOOTBRIDGE)		+= footbridge
+machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
+machine-$(CONFIG_MACH_SPEAR1310)	+= spear13xx
+machine-$(CONFIG_MACH_SPEAR1340)	+= spear13xx
+machine-$(CONFIG_MACH_SPEAR300)		+= spear3xx
+machine-$(CONFIG_MACH_SPEAR310)		+= spear3xx
+machine-$(CONFIG_MACH_SPEAR320)		+= spear3xx
+machine-$(CONFIG_MACH_SPEAR600)		+= spear6xx
+machine-$(CONFIG_ARCH_ZYNQ)		+= zynq
 
 # Platform directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
-plat-$(CONFIG_ARCH_MXC)		:= mxc
-plat-$(CONFIG_ARCH_OMAP)	:= omap
-plat-$(CONFIG_ARCH_S3C64XX)	:= samsung
-plat-$(CONFIG_ARCH_ZYNQ)	:= versatile
-plat-$(CONFIG_PLAT_IOP)		:= iop
-plat-$(CONFIG_PLAT_NOMADIK)	:= nomadik
-plat-$(CONFIG_PLAT_ORION)	:= orion
-plat-$(CONFIG_PLAT_PXA)		:= pxa
-plat-$(CONFIG_PLAT_S3C24XX)	:= s3c24xx samsung
-plat-$(CONFIG_PLAT_S5P)		:= samsung
-plat-$(CONFIG_PLAT_SPEAR)	:= spear
-plat-$(CONFIG_PLAT_VERSATILE)	:= versatile
+plat-$(CONFIG_ARCH_MXC)		+= mxc
+plat-$(CONFIG_ARCH_OMAP)	+= omap
+plat-$(CONFIG_ARCH_S3C64XX)	+= samsung
+plat-$(CONFIG_ARCH_ZYNQ)	+= versatile
+plat-$(CONFIG_PLAT_IOP)		+= iop
+plat-$(CONFIG_PLAT_NOMADIK)	+= nomadik
+plat-$(CONFIG_PLAT_ORION)	+= orion
+plat-$(CONFIG_PLAT_PXA)		+= pxa
+plat-$(CONFIG_PLAT_S3C24XX)	+= s3c24xx samsung
+plat-$(CONFIG_PLAT_S5P)		+= samsung
+plat-$(CONFIG_PLAT_SPEAR)	+= spear
+plat-$(CONFIG_PLAT_VERSATILE)	+= versatile
 
 ifeq ($(CONFIG_ARCH_EBSA110),y)
 # This is what happens if you forget the IOCS16 line.
@@ -230,15 +230,20 @@ MACHINE  := arch/arm/mach-$(word 1,$(machine-y))/
 else
 MACHINE  :=
 endif
+ifeq ($(CONFIG_ARCH_MULTIPLATFORM),y)
+MACHINE  :=
+endif
 
 machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
 platdirs := $(patsubst %,arch/arm/plat-%/,$(plat-y))
 
+ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
 ifeq ($(KBUILD_SRC),)
 KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
 else
 KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
 endif
+endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
 
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index 8e2a8fc..df89983 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -25,7 +25,13 @@ unsigned int __machine_arch_type;
 static void putstr(const char *ptr);
 extern void error(char *x);
 
+#ifdef CONFIG_ARCH_MULTIPLATFORM
+static inline void putc(int c) {}
+static inline void flush(void) {}
+static inline void arch_decomp_setup(void) {}
+#else
 #include <mach/uncompress.h>
+#endif
 
 #ifdef CONFIG_DEBUG_ICEDCC
 
diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index ce11944..963342a 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -13,7 +13,11 @@
 #define _ASMARM_TIMEX_H
 
 #include <asm/arch_timer.h>
+#ifdef CONFIG_ARCH_MULTIPLATFORM
+#define CLOCK_TICK_RATE 1000000
+#else
 #include <mach/timex.h>
+#endif
 
 typedef unsigned long cycles_t;
 
diff --git a/arch/arm/mach-highbank/Kconfig b/arch/arm/mach-highbank/Kconfig
new file mode 100644
index 0000000..0e1d0a4
--- /dev/null
+++ b/arch/arm/mach-highbank/Kconfig
@@ -0,0 +1,15 @@
+config ARCH_HIGHBANK
+	bool "Calxeda ECX-1000 (Highbank)" if ARCH_MULTI_V7
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
diff --git a/arch/arm/mach-highbank/Makefile.boot b/arch/arm/mach-highbank/Makefile.boot
deleted file mode 100644
index dae9661..0000000
--- a/arch/arm/mach-highbank/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-zreladdr-y	:= 0x00008000
diff --git a/arch/arm/mach-highbank/include/mach/timex.h b/arch/arm/mach-highbank/include/mach/timex.h
deleted file mode 100644
index 88dac7a..0000000
--- a/arch/arm/mach-highbank/include/mach/timex.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __MACH_TIMEX_H
-#define __MACH_TIMEX_H
-
-#define CLOCK_TICK_RATE		1000000
-
-#endif
diff --git a/arch/arm/mach-highbank/include/mach/uncompress.h b/arch/arm/mach-highbank/include/mach/uncompress.h
deleted file mode 100644
index bbe20e6..0000000
--- a/arch/arm/mach-highbank/include/mach/uncompress.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __MACH_UNCOMPRESS_H
-#define __MACH_UNCOMPRESS_H
-
-#define putc(c)
-#define flush()
-#define arch_decomp_setup()
-#define arch_decomp_wdog()
-
-#endif
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index caa2c5e..7b27035 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -1,3 +1,13 @@
+config ARCH_MVEBU
+	bool "Marvell SOCs with Device Tree support" if ARCH_MULTI_V7
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
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index e61d2b8..6ea8998 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,2 +1,4 @@
+ccflags-$(ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+
 obj-y += system-controller.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o
diff --git a/arch/arm/mach-mvebu/Makefile.boot b/arch/arm/mach-mvebu/Makefile.boot
deleted file mode 100644
index b327175..0000000
--- a/arch/arm/mach-mvebu/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-zreladdr-y := 0x00008000
diff --git a/arch/arm/mach-mvebu/include/mach/timex.h b/arch/arm/mach-mvebu/include/mach/timex.h
deleted file mode 100644
index ab324a3..0000000
--- a/arch/arm/mach-mvebu/include/mach/timex.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- * Marvell Armada SoC time definitions
- *
- * Copyright (C) 2012 Marvell
- *
- * Lior Amsalem <alior@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#define CLOCK_TICK_RATE		(100 * HZ)
diff --git a/arch/arm/mach-mvebu/include/mach/uncompress.h b/arch/arm/mach-mvebu/include/mach/uncompress.h
deleted file mode 100644
index d6a100c..0000000
--- a/arch/arm/mach-mvebu/include/mach/uncompress.h
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- * Marvell Armada SoC kernel uncompression UART routines
- *
- * Copyright (C) 2012 Marvell
- *
- * Lior Amsalem <alior@marvell.com>
- *
- * This file is licensed under the terms of the GNU General Public
- * License version 2.  This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-
-#include <mach/armada-370-xp.h>
-
-#define UART_THR ((volatile unsigned char *)(ARMADA_370_XP_REGS_PHYS_BASE\
-								+ 0x12000))
-#define UART_LSR ((volatile unsigned char *)(ARMADA_370_XP_REGS_PHYS_BASE\
-								+ 0x12014))
-
-#define LSR_THRE	0x20
-
-static void putc(const char c)
-{
-	int i;
-
-	for (i = 0; i < 0x1000; i++) {
-		/* Transmit fifo not full? */
-		if (*UART_LSR & LSR_THRE)
-			break;
-	}
-
-	*UART_THR = c;
-}
-
-static void flush(void)
-{
-}
-
-/*
- * nothing to do
- */
-#define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
new file mode 100644
index 0000000..868796f
--- /dev/null
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -0,0 +1,14 @@
+config ARCH_PICOXCELL
+	bool "Picochip PicoXcell" if ARCH_MULTI_V6
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
diff --git a/arch/arm/mach-picoxcell/Makefile.boot b/arch/arm/mach-picoxcell/Makefile.boot
deleted file mode 100644
index b327175..0000000
--- a/arch/arm/mach-picoxcell/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-zreladdr-y := 0x00008000
diff --git a/arch/arm/mach-picoxcell/include/mach/hardware.h b/arch/arm/mach-picoxcell/include/mach/hardware.h
deleted file mode 100644
index 70ff581..0000000
--- a/arch/arm/mach-picoxcell/include/mach/hardware.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This file contains the hardware definitions of the picoXcell SoC devices.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- */
-#ifndef __ASM_ARCH_HARDWARE_H
-#define __ASM_ARCH_HARDWARE_H
-
-#include <mach/picoxcell_soc.h>
-
-#endif
diff --git a/arch/arm/mach-picoxcell/include/mach/timex.h b/arch/arm/mach-picoxcell/include/mach/timex.h
deleted file mode 100644
index 6c540a6..0000000
--- a/arch/arm/mach-picoxcell/include/mach/timex.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#ifndef __TIMEX_H__
-#define __TIMEX_H__
-
-/* Bogus value to allow the kernel to compile. */
-#define CLOCK_TICK_RATE		1000000
-
-#endif /* __TIMEX_H__ */
-
diff --git a/arch/arm/mach-picoxcell/include/mach/uncompress.h b/arch/arm/mach-picoxcell/include/mach/uncompress.h
deleted file mode 100644
index b60b19d..0000000
--- a/arch/arm/mach-picoxcell/include/mach/uncompress.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/*
- * Copyright (c) 2011 Picochip Ltd., Jamie Iles
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-#define putc(c)
-#define flush()
-#define arch_decomp_setup()
-#define arch_decomp_wdog()
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
new file mode 100644
index 0000000..803a328
--- /dev/null
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -0,0 +1,16 @@
+config ARCH_SOCFPGA
+	bool "Altera SOCFPGA family" if ARCH_MULTI_V7
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
diff --git a/arch/arm/mach-socfpga/Makefile.boot b/arch/arm/mach-socfpga/Makefile.boot
deleted file mode 100644
index dae9661..0000000
--- a/arch/arm/mach-socfpga/Makefile.boot
+++ /dev/null
@@ -1 +0,0 @@
-zreladdr-y	:= 0x00008000
diff --git a/arch/arm/mach-socfpga/include/mach/timex.h b/arch/arm/mach-socfpga/include/mach/timex.h
deleted file mode 100644
index 43df435..0000000
--- a/arch/arm/mach-socfpga/include/mach/timex.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/*
- *  Copyright (C) 2003 ARM Limited
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#define CLOCK_TICK_RATE		(50000000 / 16)
diff --git a/arch/arm/mach-socfpga/include/mach/uncompress.h b/arch/arm/mach-socfpga/include/mach/uncompress.h
deleted file mode 100644
index bbe20e6..0000000
--- a/arch/arm/mach-socfpga/include/mach/uncompress.h
+++ /dev/null
@@ -1,9 +0,0 @@
-#ifndef __MACH_UNCOMPRESS_H
-#define __MACH_UNCOMPRESS_H
-
-#define putc(c)
-#define flush()
-#define arch_decomp_setup()
-#define arch_decomp_wdog()
-
-#endif
-- 
1.7.9.5
