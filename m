From: chao.xie@marvell.com (Chao Xie)
Date: Mon,  7 May 2012 11:22:23 +0800
Subject: [PATCH V2 2/2] ARM: mmp: add PM support for mmp2
In-Reply-To: <1336360943-16862-1-git-send-email-chao.xie@marvell.com>
References: <1336360943-16862-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1336360943-16862-2-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MMP2 can enter system sleep level during suspend.
It can be waken up by PMIC interrupt, RTC/ALARM.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/Makefile               |    4 +
 arch/arm/mach-mmp/include/mach/pm-mmp2.h |   61 +++++++
 arch/arm/mach-mmp/irq.c                  |    7 +
 arch/arm/mach-mmp/pm-mmp2.c              |  264 ++++++++++++++++++++++++++++++
 4 files changed, 336 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/pm-mmp2.h
 create mode 100644 arch/arm/mach-mmp/pm-mmp2.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index b920b9b..7d60cef 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -9,6 +9,10 @@ obj-$(CONFIG_CPU_PXA168)	+= pxa168.o
 obj-$(CONFIG_CPU_PXA910)	+= pxa910.o
 obj-$(CONFIG_CPU_MMP2)		+= mmp2.o sram.o
 
+ifeq ($(CONFIG_PM),y)
+obj-$(CONFIG_CPU_MMP2)		+= pm-mmp2.o
+endif
+
 # board support
 obj-$(CONFIG_MACH_ASPENITE)	+= aspenite.o
 obj-$(CONFIG_MACH_ZYLONITE2)	+= aspenite.o
diff --git a/arch/arm/mach-mmp/include/mach/pm-mmp2.h b/arch/arm/mach-mmp/include/mach/pm-mmp2.h
new file mode 100644
index 0000000..98bd66c
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/pm-mmp2.h
@@ -0,0 +1,61 @@
+/*
+ * MMP2 Power Management Routines
+ *
+ * This software program is licensed subject to the GNU General Public License
+ * (GPL).Version 2,June 1991, available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * (C) Copyright 2010 Marvell International Ltd.
+ * All Rights Reserved
+ */
+
+#ifndef __MMP2_PM_H__
+#define __MMP2_PM_H__
+
+#include <mach/addr-map.h>
+
+#define APMU_PJ_IDLE_CFG			APMU_REG(0x018)
+#define APMU_PJ_IDLE_CFG_PJ_IDLE		(1 << 1)
+#define APMU_PJ_IDLE_CFG_PJ_PWRDWN		(1 << 5)
+#define APMU_PJ_IDLE_CFG_PWR_SW(x)		((x) << 16)
+#define APMU_PJ_IDLE_CFG_L2_PWR_SW		(1 << 19)
+#define APMU_PJ_IDLE_CFG_ISO_MODE_CNTRL_MASK	(3 << 28)
+
+#define APMU_SRAM_PWR_DWN			APMU_REG(0x08c)
+
+#define MPMU_SCCR				MPMU_REG(0x038)
+#define MPMU_PCR_PJ				MPMU_REG(0x1000)
+#define MPMU_PCR_PJ_AXISD			(1 << 31)
+#define MPMU_PCR_PJ_SLPEN			(1 << 29)
+#define MPMU_PCR_PJ_SPSD			(1 << 28)
+#define MPMU_PCR_PJ_DDRCORSD			(1 << 27)
+#define MPMU_PCR_PJ_APBSD			(1 << 26)
+#define MPMU_PCR_PJ_INTCLR			(1 << 24)
+#define MPMU_PCR_PJ_SLPWP0			(1 << 23)
+#define MPMU_PCR_PJ_SLPWP1			(1 << 22)
+#define MPMU_PCR_PJ_SLPWP2			(1 << 21)
+#define MPMU_PCR_PJ_SLPWP3			(1 << 20)
+#define MPMU_PCR_PJ_VCTCXOSD			(1 << 19)
+#define MPMU_PCR_PJ_SLPWP4			(1 << 18)
+#define MPMU_PCR_PJ_SLPWP5			(1 << 17)
+#define MPMU_PCR_PJ_SLPWP6			(1 << 16)
+#define MPMU_PCR_PJ_SLPWP7			(1 << 15)
+
+#define MPMU_PLL2_CTRL1				MPMU_REG(0x0414)
+#define MPMU_CGR_PJ				MPMU_REG(0x1024)
+#define MPMU_WUCRM_PJ				MPMU_REG(0x104c)
+#define MPMU_WUCRM_PJ_WAKEUP(x)			(1 << (x))
+#define MPMU_WUCRM_PJ_RTC_ALARM			(1 << 17)
+
+enum {
+	POWER_MODE_ACTIVE = 0,
+	POWER_MODE_CORE_INTIDLE,
+	POWER_MODE_CORE_EXTIDLE,
+	POWER_MODE_APPS_IDLE,
+	POWER_MODE_APPS_SLEEP,
+	POWER_MODE_CHIP_SLEEP,
+	POWER_MODE_SYS_SLEEP,
+};
+
+extern void mmp2_pm_enter_lowpower_mode(int state);
+extern int mmp2_set_wake(struct irq_data *d, unsigned int on);
+#endif
diff --git a/arch/arm/mach-mmp/irq.c b/arch/arm/mach-mmp/irq.c
index 3705470..04935f1 100644
--- a/arch/arm/mach-mmp/irq.c
+++ b/arch/arm/mach-mmp/irq.c
@@ -23,6 +23,10 @@
 
 #include <mach/irqs.h>
 
