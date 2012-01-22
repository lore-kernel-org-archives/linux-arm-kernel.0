From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Sun, 22 Jan 2012 12:13:35 +0100
Subject: [RFC PATCH 09/11] Cortex-M3: Allow the building of Cortex-M3 kernel
 port
In-Reply-To: <20120122111230.GB14835@pengutronix.de>
References: <20120122111230.GB14835@pengutronix.de>
Message-ID: <1327230817-12855-9-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Catalin Marinas <catalin.marinas@arm.com>

This patch modifies the required Kconfig and Makefile files to allow the
building of kernel for Cortex-M3.

[ukleinek: don't make CPU_V7M user visible]

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig         |    2 +-
 arch/arm/Kconfig-nommu   |    2 +-
 arch/arm/Makefile        |    1 +
 arch/arm/kernel/Makefile |    8 +++++++-
 arch/arm/mm/Kconfig      |   24 +++++++++++++++++++++++-
 arch/arm/mm/Makefile     |    1 +
 6 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 24626b0..ca9b48c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1599,7 +1599,7 @@ config HZ
 
 config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode (EXPERIMENTAL)"
-	depends on CPU_V7 && !CPU_V6 && !CPU_V6K && EXPERIMENTAL
+	depends on (CPU_V7 || CPU_V7M) && !CPU_V6 && !CPU_V6K && EXPERIMENTAL
 	select AEABI
 	select ARM_ASM_UNIFIED
 	select ARM_UNWIND
diff --git a/arch/arm/Kconfig-nommu b/arch/arm/Kconfig-nommu
index 2cef8e1..c859495 100644
--- a/arch/arm/Kconfig-nommu
+++ b/arch/arm/Kconfig-nommu
@@ -28,7 +28,7 @@ config FLASH_SIZE
 config PROCESSOR_ID
 	hex 'Hard wire the processor ID'
 	default 0x00007700
-	depends on !CPU_CP15
+	depends on !(CPU_CP15 || CPU_V7M)
 	help
 	  If processor has no CP15 register, this processor ID is
 	  used instead of the auto-probing which utilizes the register.
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 40319d9..e36b8b0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -57,6 +57,7 @@ comma = ,
 # Note that GCC does not numerically define an architecture version
 # macro, but instead defines a whole series of macros which makes
 # testing for a specific architecture or later rather impossible.
+arch-$(CONFIG_CPU_32v7M)	:=-D__LINUX_ARM_ARCH__=7 -march=armv7-m -Wa,-march=armv7-m
 arch-$(CONFIG_CPU_32v7)		:=-D__LINUX_ARM_ARCH__=7 $(call cc-option,-march=armv7-a,-march=armv5t -Wa$(comma)-march=armv7-a)
 arch-$(CONFIG_CPU_32v6)		:=-D__LINUX_ARM_ARCH__=6 $(call cc-option,-march=armv6,-march=armv5t -Wa$(comma)-march=armv6)
 # Only override the compiler option if ARMv6. The ARMv6K extensions are
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 43b740d..32e96e6 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -13,10 +13,16 @@ CFLAGS_REMOVE_return_address.o = -pg
 
 # Object file lists.
 
-obj-y		:= elf.o entry-armv.o entry-common.o irq.o opcodes.o \
+obj-y		:= elf.o entry-common.o irq.o opcodes.o \
 		   process.o ptrace.o return_address.o setup.o signal.o \
 		   sys_arm.o stacktrace.o time.o traps.o
 
+ifeq ($(CONFIG_CPU_V7M),y)
+obj-y		+= entry-v7m.o
+else
+obj-y		+= entry-armv.o
+endif
+
 obj-$(CONFIG_DEPRECATED_PARAM_STRUCT) += compat.o
 
 obj-$(CONFIG_LEDS)		+= leds.o
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 4cefb57..0b57034 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -429,6 +429,18 @@ config CPU_V7
 	select CPU_COPY_V6 if MMU
 	select CPU_TLB_V7 if MMU
 
+# ARMv7
+config CPU_V7M
+	bool
+	select THUMB2_KERNEL
+	select ARM_THUMB
+	select CPU_32v7M
+	select CPU_32v6K
+	select CPU_ABRT_NOMMU
+	select CPU_PABRT_LEGACY
+	select CPU_CACHE_V7M
+	select CPU_CACHE_VIPT
+
 # Figure out what processor architecture version we should be using.
 # This defines the compiler instruction set which depends on the machine type.
 config CPU_32v3
@@ -466,6 +478,9 @@ config CPU_32v6K
 config CPU_32v7
 	bool
 
+config CPU_32v7M
+	bool
+
 # The abort model
 config CPU_ABRT_NOMMU
 	bool
@@ -519,6 +534,9 @@ config CPU_CACHE_V6
 config CPU_CACHE_V7
 	bool
 
+config CPU_CACHE_V7M
+	bool
+
 config CPU_CACHE_VIVT
 	bool
 
@@ -648,7 +666,11 @@ config ARCH_DMA_ADDR_T_64BIT
 
 config ARM_THUMB
 	bool "Support Thumb user binaries"
-	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || CPU_V7 || CPU_FEROCEON
+	depends on CPU_ARM720T || CPU_ARM740T || CPU_ARM920T || CPU_ARM922T || \
+		CPU_ARM925T || CPU_ARM926T || CPU_ARM940T || CPU_ARM946E || \
+		CPU_ARM1020 || CPU_ARM1020E || CPU_ARM1022 || CPU_ARM1026 || \
+		CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_V6 || CPU_V6K || CPU_V7 || \
+		CPU_FEROCEON || CPU_V7M
 	default y
 	help
 	  Say Y if you want to include kernel support for running user space
diff --git a/arch/arm/mm/Makefile b/arch/arm/mm/Makefile
index bca7e61..3f94178 100644
--- a/arch/arm/mm/Makefile
+++ b/arch/arm/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_CPU_FEROCEON)	+= proc-feroceon.o
 obj-$(CONFIG_CPU_V6)		+= proc-v6.o
 obj-$(CONFIG_CPU_V6K)		+= proc-v6.o
 obj-$(CONFIG_CPU_V7)		+= proc-v7.o
+obj-$(CONFIG_CPU_V7M)		+= proc-v7m.o
 
 AFLAGS_proc-v6.o	:=-Wa,-march=armv6
 AFLAGS_proc-v7.o	:=-Wa,-march=armv7-a
-- 
1.7.8.3
