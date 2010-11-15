From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 15 Nov 2010 22:36:25 +0800
Subject: [PATCH 01/11] ARM: imx: Add basic definitions for i.MX28
In-Reply-To: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
References: <1289831795-4373-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1289831795-4373-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/plat-mxc/include/mach/hardware.h |    9 +-
 arch/arm/plat-mxc/include/mach/irqs.h     |   11 +-
 arch/arm/plat-mxc/include/mach/memory.h   |    5 +-
 arch/arm/plat-mxc/include/mach/mx28.h     |  232 +++++++++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/mxc.h      |   14 ++
 5 files changed, 264 insertions(+), 7 deletions(-)
 create mode 100644 arch/arm/plat-mxc/include/mach/mx28.h

diff --git a/arch/arm/plat-mxc/include/mach/hardware.h b/arch/arm/plat-mxc/include/mach/hardware.h
index 2f59b63..499b14c 100644
--- a/arch/arm/plat-mxc/include/mach/hardware.h
+++ b/arch/arm/plat-mxc/include/mach/hardware.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
  * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
  *
  * This program is free software; you can redistribute it and/or
@@ -63,6 +63,9 @@
  *	AIPI	0x10000000+0x100000	->	0xf4400000+0x100000
  *	SAHB1	0x80000000+0x100000	->	0xf4000000+0x100000
  *	X_MEMC	0xd8000000+0x100000	->	0xf5c00000+0x100000
+ * mx28:
+ *	OCRAM	0x00000000+0x020000	->	0xf4000000+0x020000
+ *	IO	0x80000000+0x100000	->	0xf4400000+0x100000
  * mx31:
  *	AIPS1	0x43f00000+0x100000	->	0xf5300000+0x100000
  *	AIPS2	0x53f00000+0x100000	->	0xf5700000+0x100000
@@ -127,6 +130,10 @@
 # include <mach/mx25.h>
 #endif
 
+#ifdef CONFIG_ARCH_MX28
+# include <mach/mx28.h>
+#endif
+
 #ifdef CONFIG_ARCH_MXC91231
 # include <mach/mxc91231.h>
 #endif
diff --git a/arch/arm/plat-mxc/include/mach/irqs.h b/arch/arm/plat-mxc/include/mach/irqs.h
index 86781f7..2f810c5 100644
--- a/arch/arm/plat-mxc/include/mach/irqs.h
+++ b/arch/arm/plat-mxc/include/mach/irqs.h
@@ -1,5 +1,5 @@
 /*
- *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ *  Copyright 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
 /*
@@ -12,12 +12,13 @@
 #define __ASM_ARCH_MXC_IRQS_H__
 
 /*
- * SoCs with TZIC interrupt controller have 128 IRQs, those with AVIC have 64
+ * SoCs with AVIC interrupt controller have 64 IRQs,
+ * those with TZIC and ICOLL have 128.
  */
-#ifdef CONFIG_MXC_TZIC
-#define MXC_INTERNAL_IRQS	128
-#else
+#ifdef CONFIG_MXC_AVIC
 #define MXC_INTERNAL_IRQS	64
+#else
+#define MXC_INTERNAL_IRQS	128
 #endif
 
 #define MXC_GPIO_IRQ_START	MXC_INTERNAL_IRQS
