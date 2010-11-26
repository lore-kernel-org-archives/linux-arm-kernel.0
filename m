From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 26 Nov 2010 14:49:00 +0800
Subject: [PATCH 01/15] ARM: mxs: Add core definitions
In-Reply-To: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1290754154-9428-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add core definitions for MXS-based SoC MX23 and MX28.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/include/mach/hardware.h |   66 +++++++++
 arch/arm/mach-mxs/include/mach/irqs.h     |   32 ++++
 arch/arm/mach-mxs/include/mach/memory.h   |   24 +++
 arch/arm/mach-mxs/include/mach/mx23.h     |  147 +++++++++++++++++++
 arch/arm/mach-mxs/include/mach/mx28.h     |  227 +++++++++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/mxs.h      |   60 ++++++++
 6 files changed, 556 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/include/mach/hardware.h
 create mode 100644 arch/arm/mach-mxs/include/mach/irqs.h
 create mode 100644 arch/arm/mach-mxs/include/mach/memory.h
 create mode 100644 arch/arm/mach-mxs/include/mach/mx23.h
 create mode 100644 arch/arm/mach-mxs/include/mach/mx28.h
 create mode 100644 arch/arm/mach-mxs/include/mach/mxs.h

diff --git a/arch/arm/mach-mxs/include/mach/hardware.h b/arch/arm/mach-mxs/include/mach/hardware.h
new file mode 100644
index 0000000..5edccd5
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/hardware.h
@@ -0,0 +1,66 @@
+/*
+ * Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ * Copyright 2008 Juergen Beisert, kernel at pengutronix.de
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
+ * MA  02110-1301, USA.
+ */
+
+#ifndef __MACH_MXS_HARDWARE_H__
+#define __MACH_MXS_HARDWARE_H__
+
+#include <asm/sizes.h>
+
+#ifdef __ASSEMBLER__
+#define IOMEM(addr)	(addr)
+#else
+#define IOMEM(addr)	((void __force __iomem *)(addr))
+#endif
+
+#define MXS_IO_P2V_MODULE(addr, module)					\
+	(((addr) - module ## _BASE_ADDR) < module ## _SIZE ?		\
+	 (addr) - (module ## _BASE_ADDR) + (module ## _BASE_ADDR_VIRT) : 0)
+
+/*
+ * It maps the whole address space to [0xf4000000, 0xf5ffffff].
+ *
+ *	OCRAM	0x00000000+0x020000	->	0xf4000000+0x020000
+ *	IO	0x80000000+0x100000	->	0xf4400000+0x100000
+ */
+#define MXS_IO_P2V(x)	(						\
+			0xf4000000 + 					\
+			(((x) & 0x50000000) >> 6) +			\
+			(((x) & 0x0b000000) >> 4) +			\
+			(((x) & 0x000fffff)))
+
+#define MXS_IO_ADDRESS(x)	IOMEM(MXS_IO_P2V(x))
+
+#ifdef CONFIG_SOC_IMX23
+# include <mach/mx23.h>
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+# include <mach/mx28.h>
+#endif
+
+#include <mach/mxs.h>
+
+#define mxs_map_entry(soc, name, _type)	{				\
+	.virtual = soc ## _IO_P2V(soc ## _ ## name ## _BASE_ADDR),	\
+	.pfn = __phys_to_pfn(soc ## _ ## name ## _BASE_ADDR),		\
+	.length = soc ## _ ## name ## _SIZE,				\
+	.type = _type,							\
+}
+
+#endif /* __MACH_MXS_HARDWARE_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/irqs.h b/arch/arm/mach-mxs/include/mach/irqs.h
new file mode 100644
index 0000000..f771039
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/irqs.h
@@ -0,0 +1,32 @@
+/*
+ *  Copyright 2004-2007 Freescale Semiconductor, Inc. All Rights Reserved.
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __MACH_MXS_IRQS_H__
+#define __MACH_MXS_IRQS_H__
+
+#define MXS_INTERNAL_IRQS	128
+
+#define MXS_GPIO_IRQ_START	MXS_INTERNAL_IRQS
+
+/* the maximum for MXS-based */
+#define MXS_GPIO_IRQS		(32 * 5)
+
+/*
+ * The next 16 interrupts are for board specific purposes.  Since
+ * the kernel can only run on one machine at a time, we can re-use
+ * these.  If you need more, increase MXS_BOARD_IRQS, but keep it
+ * within sensible limits.
+ */
+#define MXS_BOARD_IRQ_START	(MXS_GPIO_IRQ_START + MXS_GPIO_IRQS)
+#define MXS_BOARD_IRQS		16
+
+#define NR_IRQS			(MXS_BOARD_IRQ_START + MXS_BOARD_IRQS)
+
+#endif /* __MACH_MXS_IRQS_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/memory.h b/arch/arm/mach-mxs/include/mach/memory.h
new file mode 100644
index 0000000..b5420a5
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/memory.h
@@ -0,0 +1,24 @@
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
+#ifndef __MACH_MXS_MEMORY_H__
+#define __MACH_MXS_MEMORY_H__
+
+#define PHYS_OFFSET		UL(0x40000000)
+
+#endif /* __MACH_MXS_MEMORY_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/mx23.h b/arch/arm/mach-mxs/include/mach/mx23.h
new file mode 100644
index 0000000..27a11ee
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/mx23.h
@@ -0,0 +1,147 @@
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
+#ifndef __MACH_MX23_H__
+#define __MACH_MX23_H__
+
+#ifndef __ASSEMBLER__
+#include <linux/io.h>
+#endif
+
+/*
+ * OCRAM
+ */
+#define MX23_OCRAM_BASE_ADDR		0x00000000
+#define MX23_OCRAM_SIZE			SZ_32K
+
+/*
+ * IO
+ */
+#define MX23_IO_BASE_ADDR		0x80000000
+#define MX23_IO_SIZE			SZ_1M
+
+#define MX23_ICOLL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x000000)
+#define MX23_APBH_DMA_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x004000)
+#define MX23_BCH_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x00a000)
+#define MX23_GPMI_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x00c000)
+#define MX23_SSP1_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x010000)
+#define MX23_SSP2_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x034000)
+#define MX23_PINCTRL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x018000)
+#define MX23_DIGCTL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x01c000)
+#define MX23_ETM_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x020000)
+#define MX23_APBX_DMA_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x024000)
+#define MX23_DCP_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x028000)
+#define MX23_PXP_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x02a000)
+#define MX23_OCOTP_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x02c000)
+#define MX23_AXI_AHB0_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x02e000)
+#define MX23_LCDIF_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x030000)
+#define MX23_TVENC_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x038000)
+#define MX23_CLKCTRL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x040000)
+#define MX23_SAIF0_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x042000)
+#define MX23_POWER_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x044000)
+#define MX23_SAIF1_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x046000)
+#define MX23_AUDIOOUT_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x048000)
+#define MX23_AUDIOIN_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x04c000)
+#define MX23_LRADC_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x050000)
+#define MX23_SPDIF_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x054000)
+#define MX23_RTC_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x05c000)
+#define MX23_I2C0_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x058000)
+#define MX23_PWM_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x064000)
+#define MX23_TIMROT_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x068000)
+#define MX23_AUART1_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x06c000)
+#define MX23_AUART2_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x06e000)
+#define MX23_DUART_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x070000)
+#define MX23_USBPHY_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x07c000)
+#define MX23_USBCTRL_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x080000)
+#define MX23_DRAM_BASE_ADDR		(MX23_IO_BASE_ADDR + 0x0e0000)
+
+#define MX23_IO_P2V(x)			MXS_IO_P2V(x)
+#define MX23_IO_ADDRESS(x)		IOMEM(MX23_IO_P2V(x))
+
+/*
+ * IRQ
+ */
+#define MX23_INT_DUART			0
+#define MX23_INT_COMMS_RX		1
+#define MX23_INT_COMMS_TX		1
+#define MX23_INT_SSP2_ERROR		2
+#define MX23_INT_VDD5V			3
+#define MX23_INT_HEADPHONE_SHORT	4
+#define MX23_INT_DAC_DMA		5
+#define MX23_INT_DAC_ERROR		6
+#define MX23_INT_ADC_DMA		7
+#define MX23_INT_ADC_ERROR		8
+#define MX23_INT_SPDIF_DMA		9
+#define MX23_INT_SAIF2_DMA		9
+#define MX23_INT_SPDIF_ERROR		10
+#define MX23_INT_SAIF1_IRQ		10
+#define MX23_INT_SAIF2_IRQ		10
+#define MX23_INT_USB_CTRL		11
+#define MX23_INT_USB_WAKEUP		12
+#define MX23_INT_GPMI_DMA		13
+#define MX23_INT_SSP1_DMA		14
+#define MX23_INT_SSP_ERROR		15
+#define MX23_INT_GPIO0			16
+#define MX23_INT_GPIO1			17
+#define MX23_INT_GPIO2			18
+#define MX23_INT_SAIF1_DMA		19
+#define MX23_INT_SSP2_DMA		20
+#define MX23_INT_ECC8_IRQ		21
+#define MX23_INT_RTC_ALARM		22
+#define MX23_INT_UARTAPP_TX_DMA		23
+#define MX23_INT_UARTAPP_INTERNAL	24
+#define MX23_INT_UARTAPP_RX_DMA		25
+#define MX23_INT_I2C_DMA		26
+#define MX23_INT_I2C_ERROR		27
+#define MX23_INT_TIMER0			28
+#define MX23_INT_TIMER1			29
+#define MX23_INT_TIMER2			30
+#define MX23_INT_TIMER3			31
+#define MX23_INT_BATT_BRNOUT		32
+#define MX23_INT_VDDD_BRNOUT		33
+#define MX23_INT_VDDIO_BRNOUT		34
+#define MX23_INT_VDD18_BRNOUT		35
+#define MX23_INT_TOUCH_DETECT		36
+#define MX23_INT_LRADC_CH0		37
+#define MX23_INT_LRADC_CH1		38
+#define MX23_INT_LRADC_CH2		39
+#define MX23_INT_LRADC_CH3		40
+#define MX23_INT_LRADC_CH4		41
+#define MX23_INT_LRADC_CH5		42
+#define MX23_INT_LRADC_CH6		43
+#define MX23_INT_LRADC_CH7		44
+#define MX23_INT_LCDIF_DMA		45
+#define MX23_INT_LCDIF_ERROR		46
+#define MX23_INT_DIGCTL_DEBUG_TRAP	47
+#define MX23_INT_RTC_1MSEC		48
+#define MX23_INT_DRI_DMA		49
+#define MX23_INT_DRI_ATTENTION		50
+#define MX23_INT_GPMI_ATTENTION		51
+#define MX23_INT_IR			52
+#define MX23_INT_DCP_VMI		53
+#define MX23_INT_DCP			54
+#define MX23_INT_BCH			56
+#define MX23_INT_PXP			57
+#define MX23_INT_UARTAPP2_TX_DMA	58
+#define MX23_INT_UARTAPP2_INTERNAL	59
+#define MX23_INT_UARTAPP2_RX_DMA	60
+#define MX23_INT_VDAC_DETECT		61
+#define MX23_INT_VDD5V_DROOP		64
+#define MX23_INT_DCDC4P2_BO		65
+
+#endif /* __MACH_MX23_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/mx28.h b/arch/arm/mach-mxs/include/mach/mx28.h
new file mode 100644
index 0000000..836d807
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/mx28.h
@@ -0,0 +1,227 @@
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
+#define MX28_ENET_MAC0_BASE_ADDR	(MX28_IO_BASE_ADDR + 0x0f0000)
+#define MX28_ENET_MAC1_BASE_ADDR	(MX28_IO_BASE_ADDR + 0x0f4000)
+
+#define MX28_IO_P2V(x)			MXS_IO_P2V(x)
+#define MX28_IO_ADDRESS(x)		IOMEM(MX28_IO_P2V(x))
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
+
+#endif /* __MACH_MX28_H__ */
diff --git a/arch/arm/mach-mxs/include/mach/mxs.h b/arch/arm/mach-mxs/include/mach/mxs.h
new file mode 100644
index 0000000..128c114
--- /dev/null
+++ b/arch/arm/mach-mxs/include/mach/mxs.h
@@ -0,0 +1,60 @@
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
+#ifndef __MACH_MXS_H__
+#define __MACH_MXS_H__
+
+#define MXS_SET_ADDR		0x4
+#define MXS_CLR_ADDR		0x8
+#define MXS_TOG_ADDR		0xc
+
+/*
+ * MXS CPU types
+ */
+#define MXS_CPU_MX23		23
+#define MXS_CPU_MX28		28
+
+#ifndef __ASSEMBLY__
+extern unsigned int __mxs_cpu_type;
+#endif
+
+#ifdef CONFIG_SOC_IMX23
+# ifdef mxs_cpu_type
+#  undef mxs_cpu_type
+#  define mxs_cpu_type __mxs_cpu_type
+# else
+#  define mxs_cpu_type MXS_CPU_MX23
+# endif
+# define cpu_is_mx23()		(mxs_cpu_type == MXS_CPU_MX23)
+#else
+# define cpu_is_mx23()		(0)
+#endif
+
+#ifdef CONFIG_SOC_IMX28
+# ifdef mxs_cpu_type
+#  undef mxs_cpu_type
+#  define mxs_cpu_type __mxs_cpu_type
+# else
+#  define mxs_cpu_type MXS_CPU_MX28
+# endif
+# define cpu_is_mx28()		(mxs_cpu_type == MXS_CPU_MX28)
+#else
+# define cpu_is_mx28()		(0)
+#endif
+
+#endif /* __MACH_MXS_H__ */
-- 
1.7.1
