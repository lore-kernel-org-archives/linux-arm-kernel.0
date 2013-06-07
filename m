From: jonathan.austin@arm.com (Jonathan Austin)
Date: Fri,  7 Jun 2013 11:48:29 +0100
Subject: [PATCH v3 1/3] ARM: allow platforms to use generic headers without
 ARCH_MULTIPLATFORM
In-Reply-To: <1370602111-28737-1-git-send-email-jonathan.austin@arm.com>
References: <1370602111-28737-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1370602111-28737-2-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the use of generic mach headers is only is controlled by the same
config option as selection of a multiplatform kernel (i.e.
ARCH_MULTIPLATFORM). However, there are cases where it is valid to use the
generic headers but still build a single platform kernel.

One such example is when using the vexpress platform with a core that does
not have an MMU; a multiplatform kernel does not make sense, but use of the
generic headers is required by the vexpress platform since 617276307cd4c
("ARM: vexpress: convert to multi-platform").

This patch untangles these two options by introducing a new
NEED_NO_MACH_HEADERS config option that ARCH_MULTIPLATFORM selects. Other
platforms can now select NEED_NO_MACH_HEADERS independently.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
CC: Rob Herring <rob.herring@calxeda.com>
CC: Pawel Moll <pawel.moll@arm.com>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@free-electrons.com>
CC: Tony Lindgren <tony@atomide.com>
CC: Stephen Boyd <sboyd@codeaurora.org>
CC: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig                 |    4 ++++
 arch/arm/Kconfig.debug           |    4 ++--
 arch/arm/Makefile                |    2 +-
 arch/arm/include/asm/timex.h     |    2 +-
 arch/arm/mach-mvebu/Makefile     |    2 +-
 arch/arm/mach-omap2/Makefile     |    2 +-
 arch/arm/mach-vexpress/Makefile  |    2 +-
 arch/arm/plat-omap/Makefile      |    2 +-
 arch/arm/plat-orion/Makefile     |    2 +-
 arch/arm/plat-versatile/Makefile |    2 +-
 10 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5543d36..f018924 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -207,6 +207,9 @@ config NEED_RET_TO_USER
 config ARCH_MTD_XIP
 	bool
 
+config NEED_NO_MACH_HEADERS
+	bool
+
 config VECTORS_BASE
 	hex
 	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
@@ -296,6 +299,7 @@ config ARCH_MULTIPLATFORM
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
+	select NEED_NO_MACH_HEADERS
 
 config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 1d41908..451df97 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -652,13 +652,13 @@ config DEBUG_LL_INCLUDE
 
 config DEBUG_UNCOMPRESS
 	bool
-	default y if ARCH_MULTIPLATFORM && DEBUG_LL && \
+	default y if NEED_NO_MACH_HEADERS && DEBUG_LL && \
 		     !DEBUG_OMAP2PLUS_UART && \
 		     !DEBUG_TEGRA_UART
 
 config UNCOMPRESS_INCLUDE
 	string
-	default "debug/uncompress.h" if ARCH_MULTIPLATFORM
+	default "debug/uncompress.h" if NEED_NO_MACH_HEADERS
 	default "mach/uncompress.h"
 
 config EARLY_PRINTK
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 3380c4f..72a3765 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -230,7 +230,7 @@ endif
 machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
 platdirs := $(patsubst %,arch/arm/plat-%/,$(plat-y))
 
-ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
+ifneq ($(CONFIG_NEED_NO_MACH_HEADERS),y)
 ifeq ($(KBUILD_SRC),)
 KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
 else
diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index 83f2aa8..921c79c 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -12,7 +12,7 @@
 #ifndef _ASMARM_TIMEX_H
 #define _ASMARM_TIMEX_H
 
-#ifdef CONFIG_ARCH_MULTIPLATFORM
+#ifdef CONFIG_NEED_NO_MACH_HEADERS
 #define CLOCK_TICK_RATE 1000000
 #else
 #include <mach/timex.h>
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 2d04f0e..460a53d 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,4 +1,4 @@
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+ccflags-$(CONFIG_NEED_NO_MACH_HEADERS) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-orion/include
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 55a9d67..437a238 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+ccflags-$(CONFIG_NEED_NO_MACH_HEADERS) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-omap/include
 
 # Common support
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 42703e8..59a9ce2 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+ccflags-$(CONFIG_NEED_NO_MACH_HEADERS) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-versatile/include
 
 obj-y					:= v2m.o
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 3119941..2eb913d 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-omap/include
+ccflags-$(CONFIG_NEED_NO_MACH_HEADERS) := -I$(srctree)/arch/arm/plat-omap/include
 
 # Common support
 obj-y := sram.o dma.o counter_32k.o
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index 9433605..9c8f122 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+ccflags-$(CONFIG_NEED_NO_MACH_HEADERS) := -I$(srctree)/$(src)/include
 
 orion-gpio-$(CONFIG_GPIOLIB)      += gpio.o
 obj-$(CONFIG_PLAT_ORION_LEGACY)   += irq.o pcie.o time.o common.o mpp.o
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index f88d448..4369df8 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,4 +1,4 @@
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+ccflags-$(CONFIG_NEED_NO_MACH_HEADERS) := -I$(srctree)/$(src)/include
 
 obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
-- 
1.7.9.5
