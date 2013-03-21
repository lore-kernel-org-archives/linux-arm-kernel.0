From: linus.walleij@stericsson.com (Linus Walleij)
Date: Thu, 21 Mar 2013 12:49:13 +0100
Subject: [PATCH 6/6] ARM: ux500: get rid of <mach/[hardware|db8500-regs].h>
In-Reply-To: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
References: <1363866553-15054-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <1363866553-15054-7-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

This removes <mach/hardware.h> and <mach/db8500-regs.h>
from the Ux500, merging them into the local include
"db8500-regs.h" in mach-ux500. There is some impact
outside the ux500 machine, but most of it is dealt with
in earlier patches.

Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sam, Mike: seeking your ACKs to take this through ARM SoC.
---
 arch/arm/include/debug/ux500.S                 |  23 ++-
 arch/arm/mach-ux500/board-mop500-audio.c       |   1 -
 arch/arm/mach-ux500/board-mop500-pins.c        |   2 -
 arch/arm/mach-ux500/board-mop500-sdi.c         |   2 +-
 arch/arm/mach-ux500/board-mop500-uib.c         |   1 -
 arch/arm/mach-ux500/board-mop500.c             |   2 +-
 arch/arm/mach-ux500/cache-l2x0.c               |   2 +-
 arch/arm/mach-ux500/cpu-db8500.c               |   4 +-
 arch/arm/mach-ux500/cpu.c                      |   2 +-
 arch/arm/mach-ux500/cpuidle.c                  |   2 +-
 arch/arm/mach-ux500/db8500-regs.h              | 201 +++++++++++++++++++++++++
 arch/arm/mach-ux500/devices-common.c           |   1 -
 arch/arm/mach-ux500/devices-db8500.c           |   8 +-
 arch/arm/mach-ux500/devices-db8500.h           |   1 +
 arch/arm/mach-ux500/devices.c                  |   3 +-
 arch/arm/mach-ux500/id.c                       |   2 +-
 arch/arm/mach-ux500/include/mach/db8500-regs.h | 173 ---------------------
 arch/arm/mach-ux500/include/mach/hardware.h    |  45 ------
 arch/arm/mach-ux500/include/mach/irqs.h        |   2 -
 arch/arm/mach-ux500/include/mach/uncompress.h  |   3 +-
 arch/arm/mach-ux500/platsmp.c                  |   2 +-
 arch/arm/mach-ux500/timer.c                    |   2 +-
 arch/arm/mach-ux500/usb.c                      |   2 +-
 drivers/clk/ux500/clk-prcc.c                   |   1 -
 drivers/clocksource/clksrc-dbx500-prcmu.c      |   1 -
 drivers/mfd/db8500-prcmu.c                     |   2 -
 drivers/mfd/dbx500-prcmu-regs.h                |  22 ---
 27 files changed, 239 insertions(+), 273 deletions(-)
 create mode 100644 arch/arm/mach-ux500/db8500-regs.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/db8500-regs.h
 delete mode 100644 arch/arm/mach-ux500/include/mach/hardware.h

diff --git a/arch/arm/include/debug/ux500.S b/arch/arm/include/debug/ux500.S
index 6703522..2848857 100644
--- a/arch/arm/include/debug/ux500.S
+++ b/arch/arm/include/debug/ux500.S
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  */
-#include <mach/hardware.h>
+
 
 #if CONFIG_UX500_DEBUG_UART > 2
 #error Invalid Ux500 debug UART
@@ -21,19 +21,28 @@
  */
 
 #ifdef CONFIG_UX500_SOC_DB8500
-#define __UX500_UART(n)	U8500_UART##n##_BASE
+#define U8500_UART0_PHYS_BASE	(0x80120000)
+#define U8500_UART1_PHYS_BASE	(0x80121000)
+#define U8500_UART2_PHYS_BASE	(0x80007000)
+#define U8500_UART0_VIRT_BASE	(0xa8120000)
+#define U8500_UART1_VIRT_BASE	(0xa8121000)
+#define U8500_UART2_VIRT_BASE	(0xa8007000)
+#define __UX500_PHYS_UART(n)	U8500_UART##n##_PHYS_BASE
+#define __UX500_VIRT_UART(n)	U8500_UART##n##_VIRT_BASE
 #endif
 
-#ifndef __UX500_UART
+#if !defined(__UX500_PHYS_UART) || !defined(__UX500_VIRT_UART)
 #error Unknown SOC
 #endif
 
-#define UX500_UART(n)	__UX500_UART(n)
-#define UART_BASE	UX500_UART(CONFIG_UX500_DEBUG_UART)
+#define UX500_PHYS_UART(n)	__UX500_PHYS_UART(n)
+#define UX500_VIRT_UART(n)	__UX500_VIRT_UART(n)
+#define UART_PHYS_BASE	UX500_PHYS_UART(CONFIG_UX500_DEBUG_UART)
+#define UART_VIRT_BASE	UX500_VIRT_UART(CONFIG_UX500_DEBUG_UART)
 
 	.macro	addruart, rp, rv, tmp
-	ldr	\rp, =UART_BASE				@ no, physical address
-	ldr	\rv, =IO_ADDRESS(UART_BASE)		@ yes, virtual address
+	ldr	\rp, =UART_PHYS_BASE		@ no, physical address
+	ldr	\rv, =UART_VIRT_BASE		@ yes, virtual address
 	.endm
 
 #include <asm/hardware/debug-pl01x.S>
diff --git a/arch/arm/mach-ux500/board-mop500-audio.c b/arch/arm/mach-ux500/board-mop500-audio.c
index 7209db7..c8167bf 100644
--- a/arch/arm/mach-ux500/board-mop500-audio.c
+++ b/arch/arm/mach-ux500/board-mop500-audio.c
@@ -11,7 +11,6 @@
 #include <linux/platform_data/dma-ste-dma40.h>
 
 #include <mach/devices.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/msp.h>
 
diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 0a3f30d..f3976f9 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -13,8 +13,6 @@
 
 #include <asm/mach-types.h>
 
-#include <mach/hardware.h>
-
 #include "pins-db8500.h"
 #include "board-mop500.h"
 
diff --git a/arch/arm/mach-ux500/board-mop500-sdi.c b/arch/arm/mach-ux500/board-mop500-sdi.c
index 051b62c..0ada767 100644
--- a/arch/arm/mach-ux500/board-mop500-sdi.c
+++ b/arch/arm/mach-ux500/board-mop500-sdi.c
@@ -15,8 +15,8 @@
 
 #include <asm/mach-types.h>
 #include <mach/devices.h>
-#include <mach/hardware.h>
 
+#include "db8500-regs.h"
 #include "devices-db8500.h"
 #include "board-mop500.h"
 #include "ste-dma40-db8500.h"
diff --git a/arch/arm/mach-ux500/board-mop500-uib.c b/arch/arm/mach-ux500/board-mop500-uib.c
index 7037d36..bdaa422 100644
--- a/arch/arm/mach-ux500/board-mop500-uib.c
+++ b/arch/arm/mach-ux500/board-mop500-uib.c
@@ -11,7 +11,6 @@
 #include <linux/init.h>
 #include <linux/i2c.h>
 
-#include <mach/hardware.h>
 #include "board-mop500.h"
 #include "id.h"
 
diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index b034578..caad80e 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -41,13 +41,13 @@
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
 #include <mach/irqs.h>
 #include <linux/platform_data/crypto-ux500.h>
 
 #include "ste-dma40-db8500.h"
+#include "db8500-regs.h"
 #include "devices-db8500.h"
 #include "board-mop500.h"
 #include "board-mop500-regulators.h"
diff --git a/arch/arm/mach-ux500/cache-l2x0.c b/arch/arm/mach-ux500/cache-l2x0.c
index 1c1609d..e12cc92 100644
--- a/arch/arm/mach-ux500/cache-l2x0.c
+++ b/arch/arm/mach-ux500/cache-l2x0.c
@@ -9,8 +9,8 @@
 
 #include <asm/cacheflush.h>
 #include <asm/hardware/cache-l2x0.h>
-#include <mach/hardware.h>
 
+#include "db8500-regs.h"
 #include "id.h"
 
 static void __iomem *l2x0_base;
diff --git a/arch/arm/mach-ux500/cpu-db8500.c b/arch/arm/mach-ux500/cpu-db8500.c
index 8c58dff..d726c06 100644
--- a/arch/arm/mach-ux500/cpu-db8500.c
+++ b/arch/arm/mach-ux500/cpu-db8500.c
@@ -28,15 +28,13 @@
 #include <asm/mach/map.h>
 #include <asm/mach/arch.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
-#include <mach/db8500-regs.h>
 #include <mach/irqs.h>
 
 #include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
-
+#include "db8500-regs.h"
 #include "board-mop500.h"
 #include "id.h"
 
diff --git a/arch/arm/mach-ux500/cpu.c b/arch/arm/mach-ux500/cpu.c
index 38459e9..1754041 100644
--- a/arch/arm/mach-ux500/cpu.c
+++ b/arch/arm/mach-ux500/cpu.c
@@ -23,11 +23,11 @@
 
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/devices.h>
 
 #include "board-mop500.h"
+#include "db8500-regs.h"
 #include "id.h"
 
 /*
diff --git a/arch/arm/mach-ux500/cpuidle.c b/arch/arm/mach-ux500/cpuidle.c
index df3c1d3..8e906fb 100644
--- a/arch/arm/mach-ux500/cpuidle.c
+++ b/arch/arm/mach-ux500/cpuidle.c
@@ -23,7 +23,7 @@
 #include <asm/cpuidle.h>
 #include <asm/proc-fns.h>
 
-#include <mach/hardware.h>
+#include "db8500-regs.h"
 
 /* ARM WFI Standby signal register */
 #define PRCM_ARM_WFI_STANDBY    (prcmu_base + 0x130)