diff --git a/arch/arm/plat-mxc/include/mach/memory.h b/arch/arm/plat-mxc/include/mach/memory.h
index 564ec9d..af090e3 100644
--- a/arch/arm/plat-mxc/include/mach/memory.h
+++ b/arch/arm/plat-mxc/include/mach/memory.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2004-2010 Freescale Semiconductor, Inc. All Rights Reserved.
  */
 
 /*
@@ -15,6 +15,7 @@
 #define MX21_PHYS_OFFSET	UL(0xc0000000)
 #define MX25_PHYS_OFFSET	UL(0x80000000)
 #define MX27_PHYS_OFFSET	UL(0xa0000000)
+#define MX28_PHYS_OFFSET	UL(0x40000000)
 #define MX3x_PHYS_OFFSET	UL(0x80000000)
 #define MX51_PHYS_OFFSET	UL(0x90000000)
 #define MXC91231_PHYS_OFFSET	UL(0x90000000)
@@ -28,6 +29,8 @@
 #  define PHYS_OFFSET		MX25_PHYS_OFFSET
 # elif defined CONFIG_MACH_MX27
 #  define PHYS_OFFSET		MX27_PHYS_OFFSET
+# elif defined CONFIG_ARCH_MX28
+#  define PHYS_OFFSET		MX28_PHYS_OFFSET
 # elif defined CONFIG_ARCH_MX3
 #  define PHYS_OFFSET		MX3x_PHYS_OFFSET
 # elif defined CONFIG_ARCH_MXC91231
diff --git a/arch/arm/plat-mxc/include/mach/mx28.h b/arch/arm/plat-mxc/include/mach/mx28.h
new file mode 100644
index 0000000..6f73888
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/mx28.h
@@ -0,0 +1,232 @@
+/*
+ * Copyright (C) 2009-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef __MACH_MX28_H__
+#define __MACH_MX28_H__
+
+#ifndef __ASSEMBLER__
+#include <linux/io.h>
+#endif
+
+#define SET_ADDR			0x4
+#define CLR_ADDR			0x8
+#define TOG_ADDR			0xc
+
+/*
+ * OCRAM
+ */
+#define MX28_OCRAM_BASE_ADDR		0x00000000
+#define MX28_OCRAM_SIZE			SZ_128K
+
+/*
+ * IO
+ */
+#define MX28_IO_BASE_ADDR		0x80000000
+#define MX28_IO_SIZE			SZ_1M
+
+#define MX28_ICOLL_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x000000)
+#define MX28_HSADC_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x002000)
+#define MX28_APBH_DMA_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x004000)
+#define MX28_PERFMON_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x006000)
+#define MX28_BCH_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x00a000)
+#define MX28_GPMI_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x00c000)
+#define MX28_SSP0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x010000)
+#define MX28_SSP1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x012000)
+#define MX28_SSP2_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x014000)
+#define MX28_SSP3_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x016000)
+#define MX28_PINCTRL_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x018000)
+#define MX28_DIGCTL_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x01c000)
+#define MX28_ETM_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x022000)
+#define MX28_APBX_DMA_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x024000)
+#define MX28_DCP_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x028000)
+#define MX28_PXP_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x02a000)
+#define MX28_OCOTP_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x02c000)
+#define MX28_AXI_AHB0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x02e000)
+#define MX28_LCDIF_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x030000)
+#define MX28_CAN0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x032000)
+#define MX28_CAN1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x034000)
+#define MX28_SIMDBG_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x03c000)
+#define MX28_SIMGPMISEL_BASE_ADDR	(MX28_IO_BASE_ADDR + 0x03c200)
+#define MX28_SIMSSPSEL_BASE_ADDR	(MX28_IO_BASE_ADDR + 0x03c300)
+#define MX28_SIMMEMSEL_BASE_ADDR	(MX28_IO_BASE_ADDR + 0x03c400)
+#define MX28_GPIOMON_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x03c500)
+#define MX28_SIMENET_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x03c700)
+#define MX28_ARMJTAG_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x03c800)
+#define MX28_CLKCTRL_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x040000)
+#define MX28_SAIF0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x042000)
+#define MX28_POWER_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x044000)
+#define MX28_SAIF1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x046000)
+#define MX28_LRADC_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x050000)
+#define MX28_SPDIF_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x054000)
+#define MX28_RTC_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x056000)
+#define MX28_I2C0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x058000)
+#define MX28_I2C1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x05a000)
+#define MX28_PWM_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x064000)
+#define MX28_TIMROT_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x068000)
+#define MX28_AUART0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x06a000)
+#define MX28_AUART1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x06c000)
+#define MX28_AUART2_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x06e000)
+#define MX28_AUART3_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x070000)
+#define MX28_AUART4_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x072000)
+#define MX28_DUART_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x074000)
+#define MX28_USBPHY0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x07C000)
+#define MX28_USBPHY1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x07e000)
+#define MX28_USBCTRL0_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x080000)
+#define MX28_USBCTRL1_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x090000)
+#define MX28_DFLPT_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x0c0000)
+#define MX28_DRAM_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x0e0000)
+#define MX28_ENET_BASE_ADDR		(MX28_IO_BASE_ADDR + 0x0f0000)
+#define MX28_FEC_BASE_ADDR		MX28_ENET_BASE_ADDR
+
+#define MX28_IO_P2V(x)			IMX_IO_P2V(x)
+#define MX28_IO_ADDRESS(x)		IOMEM(MX27_IO_P2V(x))
+
+/*
+ * IRQ
+ */
+#define MX28_INT_BATT_BRNOUT		0
+#define MX28_INT_VDDD_BRNOUT		1
+#define MX28_INT_VDDIO_BRNOUT		2
+#define MX28_INT_VDDA_BRNOUT		3
+#define MX28_INT_VDD5V_DROOP		4
+#define MX28_INT_DCDC4P2_BRNOUT		5
+#define MX28_INT_VDD5V			6
+#define MX28_INT_RESV7			7
+#define MX28_INT_CAN0			8
+#define MX28_INT_CAN1			9
+#define MX28_INT_LRADC_TOUCH		10
+#define MX28_INT_RESV11			11
+#define MX28_INT_RESV12			12
+#define MX28_INT_HSADC			13
+#define MX28_INT_IRADC_THRESH0		14
+#define MX28_INT_IRADC_THRESH1		15
+#define MX28_INT_LRADC_CH0		16
+#define MX28_INT_LRADC_CH1		17
+#define MX28_INT_LRADC_CH2		18
+#define MX28_INT_LRADC_CH3		19
+#define MX28_INT_LRADC_CH4		20
+#define MX28_INT_LRADC_CH5		21
+#define MX28_INT_LRADC_CH6		22
+#define MX28_INT_LRADC_CH7		23
+#define MX28_INT_LRADC_BUTTON0		24
+#define MX28_INT_LRADC_BUTTON1		25
+#define MX28_INT_RESV26			26
+#define MX28_INT_PERFMON		27
+#define MX28_INT_RTC_1MSEC		28
+#define MX28_INT_RTC_ALARM		29
+#define MX28_INT_RESV30			30
+#define MX28_INT_COMMS			31
+#define MX28_INT_EMI_ERR		32
+#define MX28_INT_RESV33			33
+#define MX28_INT_RESV34			34
+#define MX28_INT_RESV35			35
+#define MX28_INT_RESV36			36
+#define MX28_INT_RESV37			37
+#define MX28_INT_LCDIF			38
+#define MX28_INT_PXP			39
+#define MX28_INT_RESV40			40
+#define MX28_INT_BCH			41
+#define MX28_INT_GPMI			42
+#define MX28_INT_RESV43			43
+#define MX28_INT_RESV44			44
+#define MX28_INT_SPDIF_ERROR		45
+#define MX28_INT_RESV46			46
+#define MX28_INT_DUART			47
+#define MX28_INT_TIMER0			48
+#define MX28_INT_TIMER1			49
+#define MX28_INT_TIMER2			50
+#define MX28_INT_TIMER3			51
+#define MX28_INT_DCP_VMI		52
+#define MX28_INT_DCP			53
+#define MX28_INT_DCP_SECURE		54
+#define MX28_INT_RESV55			55
+#define MX28_INT_RESV56			56
+#define MX28_INT_RESV57			57
+#define MX28_INT_SAIF1			58
+#define MX28_INT_SAIF0			59
+#define MX28_INT_RESV60			60
+#define MX28_INT_RESV61			61
+#define MX28_INT_RESV62			62
+#define MX28_INT_RESV63			63
+#define MX28_INT_RESV64			64
+#define MX28_INT_RESV65			65
+#define MX28_INT_SPDIF_DMA		66
+#define MX28_INT_RESV67			67
+#define MX28_INT_I2C0_DMA		68
+#define MX28_INT_I2C1_DMA		69
+#define MX28_INT_AUART0_RX_DMA		70
+#define MX28_INT_AUART0_TX_DMA		71
+#define MX28_INT_AUART1_RX_DMA		72
+#define MX28_INT_AUART1_TX_DMA		73
+#define MX28_INT_AUART2_RX_DMA		74
+#define MX28_INT_AUART2_TX_DMA		75
+#define MX28_INT_AUART3_RX_DMA		76
+#define MX28_INT_AUART3_TX_DMA		77
+#define MX28_INT_AUART4_RX_DMA		78
+#define MX28_INT_AUART4_TX_DMA		79
+#define MX28_INT_SAIF0_DMA		80
+#define MX28_INT_SAIF1_DMA		81
+#define MX28_INT_SSP0_DMA		82
+#define MX28_INT_SSP1_DMA		83
+#define MX28_INT_SSP2_DMA		84
+#define MX28_INT_SSP3_DMA		85
+#define MX28_INT_LCDIF_DMA		86
+#define MX28_INT_HSADC_DMA		87
+#define MX28_INT_GPMI_DMA		88
+#define MX28_INT_DIGCTL_DEBUG_TRAP	89
+#define MX28_INT_RESV90			90
+#define MX28_INT_RESV91			91
+#define MX28_INT_USB1			92
+#define MX28_INT_USB0			93
+#define MX28_INT_USB1_WAKEUP		94
+#define MX28_INT_USB0_WAKEUP		95
+#define MX28_INT_SSP0			96
+#define MX28_INT_SSP1			97
+#define MX28_INT_SSP2			98
+#define MX28_INT_SSP3			99
+#define MX28_INT_ENET_SWI		100
+#define MX28_INT_ENET_MAC0		101
+#define MX28_INT_ENET_MAC1		102
+#define MX28_INT_ENET_MAC0_1588		103
+#define MX28_INT_ENET_MAC1_1588		104
+#define MX28_INT_RESV105		105
+#define MX28_INT_RESV106		106
+#define MX28_INT_RESV107		107
+#define MX28_INT_RESV108		108
+#define MX28_INT_RESV109		109
+#define MX28_INT_I2C1_ERROR		110
+#define MX28_INT_I2C0_ERROR		111
+#define MX28_INT_AUART0			112
+#define MX28_INT_AUART1			113
+#define MX28_INT_AUART2			114
+#define MX28_INT_AUART3			115
+#define MX28_INT_AUART4			116
+#define MX28_INT_RESV117		117
+#define MX28_INT_RESV118		118
+#define MX28_INT_RESV119		119
+#define MX28_INT_RESV120		120
+#define MX28_INT_RESV121		121
+#define MX28_INT_RESV122		122
+#define MX28_INT_GPIO4			123
+#define MX28_INT_GPIO3			124
+#define MX28_INT_GPIO2			125
+#define MX28_INT_GPIO1			126
+#define MX28_INT_GPIO0			127
+#define MX28_INT_FEC			MX28_INT_ENET_MAC0
+
+#endif /* __MACH_MX28_H__ */
diff --git a/arch/arm/plat-mxc/include/mach/mxc.h b/arch/arm/plat-mxc/include/mach/mxc.h
index 3432b78..563901f 100644
--- a/arch/arm/plat-mxc/include/mach/mxc.h
+++ b/arch/arm/plat-mxc/include/mach/mxc.h
@@ -30,6 +30,7 @@
 #define MXC_CPU_MX21		21
 #define MXC_CPU_MX25		25
 #define MXC_CPU_MX27		27
+#define MXC_CPU_MX28		28
 #define MXC_CPU_MX31		31
 #define MXC_CPU_MX35		35
 #define MXC_CPU_MX51		51
@@ -87,6 +88,18 @@ extern unsigned int __mxc_cpu_type;
 # define cpu_is_mx27()		(0)
 #endif
 
+#ifdef CONFIG_ARCH_MX28
+# ifdef mxc_cpu_type
+#  undef mxc_cpu_type
+#  define mxc_cpu_type __mxc_cpu_type
+# else
+#  define mxc_cpu_type MXC_CPU_MX28
+# endif
+# define cpu_is_mx28()		(mxc_cpu_type == MXC_CPU_MX28)
+#else
+# define cpu_is_mx28()		(0)
+#endif
+
 #ifdef CONFIG_ARCH_MX31
 # ifdef mxc_cpu_type
 #  undef mxc_cpu_type
@@ -161,5 +174,6 @@ extern void __iomem *mxc_irq_base;
 
 #define MXC_IRQ_TYPE_AVIC	1
 #define MXC_IRQ_TYPE_TZIC	2
+#define MXC_IRQ_TYPE_ICOLL	3
 
 #endif /*  __ASM_ARCH_MXC_H__ */
-- 
1.7.1
