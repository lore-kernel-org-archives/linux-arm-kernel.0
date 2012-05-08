From: eric@eukrea.com (=?UTF-8?q?Eric=20B=C3=A9nard?=)
Date: Tue,  8 May 2012 17:05:54 +0200
Subject: [RFC PATCH] ARM: imx: add PM support to i.MX25
Message-ID: <1336489554-29393-1-git-send-email-eric@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch adds PM support to i.MX25 CPU and is tested on an i.MX257.
A hook in avic.c is needed as the irq which can wake the CPU must be
masked in the MXC_CCM_LPIMRx registers.

Signed-off-by: Eric B?nard <eric@eukrea.com>
---
This is a RFC as there may be a better way to handle the hook in avic.c

arch/arm/mach-imx/Makefile                      |    2 +-
 arch/arm/mach-imx/pm-imx25.c                    |  150 ++++++++++++++
 arch/arm/plat-mxc/avic.c                        |   34 +++-
 arch/arm/plat-mxc/include/mach/crm-regs-imx25.h |  243 +++++++++++++++++++++++
 4 files changed, 427 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/mach-imx/pm-imx25.c
 create mode 100644 arch/arm/plat-mxc/include/mach/crm-regs-imx25.h

diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
index 4937c07..61c116b 100644
--- a/arch/arm/mach-imx/Makefile
+++ b/arch/arm/mach-imx/Makefile
@@ -1,7 +1,7 @@
 obj-$(CONFIG_SOC_IMX1) += clock-imx1.o mm-imx1.o
 obj-$(CONFIG_SOC_IMX21) += clock-imx21.o mm-imx21.o
 
-obj-$(CONFIG_SOC_IMX25) += clock-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o
+obj-$(CONFIG_SOC_IMX25) += clock-imx25.o mm-imx25.o ehci-imx25.o cpu-imx25.o pm-imx25.o
 
 obj-$(CONFIG_SOC_IMX27) += cpu-imx27.o pm-imx27.o
 obj-$(CONFIG_SOC_IMX27) += clock-imx27.o mm-imx27.o ehci-imx27.o
