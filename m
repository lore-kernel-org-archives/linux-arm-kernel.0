From: robherring2@gmail.com (Rob Herring)
Date: Fri, 24 Aug 2012 14:50:52 -0500
Subject: [RFC PATCH] ARM: initial multiplatform support
Message-ID: <1345837852-10277-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

This lets us build a multiplatform kernel for experimental purposes.
However, it will not be useful for any real work, because it relies
on a number of useful things to be disabled for now:

* SMP support is turned off because of conflicting symbols.
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
socfpga, and vexpress are converted. There's probably a few others that can
be converted easily, too.

The kconfig and makefile changes have been simplified some. Instead of 3 kconfig
symbols per mach, there are only 2. arch/arm/Kconfig is getting kind of large.
I think it should be split between Kconfig and Kconfig.mach to separate out the
mach specific parts.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig                              |  107 +++++++++++++++----------
 arch/arm/Makefile                             |   16 ++--
 arch/arm/mach-multi/Kconfig                   |   42 ++++++++++
 arch/arm/mach-multi/Makefile                  |    1 +
 arch/arm/mach-multi/include/mach/gpio.h       |    1 +
 arch/arm/mach-multi/include/mach/timex.h      |    3 +
 arch/arm/mach-multi/include/mach/uncompress.h |   10 +++
 arch/arm/mach-vexpress/Makefile               |    1 +
 arch/arm/plat-versatile/Makefile              |    2 +
 9 files changed, 136 insertions(+), 47 deletions(-)
 create mode 100644 arch/arm/mach-multi/Kconfig
 create mode 100644 arch/arm/mach-multi/Makefile
 create mode 100644 arch/arm/mach-multi/include/mach/gpio.h
 create mode 100644 arch/arm/mach-multi/include/mach/timex.h
 create mode 100644 arch/arm/mach-multi/include/mach/uncompress.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e91c7cd..e841262 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -255,22 +255,18 @@ choice
 	prompt "ARM system type"
 	default ARCH_VERSATILE
 
-config ARCH_SOCFPGA
-	bool "Altera SOCFPGA family"
-	select ARCH_WANT_OPTIONAL_GPIOLIB
-	select ARM_AMBA
-	select ARM_GIC
-	select CACHE_L2X0
-	select CLKDEV_LOOKUP
+config ARCH_MULTIPLATFORM
+	bool "Allow multiple platforms to be selected"
+	select USE_OF
 	select COMMON_CLK
-	select CPU_V7
-	select DW_APB_TIMER
-	select DW_APB_TIMER_OF
-	select GENERIC_CLOCKEVENTS
-	select GPIO_PL061 if GPIOLIB
-	select HAVE_ARM_SCU
 	select SPARSE_IRQ
-	select USE_OF
+	select MULTI_IRQ_HANDLER
+	select AUTO_ZRELADDR
+	depends on MMU
+
+config ARCH_SOCFPGA_CHOICE
+	bool "Altera SOCFPGA family"
+	select ARCH_SOCFPGA
 	help
 	  This enables support for Altera SOCFPGA Cyclone V platform
 
@@ -327,21 +323,9 @@ config ARCH_VERSATILE
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
 
@@ -368,21 +352,8 @@ config ARCH_BCMRING
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
 	help
 	  Support for the Calxeda Highbank SoC based boards.
 
@@ -1028,6 +999,58 @@ config ARCH_ZYNQ
 	  Support for Xilinx Zynq ARM Cortex A9 Platform
 endchoice
 
+source "arch/arm/mach-multi/Kconfig"
+
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
+
+config ARCH_VEXPRESS
+	bool "" if ARCH_MULTI_V7
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
+	select MAY_HAVE_SPARSE_IRQ
+
+config ARCH_HIGHBANK
+	bool "Highbank" if ARCH_MULTI_V7
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
+
 #
 # This is sorted alphabetically by mach-* pathname.  However, plat-*
 # Kconfigs may be included either alphabetically (according to the
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 30eae87..c113e53 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -133,6 +133,9 @@ textofs-$(CONFIG_ARCH_MSM7X30) := 0x00208000
 textofs-$(CONFIG_ARCH_MSM8X60) := 0x00208000
 textofs-$(CONFIG_ARCH_MSM8960) := 0x00208000
 
+# multiplatform directory must be first
+machine-$(CONFIG_ARCH_MULTIPLATFORM)	:= multi
+
 # Machine directory name.  This list is sorted alphanumerically
 # by CONFIG_* macro name.
 machine-$(CONFIG_ARCH_AT91)		:= at91
@@ -145,7 +148,7 @@ machine-$(CONFIG_ARCH_EBSA110)		:= ebsa110
 machine-$(CONFIG_ARCH_EP93XX)		:= ep93xx
 machine-$(CONFIG_ARCH_GEMINI)		:= gemini
 machine-$(CONFIG_ARCH_H720X)		:= h720x
