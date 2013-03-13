From: jonathan.austin@arm.com (Jonathan Austin)
Date: Wed, 13 Mar 2013 16:53:16 +0000
Subject: [PATCH 1/3] ARM: allow platforms to use generic headers without
 ARCH_MULTIPLATFORM
In-Reply-To: <1363193598-28116-1-git-send-email-jonathan.austin@arm.com>
References: <1363193598-28116-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1363193598-28116-2-git-send-email-jonathan.austin@arm.com>
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
ARM_GENERIC_HEADERS config option that ARCH_MULTIPLATFORM selects. Other
platforms can now select ARCH_GENERIC_HEADERS independently.

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
---

I'd be happy to submit the per-platform conversions as separate patches if
doing them in a single go is not appropriate.

 arch/arm/Kconfig                 |    4 ++++
 arch/arm/Makefile                |    2 +-
 arch/arm/boot/compressed/misc.c  |    2 +-
 arch/arm/include/asm/timex.h     |    2 +-
 arch/arm/mach-mvebu/Makefile     |    2 +-
 arch/arm/mach-omap2/Makefile     |    2 +-
 arch/arm/mach-vexpress/Makefile  |    2 +-
 arch/arm/plat-omap/Makefile      |    2 +-
 arch/arm/plat-orion/Makefile     |    2 +-
 arch/arm/plat-versatile/Makefile |    2 +-
 10 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5b71469..9655ed1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -208,6 +208,9 @@ config NEED_RET_TO_USER
 config ARCH_MTD_XIP
 	bool
 
+config ARM_GENERIC_HEADERS
+	bool
+
 config VECTORS_BASE
 	hex
 	default 0xffff0000 if MMU || CPU_HIGH_VECTOR
@@ -297,6 +300,7 @@ config ARCH_MULTIPLATFORM
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
+	select ARM_GENERIC_HEADERS
 
 config ARCH_INTEGRATOR
 	bool "ARM Ltd. Integrator family"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index ee4605f..736b4f6 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -233,7 +233,7 @@ endif
 machdirs := $(patsubst %,arch/arm/mach-%/,$(machine-y))
 platdirs := $(patsubst %,arch/arm/plat-%/,$(plat-y))
 
-ifneq ($(CONFIG_ARCH_MULTIPLATFORM),y)
+ifneq ($(CONFIG_ARM_GENERIC_HEADERS),y)
 ifeq ($(KBUILD_SRC),)
 KBUILD_CPPFLAGS += $(patsubst %,-I%include,$(machdirs) $(platdirs))
 else
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index df89983..5c6fd05 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -25,7 +25,7 @@ unsigned int __machine_arch_type;
 static void putstr(const char *ptr);
 extern void error(char *x);
 
-#ifdef CONFIG_ARCH_MULTIPLATFORM
+#ifdef CONFIG_ARM_GENERIC_HEADERS
 static inline void putc(int c) {}
 static inline void flush(void) {}
 static inline void arch_decomp_setup(void) {}
diff --git a/arch/arm/include/asm/timex.h b/arch/arm/include/asm/timex.h
index 83f2aa8..586a9c2 100644
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -12,7 +12,7 @@
 #ifndef _ASMARM_TIMEX_H
 #define _ASMARM_TIMEX_H
 
-#ifdef CONFIG_ARCH_MULTIPLATFORM
+#ifdef CONFIG_ARM_GENERIC_HEADERS
 #define CLOCK_TICK_RATE 1000000
 #else
 #include <mach/timex.h>
diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index da93bcb..da056e9 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -1,4 +1,4 @@
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+ccflags-$(CONFIG_ARM_GENERIC_HEADERS) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-orion/include
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b068b7f..46a43d1 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+ccflags-$(CONFIG_ARM_GENERIC_HEADERS) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-omap/include
 
 # Common support
diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
index 80b6497..7adf859 100644
--- a/arch/arm/mach-vexpress/Makefile
+++ b/arch/arm/mach-vexpress/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
+ccflags-$(CONFIG_ARM_GENERIC_HEADERS) := -I$(srctree)/$(src)/include \
 	-I$(srctree)/arch/arm/plat-versatile/include
 
 obj-y					:= v2m.o reset.o
diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 3119941..3e1ba10 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -2,7 +2,7 @@
 # Makefile for the linux kernel.
 #
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/plat-omap/include
+ccflags-$(CONFIG_ARM_GENERIC_HEADERS) := -I$(srctree)/arch/arm/plat-omap/include
 
 # Common support
 obj-y := sram.o dma.o counter_32k.o
diff --git a/arch/arm/plat-orion/Makefile b/arch/arm/plat-orion/Makefile
index a82cecb..d429ba4 100644
--- a/arch/arm/plat-orion/Makefile
+++ b/arch/arm/plat-orion/Makefile
@@ -1,7 +1,7 @@
 #
 # Makefile for the linux kernel.
 #
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+ccflags-$(CONFIG_ARM_GENERIC_HEADERS) := -I$(srctree)/$(src)/include
 
 obj-y                             += addr-map.o
 
diff --git a/arch/arm/plat-versatile/Makefile b/arch/arm/plat-versatile/Makefile
index f88d448..19495c6 100644
--- a/arch/arm/plat-versatile/Makefile
+++ b/arch/arm/plat-versatile/Makefile
@@ -1,4 +1,4 @@
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include
+ccflags-$(CONFIG_ARM_GENERIC_HEADERS) := -I$(srctree)/$(src)/include
 
 obj-$(CONFIG_PLAT_VERSATILE_CLOCK) += clock.o
 obj-$(CONFIG_PLAT_VERSATILE_CLCD) += clcd.o
-- 
1.7.9.5
