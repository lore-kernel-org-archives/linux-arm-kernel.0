From: jamie@jamieiles.com (Jamie Iles)
Date: Fri,  4 Nov 2011 01:10:10 +0000
Subject: [PATCHv4 13/13] ARM: VIC: remove non MULTI_IRQ_HANDLER support
In-Reply-To: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
References: <1320369010-23428-1-git-send-email-jamie@jamieiles.com>
Message-ID: <1320369010-23428-14-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that all platforms are converted to MULTI_IRQ_HANDLER, remove the
legacy support.

Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig                        |   11 ------
 arch/arm/common/Kconfig                 |    1 +
 arch/arm/common/vic.c                   |    2 -
 arch/arm/include/asm/entry-macro-vic2.S |   57 -------------------------------
 4 files changed, 1 insertions(+), 70 deletions(-)
 delete mode 100644 arch/arm/include/asm/entry-macro-vic2.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 43bb172..fe6b052 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -294,7 +294,6 @@ config ARCH_VERSATILE
 	select PLAT_VERSATILE_CLCD
 	select PLAT_VERSATILE_FPGA_IRQ
 	select ARM_TIMER_SP804
-	select MULTI_IRQ_HANDLER
 	help
 	  This enables support for ARM Ltd Versatile board.
 
@@ -410,7 +409,6 @@ config ARCH_EP93XX
 	select ARCH_HAS_HOLES_MEMORYMODEL
 	select ARCH_USES_GETTIMEOFFSET
 	select NEED_MACH_MEMORY_H
-	select MULTI_IRQ_HANDLER
 	help
 	  This enables support for the Cirrus EP93xx series of CPUs.
 
@@ -452,7 +450,6 @@ config ARCH_NETX
 	select CPU_ARM926T
 	select ARM_VIC
 	select GENERIC_CLOCKEVENTS
-	select MULTI_IRQ_HANDLER
 	help
 	  This enables support for systems based on the Hilscher NetX Soc
 
@@ -651,7 +648,6 @@ config ARCH_PICOXCELL
 	select GENERIC_GPIO
 	select HAVE_SCHED_CLOCK
 	select HAVE_TCM
-	select MULTI_IRQ_HANDLER
 	select NO_IOPORT
 	select USE_OF
 	help
@@ -789,7 +785,6 @@ config ARCH_S3C64XX
 	select SAMSUNG_GPIOLIB_4BIT
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select MULTI_IRQ_HANDLER
 	help
 	  Samsung S3C64XX series based systems
 
@@ -805,7 +800,6 @@ config ARCH_S5P64X0
 	select HAVE_SCHED_CLOCK
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
-	select MULTI_IRQ_HANDLER
 	help
 	  Samsung S5P64X0 CPU based systems, such as the Samsung SMDK6440,
 	  SMDK6450.
@@ -821,7 +815,6 @@ config ARCH_S5PC100
 	select HAVE_S3C2410_I2C if I2C
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
-	select MULTI_IRQ_HANDLER
 	help
 	  Samsung S5PC100 series based systems
 
@@ -842,7 +835,6 @@ config ARCH_S5PV210
 	select HAVE_S3C_RTC if RTC_CLASS
 	select HAVE_S3C2410_WATCHDOG if WATCHDOG
 	select NEED_MACH_MEMORY_H
-	select MULTI_IRQ_HANDLER
 	help
 	  Samsung S5PV210/S5PC110 series based systems
 
@@ -902,7 +894,6 @@ config ARCH_U300
 	select GENERIC_GPIO
 	select ARCH_REQUIRE_GPIOLIB
 	select NEED_MACH_MEMORY_H
-	select MULTI_IRQ_HANDLER
 	help
 	  Support for ST-Ericsson U300 series mobile platforms.
 
@@ -925,7 +916,6 @@ config ARCH_NOMADIK
 	select CLKDEV_LOOKUP
 	select GENERIC_CLOCKEVENTS
 	select ARCH_REQUIRE_GPIOLIB
-	select MULTI_IRQ_HANDLER
 	help
 	  Support for the Nomadik platform by ST-Ericsson
 
