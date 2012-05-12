From: shc_work@mail.ru (Alexander Shiyan)
Date: Sun, 13 May 2012 02:40:57 +0400
Subject: [PATCH] ARM: clps711x/cleanup: Combine header files into one for
 clps711x-targets
Message-ID: <1336862457-4077-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current ARM7 Cirrus Logic product line contains only 3 cpu.
EP7312 - Fully functional.
EP7309 - Missing SDRAM interface.
EP7311 - Missing DAI.
It makes no sense to separate the header files to identify these differences,
it is only necessary to keep in mind the presence or lack of any features of
a specific CPU when writing code.
Patch created for arm-soc clps711x/cleanup branch.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/include/asm/hardware/clps7111.h       |   59 ++++++++++++++++++++
 arch/arm/include/asm/hardware/cs89712.h        |   49 ----------------
 arch/arm/include/asm/hardware/ep7211.h         |   31 ----------
 arch/arm/include/asm/hardware/ep7212.h         |   71 ------------------------
 arch/arm/mach-clps711x/Kconfig                 |   21 +------
 arch/arm/mach-clps711x/include/mach/hardware.h |   23 --------
 drivers/net/irda/Kconfig                       |    4 +-
 7 files changed, 65 insertions(+), 193 deletions(-)
 delete mode 100644 arch/arm/include/asm/hardware/cs89712.h
 delete mode 100644 arch/arm/include/asm/hardware/ep7211.h
 delete mode 100644 arch/arm/include/asm/hardware/ep7212.h

diff --git a/arch/arm/include/asm/hardware/clps7111.h b/arch/arm/include/asm/hardware/clps7111.h
index 78e2856..0998606 100644
--- a/arch/arm/include/asm/hardware/clps7111.h
+++ b/arch/arm/include/asm/hardware/clps7111.h
@@ -27,9 +27,11 @@
 
 #define PADR		(0x0000)
 #define PBDR		(0x0001)
+#define PCDR		(0x0002)
 #define PDDR		(0x0003)
 #define PADDR		(0x0040)
 #define PBDDR		(0x0041)
+#define PCDDR		(0x0042)
 #define PDDDR		(0x0043)
 #define PEDR		(0x0080)
 #define PEDDR		(0x00c0)
@@ -76,6 +78,18 @@
 #define SS2POP		(0x16c0)
 #define KBDEOI		(0x1700)
 
+#define DAIR		(0x2000)
+#define DAIR0		(0x2040)
+#define DAIDR1		(0x2080)
+#define DAIDR2		(0x20c0)
+#define DAISR		(0x2100)
+#define SYSCON3		(0x2200)
+#define INTSR3		(0x2240)
+#define INTMR3		(0x2280)
+#define LEDFLSH		(0x22c0)
+#define SDCONF		(0x2300)
+#define SDRFPR		(0x2340)
+
 /* common bits: SYSCON1 / SYSCON2 */
 #define SYSCON_UARTEN		(1 << 8)
 
@@ -172,4 +186,49 @@
 #define SYNCIO_SMCKEN		(1 << 13)
 #define SYNCIO_TXFRMEN		(1 << 14)
 
+#define DAIR_DAIEN		(1 << 16)
+#define DAIR_ECS		(1 << 17)
+#define DAIR_LCTM		(1 << 19)
+#define DAIR_LCRM		(1 << 20)
+#define DAIR_RCTM		(1 << 21)
+#define DAIR_RCRM		(1 << 22)
+#define DAIR_LBM		(1 << 23)
+
+#define DAIDR2_FIFOEN		(1 << 15)
+#define DAIDR2_FIFOLEFT		(0x0d << 16)
+#define DAIDR2_FIFORIGHT	(0x11 << 16)
+
+#define DAISR_RCTS		(1 << 0)
+#define DAISR_RCRS		(1 << 1)
+#define DAISR_LCTS		(1 << 2)
+#define DAISR_LCRS		(1 << 3)
+#define DAISR_RCTU		(1 << 4)
+#define DAISR_RCRO		(1 << 5)
+#define DAISR_LCTU		(1 << 6)
+#define DAISR_LCRO		(1 << 7)
+#define DAISR_RCNF		(1 << 8)
+#define DAISR_RCNE		(1 << 9)
+#define DAISR_LCNF		(1 << 10)
+#define DAISR_LCNE		(1 << 11)
+#define DAISR_FIFO		(1 << 12)
+
+#define SYSCON3_ADCCON		(1 << 0)
+#define SYSCON3_DAISEL		(1 << 3)
+#define SYSCON3_ADCCKNSEN	(1 << 4)
+#define SYSCON3_FASTWAKE	(1 << 8)
+#define SYSCON3_DAIEN		(1 << 9)
+
+#define SDCONF_ACTIVE		(1 << 10)
+#define SDCONF_CLKCTL		(1 << 9)
+#define SDCONF_WIDTH_4		(0 << 7)
+#define SDCONF_WIDTH_8		(1 << 7)
+#define SDCONF_WIDTH_16		(2 << 7)
+#define SDCONF_WIDTH_32		(3 << 7)
+#define SDCONF_SIZE_16		(0 << 5)
+#define SDCONF_SIZE_64		(1 << 5)
+#define SDCONF_SIZE_128		(2 << 5)
+#define SDCONF_SIZE_256		(3 << 5)
+#define SDCONF_CASLAT_2		(2)
+#define SDCONF_CASLAT_3		(3)
+
 #endif /* __ASM_HARDWARE_CLPS7111_H */