diff --git a/arch/arm/mach-imx/pm-imx25.c b/arch/arm/mach-imx/pm-imx25.c
new file mode 100644
index 0000000..ffe48bb
--- /dev/null
+++ b/arch/arm/mach-imx/pm-imx25.c
@@ -0,0 +1,150 @@
+/*
+ * i.MX25 Power Management Routines
+ *
+ * Based on Freescale's BSP which is :
+ * Copyright (C) 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License.
+ */
+
+#include <linux/suspend.h>
+#include <linux/clk.h>
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/irq.h>
+#include <mach/common.h>
+#include <mach/hardware.h>
+#include <mach/crm-regs-imx25.h>
+
+enum mx25_low_pwr_mode {
+	MX25_RUN_MODE,
+	MX25_WAIT_MODE,
+	MX25_DOZE_MODE,
+	MX25_STOP_MODE
+};
+
+static unsigned int cgcr0, cgcr1, cgcr2;
+
+void mxc_cpu_lp_set(enum mxc_cpu_pwr_mode mode)
+{
+	u32 lpm;
+	u32 reg;
+	u32 pmcr1, pmcr2;
+	u32 cgcr0, cgcr1, cgcr2;
+
+	/* read CCTL value */
+	reg = __raw_readl(MXC_CCM_CCTL);
+
+	switch (mode) {
+	case WAIT_UNCLOCKED_POWER_OFF:
+		lpm = MX25_DOZE_MODE;
+		break;
+
+	case STOP_POWER_ON:
+	case STOP_POWER_OFF:
+		lpm = MX25_STOP_MODE;
+		/* The clock of LCDC/SLCDC, SDMA, RTIC, RNGC, MAX, CAN
+		   and EMI needs to be gated on when entering Stop mode.
+		 */
+		cgcr0 = __raw_readl(MXC_CCM_CGCR0);
+		cgcr1 = __raw_readl(MXC_CCM_CGCR1);
+		cgcr2 = __raw_readl(MXC_CCM_CGCR2);
+		__raw_writel(cgcr0 | MXC_CCM_CGCR0_STOP_MODE_MASK,
+			     MXC_CCM_CGCR0);
+		__raw_writel(cgcr1 | MXC_CCM_CGCR1_STOP_MODE_MASK,
+			     MXC_CCM_CGCR1);
+		__raw_writel(cgcr2 | MXC_CCM_CGCR2_STOP_MODE_MASK,
+			     MXC_CCM_CGCR2);
+
+		if (mode == STOP_POWER_OFF) {
+			pmcr2 = __raw_readl(MXC_CCM_PMCR2);
+			pmcr2 |= (MXC_CCM_PMCR2_OSC24M_DOWN |
+				  MXC_CCM_PMCR2_VSTBY);
+			__raw_writel(pmcr2, MXC_CCM_PMCR2);
+			pmcr1 = __raw_readl(MXC_CCM_PMCR1);
+			pmcr1 &= ~(MXC_CCM_PMCR1_WBCN_MASK |
+				   MXC_CCM_PMCR1_CSPAEM_MASK |
+				   MXC_CCM_PMCR1_CSPA_MASK);
+			pmcr1 |= MXC_CCM_PMCR1_AWB_DEFAULT;
+			__raw_writel(pmcr1, MXC_CCM_PMCR1);
+		}
+		break;
+
+	case WAIT_CLOCKED:
+	case WAIT_UNCLOCKED:
+	default:
+		/* Wait is the default mode used when idle. */
+		lpm = MX25_WAIT_MODE;
+		break;
+	}
+
+	/* program LP CTL bit */
+	reg = ((reg & (~MXC_CCM_CCTL_LP_CTL_MASK)) |
+	       lpm << MXC_CCM_CCTL_LP_CTL_OFFSET);
+
+	__raw_writel(reg, MXC_CCM_CCTL);
+}
+
+static int mx25_suspend_enter(suspend_state_t state)
+{
+	unsigned int reg;
+
+	switch (state) {
+	case PM_SUSPEND_MEM:
+		mxc_cpu_lp_set(STOP_POWER_OFF);
+		break;
+	case PM_SUSPEND_STANDBY:
+		mxc_cpu_lp_set(WAIT_UNCLOCKED_POWER_OFF);
+		break;
+	default:
+		return -EINVAL;
+	}
+	/* Executing CP15 (Wait-for-Interrupt) Instruction */
+	cpu_do_idle();
+	/* Back to wait mode */
+	mxc_cpu_lp_set(WAIT_CLOCKED);
+
+	reg = (__raw_readl(MXC_CCM_CGCR0) & ~MXC_CCM_CGCR0_STOP_MODE_MASK) |
+		cgcr0;
+	__raw_writel(reg, MXC_CCM_CGCR0);
+	reg = (__raw_readl(MXC_CCM_CGCR1) & ~MXC_CCM_CGCR1_STOP_MODE_MASK) |
+		cgcr1;
+	__raw_writel(reg, MXC_CCM_CGCR1);
+	reg = (__raw_readl(MXC_CCM_CGCR2) & ~MXC_CCM_CGCR2_STOP_MODE_MASK) |
+		cgcr2;
+	__raw_writel(reg, MXC_CCM_CGCR2);
+
+	return 0;
+}
+
+static int mx25_suspend_prepare(void)
+{
+	cgcr0 = __raw_readl(MXC_CCM_CGCR0) & MXC_CCM_CGCR0_STOP_MODE_MASK;
+	cgcr1 = __raw_readl(MXC_CCM_CGCR1) & MXC_CCM_CGCR1_STOP_MODE_MASK;
+	cgcr2 = __raw_readl(MXC_CCM_CGCR2) & MXC_CCM_CGCR2_STOP_MODE_MASK;
+
+	return 0;
+}
+
+static int mx25_pm_valid(suspend_state_t state)
+{
+	return (state > PM_SUSPEND_ON && state <= PM_SUSPEND_MAX);
+}
+
+static const struct platform_suspend_ops mx25_suspend_ops = {
+	.enter = mx25_suspend_enter,
+	.prepare = mx25_suspend_prepare,
+	.valid = mx25_pm_valid,
+};
+
+static int __init mx25_pm_init(void)
+{
+	if (!cpu_is_mx25())
+		return 0;
+
+	suspend_set_ops(&mx25_suspend_ops);
+	return 0;
+}
+
+device_initcall(mx25_pm_init);
diff --git a/arch/arm/plat-mxc/avic.c b/arch/arm/plat-mxc/avic.c
index 689f81f..ab94d2e 100644
--- a/arch/arm/plat-mxc/avic.c
+++ b/arch/arm/plat-mxc/avic.c
@@ -24,6 +24,7 @@
 #include <asm/mach/irq.h>
 #include <asm/exception.h>
 #include <mach/hardware.h>
