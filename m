From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  3 Sep 2010 11:56:53 +0200
Subject: [PATCH 2/7] [RFC] ARM: shmobile: remove unneeded hack to calculate
	zreladdr
In-Reply-To: <20100903095504.GC13643@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
Message-ID: <1283507818-1573-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The calculated value in Makefile.boot isn't used anymore since

	e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)

and physoffset can better be set in mach/memory.h depending on the
actual machine type.

Cc: Paul Mundt <lethal@linux-sh.org>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-sh at vger.kernel.org
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-shmobile/Kconfig               |   11 -----------
 arch/arm/mach-shmobile/Makefile.boot         |    9 ---------
 arch/arm/mach-shmobile/include/mach/memory.h |   15 ++++++++++++++-
 3 files changed, 14 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/mach-shmobile/Makefile.boot

diff --git a/arch/arm/mach-shmobile/Kconfig b/arch/arm/mach-shmobile/Kconfig
index 54b479c..45e134e 100644
--- a/arch/arm/mach-shmobile/Kconfig
+++ b/arch/arm/mach-shmobile/Kconfig
@@ -61,17 +61,6 @@ comment "SH-Mobile System Configuration"
 
 menu "Memory configuration"
 
-config MEMORY_START
-	hex "Physical memory start address"
-	default "0x50000000" if MACH_G3EVM
-	default "0x40000000" if MACH_G4EVM
-	default "0x40000000" if MACH_AP4EVB
-	default "0x00000000"
-	---help---
-	  Tweak this only when porting to a new machine which does not
-	  already have a defconfig. Changing it from the known correct
-	  value on any of the known systems will only lead to disaster.
-
 config MEMORY_SIZE
 	hex "Physical memory size"
 	default "0x08000000" if MACH_G3EVM
diff --git a/arch/arm/mach-shmobile/Makefile.boot b/arch/arm/mach-shmobile/Makefile.boot
deleted file mode 100644
index 1c08ee9..0000000
--- a/arch/arm/mach-shmobile/Makefile.boot
+++ /dev/null
@@ -1,9 +0,0 @@
-__ZRELADDR	:= $(shell /bin/bash -c 'printf "0x%08x" \
-		     $$[$(CONFIG_MEMORY_START) + 0x8000]')
-
-   zreladdr-y   := $(__ZRELADDR)
-
-# Unsupported legacy stuff
-#
-#params_phys-y (Instead: Pass atags pointer in r2)
-#initrd_phys-y (Instead: Use compiled-in initramfs)
diff --git a/arch/arm/mach-shmobile/include/mach/memory.h b/arch/arm/mach-shmobile/include/mach/memory.h
index 377584e..100f734 100644
--- a/arch/arm/mach-shmobile/include/mach/memory.h
+++ b/arch/arm/mach-shmobile/include/mach/memory.h
@@ -1,7 +1,20 @@
 #ifndef __ASM_MACH_MEMORY_H
 #define __ASM_MACH_MEMORY_H
 
-#define PHYS_OFFSET	UL(CONFIG_MEMORY_START)
+#define SH7367_PHYS_OFFSET UL(0x50000000)
+#define SH7372_PHYS_OFFSET UL(0x40000000)
+#define SH7377_PHYS_OFFSET UL(0x40000000)
+
+#if !defined(CONFIG_RUNTIME_PHYS_OFFSET)
+# if defined(CONFIG_ARCH_SH7367)
+#  define PHYS_OFFSET	SH7367_PHYS_OFFSET
+# elif defined(CONFIG_ARCH_SH7372)
+#  define PHYS_OFFSET	SH7372_PHYS_OFFSET
+# elif defined(CONFIG_ARCH_SH7377)
+#  define PHYS_OFFSET	SH7377_PHYS_OFFSET
+# endif
+#endif /* if !defined(CONFIG_RUNTIME_PHYS_OFFSET) */
+
 #define MEM_SIZE	UL(CONFIG_MEMORY_SIZE)
 
 /* DMA memory at 0xf6000000 - 0xffdfffff */
-- 
1.7.1
