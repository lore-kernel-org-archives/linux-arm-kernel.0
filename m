From: chao.xie@marvell.com (Chao Xie)
Date: Thu,  3 May 2012 10:04:31 +0800
Subject: [PATCH 4/4] ARM: pxa910: add pm support for pxa910
In-Reply-To: <1336010671-12792-1-git-send-email-chao.xie@marvell.com>
References: <1336010671-12792-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1336010671-12792-4-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add suspend/resume functionality for pxa910

Signed-off-by: Chao Xie <chao.xie@marvell.com>
Signed-off-by: Raul Xiong <xjian@marvell.com>
---
 arch/arm/mach-mmp/Makefile                 |    1 +
 arch/arm/mach-mmp/include/mach/pm-pxa910.h |   77 ++++++++
 arch/arm/mach-mmp/irq-pxa168.c             |    6 +
 arch/arm/mach-mmp/pm-pxa910.c              |  286 ++++++++++++++++++++++++++++
 4 files changed, 370 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/pm-pxa910.h
 create mode 100644 arch/arm/mach-mmp/pm-pxa910.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index fb96222..f111472 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_CPU_PXA910)	+= pxa910.o irq-pxa168.o
 obj-$(CONFIG_CPU_MMP2)		+= mmp2.o irq-mmp2.o sram.o
 
 ifeq ($(CONFIG_PM),y)
+obj-$(CONFIG_CPU_PXA910)	+= pm-pxa910.o
 obj-$(CONFIG_CPU_MMP2)		+= pm-mmp2.o
 endif
 