+#include <mach/crm-regs-imx25.h>
 
 #include "irq-common.h"
 
@@ -52,6 +53,7 @@
 void __iomem *avic_base;
 
 static u32 avic_saved_mask_reg[2];
+static u32 avic_imx25_lpimr[2];
 
 #ifdef CONFIG_MXC_IRQ_PRIOR
 static int avic_irq_set_priority(unsigned char irq, unsigned char prio)
@@ -128,6 +130,27 @@ static void avic_irq_resume(struct irq_data *d)
 #define avic_irq_resume NULL
 #endif
 
+int imx25_gc_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
+
+	if (on)
+		if ((d->irq) < 32)
+			avic_imx25_lpimr[0] &= ~(1 << (d->irq - gc->irq_base));
+		else
+			avic_imx25_lpimr[1] &= ~(1 << (d->irq - gc->irq_base));
+	else
+		if ((d->irq) < 32)
+			avic_imx25_lpimr[0] |= (1 << (d->irq - gc->irq_base));
+		else
+			avic_imx25_lpimr[1] |= (1 << (d->irq - gc->irq_base));
+
+	__raw_writel(avic_imx25_lpimr[0], MXC_CCM_LPIMR0);
+	__raw_writel(avic_imx25_lpimr[1], MXC_CCM_LPIMR1);
+
+	return irq_gc_set_wake(d, on);
+}
+
 static __init void avic_init_gc(unsigned int irq_start)
 {
 	struct irq_chip_generic *gc;
@@ -148,7 +171,16 @@ static __init void avic_init_gc(unsigned int irq_start)
 	ct->chip.irq_resume = avic_irq_resume;
 	ct->regs.mask = !idx ? AVIC_INTENABLEL : AVIC_INTENABLEH;
 	ct->regs.ack = ct->regs.mask;
-
+	if (cpu_is_mx25()) {
+		ct->chip.irq_set_wake = imx25_gc_set_wake;
+		if (irq_start == 0) {
+			avic_imx25_lpimr[0] = 0xFFFFFFFF;
+			__raw_writel(avic_imx25_lpimr[0], MXC_CCM_LPIMR0);
+		} else {
+			avic_imx25_lpimr[1] = 0xFFFFFFFF;
+			__raw_writel(avic_imx25_lpimr[1], MXC_CCM_LPIMR1);
+		}
+	}
 	irq_setup_generic_chip(gc, IRQ_MSK(32), 0, IRQ_NOREQUEST, 0);
 }
 