-machine-$(CONFIG_ARCH_HIGHBANK)		:= highbank
+machine-$(CONFIG_ARCH_HIGHBANK)		+= highbank
 machine-$(CONFIG_ARCH_INTEGRATOR)	:= integrator
 machine-$(CONFIG_ARCH_IOP13XX)		:= iop13xx
 machine-$(CONFIG_ARCH_IOP32X)		:= iop32x
@@ -186,11 +189,11 @@ machine-$(CONFIG_ARCH_TEGRA)		:= tegra
 machine-$(CONFIG_ARCH_U300)		:= u300
 machine-$(CONFIG_ARCH_U8500)		:= ux500
 machine-$(CONFIG_ARCH_VERSATILE)	:= versatile
-machine-$(CONFIG_ARCH_VEXPRESS)		:= vexpress
+machine-$(CONFIG_ARCH_VEXPRESS)		+= vexpress
 machine-$(CONFIG_ARCH_VT8500)		:= vt8500
 machine-$(CONFIG_ARCH_W90X900)		:= w90x900
 machine-$(CONFIG_FOOTBRIDGE)		:= footbridge
-machine-$(CONFIG_ARCH_SOCFPGA)		:= socfpga
+machine-$(CONFIG_ARCH_SOCFPGA)		+= socfpga
 machine-$(CONFIG_MACH_SPEAR1310)	:= spear13xx
 machine-$(CONFIG_MACH_SPEAR1340)	:= spear13xx
 machine-$(CONFIG_MACH_SPEAR300)		:= spear3xx
@@ -230,14 +233,17 @@ MACHINE  := arch/arm/mach-$(word 1,$(machine-y))/
 else
 MACHINE  :=
 endif
+ifeq ($(CONFIG_ARCH_MULTIPLATFORM),y)
+MACHINE  :=
+endif
 
 machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
 platdirs := $(patsubst %,arch/arm/plat-%/,$(plat-y))
 
 ifeq ($(KBUILD_SRC),)
-KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
+KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(word 1,$(machdirs) $(platdirs)))
 else
-KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs) $(platdirs))
+KBUILD_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(word 1,$(machdirs) $(platdirs)))
 endif
 
 export	TEXT_OFFSET GZFLAGS MMUEXT
diff --git a/arch/arm/mach-multi/Kconfig b/arch/arm/mach-multi/Kconfig
new file mode 100644
index 0000000..0a6369f
--- /dev/null
+++ b/arch/arm/mach-multi/Kconfig
@@ -0,0 +1,42 @@
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
+	select ARCH_MULTI_V6_V7
+
+config ARCH_MULTI_V7
+	bool "ARMv7 based platforms (Cortex-A, PJ4, Krait)"
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
+comment "SoC family selection"
diff --git a/arch/arm/mach-multi/Makefile b/arch/arm/mach-multi/Makefile
new file mode 100644
index 0000000..1bb8bf6
--- /dev/null
+++ b/arch/arm/mach-multi/Makefile
@@ -0,0 +1 @@
+# empty
diff --git a/arch/arm/mach-multi/include/mach/gpio.h b/arch/arm/mach-multi/include/mach/gpio.h
new file mode 100644
index 0000000..40a8c17
--- /dev/null
+++ b/arch/arm/mach-multi/include/mach/gpio.h
@@ -0,0 +1 @@
+/* empty */
diff --git a/arch/arm/mach-multi/include/mach/timex.h b/arch/arm/mach-multi/include/mach/timex.h
new file mode 100644
index 0000000..929b4c4
--- /dev/null
+++ b/arch/arm/mach-multi/include/mach/timex.h
@@ -0,0 +1,3 @@
+#ifndef CLOCK_TICK_RATE
+#define CLOCK_TICK_RATE 1000000
+#endif
diff --git a/arch/arm/mach-multi/include/mach/uncompress.h b/arch/arm/mach-multi/include/mach/uncompress.h
new file mode 100644
index 0000000..a4dec68
--- /dev/null
+++ b/arch/arm/mach-multi/include/mach/uncompress.h
@@ -0,0 +1,10 @@
+#ifndef __MACH_UNCOMPRESS_H
+#define __MACH_UNCOMPRESS_H
+
+/* no-op dummies for the uncompress debugging for multiplatform kernels */
+
+static inline void putc(int c) {}
+static inline void flush(void) {}
+static inline void arch_decomp_setup(void) {}
+
+#endif
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 90551b9..1666f6e 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -1,6 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
+ccflags-y := -I$(srctree)/$(src)/include -I$(srctree)/arch/arm/plat-versatile/include
 
 obj-y					:= v2m.o
 obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index 272769a8..15411b1 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,3 +1,5 @@
+ccflags-y := -I$(srctree)/$(src)/include
+
 obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
 obj-$(CONFIG_PLAT_VERSATILE_FPGA_IRQ) += fpga-irq.o
-- 
1.7.9.5
