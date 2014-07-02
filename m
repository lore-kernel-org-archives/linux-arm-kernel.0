From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed,  2 Jul 2014 11:57:22 +0200
Subject: [PATCH 2/3] ARM: remove remaining definitions of PLAT_PHYS_OFFSET
 from <mach/memory.h>
In-Reply-To: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1404295043-6661-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1404295043-6661-2-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platforms selecting NEED_MACH_MEMORY_H defined the start address of
their physical memory in the respective <mach/memory.h>. With
ARM_PATCH_PHYS_VIRT=y (which is quite common today) this is useless
though because the definition isn't used but determined dynamically.

So remove the definitions from all <mach/memory.h> and provide the
Kconfig symbol PHYS_OFFSET with the respective defaults in case
ARM_PATCH_PHYS_VIRT isn't enabled.

This allows to drop the dependency of PHYS_OFFSET on !NEED_MACH_MEMORY_H
which prevents compiling an integrator nommu-kernel.
(CONFIG_PAGE_OFFSET which has "default PHYS_OFFSET if !MMU" expanded to
"0x" because CONFIG_PHYS_OFFSET doesn't exist as INTEGRATOR selects
NEED_MACH_MEMORY_H.)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig                               | 11 +++++++++--
 arch/arm/include/asm/memory.h                  |  6 ++----
 arch/arm/mach-ebsa110/include/mach/memory.h    |  5 -----
 arch/arm/mach-ep93xx/include/mach/memory.h     | 22 ----------------------
 arch/arm/mach-footbridge/include/mach/memory.h |  5 -----
 arch/arm/mach-integrator/include/mach/memory.h |  5 -----
 arch/arm/mach-iop13xx/include/mach/memory.h    |  5 -----
 arch/arm/mach-ks8695/include/mach/memory.h     |  5 -----
 arch/arm/mach-omap1/include/mach/memory.h      |  5 -----
 arch/arm/mach-realview/include/mach/memory.h   | 11 -----------
 arch/arm/mach-rpc/include/mach/memory.h        |  5 -----
 arch/arm/mach-s5pv210/include/mach/memory.h    |  2 --
 arch/arm/mach-sa1100/include/mach/memory.h     |  5 -----
 13 files changed, 11 insertions(+), 81 deletions(-)
 delete mode 100644 arch/arm/mach-ep93xx/include/mach/memory.h

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 245058b3b0ef..6dab0604b911 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -262,8 +262,16 @@ config NEED_MACH_MEMORY_H
 
 config PHYS_OFFSET
 	hex "Physical address of main memory" if MMU
-	depends on !ARM_PATCH_PHYS_VIRT && !NEED_MACH_MEMORY_H
+	depends on !ARM_PATCH_PHYS_VIRT
 	default DRAM_BASE if !MMU
+	default 0x00000000 if ARCH_EBSA110 || EP93XX_SDCE3_SYNC_PHYS_OFFSET || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_IOP13XX || ARCH_KS8695 || (ARCH_REALVIEW && !REALVIEW_HIGH_PHYS_OFFSET)
+	default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
+	default 0x20000000 if ARCH_S5PV210
+	default 0x70000000 if REALVIEW_HIGH_PHYS_OFFSET
+	default 0xc0000000 if EP93XX_SDCE0_PHYS_OFFSET || ARCH_SA1100
+	default 0xd0000000 if EP93XX_SDCE1_PHYS_OFFSET
+	default 0xe0000000 if EP93XX_SDCE2_PHYS_OFFSET
+	default 0xf0000000 if EP93XX_SDCE3_ASYNC_PHYS_OFFSET
 	help
 	  Please provide the physical address corresponding to the
 	  location of main memory in your system.
@@ -435,7 +443,6 @@ config ARCH_EP93XX
 	select ARM_VIC
 	select CLKDEV_LOOKUP
 	select CPU_ARM920T