diff --git a/arch/arm/plat-mxc/include/mach/crm-regs-imx25.h b/arch/arm/plat-mxc/include/mach/crm-regs-imx25.h
new file mode 100644
index 0000000..6c448fe
--- /dev/null
+++ b/arch/arm/plat-mxc/include/mach/crm-regs-imx25.h
@@ -0,0 +1,243 @@
+/*
+ * Copyright (C) 2008-2010 Freescale Semiconductor, Inc. All Rights Reserved.
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+#ifndef __ARCH_ARM_MACH_MX25_CRM_REGS_H__
+#define __ARCH_ARM_MACH_MX25_CRM_REGS_H__
+
+#define MX25_CCM_BASE			MX25_IO_ADDRESS(MX25_CRM_BASE_ADDR)
+/* Register offsets */
+#define MXC_CCM_MPCTL		(MX25_CCM_BASE + 0x00)
+#define MXC_CCM_UPCTL		(MX25_CCM_BASE + 0x04)
+#define MXC_CCM_CCTL		(MX25_CCM_BASE + 0x08)
+#define MXC_CCM_CGCR0		(MX25_CCM_BASE + 0x0C)
+#define MXC_CCM_CGCR1		(MX25_CCM_BASE + 0x10)
+#define MXC_CCM_CGCR2		(MX25_CCM_BASE + 0x14)
+#define MXC_CCM_PCDR0		(MX25_CCM_BASE + 0x18)
+#define MXC_CCM_PCDR1		(MX25_CCM_BASE + 0x1C)
+#define MXC_CCM_PCDR2		(MX25_CCM_BASE + 0x20)
+#define MXC_CCM_PCDR3		(MX25_CCM_BASE + 0x24)
+#define MXC_CCM_RCSR		(MX25_CCM_BASE + 0x28)
+#define MXC_CCM_CRDR		(MX25_CCM_BASE + 0x2C)
+#define MXC_CCM_DCVR0		(MX25_CCM_BASE + 0x30)
+#define MXC_CCM_DCVR1		(MX25_CCM_BASE + 0x34)
+#define MXC_CCM_DCVR2		(MX25_CCM_BASE + 0x38)
+#define MXC_CCM_DCVR3		(MX25_CCM_BASE + 0x3C)
+#define MXC_CCM_LTR0		(MX25_CCM_BASE + 0x40)
+#define MXC_CCM_LTR1		(MX25_CCM_BASE + 0x44)
+#define MXC_CCM_LTR2		(MX25_CCM_BASE + 0x48)
+#define MXC_CCM_LTR3		(MX25_CCM_BASE + 0x4C)
+#define MXC_CCM_LTBR0		(MX25_CCM_BASE + 0x50)
+#define MXC_CCM_LTBR1		(MX25_CCM_BASE + 0x54)
+#define MXC_CCM_PMCR0		(MX25_CCM_BASE + 0x58)
+#define MXC_CCM_PMCR1		(MX25_CCM_BASE + 0x5C)
+#define MXC_CCM_PMCR2		(MX25_CCM_BASE + 0x60)
+#define MXC_CCM_MCR		(MX25_CCM_BASE + 0x64)
+#define MXC_CCM_LPIMR0		(MX25_CCM_BASE + 0x68)
+#define MXC_CCM_LPIMR1		(MX25_CCM_BASE + 0x6C)
+
+#define MXC_CCM_MPCTL_BRMO		(1 << 31)
+#define MXC_CCM_MPCTL_PD_OFFSET		26
+#define MXC_CCM_MPCTL_PD_MASK		(0xf << 26)
+#define MXC_CCM_MPCTL_MFD_OFFSET	16
+#define MXC_CCM_MPCTL_MFD_MASK		(0x3ff << 16)
+#define MXC_CCM_MPCTL_MFI_OFFSET	10
+#define MXC_CCM_MPCTL_MFI_MASK		(0xf << 10)
+#define MXC_CCM_MPCTL_MFN_OFFSET	0
+#define MXC_CCM_MPCTL_MFN_MASK		0x3ff
+#define MXC_CCM_MPCTL_LF		(1 << 15)
+
+#define MXC_CCM_UPCTL_BRMO		(1 << 31)
+#define MXC_CCM_UPCTL_PD_OFFSET		26
+#define MXC_CCM_UPCTL_PD_MASK		 (0xf << 26)
+#define MXC_CCM_UPCTL_MFD_OFFSET	16
+#define MXC_CCM_UPCTL_MFD_MASK		(0x3ff << 16)
+#define MXC_CCM_UPCTL_MFI_OFFSET	10
+#define MXC_CCM_UPCTL_MFI_MASK		(0xf << 10)
+#define MXC_CCM_UPCTL_MFN_OFFSET	0
+#define MXC_CCM_UPCTL_MFN_MASK		0x3ff
+#define MXC_CCM_UPCTL_LF		(1 << 15)
+
+#define MXC_CCM_CCTL_ARM_OFFSET		30
+#define MXC_CCM_CCTL_ARM_MASK		(0x3 << 30)
+#define MXC_CCM_CCTL_AHB_OFFSET		28
+#define MXC_CCM_CCTL_AHB_MASK		(0x3 << 28)
+#define MXC_CCM_CCTL_MPLL_RST		(1 << 27)
+#define MXC_CCM_CCTL_UPLL_RST		(1 << 26)
+#define MXC_CCM_CCTL_LP_CTL_OFFSET	24
+#define MXC_CCM_CCTL_LP_CTL_MASK	(0x3 << 24)
+#define MXC_CCM_CCTL_LP_MODE_RUN	(0x0 << 24)
+#define MXC_CCM_CCTL_LP_MODE_WAIT	(0x1 << 24)
+#define MXC_CCM_CCTL_LP_MODE_DOZE	(0x2 << 24)
+#define MXC_CCM_CCTL_LP_MODE_STOP	(0x3 << 24)
+#define MXC_CCM_CCTL_UPLL_DISABLE	(1 << 23)
+#define MXC_CCM_CCTL_MPLL_BYPASS	(1 << 22)
+#define MXC_CCM_CCTL_USB_DIV_OFFSET	16
+#define MXC_CCM_CCTL_USB_DIV_MASK	(0x3 << 16)
+#define MXC_CCM_CCTL_CG_CTRL		(1 << 15)
+#define MXC_CCM_CCTL_ARM_SRC		(1 << 14)
+#define MXC_CCM_CCTL_ARM_SRC_OFFSET	14
+
+#define MXC_CCM_CGCR0_HCLK_ATA_OFFSET		16
+#define MXC_CCM_CGCR0_HCLK_BROM_OFFSET		17
+#define MXC_CCM_CGCR0_HCLK_CSI_OFFSET		18
+#define MXC_CCM_CGCR0_HCLK_EMI_OFFSET		19
+#define MXC_CCM_CGCR0_HCLK_ESAI_OFFSET		20
+#define MXC_CCM_CGCR0_HCLK_ESDHC1_OFFSET	21
+#define MXC_CCM_CGCR0_HCLK_ESDHC2_OFFSET	22
+#define MXC_CCM_CGCR0_HCLK_FEC_OFFSET		23
+#define MXC_CCM_CGCR0_HCLK_LCDC_OFFSET		24
+#define MXC_CCM_CGCR0_HCLK_RTIC_OFFSET		25
+#define MXC_CCM_CGCR0_HCLK_SDMA_OFFSET		26
+#define MXC_CCM_CGCR0_HCLK_SLCDC_OFFSET		27
+#define MXC_CCM_CGCR0_HCLK_USBOTG_OFFSET	28
+
+#define MXC_CCM_CGCR0_PER_CSI_OFFSET	0
+#define MXC_CCM_CGCR0_PER_EPIT_OFFSET	1
+#define MXC_CCM_CGCR0_PER_ESAI_OFFSET	2
+#define MXC_CCM_CGCR0_PER_ESDHC1_OFFSET	3
+#define MXC_CCM_CGCR0_PER_ESDHC2_OFFSET	4
+#define MXC_CCM_CGCR0_PER_GPT_OFFSET	5
+#define MXC_CCM_CGCR0_PER_I2C_OFFSET	6
+#define MXC_CCM_CGCR0_PER_LCDC_OFFSET	7
+#define MXC_CCM_CGCR0_PER_NFC_OFFSET	8
+#define MXC_CCM_CGCR0_PER_OWIRE_OFFSET	9
+#define MXC_CCM_CGCR0_PER_PWM_OFFSET	10
+#define MXC_CCM_CGCR0_PER_SIM1_OFFSET	11
+#define MXC_CCM_CGCR0_PER_SIM2_OFFSET	12
+#define MXC_CCM_CGCR0_PER_SSI1_OFFSET	13
+#define MXC_CCM_CGCR0_PER_SSI2_OFFSET	14
+#define MXC_CCM_CGCR0_PER_UART_OFFSET	15
+
+#define MXC_CCM_CGCR1_AUDMUX_OFFSET	0
+#define MXC_CCM_CGCR1_ATA_OFFSET	1
+#define MXC_CCM_CGCR1_CAN1_OFFSET	2
+#define MXC_CCM_CGCR1_CAN2_OFFSET	3
+#define MXC_CCM_CGCR1_CSI_OFFSET	4
+#define MXC_CCM_CGCR1_CSPI1_OFFSET	5
+#define MXC_CCM_CGCR1_CSPI2_OFFSET	6
+#define MXC_CCM_CGCR1_CSPI3_OFFSET	7
+#define MXC_CCM_CGCR1_DRYICE_OFFSET	8
+#define MXC_CCM_CGCR1_ECT_OFFSET	9
+#define MXC_CCM_CGCR1_EPIT1_OFFSET	10
+#define MXC_CCM_CGCR1_EPIT2_OFFSET	11
+#define MXC_CCM_CGCR1_ESAI_OFFSET	12
+#define MXC_CCM_CGCR1_ESDHC1_OFFSET	13
+#define MXC_CCM_CGCR1_ESDHC2_OFFSET	14
+#define MXC_CCM_CGCR1_FEC_OFFSET	15
+#define MXC_CCM_CGCR1_GPIO1_OFFSET	16
+#define MXC_CCM_CGCR1_GPIO2_OFFSET	17
+#define MXC_CCM_CGCR1_GPIO3_OFFSET	18
+#define MXC_CCM_CGCR1_GPT1_OFFSET	19
+#define MXC_CCM_CGCR1_GPT2_OFFSET	20
+#define MXC_CCM_CGCR1_GPT3_OFFSET	21
+#define MXC_CCM_CGCR1_GPT4_OFFSET	22
+#define MXC_CCM_CGCR1_I2C1_OFFSET	23
+#define MXC_CCM_CGCR1_I2C2_OFFSET	24
+#define MXC_CCM_CGCR1_I2C3_OFFSET	25
+#define MXC_CCM_CGCR1_IIM_OFFSET	26
+#define MXC_CCM_CGCR1_IOMUXC_OFFSET	27
+#define MXC_CCM_CGCR1_KPP_OFFSET	28
+#define MXC_CCM_CGCR1_LCDC_OFFSET	29
+#define MXC_CCM_CGCR1_OWIRE_OFFSET	30
+#define MXC_CCM_CGCR1_PWM1_OFFSET	31
+
+#define MXC_CCM_CGCR2_PWM2_OFFSET	(32-32)
+#define MXC_CCM_CGCR2_PWM3_OFFSET	(33-32)
+#define MXC_CCM_CGCR2_PWM4_OFFSET	(34-32)
+#define MXC_CCM_CGCR2_RNGB_OFFSET	(35-32)
+#define MXC_CCM_CGCR2_RTIC_OFFSET	(36-32)
+#define MXC_CCM_CGCR2_SCC_OFFSET	(37-32)
+#define MXC_CCM_CGCR2_SDMA_OFFSET	(38-32)
+#define MXC_CCM_CGCR2_SIM1_OFFSET	(39-32)
+#define MXC_CCM_CGCR2_SIM2_OFFSET	(40-32)
+#define MXC_CCM_CGCR2_SLCDC_OFFSET	(41-32)
+#define MXC_CCM_CGCR2_SPBA_OFFSET	(42-32)
+#define MXC_CCM_CGCR2_SSI1_OFFSET	(43-32)
+#define MXC_CCM_CGCR2_SSI2_OFFSET	(44-32)
+#define MXC_CCM_CGCR2_TCHSCRN_OFFSET	(45-32)
+#define MXC_CCM_CGCR2_UART1_OFFSET	(46-32)
+#define MXC_CCM_CGCR2_UART2_OFFSET	(47-32)
+#define MXC_CCM_CGCR2_UART3_OFFSET	(48-32)
+#define MXC_CCM_CGCR2_UART4_OFFSET	(49-32)
+#define MXC_CCM_CGCR2_UART5_OFFSET	(50-32)
+#define MXC_CCM_CGCR2_WDOG_OFFSET	(51-32)
+
+#define MXC_CCM_CGCR0_STOP_MODE_MASK	\
+			((1 << MXC_CCM_CGCR0_HCLK_SLCDC_OFFSET) | \
+			 (1 << MXC_CCM_CGCR0_HCLK_RTIC_OFFSET) | \
+			 (1 << MXC_CCM_CGCR0_HCLK_EMI_OFFSET) | \
+			 (1 << MXC_CCM_CGCR0_HCLK_BROM_OFFSET))
+
+#define MXC_CCM_CGCR1_STOP_MODE_MASK	((1 << MXC_CCM_CGCR1_IIM_OFFSET) | \
+					 (1 << MXC_CCM_CGCR1_CAN2_OFFSET) | \
+					 (1 << MXC_CCM_CGCR1_CAN1_OFFSET))
+
+#define MXC_CCM_CGCR2_STOP_MODE_MASK	((1 << MXC_CCM_CGCR2_SPBA_OFFSET) | \
+					 (1 << MXC_CCM_CGCR2_SDMA_OFFSET) | \
+					 (1 << MXC_CCM_CGCR2_RTIC_OFFSET))
+
+#define MXC_CCM_PCDR1_PERDIV1_MASK	0x3f
+
+#define MXC_CCM_RCSR_NF16B		(1 << 14)
+
+#define MXC_CCM_PMCR1_CPEN_EMI		(1 << 29)
+#define MXC_CCM_PMCR1_CSPAEM_P_OFFSET	26
+#define MXC_CCM_PMCR1_CSPAEM_N_OFFSET	24
+#define MXC_CCM_PMCR1_CSPAEM_MASK	(0xf << 24)
+#define MXC_CCM_PMCR1_WBCN_OFFSET	16
+#define MXC_CCM_PMCR1_CPEN		(1 << 13)
+#define MXC_CCM_PMCR1_CSPA_P_OFFSET	11
+#define MXC_CCM_PMCR1_CSPA_N_OFFSET	9
+#define MXC_CCM_PMCR1_CSPA_MASK		(0xf << 9)
+
+#define MXC_CCM_PMCR1_WBCN_MASK		(0xff << 16)
+#define MXC_CCM_PMCR1_WBCN_DEFAULT	0xa0
+#define MXC_CCM_PMCR1_WBB_INCR		0
+#define MXC_CCM_PMCR1_WBB_MODE		1
+#define MXC_CCM_PMCR1_WBB_DECR		2
+#define MXC_CCM_PMCR1_WBB_MINI		3
+
+#define MXC_CCM_PMCR2_VSTBY		(1 << 17)
+#define MXC_CCM_PMCR2_OSC24M_DOWN	(1 << 16)
+
+#define MXC_CCM_PMCR1_AWB_EN		(MXC_CCM_PMCR1_CPEN_EMI | \
+					 MXC_CCM_PMCR1_CPEN | \
+					 (MXC_CCM_PMCR1_WBCN_DEFAULT << \
+					 MXC_CCM_PMCR1_WBCN_OFFSET))
+
+#define MXC_CCM_PMCR1_WBB_DEFAULT	((MXC_CCM_PMCR1_WBB_DECR << \
+					 MXC_CCM_PMCR1_CSPAEM_P_OFFSET) | \
+					 (MXC_CCM_PMCR1_WBB_DECR << \
+					 MXC_CCM_PMCR1_CSPAEM_N_OFFSET) | \
+					 (MXC_CCM_PMCR1_WBB_DECR << \
+					 MXC_CCM_PMCR1_CSPA_P_OFFSET) | \
+					 (MXC_CCM_PMCR1_WBB_DECR << \
+					 MXC_CCM_PMCR1_CSPA_N_OFFSET))
+
+#define MXC_CCM_PMCR1_AWB_DEFAULT	(MXC_CCM_PMCR1_AWB_EN | \
+					 MXC_CCM_PMCR1_WBB_DEFAULT)
+
+#define MXC_CCM_MCR_USB_XTAL_MUX_OFFSET	31
+#define MXC_CCM_MCR_CLKO_EN_OFFSET	30
+#define MXC_CCM_MCR_CLKO_DIV_OFFSET	24
+#define MXC_CCM_MCR_CLKO_DIV_MASK	(0x3F << 24)
+#define MXC_CCM_MCR_CLKO_SEL_OFFSET	20
+#define MXC_CCM_MCR_CLKO_SEL_MASK	(0xF << 20)
+#define MXC_CCM_MCR_ESAI_CLK_MUX_OFFSET	19
+#define MXC_CCM_MCR_SSI2_CLK_MUX_OFFSET	18
+#define MXC_CCM_MCR_SSI1_CLK_MUX_OFFSET	17
+#define MXC_CCM_MCR_USB_CLK_MUX_OFFSET	16
+
+#define MXC_CCM_MCR_PER_CLK_MUX_MASK	(0xFFFF << 0)
+
+#define MXC_CCM_LPIMR0_MASK		0xFFFFFFFF
+#define MXC_CCM_LPIMR1_MASK		0xFFFFFFFF
+
+#endif				/* __ARCH_ARM_MACH_MX25_CRM_REGS_H__ */
-- 
1.7.7.6
