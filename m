From: srinidhi.kasagar@stericsson.com (srinidhi kasagar)
Date: Fri, 27 Nov 2009 05:25:38 +0530
Subject: [PATCH v4 1/6] ARM: U8500 register definitions
Message-ID: <1259279738.13327.66.camel@vinay-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Date: Fri, 27 Nov 2009 15:28:17 +0530

Adds register definitions, shared peripheral interrupt
numbers (SHPI) and IO mappings for the U8500 core support.
SHPI are assigned to [160:32] where first 32 interrupts
are reserved.

Signed-off-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>
Acked-by: Andrea Gallo <andrea.gallo@stericsson.com>
Reviewed-by: Alessandro Rubin <rubini@unipv.it>
---
 arch/arm/mach-ux500/include/mach/hardware.h |  131 +++++++++++++++++++++++++++
 arch/arm/mach-ux500/include/mach/io.h       |   22 +++++
 arch/arm/mach-ux500/include/mach/irqs.h     |   71 +++++++++++++++
 3 files changed, 224 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-ux500/include/mach/hardware.h
 create mode 100644 arch/arm/mach-ux500/include/mach/io.h
 create mode 100644 arch/arm/mach-ux500/include/mach/irqs.h

diff --git a/arch/arm/mach-ux500/include/mach/hardware.h b/arch/arm/mach-ux500/include/mach/hardware.h
new file mode 100644
index 0000000..6da6502
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/hardware.h
@@ -0,0 +1,131 @@
+/*
+ * Copyright (C) 2009 ST-Ericsson.
+ *
+ * U8500 hardware definitions
+ *
+ * This file is licensed under  the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+#ifndef __MACH_HARDWARE_H
+#define __MACH_HARDWARE_H
+
+/* macros to get at IO space when running virtually
+ * We dont map all the peripherals, let ioremap do
+ * this for us. We map only very basic peripherals here.
+ */
+#define U8500_IO_VIRTUAL	0xf0000000
+#define U8500_IO_PHYSICAL	0xa0000000
+
+/* this macro is used in assembly, so no cast */
+#define IO_ADDRESS(x)           \
+	(((x) & 0x0fffffff) + (((x) >> 4) & 0x0f000000) + U8500_IO_VIRTUAL)
+
+/* typesafe io address */
+#define __io_address(n)		__io(IO_ADDRESS(n))
+
+/*
+ * Base address definitions for U8500 Onchip IPs. All the
+ * peripherals are contained in a single 1 Mbyte region, with
+ * AHB peripherals at the bottom and APB peripherals at the
+ * top of the region. PER stands for PERIPHERAL region which
+ * itself divided into sub regions.
+ */
+#define U8500_PER3_BASE		0x80000000
+#define U8500_PER2_BASE		0x80110000
+#define U8500_PER1_BASE		0x80120000
+#define U8500_PER4_BASE		0x80150000
+
+#define U8500_PER6_BASE		0xa03c0000
+#define U8500_PER5_BASE		0xa03e0000
+#define U8500_PER7_BASE		0xa03d0000
+
+#define U8500_SVA_BASE		0xa0100000
+#define U8500_SIA_BASE		0xa0200000
+
+#define U8500_SGA_BASE		0xa0300000
+#define U8500_MCDE_BASE		0xa0350000
+#define U8500_DMA_BASE		0xa0362000
+
+#define U8500_SCU_BASE		0xa0410000
+#define U8500_GIC_CPU_BASE	0xa0410100
+#define U8500_TWD_BASE		0xa0410600
+#define U8500_GIC_DIST_BASE	0xa0411000
+#define U8500_L2CC_BASE		0xa0412000
+
+#define U8500_TWD_SIZE		0x100
+
+/* per7 base addressess */
+#define U8500_CR_BASE		(U8500_PER7_BASE + 0x8000)
+#define U8500_MTU0_BASE		(U8500_PER7_BASE + 0xa000)
+#define U8500_MTU1_BASE		(U8500_PER7_BASE + 0xb000)
+#define U8500_TZPC0_BASE	(U8500_PER7_BASE + 0xc000)
+#define U8500_CLKRST7_BASE	(U8500_PER7_BASE + 0xf000)
+
+/* per6 base addressess */
+#define U8500_RNG_BASE		(U8500_PER6_BASE + 0x0000)
+#define U8500_PKA_BASE		(U8500_PER6_BASE + 0x1000)
+#define U8500_PKAM_BASE		(U8500_PER6_BASE + 0x2000)
+#define U8500_CRYPTO0_BASE	(U8500_PER6_BASE + 0xa000)
+#define U8500_CRYPTO1_BASE	(U8500_PER6_BASE + 0xb000)
+#define U8500_CLKRST6_BASE	(U8500_PER7_BASE + 0xf000)
+
+/* per5 base addressess */
+#define U8500_USBOTG_BASE	(U8500_PER5_BASE + 0x00000)
+#define U8500_GPIO5_BASE	(U8500_PER5_BASE + 0x1e000)
+#define U8500_CLKRST5_BASE	(U8500_PER7_BASE + 0x1f000)
+
+/* per4 base addressess */
+#define U8500_BACKUPRAM0_BASE	(U8500_PER4_BASE + 0x0000)
+#define U8500_BACKUPRAM1_BASE	(U8500_PER4_BASE + 0x1000)
+#define U8500_RTT0_BASE		(U8500_PER4_BASE + 0x2000)
+#define U8500_RTT1_BASE		(U8500_PER4_BASE + 0x3000)
+#define U8500_RTC_BASE		(U8500_PER4_BASE + 0x4000)
+#define U8500_SCR_BASE		(U8500_PER4_BASE + 0x5000)
+#define U8500_DMC_BASE		(U8500_PER4_BASE + 0x6000)
+#define U8500_PRCMU_BASE	(U8500_PER4_BASE + 0x7000)
+
+/* per3 base addressess */
+#define U8500_FSMC_BASE		(U8500_PER3_BASE + 0x0000)
+#define U8500_SSP0_BASE		(U8500_PER3_BASE + 0x2000)
+#define U8500_SSP1_BASE		(U8500_PER3_BASE + 0x3000)
+#define U8500_I2C0_BASE		(U8500_PER3_BASE + 0x4000)
+#define U8500_SDI2_BASE		(U8500_PER3_BASE + 0x5000)
+#define U8500_SKE_BASE		(U8500_PER3_BASE + 0x6000)
+#define U8500_UART2_BASE	(U8500_PER3_BASE + 0x7000)
+#define U8500_SDI5_BASE		(U8500_PER3_BASE + 0x8000)
+#define U8500_GPIO3_BASE	(U8500_PER3_BASE + 0xe000)
+#define U8500_CLKRST3_BASE	(U8500_PER7_BASE + 0xf000)
+
+/* per2 base addressess */
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
+#define U8500_GPIO2_BASE	(U8500_PER2_BASE + 0xe000)
+#define U8500_CLKRST2_BASE	(U8500_PER2_BASE + 0xf000)
+
+/* per1 base addresses */
+#define U8500_UART0_BASE	(U8500_PER1_BASE + 0x0000)
+#define U8500_UART1_BASE	(U8500_PER1_BASE + 0x1000)
+#define U8500_I2C1_BASE		(U8500_PER1_BASE + 0x2000)
+#define U8500_MSP0_BASE		(U8500_PER1_BASE + 0x3000)
+#define U8500_MSP1_BASE		(U8500_PER1_BASE + 0x4000)
+#define U8500_SDI0_BASE		(U8500_PER1_BASE + 0x6000)
+#define U8500_I2C2_BASE		(U8500_PER1_BASE + 0x8000)
+#define U8500_SPI3_BASE		(U8500_PER1_BASE + 0x9000)
+#define U8500_SLIM0_BASE	(U8500_PER1_BASE + 0xa000)
+#define U8500_GPIO1_BASE	(U8500_PER1_BASE + 0xe000)
+#define U8500_CLKRST1_BASE	(U8500_PER2_BASE + 0xf000)
+
+/* ST-Ericsson modified pl022 id */
+#define SSP_PER_ID		0x01080022
+
+#endif				/* __MACH_HARDWARE_H */
diff --git a/arch/arm/mach-ux500/include/mach/io.h b/arch/arm/mach-ux500/include/mach/io.h
new file mode 100644
index 0000000..1cf3f44
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/io.h
@@ -0,0 +1,22 @@
+/*
+ * arch/arm/mach-u8500/include/mach/io.h
+ *
+ * Copyright (C) 1997-1999 Russell King
+ *
+ * Modifications:
+ *  06-12-1997	RMK	Created.
+ *  07-04-1999	RMK	Major cleanup
+ */
+#ifndef __ASM_ARM_ARCH_IO_H
+#define __ASM_ARM_ARCH_IO_H
+
+#define IO_SPACE_LIMIT 0xffffffff
+
+/*
+ * We don't actually have real ISA nor PCI buses, but there is so many
+ * drivers out there that might just work if we fake them...
+ */
+#define __io(a)		__typesafe_io(a)
+#define __mem_pci(a)	(a)
+
+#endif
diff --git a/arch/arm/mach-ux500/include/mach/irqs.h b/arch/arm/mach-ux500/include/mach/irqs.h
new file mode 100644
index 0000000..394b5dd
--- /dev/null
+++ b/arch/arm/mach-ux500/include/mach/irqs.h
@@ -0,0 +1,71 @@
+/*
+ *  Copyright (C) 2008 STMicroelectronics
+ *  Copyright (C) 2009 ST-Ericsson.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef ASM_ARCH_IRQS_H
+#define ASM_ARCH_IRQS_H
+
+#include <mach/hardware.h>
+
+#define IRQ_LOCALTIMER                  29
+#define IRQ_LOCALWDOG                   30
+
+/* Shared Peripheral Interrupt (SHPI) */
+#define IRQ_SHPI_START			32
+
+/* Interrupt numbers generic for shared peripheral */
+#define IRQ_MTU0		(IRQ_SHPI_START + 4)
+#define IRQ_SPI2		(IRQ_SHPI_START + 6)
+#define IRQ_SPI0		(IRQ_SHPI_START + 8)
+#define IRQ_UART0		(IRQ_SHPI_START + 11)
+#define IRQ_I2C3		(IRQ_SHPI_START + 12)
+#define IRQ_SSP0		(IRQ_SHPI_START + 14)
+#define IRQ_MTU1		(IRQ_SHPI_START + 17)
+#define IRQ_RTC_RTT		(IRQ_SHPI_START + 18)
+#define IRQ_UART1		(IRQ_SHPI_START + 19)
+#define IRQ_I2C0		(IRQ_SHPI_START + 21)
+#define IRQ_I2C1		(IRQ_SHPI_START + 22)
+#define IRQ_USBOTG		(IRQ_SHPI_START + 23)
+#define IRQ_DMA			(IRQ_SHPI_START + 25)
+#define IRQ_UART2		(IRQ_SHPI_START + 26)
+#define IRQ_HSIR_EXCEP		(IRQ_SHPI_START + 29)
+#define IRQ_MSP0		(IRQ_SHPI_START + 31)
+#define IRQ_HSIR_CH0_OVRRUN	(IRQ_SHPI_START + 32)
+#define IRQ_HSIR_CH1_OVRRUN	(IRQ_SHPI_START + 33)
+#define IRQ_HSIR_CH2_OVRRUN	(IRQ_SHPI_START + 34)
+#define IRQ_HSIR_CH3_OVRRUN	(IRQ_SHPI_START + 35)
+#define IRQ_AB4500		(IRQ_SHPI_START + 40)
+#define IRQ_DISP		(IRQ_SHPI_START + 48)
+#define IRQ_SiPI3		(IRQ_SHPI_START + 49)
+#define IRQ_SSP1		(IRQ_SHPI_START + 52)
+#define IRQ_I2C2		(IRQ_SHPI_START + 55)
+#define IRQ_SDMMC0		(IRQ_SHPI_START + 60)
+#define IRQ_MSP1		(IRQ_SHPI_START + 62)
+#define IRQ_SPI1		(IRQ_SHPI_START + 96)
+#define IRQ_MSP2		(IRQ_SHPI_START + 98)
+#define IRQ_SDMMC4		(IRQ_SHPI_START + 99)
+#define IRQ_HSIRD0		(IRQ_SHPI_START + 104)
+#define IRQ_HSIRD1		(IRQ_SHPI_START + 105)
+#define IRQ_HSITD0		(IRQ_SHPI_START + 106)
+#define IRQ_HSITD1		(IRQ_SHPI_START + 107)
+#define IRQ_GPIO0		(IRQ_SHPI_START + 119)
+#define IRQ_GPIO1		(IRQ_SHPI_START + 120)
+#define IRQ_GPIO2		(IRQ_SHPI_START + 121)
+#define IRQ_GPIO3		(IRQ_SHPI_START + 122)
+#define IRQ_GPIO4		(IRQ_SHPI_START + 123)
+#define IRQ_GPIO5		(IRQ_SHPI_START + 124)
+#define IRQ_GPIO6		(IRQ_SHPI_START + 125)
+#define IRQ_GPIO7		(IRQ_SHPI_START + 126)
+#define IRQ_GPIO8		(IRQ_SHPI_START + 127)
+
+/* There are 128 shared peripheral interrupts assigned to
+ * INTID[160:32]. The first 32 interrupts are reserved.
+ */
+#define NR_IRQS			161
+
+#endif /*ASM_ARCH_IRQS_H*/
-- 
1.6.3.GIT