diff --git a/arch/arm/mach-mmp/include/mach/pm-pxa910.h b/arch/arm/mach-mmp/include/mach/pm-pxa910.h
new file mode 100644
index 0000000..8cac8ab
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/pm-pxa910.h
@@ -0,0 +1,77 @@
+/*
+ * PXA910 Power Management Routines
+ *
+ * This software program is licensed subject to the GNU General Public License
+ * (GPL).Version 2,June 1991, available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * (C) Copyright 2009 Marvell International Ltd.
+ * All Rights Reserved
+ */
+
+#ifndef __PXA910_PM_H__
+#define __PXA910_PM_H__
+
+#define APMU_MOH_IDLE_CFG			APMU_REG(0x0018)
+#define APMU_MOH_IDLE_CFG_MOH_IDLE		(1 << 1)
+#define APMU_MOH_IDLE_CFG_MOH_PWRDWN		(1 << 5)
+#define APMU_MOH_IDLE_CFG_MOH_SRAM_PWRDWN	(1 << 6)
+#define APMU_MOH_IDLE_CFG_MOH_PWR_SW(x)		(((x) & 0x3) << 16)
+#define APMU_MOH_IDLE_CFG_MOH_L2_PWR_SW(x)	(((x) & 0x3) << 18)
+#define APMU_MOH_IDLE_CFG_MOH_DIS_MC_SW_REQ	(1 << 21)
+#define APMU_MOH_IDLE_CFG_MOH_MC_WAKE_EN	(1 << 20)
+
+#define APMU_SQU_CLK_GATE_CTRL			APMU_REG(0x001c)
+#define APMU_MC_HW_SLP_TYPE			APMU_REG(0x00b0)
+
+#define MPMU_FCCR				MPMU_REG(0x0008)
+#define MPMU_APCR				MPMU_REG(0x1000)
+#define MPMU_APCR_AXISD				(1 << 31)
+#define MPMU_APCR_DSPSD				(1 << 30)
+#define MPMU_APCR_SLPEN				(1 << 29)
+#define MPMU_APCR_DTCMSD			(1 << 28)
+#define MPMU_APCR_DDRCORSD			(1 << 27)
+#define MPMU_APCR_APBSD				(1 << 26)
+#define MPMU_APCR_BBSD				(1 << 25)
+#define MPMU_APCR_SLPWP0			(1 << 23)
+#define MPMU_APCR_SLPWP1			(1 << 22)
+#define MPMU_APCR_SLPWP2			(1 << 21)
+#define MPMU_APCR_SLPWP3			(1 << 20)
+#define MPMU_APCR_VCTCXOSD			(1 << 19)
+#define MPMU_APCR_SLPWP4			(1 << 18)
+#define MPMU_APCR_SLPWP5			(1 << 17)
+#define MPMU_APCR_SLPWP6			(1 << 16)
+#define MPMU_APCR_SLPWP7			(1 << 15)
+#define MPMU_APCR_MSASLPEN			(1 << 14)
+#define MPMU_APCR_STBYEN			(1 << 13)
+
+#define MPMU_AWUCRM				MPMU_REG(0x104c)
+#define MPMU_AWUCRM_AP_ASYNC_INT		(1 << 25)
+#define MPMU_AWUCRM_AP_FULL_IDLE		(1 << 24)
+#define MPMU_AWUCRM_SDH1			(1 << 23)
+#define MPMU_AWUCRM_SDH2			(1 << 22)
+#define MPMU_AWUCRM_KEYPRESS			(1 << 21)
+#define MPMU_AWUCRM_TRACKBALL			(1 << 20)
+#define MPMU_AWUCRM_NEWROTARY			(1 << 19)
+#define MPMU_AWUCRM_RTC_ALARM			(1 << 17)
+#define MPMU_AWUCRM_AP2_TIMER_3			(1 << 13)
+#define MPMU_AWUCRM_AP2_TIMER_2			(1 << 12)
+#define MPMU_AWUCRM_AP2_TIMER_1			(1 << 11)
+#define MPMU_AWUCRM_AP1_TIMER_3			(1 << 10)
+#define MPMU_AWUCRM_AP1_TIMER_2			(1 << 9)
+#define MPMU_AWUCRM_AP1_TIMER_1			(1 << 8)
+#define MPMU_AWUCRM_WAKEUP(x)			(1 << ((x) & 0x7))
+
+enum {
+	POWER_MODE_ACTIVE = 0,
+	POWER_MODE_CORE_INTIDLE,
+	POWER_MODE_CORE_EXTIDLE,
+	POWER_MODE_APPS_IDLE,
+	POWER_MODE_APPS_SLEEP,
+	POWER_MODE_SYS_SLEEP,
+	POWER_MODE_HIBERNATE,
+	POWER_MODE_UDR,
+};
+
+extern int pxa910_set_wake(struct irq_data *data, unsigned int on);
+
+#endif
diff --git a/arch/arm/mach-mmp/irq-pxa168.c b/arch/arm/mach-mmp/irq-pxa168.c
index 89706a0..d71b156 100644
--- a/arch/arm/mach-mmp/irq-pxa168.c
+++ b/arch/arm/mach-mmp/irq-pxa168.c
@@ -17,6 +17,9 @@
 #include <linux/io.h>
 
 #include <mach/regs-icu.h>
+#ifdef CONFIG_CPU_PXA910
+#include <mach/pm-pxa910.h>
+#endif
 
 #include "common.h"
 
@@ -40,6 +43,9 @@ static struct irq_chip icu_irq_chip = {
 	.irq_ack	= icu_mask_irq,
 	.irq_mask	= icu_mask_irq,
 	.irq_unmask	= icu_unmask_irq,
+#ifdef CONFIG_CPU_PXA910
+	.irq_set_wake	= pxa910_set_wake,
+#endif
 };
 
 void __init icu_init_irq(void)