diff --git a/arch/arm/mach-ux500/db8500-regs.h b/arch/arm/mach-ux500/db8500-regs.h
new file mode 100644
index 0000000..b2d7a0b
--- /dev/null
+++ b/arch/arm/mach-ux500/db8500-regs.h
@@ -0,0 +1,201 @@
+/*
+ * Copyright (C) ST-Ericsson SA 2010
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __MACH_DB8500_REGS_H
+#define __MACH_DB8500_REGS_H
+
+/* Base address and bank offsets for ESRAM */
+#define U8500_ESRAM_BASE	0x40000000
+#define U8500_ESRAM_BANK_SIZE	0x00020000
+#define U8500_ESRAM_BANK0	U8500_ESRAM_BASE
+#define U8500_ESRAM_BANK1	(U8500_ESRAM_BASE + U8500_ESRAM_BANK_SIZE)
+#define U8500_ESRAM_BANK2	(U8500_ESRAM_BANK1 + U8500_ESRAM_BANK_SIZE)
+#define U8500_ESRAM_BANK3	(U8500_ESRAM_BANK2 + U8500_ESRAM_BANK_SIZE)
+#define U8500_ESRAM_BANK4	(U8500_ESRAM_BANK3 + U8500_ESRAM_BANK_SIZE)
+/*
+ * on V1 DMA uses 4KB for logical parameters position is right after the 64KB
+ * reserved for security
+ */
+#define U8500_ESRAM_DMA_LCPA_OFFSET     0x10000
+
+#define U8500_DMA_LCPA_BASE    (U8500_ESRAM_BANK0 + U8500_ESRAM_DMA_LCPA_OFFSET)
+
+/* This address fulfills the 256k alignment requirement of the lcla base */
+#define U8500_DMA_LCLA_BASE	U8500_ESRAM_BANK4
+
+#define U8500_PER3_BASE		0x80000000
+#define U8500_STM_BASE		0x80100000
+#define U8500_STM_REG_BASE	(U8500_STM_BASE + 0xF000)
+#define U8500_PER2_BASE		0x80110000
+#define U8500_PER1_BASE		0x80120000
+#define U8500_B2R2_BASE		0x80130000
+#define U8500_HSEM_BASE		0x80140000
+#define U8500_PER4_BASE		0x80150000
+#define U8500_TPIU_BASE		0x80190000
+#define U8500_ICN_BASE		0x81000000
+
+#define U8500_BOOT_ROM_BASE	0x90000000
+/* ASIC ID is at 0xbf4 offset within this region */
+#define U8500_ASIC_ID_BASE	0x9001D000
+
+#define U9540_BOOT_ROM_BASE	0xFFFE0000
+/* ASIC ID is at 0xbf4 offset within this region */
+#define U9540_ASIC_ID_BASE	0xFFFFD000
+
+#define U8500_PER6_BASE		0xa03c0000
+#define U8500_PER7_BASE		0xa03d0000
+#define U8500_PER5_BASE		0xa03e0000
+
+#define U8500_SVA_BASE		0xa0100000
+#define U8500_SIA_BASE		0xa0200000
+
+#define U8500_SGA_BASE		0xa0300000
+#define U8500_MCDE_BASE		0xa0350000
+#define U8500_DMA_BASE		0x801C0000	/* v1 */
+
+#define U8500_SBAG_BASE		0xa0390000
+
+#define U8500_SCU_BASE		0xa0410000
+#define U8500_GIC_CPU_BASE	0xa0410100
+#define U8500_TWD_BASE		0xa0410600
+#define U8500_GIC_DIST_BASE	0xa0411000
+#define U8500_L2CC_BASE		0xa0412000
+
+#define U8500_MODEM_I2C		0xb7e02000
+
+#define U8500_GPIO0_BASE	(U8500_PER1_BASE + 0xE000)
+#define U8500_GPIO1_BASE	(U8500_PER3_BASE + 0xE000)
+#define U8500_GPIO2_BASE	(U8500_PER2_BASE + 0xE000)
+#define U8500_GPIO3_BASE	(U8500_PER5_BASE + 0x1E000)
+
+#define U8500_UART0_BASE	(U8500_PER1_BASE + 0x0000)
+#define U8500_UART1_BASE	(U8500_PER1_BASE + 0x1000)
+
+/* per6 base addresses */
+#define U8500_RNG_BASE		(U8500_PER6_BASE + 0x0000)
+#define U8500_HASH0_BASE        (U8500_PER6_BASE + 0x1000)
+#define U8500_HASH1_BASE        (U8500_PER6_BASE + 0x2000)
+#define U8500_PKA_BASE		(U8500_PER6_BASE + 0x4000)
+#define U8500_PKAM_BASE		(U8500_PER6_BASE + 0x5100)
+#define U8500_MTU0_BASE		(U8500_PER6_BASE + 0x6000) /* v1 */
+#define U8500_MTU1_BASE		(U8500_PER6_BASE + 0x7000) /* v1 */
+#define U8500_CR_BASE		(U8500_PER6_BASE + 0x8000) /* v1 */
+#define U8500_CRYP0_BASE	(U8500_PER6_BASE + 0xa000)
+#define U8500_CRYP1_BASE	(U8500_PER6_BASE + 0xb000)
+#define U8500_CLKRST6_BASE	(U8500_PER6_BASE + 0xf000)
+
+/* per5 base addresses */
+#define U8500_USBOTG_BASE	(U8500_PER5_BASE + 0x00000)
+#define U8500_CLKRST5_BASE	(U8500_PER5_BASE + 0x1f000)
+
+/* per4 base addresses */
+#define U8500_BACKUPRAM0_BASE	(U8500_PER4_BASE + 0x00000)
+#define U8500_BACKUPRAM1_BASE	(U8500_PER4_BASE + 0x01000)
+#define U8500_RTT0_BASE		(U8500_PER4_BASE + 0x02000)
+#define U8500_RTT1_BASE		(U8500_PER4_BASE + 0x03000)
+#define U8500_RTC_BASE		(U8500_PER4_BASE + 0x04000)
+#define U8500_SCR_BASE		(U8500_PER4_BASE + 0x05000)
+#define U8500_DMC_BASE		(U8500_PER4_BASE + 0x06000)
+#define U8500_PRCMU_BASE	(U8500_PER4_BASE + 0x07000)
+#define U9540_DMC1_BASE		(U8500_PER4_BASE + 0x0A000)
+#define U8500_PRCMU_TCDM_BASE	(U8500_PER4_BASE + 0x68000)
+#define U9540_PRCMU_TCDM_BASE	(U8500_PER4_BASE + 0x6A000)
+#define U8500_PRCMU_TCPM_BASE   (U8500_PER4_BASE + 0x60000)
+#define U8500_PRCMU_TIMER_3_BASE (U8500_PER4_BASE + 0x07338)
+#define U8500_PRCMU_TIMER_4_BASE (U8500_PER4_BASE + 0x07450)
+
+/* per3 base addresses */
+#define U8500_FSMC_BASE		(U8500_PER3_BASE + 0x0000)
+#define U8500_SSP0_BASE		(U8500_PER3_BASE + 0x2000)
+#define U8500_SSP1_BASE		(U8500_PER3_BASE + 0x3000)
+#define U8500_I2C0_BASE		(U8500_PER3_BASE + 0x4000)
+#define U8500_SDI2_BASE		(U8500_PER3_BASE + 0x5000)
+#define U8500_SKE_BASE		(U8500_PER3_BASE + 0x6000)
+#define U8500_UART2_BASE	(U8500_PER3_BASE + 0x7000)
+#define U8500_SDI5_BASE		(U8500_PER3_BASE + 0x8000)
+#define U8500_CLKRST3_BASE	(U8500_PER3_BASE + 0xf000)
+
+/* per2 base addresses */
+#define U8500_I2C3_BASE		(U8500_PER2_BASE + 0x0000)
+#define U8500_SPI2_BASE		(U8500_PER2_BASE + 0x1000)
+#define U8500_SPI1_BASE		(U8500_PER2_BASE + 0x2000)
+#define U8500_PWL_BASE		(U8500_PER2_BASE + 0x3000)
+#define U8500_SDI4_BASE		(U8500_PER2_BASE + 0x4000)
+#define U8500_MSP2_BASE		(U8500_PER2_BASE + 0x7000)
+#define U8500_SDI1_BASE		(U8500_PER2_BASE + 0x8000)
+#define U8500_SDI3_BASE		(U8500_PER2_BASE + 0x9000)
+#define U8500_SPI0_BASE		(U8500_PER2_BASE + 0xa000)
+#define U8500_HSIR_BASE		(U8500_PER2_BASE + 0xb000)
+#define U8500_HSIT_BASE		(U8500_PER2_BASE + 0xc000)
+#define U8500_CLKRST2_BASE	(U8500_PER2_BASE + 0xf000)
+
+/* per1 base addresses */
+#define U8500_I2C1_BASE		(U8500_PER1_BASE + 0x2000)
+#define U8500_MSP0_BASE		(U8500_PER1_BASE + 0x3000)
+#define U8500_MSP1_BASE		(U8500_PER1_BASE + 0x4000)
+#define U8500_MSP3_BASE		(U8500_PER1_BASE + 0x5000)
+#define U8500_SDI0_BASE		(U8500_PER1_BASE + 0x6000)
+#define U8500_I2C2_BASE		(U8500_PER1_BASE + 0x8000)
+#define U8500_SPI3_BASE		(U8500_PER1_BASE + 0x9000)
+#define U8500_I2C4_BASE		(U8500_PER1_BASE + 0xa000)
+#define U8500_SLIM0_BASE	(U8500_PER1_BASE + 0xb000)
+#define U8500_CLKRST1_BASE	(U8500_PER1_BASE + 0xf000)
+
+#define U8500_SHRM_GOP_INTERRUPT_BASE	0xB7C00040
+
+#define U8500_GPIOBANK0_BASE	U8500_GPIO0_BASE
+#define U8500_GPIOBANK1_BASE	(U8500_GPIO0_BASE + 0x80)
+#define U8500_GPIOBANK2_BASE	U8500_GPIO1_BASE
+#define U8500_GPIOBANK3_BASE	(U8500_GPIO1_BASE + 0x80)
+#define U8500_GPIOBANK4_BASE	(U8500_GPIO1_BASE + 0x100)
+#define U8500_GPIOBANK5_BASE	(U8500_GPIO1_BASE + 0x180)
+#define U8500_GPIOBANK6_BASE	U8500_GPIO2_BASE
+#define U8500_GPIOBANK7_BASE	(U8500_GPIO2_BASE + 0x80)
+#define U8500_GPIOBANK8_BASE	U8500_GPIO3_BASE
+
+#define U8500_MCDE_SIZE		0x1000
+#define U8500_DSI_LINK_SIZE	0x1000
+#define U8500_DSI_LINK1_BASE	(U8500_MCDE_BASE + U8500_MCDE_SIZE)
+#define U8500_DSI_LINK2_BASE	(U8500_DSI_LINK1_BASE + U8500_DSI_LINK_SIZE)
+#define U8500_DSI_LINK3_BASE	(U8500_DSI_LINK2_BASE + U8500_DSI_LINK_SIZE)
+#define U8500_DSI_LINK_COUNT	0x3
+
+/* Modem and APE physical addresses */
+#define U8500_MODEM_BASE	0xe000000
+#define U8500_APE_BASE		0x6000000
+
+/* SoC identification number information */
+#define U8500_BB_UID_BASE      (U8500_BACKUPRAM1_BASE + 0xFC0)
+
+/* Offsets to specific addresses in some IP blocks for DMA */
+#define MSP_TX_RX_REG_OFFSET	0
+#define CRYP1_RX_REG_OFFSET	0x10
+#define CRYP1_TX_REG_OFFSET	0x8
+#define HASH1_TX_REG_OFFSET	0x4
+
+/*
+ * Macros to get at IO space when running virtually
+ * We dont map all the peripherals, let ioremap do
+ * this for us. We map only very basic peripherals here.
+ */
+#define U8500_IO_VIRTUAL	0xf0000000
+#define U8500_IO_PHYSICAL	0xa0000000
+/* This is where we map in the ROM to check ASIC IDs */
+#define UX500_VIRT_ROM		0xf0000000
+
+/* This macro is used in assembly, so no cast */
+#define IO_ADDRESS(x)           \
+	(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + U8500_IO_VIRTUAL)
+
+/* typesafe io address */
+#define __io_address(n)		IOMEM(IO_ADDRESS(n))
+
+/* Used by some plat-nomadik code */
+#define io_p2v(n)		__io_address(n)
+
+#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
+
+#endif
diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
index 16b5f71..94868b7 100644
--- a/arch/arm/mach-ux500/devices-common.c
+++ b/arch/arm/mach-ux500/devices-common.c
@@ -13,7 +13,6 @@
 #include <linux/platform_device.h>
 #include <linux/platform_data/pinctrl-nomadik.h>
 
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 
 #include "devices-common.h"