diff --git a/arch/arm/include/asm/hardware/cs89712.h b/arch/arm/include/asm/hardware/cs89712.h
deleted file mode 100644
index f756269..0000000
--- a/arch/arm/include/asm/hardware/cs89712.h
+++ /dev/null
@@ -1,49 +0,0 @@
-/*
- *  arch/arm/include/asm/hardware/cs89712.h
- *
- *  This file contains the hardware definitions of the CS89712
- *  additional internal registers.
- *
- *  Copyright (C) 2001 Thomas Gleixner autronix automation <gleixner@autronix.de>
- *			
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
-#ifndef __ASM_HARDWARE_CS89712_H
-#define __ASM_HARDWARE_CS89712_H
-
-/*
-*	CS89712 additional registers
-*/
-                                  
-#define PCDR			0x0002	/* Port C Data register ---------------------------- */
-#define PCDDR			0x0042	/* Port C Data Direction register ------------------ */
-#define SDCONF			0x2300  /* SDRAM Configuration register ---------------------*/
-#define SDRFPR			0x2340  /* SDRAM Refresh period register --------------------*/
-
-#define SDCONF_ACTIVE		(1 << 10)
-#define SDCONF_CLKCTL		(1 << 9)
-#define SDCONF_WIDTH_4		(0 << 7)
-#define SDCONF_WIDTH_8		(1 << 7)
-#define SDCONF_WIDTH_16		(2 << 7)
-#define SDCONF_WIDTH_32		(3 << 7)
-#define SDCONF_SIZE_16		(0 << 5)
-#define SDCONF_SIZE_64		(1 << 5)
-#define SDCONF_SIZE_128		(2 << 5)
-#define SDCONF_SIZE_256		(3 << 5)
-#define SDCONF_CASLAT_2		(2)
-#define SDCONF_CASLAT_3		(3)
-
-#endif /* __ASM_HARDWARE_CS89712_H */
diff --git a/arch/arm/include/asm/hardware/ep7211.h b/arch/arm/include/asm/hardware/ep7211.h
deleted file mode 100644
index 4b3f86b..0000000
--- a/arch/arm/include/asm/hardware/ep7211.h
+++ /dev/null
@@ -1,31 +0,0 @@
-/*
- *  arch/arm/include/asm/hardware/ep7211.h
- *
- *  This file contains the hardware definitions of the EP7211 internal
- *  registers.
- *
- *  Copyright (C) 2001 Blue Mug, Inc.  All Rights Reserved.
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
-#ifndef __ASM_HARDWARE_EP7211_H
-#define __ASM_HARDWARE_EP7211_H
-
-/*
- * XXX miket at bluemug.com: need to introduce EP7211 registers (those not
- * present in 7212) here.
- */
-
-#endif /* __ASM_HARDWARE_EP7211_H */
diff --git a/arch/arm/include/asm/hardware/ep7212.h b/arch/arm/include/asm/hardware/ep7212.h
deleted file mode 100644
index aad07f7..0000000
--- a/arch/arm/include/asm/hardware/ep7212.h
+++ /dev/null
@@ -1,71 +0,0 @@
-/*
- *  arch/arm/include/asm/hardware/ep7212.h
- *
- *  This file contains the hardware definitions of the EP7212 internal
- *  registers.
- *
- *  Copyright (C) 2000 Deep Blue Solutions Ltd.
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
-#ifndef __ASM_HARDWARE_EP7212_H
-#define __ASM_HARDWARE_EP7212_H
-
-/*
- * These registers are specific to the EP7212 only
- */
-#define DAIR			0x2000
-#define DAIR0			0x2040
-#define DAIDR1			0x2080
-#define DAIDR2			0x20c0
-#define DAISR			0x2100
-#define SYSCON3			0x2200
-#define INTSR3			0x2240
-#define INTMR3			0x2280
-#define LEDFLSH			0x22c0
-
-#define DAIR_DAIEN		(1 << 16)
-#define DAIR_ECS		(1 << 17)
-#define DAIR_LCTM		(1 << 19)
-#define DAIR_LCRM		(1 << 20)
-#define DAIR_RCTM		(1 << 21)
-#define DAIR_RCRM		(1 << 22)
-#define DAIR_LBM		(1 << 23)
-
-#define DAIDR2_FIFOEN		(1 << 15)
-#define DAIDR2_FIFOLEFT		(0x0d << 16)
-#define DAIDR2_FIFORIGHT	(0x11 << 16)
-
-#define DAISR_RCTS		(1 << 0)
-#define DAISR_RCRS		(1 << 1)
-#define DAISR_LCTS		(1 << 2)
-#define DAISR_LCRS		(1 << 3)
-#define DAISR_RCTU		(1 << 4)
-#define DAISR_RCRO		(1 << 5)
-#define DAISR_LCTU		(1 << 6)
-#define DAISR_LCRO		(1 << 7)
-#define DAISR_RCNF		(1 << 8)
-#define DAISR_RCNE		(1 << 9)
-#define DAISR_LCNF		(1 << 10)
-#define DAISR_LCNE		(1 << 11)
-#define DAISR_FIFO		(1 << 12)
-
-#define SYSCON3_ADCCON		(1 << 0)
-#define SYSCON3_DAISEL		(1 << 3)
-#define SYSCON3_ADCCKNSEN	(1 << 4)
-#define SYSCON3_FASTWAKE	(1 << 8)
-#define SYSCON3_DAIEN		(1 << 9)
-
-#endif /* __ASM_HARDWARE_EP7212_H */
diff --git a/arch/arm/mach-clps711x/Kconfig b/arch/arm/mach-clps711x/Kconfig
index eb34bd1..ea036d6 100644
--- a/arch/arm/mach-clps711x/Kconfig
+++ b/arch/arm/mach-clps711x/Kconfig
@@ -1,6 +1,6 @@
 if ARCH_CLPS711X
 