+#ifdef CONFIG_CPU_MMP2
+#include <mach/pm-mmp2.h>
+#endif
+
 #include "common.h"
 
 #define MAX_ICU_NR		16
@@ -305,6 +309,9 @@ void __init mmp2_init_icu(void)
 		set_irq_flags(irq, IRQF_VALID);
 	}
 	irq_set_default_host(icu_data[0].domain);
+#ifdef CONFIG_CPU_MMP2
+	icu_irq_chip.irq_set_wake = mmp2_set_wake;
+#endif
 }
 
 #ifdef CONFIG_OF
diff --git a/arch/arm/mach-mmp/pm-mmp2.c b/arch/arm/mach-mmp/pm-mmp2.c
new file mode 100644
index 0000000..461a191
--- /dev/null
+++ b/arch/arm/mach-mmp/pm-mmp2.c
@@ -0,0 +1,264 @@
+/*
+ * MMP2 Power Management Routines
+ *
+ * This software program is licensed subject to the GNU General Public License
+ * (GPL).Version 2,June 1991, available at http://www.fsf.org/copyleft/gpl.html
+ *
+ * (C) Copyright 2012 Marvell International Ltd.
+ * All Rights Reserved
+ */
+
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/time.h>
+#include <linux/delay.h>
+#include <linux/suspend.h>
+#include <linux/irq.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <asm/mach-types.h>
+#include <mach/hardware.h>
+#include <mach/cputype.h>
+#include <mach/addr-map.h>
+#include <mach/pm-mmp2.h>
+#include <mach/regs-icu.h>
+#include <mach/irqs.h>
+
+int mmp2_set_wake(struct irq_data *d, unsigned int on)
+{
+	int irq = d->irq;
+	struct irq_desc *desc = irq_to_desc(irq);
+	unsigned long data = 0;
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
+	/* enable wakeup sources */
+	switch (irq) {
+	case IRQ_MMP2_RTC:
+	case IRQ_MMP2_RTC_ALARM:
+		data = MPMU_WUCRM_PJ_WAKEUP(4) | MPMU_WUCRM_PJ_RTC_ALARM;
+		break;
+	case IRQ_MMP2_PMIC:
+		data = MPMU_WUCRM_PJ_WAKEUP(7);
+		break;
+	case IRQ_MMP2_MMC2:
+		/* mmc use WAKEUP2, same as GPIO wakeup source */
+		data = MPMU_WUCRM_PJ_WAKEUP(2);
+		break;
+	}
+	if (on) {
+		if (data) {
+			data |= __raw_readl(MPMU_WUCRM_PJ);
+			__raw_writel(data, MPMU_WUCRM_PJ);
+		}
+	} else {
+		if (data) {
+			data = ~data & __raw_readl(MPMU_WUCRM_PJ);
+			__raw_writel(data, MPMU_WUCRM_PJ);
+		}
+	}
+	return 0;
+}
+
+static void pm_scu_clk_disable(void)
+{
+	unsigned int val;
+
+	/* close AXI fabric clock gate */
+	__raw_writel(0x0, CIU_REG(0x64));
+	__raw_writel(0x0, CIU_REG(0x68));
+
+	/* close MCB master clock gate */
+	val = __raw_readl(CIU_REG(0x1c));
+	val |= 0xf0;
+	__raw_writel(val, CIU_REG(0x1c));
+
+	return ;
+}
+
+static void pm_scu_clk_enable(void)
+{
+	unsigned int val;
+
+	/* open AXI fabric clock gate */
+	__raw_writel(0x03003003, CIU_REG(0x64));
+	__raw_writel(0x00303030, CIU_REG(0x68));
+
+	/* open MCB master clock gate */
+	val = __raw_readl(CIU_REG(0x1c));
+	val &= ~(0xf0);
+	__raw_writel(val, CIU_REG(0x1c));
+
+	return ;
+}
+
+static void pm_mpmu_clk_disable(void)
+{
+	/*
+	 * disable clocks in MPMU_CGR_PJ register
+	 * except clock for APMU_PLL1, APMU_PLL1_2 and AP_26M
+	 */
+	__raw_writel(0x0000a010, MPMU_CGR_PJ);
+}
+
+static void pm_mpmu_clk_enable(void)
+{
+	unsigned int val;
+
+	__raw_writel(0xdffefffe, MPMU_CGR_PJ);
+	val = __raw_readl(MPMU_PLL2_CTRL1);
+	val |= (1 << 29);
+	__raw_writel(val, MPMU_PLL2_CTRL1);
+
+	return ;
+}
+
+void mmp2_pm_enter_lowpower_mode(int state)
+{
+	uint32_t idle_cfg, apcr;
+
+	idle_cfg = __raw_readl(APMU_PJ_IDLE_CFG);
+	apcr = __raw_readl(MPMU_PCR_PJ);
+	apcr &= ~(MPMU_PCR_PJ_SLPEN | MPMU_PCR_PJ_DDRCORSD | MPMU_PCR_PJ_APBSD
+		 | MPMU_PCR_PJ_AXISD | MPMU_PCR_PJ_VCTCXOSD | (1 << 13));
+	idle_cfg &= ~APMU_PJ_IDLE_CFG_PJ_IDLE;
+
+	switch (state) {
+	case POWER_MODE_SYS_SLEEP:
+		apcr |= MPMU_PCR_PJ_SLPEN;		/* set the SLPEN bit */
+		apcr |= MPMU_PCR_PJ_VCTCXOSD;		/* set VCTCXOSD */
+		/* fall through */
+	case POWER_MODE_CHIP_SLEEP:
+		apcr |= MPMU_PCR_PJ_SLPEN;
+		/* fall through */
+	case POWER_MODE_APPS_SLEEP:
+		apcr |= MPMU_PCR_PJ_APBSD;		/* set APBSD */
+		/* fall through */
+	case POWER_MODE_APPS_IDLE:
+		apcr |= MPMU_PCR_PJ_AXISD;		/* set AXISDD bit */
+		apcr |= MPMU_PCR_PJ_DDRCORSD;		/* set DDRCORSD bit */
+		idle_cfg |= APMU_PJ_IDLE_CFG_PJ_PWRDWN;	/* PJ power down */
+		apcr |= MPMU_PCR_PJ_SPSD;
+		/* fall through */
+	case POWER_MODE_CORE_EXTIDLE:
+		idle_cfg |= APMU_PJ_IDLE_CFG_PJ_IDLE;	/* set the IDLE bit */
+		idle_cfg &= ~APMU_PJ_IDLE_CFG_ISO_MODE_CNTRL_MASK;
+		idle_cfg |= APMU_PJ_IDLE_CFG_PWR_SW(3)
+			| APMU_PJ_IDLE_CFG_L2_PWR_SW;
+		break;
+	case POWER_MODE_CORE_INTIDLE:
+		apcr &= ~MPMU_PCR_PJ_SPSD;
+		break;
+	}
+
+	/* set reserve bits */
+	apcr |= (1 << 30) | (1 << 25);
+
+	/* finally write the registers back */
+	__raw_writel(idle_cfg, APMU_PJ_IDLE_CFG);
+	__raw_writel(apcr, MPMU_PCR_PJ);	/* 0xfe086000 */
+}
+
+static int mmp2_pm_enter(suspend_state_t state)
+{
+	int temp;
+
+	temp = __raw_readl(MMP2_ICU_INT4_MASK);
+	if (temp & (1 << 1)) {
+		printk(KERN_ERR "%s: PMIC interrupt is handling\n", __func__);
+		return -EAGAIN;
+	}
+
+	temp = __raw_readl(APMU_SRAM_PWR_DWN);
+	temp |= ((1 << 19) | (1 << 18));
+	__raw_writel(temp, APMU_SRAM_PWR_DWN);
+	pm_mpmu_clk_disable();
+	pm_scu_clk_disable();
+
+	printk(KERN_INFO "%s: before suspend\n", __func__);
+	cpu_do_idle();
+	printk(KERN_INFO "%s: after suspend\n", __func__);
+
+	pm_mpmu_clk_enable();		/* enable clocks in MPMU */
+	pm_scu_clk_enable();		/* enable clocks in SCU */
+
+	return 0;
+}
+
+/*
+ * Called after processes are frozen, but before we shut down devices.
+ */
+static int mmp2_pm_prepare(void)
+{
+	mmp2_pm_enter_lowpower_mode(POWER_MODE_SYS_SLEEP);
+
+	return 0;
+}
+
+/*
+ * Called after devices are re-setup, but before processes are thawed.
+ */
+static void mmp2_pm_finish(void)
+{
+	mmp2_pm_enter_lowpower_mode(POWER_MODE_CORE_INTIDLE);
+}
+
+static int mmp2_pm_valid(suspend_state_t state)
+{
+	return ((state == PM_SUSPEND_STANDBY) || (state == PM_SUSPEND_MEM));
+}
+
+/*
+ * Set to PM_DISK_FIRMWARE so we can quickly veto suspend-to-disk.
+ */
+static const struct platform_suspend_ops mmp2_pm_ops = {
+	.valid		= mmp2_pm_valid,
+	.prepare	= mmp2_pm_prepare,
+	.enter		= mmp2_pm_enter,
+	.finish		= mmp2_pm_finish,
+};
+
+static int __init mmp2_pm_init(void)
+{
+	uint32_t apcr;
+
+	if (!cpu_is_mmp2())
+		return -EIO;
+
+	suspend_set_ops(&mmp2_pm_ops);
+
+	/*
+	 * Set bit 0, Slow clock Select 32K clock input instead of VCXO
+	 * VCXO is chosen by default, which would be disabled in suspend
+	 */
+	__raw_writel(0x5, MPMU_SCCR);
+
+	/*
+	 * Clear bit 23 of CIU_CPU_CONF
+	 * direct PJ4 to DDR access through Memory Controller slow queue
+	 * fast queue has issue and cause lcd will flick
+	 */
+	__raw_writel(__raw_readl(CIU_REG(0x8)) & ~(0x1 << 23), CIU_REG(0x8));
+
+	/* Clear default low power control bit */
+	apcr = __raw_readl(MPMU_PCR_PJ);
+	apcr &= ~(MPMU_PCR_PJ_SLPEN | MPMU_PCR_PJ_DDRCORSD
+			| MPMU_PCR_PJ_APBSD | MPMU_PCR_PJ_AXISD | 1 << 13);
+	__raw_writel(apcr, MPMU_PCR_PJ);
+
+	return 0;
+}
+
+late_initcall(mmp2_pm_init);
-- 
1.7.0.4