diff --git a/arch/arm/mach-ux500/devices-db8500.c b/arch/arm/mach-ux500/devices-db8500.c
index f3d9419..9152aca 100644
--- a/arch/arm/mach-ux500/devices-db8500.c
+++ b/arch/arm/mach-ux500/devices-db8500.c
@@ -15,10 +15,10 @@
 #include <linux/platform_data/dma-ste-dma40.h>
 #include <linux/mfd/dbx500-prcmu.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 #include <mach/irqs.h>
 
+#include "db8500-regs.h"
 #include "devices-db8500.h"
 #include "ste-dma40-db8500.h"
 
@@ -228,6 +228,12 @@ static struct resource db8500_prcmu_res[] = {
 		.end   = U8500_PRCMU_TCPM_BASE + SZ_4K - 1,
 		.flags = IORESOURCE_MEM,
 	},
+	{
+		.name  = "gic-distbase",
+		.start = U8500_GIC_DIST_BASE,
+		.end   = U8500_GIC_DIST_BASE + SZ_4K - 1,
+		.flags = IORESOURCE_MEM,
+	},
 };
 
 struct platform_device db8500_prcmu_device = {
diff --git a/arch/arm/mach-ux500/devices-db8500.h b/arch/arm/mach-ux500/devices-db8500.h
index dbcb35c..c9db210 100644
--- a/arch/arm/mach-ux500/devices-db8500.h
+++ b/arch/arm/mach-ux500/devices-db8500.h
@@ -10,6 +10,7 @@
 
 #include <linux/platform_data/usb-musb-ux500.h>
 #include <mach/irqs.h>
+#include "db8500-regs.h"
 #include "devices-common.h"
 
 struct ske_keypad_platform_data;
diff --git a/arch/arm/mach-ux500/devices.c b/arch/arm/mach-ux500/devices.c
index ea0a2f9..f63a512 100644
--- a/arch/arm/mach-ux500/devices.c
+++ b/arch/arm/mach-ux500/devices.c
@@ -11,9 +11,10 @@
 #include <linux/io.h>
 #include <linux/amba/bus.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 
+#include "db8500-regs.h"
+
 void __init amba_add_devices(struct amba_device *devs[], int num)
 {
 	int i;
diff --git a/arch/arm/mach-ux500/id.c b/arch/arm/mach-ux500/id.c
index 9f95184..a847cf2 100644
--- a/arch/arm/mach-ux500/id.c
+++ b/arch/arm/mach-ux500/id.c
@@ -14,9 +14,9 @@
 #include <asm/cacheflush.h>
 #include <asm/mach/map.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 
+#include "db8500-regs.h"
 #include "id.h"
 
 struct dbx500_asic_id dbx500_id;
diff --git a/arch/arm/mach-ux500/include/mach/db8500-regs.h b/arch/arm/mach-ux500/include/mach/db8500-regs.h
deleted file mode 100644
index 1530d49..0000000
--- a/arch/arm/mach-ux500/include/mach/db8500-regs.h
+++ /dev/null
@@ -1,173 +0,0 @@
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * License terms: GNU General Public License (GPL) version 2
- */
-
-#ifndef __MACH_DB8500_REGS_H
-#define __MACH_DB8500_REGS_H
-
-/* Base address and bank offsets for ESRAM */
-#define U8500_ESRAM_BASE	0x40000000
-#define U8500_ESRAM_BANK_SIZE	0x00020000
-#define U8500_ESRAM_BANK0	U8500_ESRAM_BASE
-#define U8500_ESRAM_BANK1	(U8500_ESRAM_BASE + U8500_ESRAM_BANK_SIZE)
-#define U8500_ESRAM_BANK2	(U8500_ESRAM_BANK1 + U8500_ESRAM_BANK_SIZE)
-#define U8500_ESRAM_BANK3	(U8500_ESRAM_BANK2 + U8500_ESRAM_BANK_SIZE)
-#define U8500_ESRAM_BANK4	(U8500_ESRAM_BANK3 + U8500_ESRAM_BANK_SIZE)
-/*
- * on V1 DMA uses 4KB for logical parameters position is right after the 64KB
- * reserved for security
- */
-#define U8500_ESRAM_DMA_LCPA_OFFSET     0x10000
-
-#define U8500_DMA_LCPA_BASE    (U8500_ESRAM_BANK0 + U8500_ESRAM_DMA_LCPA_OFFSET)
-
-/* This address fulfills the 256k alignment requirement of the lcla base */
-#define U8500_DMA_LCLA_BASE	U8500_ESRAM_BANK4
-
-#define U8500_PER3_BASE		0x80000000
-#define U8500_STM_BASE		0x80100000
-#define U8500_STM_REG_BASE	(U8500_STM_BASE + 0xF000)
-#define U8500_PER2_BASE		0x80110000
-#define U8500_PER1_BASE		0x80120000
-#define U8500_B2R2_BASE		0x80130000
-#define U8500_HSEM_BASE		0x80140000
-#define U8500_PER4_BASE		0x80150000
-#define U8500_TPIU_BASE		0x80190000
-#define U8500_ICN_BASE		0x81000000
-
-#define U8500_BOOT_ROM_BASE	0x90000000
-/* ASIC ID is at 0xbf4 offset within this region */
-#define U8500_ASIC_ID_BASE	0x9001D000
-
-#define U9540_BOOT_ROM_BASE	0xFFFE0000
-/* ASIC ID is at 0xbf4 offset within this region */
-#define U9540_ASIC_ID_BASE	0xFFFFD000
-
-#define U8500_PER6_BASE		0xa03c0000
-#define U8500_PER7_BASE		0xa03d0000
-#define U8500_PER5_BASE		0xa03e0000
-
-#define U8500_SVA_BASE		0xa0100000
-#define U8500_SIA_BASE		0xa0200000
-
-#define U8500_SGA_BASE		0xa0300000
-#define U8500_MCDE_BASE		0xa0350000
-#define U8500_DMA_BASE		0x801C0000	/* v1 */
-
-#define U8500_SBAG_BASE		0xa0390000
-
-#define U8500_SCU_BASE		0xa0410000
-#define U8500_GIC_CPU_BASE	0xa0410100
-#define U8500_TWD_BASE		0xa0410600
-#define U8500_GIC_DIST_BASE	0xa0411000
-#define U8500_L2CC_BASE		0xa0412000
-
-#define U8500_MODEM_I2C		0xb7e02000
-
-#define U8500_GPIO0_BASE	(U8500_PER1_BASE + 0xE000)
-#define U8500_GPIO1_BASE	(U8500_PER3_BASE + 0xE000)
-#define U8500_GPIO2_BASE	(U8500_PER2_BASE + 0xE000)
-#define U8500_GPIO3_BASE	(U8500_PER5_BASE + 0x1E000)
-
-#define U8500_UART0_BASE	(U8500_PER1_BASE + 0x0000)
-#define U8500_UART1_BASE	(U8500_PER1_BASE + 0x1000)
-
-/* per6 base addresses */
-#define U8500_RNG_BASE		(U8500_PER6_BASE + 0x0000)
-#define U8500_HASH0_BASE        (U8500_PER6_BASE + 0x1000)
-#define U8500_HASH1_BASE        (U8500_PER6_BASE + 0x2000)
-#define U8500_PKA_BASE		(U8500_PER6_BASE + 0x4000)
-#define U8500_PKAM_BASE		(U8500_PER6_BASE + 0x5100)
-#define U8500_MTU0_BASE		(U8500_PER6_BASE + 0x6000) /* v1 */
-#define U8500_MTU1_BASE		(U8500_PER6_BASE + 0x7000) /* v1 */
-#define U8500_CR_BASE		(U8500_PER6_BASE + 0x8000) /* v1 */
-#define U8500_CRYP0_BASE	(U8500_PER6_BASE + 0xa000)
-#define U8500_CRYP1_BASE	(U8500_PER6_BASE + 0xb000)
-#define U8500_CLKRST6_BASE	(U8500_PER6_BASE + 0xf000)
-
-/* per5 base addresses */
-#define U8500_USBOTG_BASE	(U8500_PER5_BASE + 0x00000)
-#define U8500_CLKRST5_BASE	(U8500_PER5_BASE + 0x1f000)
-
-/* per4 base addresses */
-#define U8500_BACKUPRAM0_BASE	(U8500_PER4_BASE + 0x00000)
-#define U8500_BACKUPRAM1_BASE	(U8500_PER4_BASE + 0x01000)
-#define U8500_RTT0_BASE		(U8500_PER4_BASE + 0x02000)
-#define U8500_RTT1_BASE		(U8500_PER4_BASE + 0x03000)
-#define U8500_RTC_BASE		(U8500_PER4_BASE + 0x04000)
-#define U8500_SCR_BASE		(U8500_PER4_BASE + 0x05000)
-#define U8500_DMC_BASE		(U8500_PER4_BASE + 0x06000)
-#define U8500_PRCMU_BASE	(U8500_PER4_BASE + 0x07000)
-#define U9540_DMC1_BASE		(U8500_PER4_BASE + 0x0A000)
-#define U8500_PRCMU_TCDM_BASE	(U8500_PER4_BASE + 0x68000)
-#define U9540_PRCMU_TCDM_BASE	(U8500_PER4_BASE + 0x6A000)
-#define U8500_PRCMU_TCPM_BASE   (U8500_PER4_BASE + 0x60000)
-#define U8500_PRCMU_TIMER_3_BASE (U8500_PER4_BASE + 0x07338)
-#define U8500_PRCMU_TIMER_4_BASE (U8500_PER4_BASE + 0x07450)
-
-/* per3 base addresses */
-#define U8500_FSMC_BASE		(U8500_PER3_BASE + 0x0000)
-#define U8500_SSP0_BASE		(U8500_PER3_BASE + 0x2000)
-#define U8500_SSP1_BASE		(U8500_PER3_BASE + 0x3000)
-#define U8500_I2C0_BASE		(U8500_PER3_BASE + 0x4000)
-#define U8500_SDI2_BASE		(U8500_PER3_BASE + 0x5000)
-#define U8500_SKE_BASE		(U8500_PER3_BASE + 0x6000)
-#define U8500_UART2_BASE	(U8500_PER3_BASE + 0x7000)
-#define U8500_SDI5_BASE		(U8500_PER3_BASE + 0x8000)
-#define U8500_CLKRST3_BASE	(U8500_PER3_BASE + 0xf000)
-
-/* per2 base addresses */
-#define U8500_I2C3_BASE		(U8500_PER2_BASE + 0x0000)
-#define U8500_SPI2_BASE		(U8500_PER2_BASE + 0x1000)
-#define U8500_SPI1_BASE		(U8500_PER2_BASE + 0x2000)
-#define U8500_PWL_BASE		(U8500_PER2_BASE + 0x3000)
-#define U8500_SDI4_BASE		(U8500_PER2_BASE + 0x4000)
-#define U8500_MSP2_BASE		(U8500_PER2_BASE + 0x7000)
-#define U8500_SDI1_BASE		(U8500_PER2_BASE + 0x8000)
-#define U8500_SDI3_BASE		(U8500_PER2_BASE + 0x9000)
-#define U8500_SPI0_BASE		(U8500_PER2_BASE + 0xa000)
-#define U8500_HSIR_BASE		(U8500_PER2_BASE + 0xb000)
-#define U8500_HSIT_BASE		(U8500_PER2_BASE + 0xc000)
-#define U8500_CLKRST2_BASE	(U8500_PER2_BASE + 0xf000)
-
-/* per1 base addresses */
-#define U8500_I2C1_BASE		(U8500_PER1_BASE + 0x2000)
-#define U8500_MSP0_BASE		(U8500_PER1_BASE + 0x3000)
-#define U8500_MSP1_BASE		(U8500_PER1_BASE + 0x4000)
-#define U8500_MSP3_BASE		(U8500_PER1_BASE + 0x5000)
-#define U8500_SDI0_BASE		(U8500_PER1_BASE + 0x6000)
-#define U8500_I2C2_BASE		(U8500_PER1_BASE + 0x8000)
-#define U8500_SPI3_BASE		(U8500_PER1_BASE + 0x9000)
-#define U8500_I2C4_BASE		(U8500_PER1_BASE + 0xa000)
-#define U8500_SLIM0_BASE	(U8500_PER1_BASE + 0xb000)
-#define U8500_CLKRST1_BASE	(U8500_PER1_BASE + 0xf000)
-
-#define U8500_SHRM_GOP_INTERRUPT_BASE	0xB7C00040
-
-#define U8500_GPIOBANK0_BASE	U8500_GPIO0_BASE
-#define U8500_GPIOBANK1_BASE	(U8500_GPIO0_BASE + 0x80)
-#define U8500_GPIOBANK2_BASE	U8500_GPIO1_BASE
-#define U8500_GPIOBANK3_BASE	(U8500_GPIO1_BASE + 0x80)
-#define U8500_GPIOBANK4_BASE	(U8500_GPIO1_BASE + 0x100)
-#define U8500_GPIOBANK5_BASE	(U8500_GPIO1_BASE + 0x180)
-#define U8500_GPIOBANK6_BASE	U8500_GPIO2_BASE
-#define U8500_GPIOBANK7_BASE	(U8500_GPIO2_BASE + 0x80)
-#define U8500_GPIOBANK8_BASE	U8500_GPIO3_BASE
-
-#define U8500_MCDE_SIZE		0x1000
-#define U8500_DSI_LINK_SIZE	0x1000
-#define U8500_DSI_LINK1_BASE	(U8500_MCDE_BASE + U8500_MCDE_SIZE)
-#define U8500_DSI_LINK2_BASE	(U8500_DSI_LINK1_BASE + U8500_DSI_LINK_SIZE)
-#define U8500_DSI_LINK3_BASE	(U8500_DSI_LINK2_BASE + U8500_DSI_LINK_SIZE)
-#define U8500_DSI_LINK_COUNT	0x3
-
-/* Modem and APE physical addresses */
-#define U8500_MODEM_BASE	0xe000000
-#define U8500_APE_BASE		0x6000000
-
-/* SoC identification number information */
-#define U8500_BB_UID_BASE      (U8500_BACKUPRAM1_BASE + 0xFC0)
-
-#endif
diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
deleted file mode 100644
index 4eece2a..0000000
--- a/arch/arm/mach-ux500/include/mach/hardware.h
+++ /dev/null
@@ -1,45 +0,0 @@
-/*
- * Copyright (C) 2009 ST-Ericsson.
- *
- * U8500 hardware definitions
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#ifndef __MACH_HARDWARE_H
-#define __MACH_HARDWARE_H
-
-/*
- * Macros to get at IO space when running virtually
- * We dont map all the peripherals, let ioremap do
- * this for us. We map only very basic peripherals here.
- */
-#define U8500_IO_VIRTUAL	0xf0000000
-#define U8500_IO_PHYSICAL	0xa0000000
-/* This is where we map in the ROM to check ASIC IDs */
-#define UX500_VIRT_ROM		0xf0000000
-
-/* This macro is used in assembly, so no cast */
-#define IO_ADDRESS(x)           \
-	(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + U8500_IO_VIRTUAL)
-
-/* typesafe io address */
-#define __io_address(n)		IOMEM(IO_ADDRESS(n))
-
-/* Used by some plat-nomadik code */
-#define io_p2v(n)		__io_address(n)
-
-#include <mach/db8500-regs.h>
-
-#define MSP_TX_RX_REG_OFFSET	0
-#define CRYP1_RX_REG_OFFSET	0x10
-#define CRYP1_TX_REG_OFFSET	0x8
-#define HASH1_TX_REG_OFFSET	0x4
-
-#ifndef __ASSEMBLY__
-
-#define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
-
-#endif				/* __ASSEMBLY__ */
-#endif				/* __MACH_HARDWARE_H */
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
index fc77b42..829947d 100644
--- a/arch/arm/mach-ux500/include/mach/irqs.h
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -10,8 +10,6 @@
 #ifndef ASM_ARCH_IRQS_H
 #define ASM_ARCH_IRQS_H
 
-#include <mach/hardware.h>
-
 #define IRQ_LOCALTIMER			29
 #define IRQ_LOCALWDOG			30
 
diff --git a/arch/arm/mach-ux500/include/mach/uncompress.h b/arch/arm/mach-ux500/include/mach/uncompress.h
index 36969d5..533a004 100644
--- a/arch/arm/mach-ux500/include/mach/uncompress.h
+++ b/arch/arm/mach-ux500/include/mach/uncompress.h
@@ -22,7 +22,8 @@
 #include <asm/mach-types.h>
 #include <linux/io.h>
 #include <linux/amba/serial.h>
-#include <mach/hardware.h>
+/* TODO: This goes away in multiplatform boot, this file gets deleted */
+#include "../../db8500-regs.h"
 
 void __iomem *ux500_uart_base;
 
diff --git a/arch/arm/mach-ux500/platsmp.c b/arch/arm/mach-ux500/platsmp.c
index 18f7af3..8a9c070 100644
--- a/arch/arm/mach-ux500/platsmp.c
+++ b/arch/arm/mach-ux500/platsmp.c
@@ -22,9 +22,9 @@
 #include <asm/smp_plat.h>
 #include <asm/smp_scu.h>
 
-#include <mach/hardware.h>
 #include <mach/setup.h>
 
+#include "db8500-regs.h"
 #include "id.h"
 
 /* This is called from headsmp.S to wakeup the secondary core */
diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index a6af0b8..5b91fac 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -14,9 +14,9 @@
 #include <asm/smp_twd.h>
 
 #include <mach/setup.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 
+#include "db8500-regs.h"
 #include "id.h"
 
 #ifdef CONFIG_HAVE_ARM_TWD
diff --git a/arch/arm/mach-ux500/usb.c b/arch/arm/mach-ux500/usb.c
index 78ac65f..2dfc72f 100644
--- a/arch/arm/mach-ux500/usb.c
+++ b/arch/arm/mach-ux500/usb.c
@@ -10,7 +10,7 @@
 #include <linux/platform_data/usb-musb-ux500.h>
 #include <linux/platform_data/dma-ste-dma40.h>
 
-#include <mach/hardware.h>
+#include "db8500-regs.h"
 
 #define MUSB_DMA40_RX_CH { \
 		.mode = STEDMA40_MODE_LOGICAL, \
diff --git a/drivers/clk/ux500/clk-prcc.c b/drivers/clk/ux500/clk-prcc.c
index 7eee7f7..bd4769a 100644
--- a/drivers/clk/ux500/clk-prcc.c
+++ b/drivers/clk/ux500/clk-prcc.c
@@ -13,7 +13,6 @@
 #include <linux/io.h>
 #include <linux/err.h>
 #include <linux/types.h>
-#include <mach/hardware.h>
 
 #include "clk.h"
 
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index c26c369..4f34093 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -18,7 +18,6 @@
 #include <asm/sched_clock.h>
 
 #include <mach/setup.h>
-#include <mach/hardware.h>
 
 #define RATE_32K		32768
 
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 2d3a5f6..03e2aed 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -33,9 +33,7 @@
 #include <linux/regulator/machine.h>
 #include <linux/cpufreq.h>
 #include <linux/platform_data/ux500_wdt.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
-#include <mach/db8500-regs.h>
 #include "dbx500-prcmu-regs.h"
 
 /* Index of different voltages to be used when accessing AVSData */
diff --git a/drivers/mfd/dbx500-prcmu-regs.h b/drivers/mfd/dbx500-prcmu-regs.h
index 439254d..d14836e 100644
--- a/drivers/mfd/dbx500-prcmu-regs.h
+++ b/drivers/mfd/dbx500-prcmu-regs.h
@@ -74,33 +74,11 @@
 #define PRCM_A9PL_FORCE_CLKEN_PRCM_A9PL_FORCE_CLKEN BIT(0)
 #define PRCM_A9PL_FORCE_CLKEN_PRCM_A9AXI_FORCE_CLKEN BIT(1)
 
-/* ARM WFI Standby signal register */
-#define PRCM_ARM_WFI_STANDBY    (prcmu_base + 0x130)
-#define PRCM_ARM_WFI_STANDBY_WFI0               0x08
-#define PRCM_ARM_WFI_STANDBY_WFI1               0x10
-#define PRCM_IOCR		(prcmu_base + 0x310)
-#define PRCM_IOCR_IOFORCE			0x1
-
 /* CPU mailbox registers */
 #define PRCM_MBOX_CPU_VAL	(prcmu_base + 0x0fc)
 #define PRCM_MBOX_CPU_SET	(prcmu_base + 0x100)
 #define PRCM_MBOX_CPU_CLR	(prcmu_base + 0x104)
 
-/* Dual A9 core interrupt management unit registers */
-#define PRCM_A9_MASK_REQ	(prcmu_base + 0x328)
-#define PRCM_A9_MASK_REQ_PRCM_A9_MASK_REQ	0x1
-
-#define PRCM_A9_MASK_ACK	(prcmu_base + 0x32c)
-#define PRCM_ARMITMSK31TO0	(prcmu_base + 0x11c)
-#define PRCM_ARMITMSK63TO32	(prcmu_base + 0x120)
-#define PRCM_ARMITMSK95TO64	(prcmu_base + 0x124)
-#define PRCM_ARMITMSK127TO96	(prcmu_base + 0x128)
-#define PRCM_POWER_STATE_VAL	(prcmu_base + 0x25C)
-#define PRCM_ARMITVAL31TO0	(prcmu_base + 0x260)
-#define PRCM_ARMITVAL63TO32	(prcmu_base + 0x264)
-#define PRCM_ARMITVAL95TO64	(prcmu_base + 0x268)
-#define PRCM_ARMITVAL127TO96	(prcmu_base + 0x26C)
-
 #define PRCM_HOSTACCESS_REQ	(prcmu_base + 0x334)
 #define PRCM_HOSTACCESS_REQ_HOSTACCESS_REQ 0x1
 #define PRCM_HOSTACCESS_REQ_WAKE_REQ	BIT(16)
-- 
1.7.11.3