diff --git a/arch/arm/mach-mmp/pm-pxa910.c b/arch/arm/mach-mmp/pm-pxa910.c
new file mode 100644
index 0000000..2504d68
--- /dev/null
+++ b/arch/arm/mach-mmp/pm-pxa910.c
@@ -0,0 +1,286 @@
+/*
+ * PXA910 Power Management Routines
+ *
+ * This software program is licensed subject to the GNU General Public License
+ * (GPL).Version 2,June 1991, available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * (C) Copyright 2009 Marvell International Ltd.
+ * All Rights Reserved
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/time.h>
+#include <linux/delay.h>
+#include <linux/suspend.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <mach/cputype.h>
+#include <mach/addr-map.h>
+#include <mach/pm-pxa910.h>
+#include <mach/regs-ciu.h>
+#include <mach/regs-icu.h>
+#include <mach/irqs.h>
+
+int pxa910_set_wake(struct irq_data *data, unsigned int on)
+{
+	int irq = data->irq;
+	struct irq_desc *desc = irq_to_desc(data->irq);
+	uint32_t awucrm = 0, apcr = 0;
+
+	if (unlikely(irq >= nr_irqs)) {
+		pr_err("IRQ nubmers are out of boundary!\n");
+		return -EINVAL;
+	}
+
+	if (on) {
+		if (desc->action)
+			desc->action->flags |= IRQF_NO_SUSPEND;
+	} else {
+		if (desc->action)
+			desc->action->flags &= ~IRQF_NO_SUSPEND;
+	}
+
+	/* setting wakeup sources */
+	switch (irq) {
+	/* wakeup line 2 */
+	case IRQ_PXA910_AP_GPIO:
+		awucrm = MPMU_AWUCRM_WAKEUP(2);
+		apcr |= MPMU_APCR_SLPWP2;
+		break;
+	/* wakeup line 3 */
+	case IRQ_PXA910_KEYPAD:
+		awucrm = MPMU_AWUCRM_WAKEUP(3) | MPMU_AWUCRM_KEYPRESS;
+		apcr |= MPMU_APCR_SLPWP3;
+		break;
+	case IRQ_PXA910_ROTARY:
+		awucrm = MPMU_AWUCRM_WAKEUP(3) | MPMU_AWUCRM_NEWROTARY;
+		apcr |= MPMU_APCR_SLPWP3;
+		break;
+	case IRQ_PXA910_TRACKBALL:
+		awucrm = MPMU_AWUCRM_WAKEUP(3) | MPMU_AWUCRM_TRACKBALL;
+		apcr |= MPMU_APCR_SLPWP3;
+		break;
+	/* wakeup line 4 */
+	case IRQ_PXA910_AP1_TIMER1:
+		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP1_TIMER_1;
+		apcr |= MPMU_APCR_SLPWP4;
+		break;
+	case IRQ_PXA910_AP1_TIMER2:
+		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP1_TIMER_2;
+		apcr |= MPMU_APCR_SLPWP4;
+		break;
+	case IRQ_PXA910_AP1_TIMER3:
+		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP1_TIMER_3;
+		apcr |= MPMU_APCR_SLPWP4;
+		break;
+	case IRQ_PXA910_AP2_TIMER1:
+		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP2_TIMER_1;
+		apcr |= MPMU_APCR_SLPWP4;
+		break;
+	case IRQ_PXA910_AP2_TIMER2:
+		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP2_TIMER_2;
+		apcr |= MPMU_APCR_SLPWP4;
+		break;
+	case IRQ_PXA910_AP2_TIMER3:
+		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_AP2_TIMER_3;
+		apcr |= MPMU_APCR_SLPWP4;
+		break;
+	case IRQ_PXA910_RTC_ALARM:
+		awucrm = MPMU_AWUCRM_WAKEUP(4) | MPMU_AWUCRM_RTC_ALARM;
+		apcr |= MPMU_APCR_SLPWP4;
+		break;
+	/* wakeup line 5 */
+	case IRQ_PXA910_USB1:
+	case IRQ_PXA910_USB2:
+		awucrm = MPMU_AWUCRM_WAKEUP(5);
+		apcr |= MPMU_APCR_SLPWP5;
+		break;
+	/* wakeup line 6 */
+	case IRQ_PXA910_MMC:
+		awucrm = MPMU_AWUCRM_WAKEUP(6)
+			| MPMU_AWUCRM_SDH1
+			| MPMU_AWUCRM_SDH2;
+		apcr |= MPMU_APCR_SLPWP6;
+		break;
+	/* wakeup line 7 */
+	case IRQ_PXA910_PMIC_INT:
+		awucrm = MPMU_AWUCRM_WAKEUP(7);
+		apcr |= MPMU_APCR_SLPWP7;
+		break;
+	default:
+		if (irq >= IRQ_GPIO_START && irq < IRQ_BOARD_START) {
+			awucrm = MPMU_AWUCRM_WAKEUP(2);
+			apcr |= MPMU_APCR_SLPWP2;
+		} else
+			printk(KERN_ERR "Error: no defined wake up source irq: %d\n",
+				irq);
+	}
+
+	if (on) {
+		if (awucrm) {
+			awucrm |= __raw_readl(MPMU_AWUCRM);
+			__raw_writel(awucrm, MPMU_AWUCRM);
+		}
+		if (apcr) {
+			apcr = ~apcr & __raw_readl(MPMU_APCR);
+			__raw_writel(apcr, MPMU_APCR);
+		}
+	} else {
+		if (awucrm) {
+			awucrm = ~awucrm & __raw_readl(MPMU_AWUCRM);
+			__raw_writel(awucrm, MPMU_AWUCRM);
+		}
+		if (apcr) {
+			apcr |= __raw_readl(MPMU_APCR);
+			__raw_writel(apcr, MPMU_APCR);
+		}
+	}
+	return 0;
+}
+
+void pxa910_pm_enter_lowpower_mode(int state)
+{
+	uint32_t idle_cfg, apcr;
+
+	idle_cfg = __raw_readl(APMU_MOH_IDLE_CFG);
+	apcr = __raw_readl(MPMU_APCR);
+
+	apcr &= ~(MPMU_APCR_DDRCORSD | MPMU_APCR_APBSD | MPMU_APCR_AXISD
+		| MPMU_APCR_VCTCXOSD | MPMU_APCR_STBYEN);
+	idle_cfg &= ~(APMU_MOH_IDLE_CFG_MOH_IDLE
+		| APMU_MOH_IDLE_CFG_MOH_PWRDWN);
+
+	switch (state) {
+	case POWER_MODE_UDR:
+		/* only shutdown APB in UDR */
+		apcr |= MPMU_APCR_STBYEN | MPMU_APCR_APBSD;
+		/* fall through */
+	case POWER_MODE_SYS_SLEEP:
+		apcr |= MPMU_APCR_SLPEN;		/* set the SLPEN bit */
+		apcr |= MPMU_APCR_VCTCXOSD;		/* set VCTCXOSD */
+		/* fall through */
+	case POWER_MODE_APPS_SLEEP:
+		apcr |= MPMU_APCR_DDRCORSD;		/* set DDRCORSD */
+		/* fall through */
+	case POWER_MODE_APPS_IDLE:
+		apcr |= MPMU_APCR_AXISD;		/* set AXISDD bit */
+		/* fall through */
+	case POWER_MODE_CORE_EXTIDLE:
+		idle_cfg |= APMU_MOH_IDLE_CFG_MOH_IDLE;
+		idle_cfg |= APMU_MOH_IDLE_CFG_MOH_PWRDWN;
+		idle_cfg |= APMU_MOH_IDLE_CFG_MOH_PWR_SW(3)
+			| APMU_MOH_IDLE_CFG_MOH_L2_PWR_SW(3);
+		/* fall through */
+	case POWER_MODE_CORE_INTIDLE:
+		break;
+	}
+
+	/* program the memory controller hardware sleep type and auto wakeup */
+	idle_cfg |= APMU_MOH_IDLE_CFG_MOH_DIS_MC_SW_REQ;
+	idle_cfg |= APMU_MOH_IDLE_CFG_MOH_MC_WAKE_EN;
+	__raw_writel(0x0, APMU_MC_HW_SLP_TYPE);		/* auto refresh */
+
+	/* set DSPSD, DTCMSD, BBSD, MSASLPEN */
+	apcr |= MPMU_APCR_DSPSD | MPMU_APCR_DTCMSD | MPMU_APCR_BBSD
+		| MPMU_APCR_MSASLPEN;
+
+	/*always set SLEPEN bit mainly for MSA*/
+	apcr |= MPMU_APCR_SLPEN;
+
+	/* finally write the registers back */
+	__raw_writel(idle_cfg, APMU_MOH_IDLE_CFG);
+	__raw_writel(apcr, MPMU_APCR);
+
+}
+
+static int pxa910_pm_enter(suspend_state_t state)
+{
+	unsigned int idle_cfg, reg = 0;
+
+	/*pmic thread not completed,exit;otherwise system can't be waked up*/
+	reg = __raw_readl(ICU_INT_CONF(IRQ_PXA910_PMIC_INT));
+	if ((reg & 0x3) == 0)
+		return -EAGAIN;
+
+	idle_cfg = __raw_readl(APMU_MOH_IDLE_CFG);
+	idle_cfg |= APMU_MOH_IDLE_CFG_MOH_PWRDWN
+		| APMU_MOH_IDLE_CFG_MOH_SRAM_PWRDWN;
+	__raw_writel(idle_cfg, APMU_MOH_IDLE_CFG);
+
+	/* disable L2 */
+	outer_disable();
+	/* wait for l2 idle */
+	while (!(readl(CIU_REG(0x8)) & (1 << 16)))
+		udelay(1);
+
+	cpu_do_idle();
+
+	/* enable L2 */
+	outer_resume();
+	/* wait for l2 idle */
+	while (!(readl(CIU_REG(0x8)) & (1 << 16)))
+		udelay(1);
+
+	idle_cfg = __raw_readl(APMU_MOH_IDLE_CFG);
+	idle_cfg &= ~(APMU_MOH_IDLE_CFG_MOH_PWRDWN
+		| APMU_MOH_IDLE_CFG_MOH_SRAM_PWRDWN);
+	__raw_writel(idle_cfg, APMU_MOH_IDLE_CFG);
+
+	return 0;
+}
+
+/*
+ * Called after processes are frozen, but before we shut down devices.
+ */
+static int pxa910_pm_prepare(void)
+{
+	pxa910_pm_enter_lowpower_mode(POWER_MODE_UDR);
+	return 0;
+}
+
+/*
+ * Called after devices are re-setup, but before processes are thawed.
+ */
+static void pxa910_pm_finish(void)
+{
+	pxa910_pm_enter_lowpower_mode(POWER_MODE_CORE_INTIDLE);
+}
+
+static int pxa910_pm_valid(suspend_state_t state)
+{
+	return ((state == PM_SUSPEND_STANDBY) || (state == PM_SUSPEND_MEM));
+}
+
+static const struct platform_suspend_ops pxa910_pm_ops = {
+	.valid		= pxa910_pm_valid,
+	.prepare	= pxa910_pm_prepare,
+	.enter		= pxa910_pm_enter,
+	.finish		= pxa910_pm_finish,
+};
+
+static int __init pxa910_pm_init(void)
+{
+	uint32_t awucrm = 0;
+
+	if (!cpu_is_pxa910())
+		return -EIO;
+
+	suspend_set_ops(&pxa910_pm_ops);
+
+	/* Set the following bits for MMP3 playback with VCTXO on */
+	__raw_writel(__raw_readl(APMU_SQU_CLK_GATE_CTRL) | (1 << 30),
+		APMU_SQU_CLK_GATE_CTRL);
+	__raw_writel(__raw_readl(MPMU_FCCR) | (1 << 28), MPMU_FCCR);
+
+	awucrm |= MPMU_AWUCRM_AP_ASYNC_INT | MPMU_AWUCRM_AP_FULL_IDLE;
+	__raw_writel(awucrm, MPMU_AWUCRM);
+
+	return 0;
+}
+
+late_initcall(pxa910_pm_init);
-- 
1.7.0.4