-	select NEED_MACH_MEMORY_H
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
diff --git a/arch/arm/include/asm/memory.h b/arch/arm/include/asm/memory.h
index 2b751464d6ff..04ccf1c0a1af 100644
--- a/arch/arm/include/asm/memory.h
+++ b/arch/arm/include/asm/memory.h
@@ -150,13 +150,11 @@
 
 /*
  * PLAT_PHYS_OFFSET is the offset (from zero) of the start of physical
- * memory.  This is used for XIP and NoMMU kernels, or by kernels which
- * have their own mach/memory.h.  Assembly code must always use
+ * memory.  This is used for XIP and NoMMU kernels, and on platforms that don't
+ * have CONFIG_ARM_PATCH_PHYS_VIRT. Assembly code must always use
  * PLAT_PHYS_OFFSET and not PHYS_OFFSET.
  */
-#ifndef PLAT_PHYS_OFFSET
 #define PLAT_PHYS_OFFSET	UL(CONFIG_PHYS_OFFSET)
-#endif
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/arm/mach-ebsa110/include/mach/memory.h b/arch/arm/mach-ebsa110/include/mach/memory.h
index 8e49066ad850..866f8a1c6ff7 100644
--- a/arch/arm/mach-ebsa110/include/mach/memory.h
+++ b/arch/arm/mach-ebsa110/include/mach/memory.h
@@ -17,11 +17,6 @@
 #define __ASM_ARCH_MEMORY_H
 
 /*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
-/*
  * Cache flushing area - SRAM
  */
 #define FLUSH_BASE_PHYS		0x40000000
diff --git a/arch/arm/mach-ep93xx/include/mach/memory.h b/arch/arm/mach-ep93xx/include/mach/memory.h
deleted file mode 100644
index c9400cf0051c..000000000000
--- a/arch/arm/mach-ep93xx/include/mach/memory.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * arch/arm/mach-ep93xx/include/mach/memory.h
- */
-
-#ifndef __ASM_ARCH_MEMORY_H
-#define __ASM_ARCH_MEMORY_H
-
-#if defined(CONFIG_EP93XX_SDCE3_SYNC_PHYS_OFFSET)
-#define PLAT_PHYS_OFFSET		UL(0x00000000)
-#elif defined(CONFIG_EP93XX_SDCE0_PHYS_OFFSET)
-#define PLAT_PHYS_OFFSET		UL(0xc0000000)
-#elif defined(CONFIG_EP93XX_SDCE1_PHYS_OFFSET)
-#define PLAT_PHYS_OFFSET		UL(0xd0000000)
-#elif defined(CONFIG_EP93XX_SDCE2_PHYS_OFFSET)
-#define PLAT_PHYS_OFFSET		UL(0xe0000000)
-#elif defined(CONFIG_EP93XX_SDCE3_ASYNC_PHYS_OFFSET)
-#define PLAT_PHYS_OFFSET		UL(0xf0000000)
-#else
-#error "Kconfig bug: No EP93xx PHYS_OFFSET set"
-#endif
-
-#endif
diff --git a/arch/arm/mach-footbridge/include/mach/memory.h b/arch/arm/mach-footbridge/include/mach/memory.h
index 5c6df377f969..6f2ecccdf323 100644
--- a/arch/arm/mach-footbridge/include/mach/memory.h
+++ b/arch/arm/mach-footbridge/include/mach/memory.h
@@ -59,11 +59,6 @@ extern unsigned long __bus_to_pfn(unsigned long);
  */
 #define FLUSH_BASE		0xf9000000
 
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET		UL(0x00000000)
-
 #define FLUSH_BASE_PHYS		0x50000000
 
 #endif
diff --git a/arch/arm/mach-integrator/include/mach/memory.h b/arch/arm/mach-integrator/include/mach/memory.h
index 334d5e271889..7268cb50ded0 100644
--- a/arch/arm/mach-integrator/include/mach/memory.h
+++ b/arch/arm/mach-integrator/include/mach/memory.h
@@ -20,11 +20,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
 #define BUS_OFFSET	UL(0x80000000)
 #define __virt_to_bus(x)	((x) - PAGE_OFFSET + BUS_OFFSET)
 #define __bus_to_virt(x)	((x) - BUS_OFFSET + PAGE_OFFSET)
diff --git a/arch/arm/mach-iop13xx/include/mach/memory.h b/arch/arm/mach-iop13xx/include/mach/memory.h
index 7c032d0ab24a..59307e787588 100644
--- a/arch/arm/mach-iop13xx/include/mach/memory.h
+++ b/arch/arm/mach-iop13xx/include/mach/memory.h
@@ -3,11 +3,6 @@
 
 #include <mach/hardware.h>
 
