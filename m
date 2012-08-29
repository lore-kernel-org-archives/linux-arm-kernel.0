From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Aug 2012 17:49:59 -0500
Subject: [PATCH 5/6] ARM: initial multiplatform support
In-Reply-To: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346280600-29395-6-git-send-email-robherring2@gmail.com>
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
picoxcell, mvebu, socfpga, and vexpress are converted.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig.mach            |   57 ++++++++++++++
 arch/arm/Makefile                |  155 ++++++++++++++++++++------------------
 arch/arm/boot/compressed/misc.c  |    6 ++
 arch/arm/include/asm/timex.h     |    4 +
 arch/arm/mach-highbank/Kconfig   |    2 +-
 arch/arm/mach-mvebu/Kconfig      |    2 +-
 arch/arm/mach-mvebu/Makefile     |    2 +
 arch/arm/mach-picoxcell/Kconfig  |    2 +-
 arch/arm/mach-socfpga/Kconfig    |    2 +-
 arch/arm/mach-vexpress/Kconfig   |    2 +-
 arch/arm/mach-vexpress/Makefile  |    2 +
 arch/arm/plat-versatile/Makefile |    2 +
 12 files changed, 158 insertions(+), 80 deletions(-)

diff --git a/arch/arm/Kconfig.mach b/arch/arm/Kconfig.mach
index 60f0386..7a21abb 100644
--- a/arch/arm/Kconfig.mach
+++ b/arch/arm/Kconfig.mach
@@ -4,6 +4,7 @@
 #
 choice
 	prompt "ARM system type"
+	depends on !ARCH_MULTIPLATFORM
 	default ARCH_VERSATILE
 
 config ARCH_SOCFPGA_CHOICE
@@ -378,6 +379,62 @@ config ARCH_ZYNQ_CHOICE
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
 endchoice
 
+menuconfig ARCH_MULTIPLATFORM
+	bool "Multiple platform selection"
+	select USE_OF
+	select COMMON_CLK
+	select SPARSE_IRQ
+	select MULTI_IRQ_HANDLER
+	select AUTO_ZRELADDR
+	depends on MMU
+
+if ARCH_MULTIPLATFORM
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
+	select ARCH_VEXPRESS
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
+endif
+
+if ARCH_MULTIPLATFORM
+comment "SoC family selection"
+endif
+
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
 # Kconfigs may be included either alphabetically (according to the
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
index d4f1b23..0e1d0a4 100644
--- a/arch/arm/mach-highbank/Kconfig
+++ b/arch/arm/mach-highbank/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_HIGHBANK
-	bool
+	bool "Calxeda ECX-1000 (Highbank)" if ARCH_MULTI_V7
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 1ed7d15..7b27035 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_MVEBU
-	bool
+	bool "Marvell SOCs with Device Tree support" if ARCH_MULTI_V7
 	select CLKSRC_MMIO
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index e61d2b8..6ea8998 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,2 +1,4 @@
+ccflags-$(ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+
 obj-y += system-controller.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o irq-armada-370-xp.o
diff --git a/arch/arm/mach-picoxcell/Kconfig b/arch/arm/mach-picoxcell/Kconfig
index b0fd5a1..868796f 100644
--- a/arch/arm/mach-picoxcell/Kconfig
+++ b/arch/arm/mach-picoxcell/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_PICOXCELL
-	bool
+	bool "Picochip PicoXcell" if ARCH_MULTI_V6
 	select ARCH_REQUIRE_GPIOLIB
 	select ARM_PATCH_PHYS_VIRT
 	select ARM_VIC
diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
index 51b04ba..803a328 100644
--- a/arch/arm/mach-socfpga/Kconfig
+++ b/arch/arm/mach-socfpga/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_SOCFPGA
-	bool
+	bool "Altera SOCFPGA family" if ARCH_MULTI_V7
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_GIC
diff --git a/arch/arm/mach-vexpress/Kconfig b/arch/arm/mach-vexpress/Kconfig
index 8ce13a7..498ea15 100644
--- a/arch/arm/mach-vexpress/Kconfig
+++ b/arch/arm/mach-vexpress/Kconfig
@@ -1,5 +1,5 @@
 config ARCH_VEXPRESS
-	bool
+	bool "ARM Ltd. Versatile Express family" if ARCH_MULTI_V7
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_AMBA
 	select ARM_TIMER_SP804
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 90551b9..42703e8 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -1,6 +1,8 @@
 #
 # Makefile for the linux kernel.
 #
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+	-I$(srctree)/arch/arm/plat-versatile/include
 
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 272769a8..74cfd94 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,3 +1,5 @@
+ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+
 obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
-- 
1.7.9.5