@@ -962,7 +952,6 @@ config PLAT_SPEAR
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
 	select HAVE_CLK
-	select MULTI_IRQ_HANDLER
 	help
 	  Support for ST's SPEAr platform (SPEAr3xx, SPEAr6xx and SPEAr13xx).
 
diff --git a/arch/arm/common/Kconfig b/arch/arm/common/Kconfig
index e91ee7d..e086d1d 100644
--- a/arch/arm/common/Kconfig
+++ b/arch/arm/common/Kconfig
@@ -4,6 +4,7 @@ config ARM_GIC
 
 config ARM_VIC
 	select IRQ_DOMAIN
+	select MULTI_IRQ_HANDLER
 	bool
 
 config ARM_VIC_NR
diff --git a/arch/arm/common/vic.c b/arch/arm/common/vic.c
index a82e3e0..8c5f4b0 100644
--- a/arch/arm/common/vic.c
+++ b/arch/arm/common/vic.c
@@ -429,7 +429,6 @@ int __init vic_of_init(struct device_node *node, struct device_node *parent)
 }
 #endif /* CONFIG OF */
 
-#ifdef CONFIG_MULTI_IRQ_HANDLER
 /*
  * Handle each interrupt in a single VIC.  Returns non-zero if we've
  * handled at least one interrupt.  This does a single read of the
@@ -464,4 +463,3 @@ asmlinkage void __exception_irq_entry vic_handle_irq(struct pt_regs *regs)
 			handled |= handle_one_vic(&vic_devices[i], regs);
 	} while (handled);
 }
-#endif /* CONFIG_MULTI_IRQ_HANDLER */
diff --git a/arch/arm/include/asm/entry-macro-vic2.S b/arch/arm/include/asm/entry-macro-vic2.S
deleted file mode 100644
index 3ceb85e..0000000
--- a/arch/arm/include/asm/entry-macro-vic2.S
+++ /dev/null
@@ -1,57 +0,0 @@
-/* arch/arm/include/asm/entry-macro-vic2.S
- *
- * Originally arch/arm/mach-s3c6400/include/mach/entry-macro.S
- *
- * Copyright 2008 Openmoko, Inc.
- * Copyright 2008 Simtec Electronics
- *	http://armlinux.simtec.co.uk/
- *	Ben Dooks <ben@simtec.co.uk>
- *
- * Low-level IRQ helper macros for a device with two VICs
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
-*/
-
-/* This should be included from <mach/entry-macro.S> with the necessary
- * defines for virtual addresses and IRQ bases for the two vics.
- *
- * The code needs the following defined:
- *	IRQ_VIC0_BASE	IRQ number of VIC0's first IRQ
- *	IRQ_VIC1_BASE	IRQ number of VIC1's first IRQ
- *	VA_VIC0		Virtual address of VIC0
- *	VA_VIC1		Virtual address of VIC1
- *
- * Note, code assumes VIC0's virtual address is an ARM immediate constant
- * away from VIC1.
-*/
-
-#include <asm/hardware/vic.h>
-
-	.macro	disable_fiq
-	.endm
-
-	.macro	get_irqnr_preamble, base, tmp
-	ldr	\base, =VA_VIC0
-	.endm
-
-	.macro	arch_ret_to_user, tmp1, tmp2
-	.endm
-
-	.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-
-	@ check the vic0
-	mov	\irqnr, #IRQ_VIC0_BASE + 31
-	ldr	\irqstat, [ \base, # VIC_IRQ_STATUS ]
-	teq	\irqstat, #0
-
-	@ otherwise try vic1
-	addeq	\tmp, \base, #(VA_VIC1 - VA_VIC0)
-	addeq	\irqnr, \irqnr, #(IRQ_VIC1_BASE - IRQ_VIC0_BASE)
-	ldreq	\irqstat, [ \tmp, # VIC_IRQ_STATUS ]
-	teqeq	\irqstat, #0
-
-	clzne	\irqstat, \irqstat
-	subne	\irqnr, \irqnr, \irqstat
-	.endm
-- 
1.7.5.4