-/*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x00000000)
-
 #ifndef __ASSEMBLY__
 
 #if defined(CONFIG_ARCH_IOP13XX)
diff --git a/arch/arm/mach-ks8695/include/mach/memory.h b/arch/arm/mach-ks8695/include/mach/memory.h
index 95e731a7ed6a..ab0d27fa8969 100644
--- a/arch/arm/mach-ks8695/include/mach/memory.h
+++ b/arch/arm/mach-ks8695/include/mach/memory.h
@@ -15,11 +15,6 @@
 
 #include <mach/hardware.h>
 
-/*
- * Physical SRAM offset.
- */
-#define PLAT_PHYS_OFFSET		KS8695_SDRAM_PA
-
 #ifndef __ASSEMBLY__
 
 #ifdef CONFIG_PCI
diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
index 3c2530523111..058a4f7d44c5 100644
--- a/arch/arm/mach-omap1/include/mach/memory.h
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -6,11 +6,6 @@
 #define __ASM_ARCH_MEMORY_H
 
 /*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET		UL(0x10000000)
-
-/*
  * Bus address is physical address, except for OMAP-1510 Local Bus.
  * OMAP-1510 bus address is translated into a Local Bus address if the
  * OMAP bus type is lbus. We do the address translation based on the
diff --git a/arch/arm/mach-realview/include/mach/memory.h b/arch/arm/mach-realview/include/mach/memory.h
index db09170e3832..eb69feb3b804 100644
--- a/arch/arm/mach-realview/include/mach/memory.h
+++ b/arch/arm/mach-realview/include/mach/memory.h
@@ -21,17 +21,6 @@
 #define __ASM_ARCH_MEMORY_H
 
 /*
- * Physical DRAM offset.
- */
-#ifdef CONFIG_REALVIEW_HIGH_PHYS_OFFSET
-#define PLAT_PHYS_OFFSET		UL(0x70000000)
-#else
-#define PLAT_PHYS_OFFSET		UL(0x00000000)
-#endif
-
-#ifdef CONFIG_SPARSEMEM
-
-/*
  * Sparsemem definitions for RealView PBX.
  *
  * The RealView PBX board has another block of 512MB of RAM at 0x20000000,
diff --git a/arch/arm/mach-rpc/include/mach/memory.h b/arch/arm/mach-rpc/include/mach/memory.h
index 18a221093bf5..b7e49571417d 100644
--- a/arch/arm/mach-rpc/include/mach/memory.h
+++ b/arch/arm/mach-rpc/include/mach/memory.h
@@ -19,11 +19,6 @@
 #define __ASM_ARCH_MEMORY_H
 
 /*
- * Physical DRAM offset.
- */
-#define PLAT_PHYS_OFFSET	UL(0x10000000)
-
-/*
  * Cache flushing area - ROM
  */
 #define FLUSH_BASE_PHYS		0x00000000
diff --git a/arch/arm/mach-s5pv210/include/mach/memory.h b/arch/arm/mach-s5pv210/include/mach/memory.h
index 2d3cfa221d5f..d584fac9156b 100644
--- a/arch/arm/mach-s5pv210/include/mach/memory.h
+++ b/arch/arm/mach-s5pv210/include/mach/memory.h
@@ -13,8 +13,6 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
-#define PLAT_PHYS_OFFSET		UL(0x20000000)
-
 /*
  * Sparsemem support
  * Physical memory can be located from 0x20000000 to 0x7fffffff,
diff --git a/arch/arm/mach-sa1100/include/mach/memory.h b/arch/arm/mach-sa1100/include/mach/memory.h
index 12d376795abc..2054051eb797 100644
--- a/arch/arm/mach-sa1100/include/mach/memory.h
+++ b/arch/arm/mach-sa1100/include/mach/memory.h
@@ -10,11 +10,6 @@
 #include <asm/sizes.h>
 
 /*
- * Physical DRAM offset is 0xc0000000 on the SA1100
- */
-#define PLAT_PHYS_OFFSET	UL(0xc0000000)
-
-/*
  * Because of the wide memory address space between physical RAM banks on the
  * SA1100, it's much convenient to use Linux's SparseMEM support to implement
  * our memory map representation.  Assuming all memory nodes have equal access
-- 
2.0.0