-menu "CLPS711X/EP721X Implementations"
+menu "CLPS711X/EP721X/EP731X Implementations"
 
 config ARCH_AUTCPU12
 	bool "AUTCPU12"
@@ -45,26 +45,13 @@ config ARCH_P720T
 config ARCH_FORTUNET
 	bool "FORTUNET"
 
-# XXX Maybe these should indicate register compatibility
-# instead of being mutually exclusive.
-config ARCH_EP7211
-	bool
-	depends on ARCH_EDB7211
-	default y
-
-config ARCH_EP7212
-	bool
-	depends on ARCH_P720T || ARCH_CEIVA
-	default y
-
 config EP72XX_ROM_BOOT
-	bool "EP72xx ROM boot"
-	depends on ARCH_EP7211 || ARCH_EP7212
-	---help---
+	bool "EP721x/EP731x ROM boot"
+	help
 	  If you say Y here, your CLPS711x-based kernel will use the bootstrap
 	  mode memory map instead of the normal memory map.
 
-	  Processors derived from the Cirrus CLPS-711X core support two boot
+	  Processors derived from the Cirrus CLPS711X core support two boot
 	  modes.  Normal mode boots from the external memory device at CS0.
 	  Bootstrap mode rearranges parts of the memory map, placing an
 	  internal 128 byte bootstrap ROM@CS0.  This option performs the
diff --git a/arch/arm/mach-clps711x/include/mach/hardware.h b/arch/arm/mach-clps711x/include/mach/hardware.h
index 1026ac9..d31fc79 100644
--- a/arch/arm/mach-clps711x/include/mach/hardware.h
+++ b/arch/arm/mach-clps711x/include/mach/hardware.h
@@ -61,32 +61,11 @@
 #define CS7_PHYS_BASE		(0x00000000)
 #endif
 
-#if defined (CONFIG_ARCH_EP7211)
-
-#include <asm/hardware/ep7211.h>
-
-#elif defined (CONFIG_ARCH_EP7212)
-
-#include <asm/hardware/ep7212.h>
-
-#endif
-
 #define SYSPLD_VIRT_BASE	0xfe000000
 #define SYSPLD_BASE		SYSPLD_VIRT_BASE
 
-#if  defined (CONFIG_ARCH_AUTCPU12)
-
-#include <asm/hardware/ep7212.h>
-#include <asm/hardware/cs89712.h>
-
-#endif
-
-
 #if defined (CONFIG_ARCH_CDB89712)
 
-#include <asm/hardware/ep7212.h>
-#include <asm/hardware/cs89712.h>
-
 #define ETHER_START      0x20000000
 #define ETHER_SIZE       0x1000
 #define ETHER_BASE       0xfe000000
@@ -149,8 +128,6 @@
 
 #if defined (CONFIG_ARCH_CEIVA)
 
-#include <asm/hardware/ep7212.h>
-
 /*
  * The two flash banks are wired to chip selects 0 and 1. This is the mapping
  * for them.
diff --git a/drivers/net/irda/Kconfig b/drivers/net/irda/Kconfig
index 4680478..e7ecd3f 100644
--- a/drivers/net/irda/Kconfig
+++ b/drivers/net/irda/Kconfig
@@ -211,8 +211,8 @@ config KINGSUN_DONGLE
 	  kingsun-sir.
 
 config EP7211_DONGLE
-	tristate "EP7211 I/R support"
-	depends on IRTTY_SIR && ARCH_EP7211 && IRDA && EXPERIMENTAL
+	tristate "Cirrus Logic clps711x I/R support"
+	depends on IRTTY_SIR && ARCH_CLPS711X && IRDA && EXPERIMENTAL
 	help
 	  Say Y here if you want to build support for the Cirrus logic
 	  EP7211 chipset's infrared module.
-- 
1.7.3.4
