From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:32:04 -0800
Subject: [PATCH 22/35] davinci: add power management support
In-Reply-To: <1262802737-6601-22-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-11-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-12-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-13-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-14-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-15-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-16-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-17-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-18-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-19-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-20-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-21-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-22-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-23-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

This patch adds core power management (suspend-to-RAM)
support for DaVinci SoCs.

The code depends on the the "deepsleep" feature to suspend
the SoC and saves power by gating the input clock.

The wakeup can be based on an external event as supported
by the SoC.

Assembly code (in sleep.S) is added to aid gating DDR2
clocks. Code doing this work should not be accessing DDR2.
The assembly code is relocated to SRAM by the code in pm.c

The support has been validated on DA850/OMAP-L138 only
though the code is (hopefully) generic enough that other
SoCs supporting deepsleep feature simply requires SoC
specific code to start using this driver.

Note that all the device drivers don't support suspend/resume
still and are being worked on.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/Makefile              |    1 +
 arch/arm/mach-davinci/include/mach/memory.h |    1 +
 arch/arm/mach-davinci/include/mach/pm.h     |   54 +++++++
 arch/arm/mach-davinci/pm.c                  |  158 +++++++++++++++++++
 arch/arm/mach-davinci/sleep.S               |  224 +++++++++++++++++++++++++++
 5 files changed, 438 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-davinci/include/mach/pm.h
 create mode 100644 arch/arm/mach-davinci/pm.c
 create mode 100644 arch/arm/mach-davinci/sleep.S

diff --git a/arch/arm/mach-davinci/Makefile b/arch/arm/mach-davinci/Makefile
index eeb9230..d0fed3a 100644
--- a/arch/arm/mach-davinci/Makefile
+++ b/arch/arm/mach-davinci/Makefile
@@ -34,3 +34,4 @@ obj-$(CONFIG_MACH_DAVINCI_DA850_EVM)	+= board-da850-evm.o
 # Power Management
 obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o
 obj-$(CONFIG_CPU_IDLE)			+= cpuidle.o
+obj-$(CONFIG_SUSPEND)			+= pm.o sleep.o
diff --git a/arch/arm/mach-davinci/include/mach/memory.h b/arch/arm/mach-davinci/include/mach/memory.h
index 7aeaf46..a91edfb 100644
--- a/arch/arm/mach-davinci/include/mach/memory.h
+++ b/arch/arm/mach-davinci/include/mach/memory.h
@@ -33,6 +33,7 @@
 
 #define DDR2_SDRCR_OFFSET	0xc
 #define DDR2_SRPD_BIT		BIT(23)
+#define DDR2_MCLKSTOPEN_BIT	BIT(30)
 #define DDR2_LPMODEN_BIT	BIT(31)
 
 /*
diff --git a/arch/arm/mach-davinci/include/mach/pm.h b/arch/arm/mach-davinci/include/mach/pm.h
new file mode 100644
index 0000000..37b19bf
--- /dev/null
+++ b/arch/arm/mach-davinci/include/mach/pm.h
@@ -0,0 +1,54 @@
+/*
+ * TI DaVinci platform support for power management.
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation version 2.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+#ifndef _MACH_DAVINCI_PM_H
+#define _MACH_DAVINCI_PM_H
+
+/*
+ * Caution: Assembly code in sleep.S makes assumtion on the order
+ * of the members of this structure.
+ */
+struct davinci_pm_config {
+	void __iomem *ddr2_ctlr_base;
+	void __iomem *ddrpsc_reg_base;
+	int ddrpsc_num;
+	void __iomem *ddrpll_reg_base;
+	void __iomem *deepsleep_reg;
+	void __iomem *cpupll_reg_base;
+	/*
+	 * Note on SLEEPCOUNT:
+	 * The SLEEPCOUNT feature is mainly intended for cases in which
+	 * the internal oscillator is used. The internal oscillator is
+	 * fully disabled in deep sleep mode.  When you exist deep sleep
+	 * mode, the oscillator will be turned on and will generate very
+	 * small oscillations which will not be detected by the deep sleep
+	 * counter.  Eventually those oscillations will grow to an amplitude
+	 * large enough to start incrementing the deep sleep counter.
+	 * In this case recommendation from hardware engineers is that the
+	 * SLEEPCOUNT be set to 4096.  This means that 4096 valid clock cycles
+	 * must be detected before the clock is passed to the rest of the
+	 * system.
+	 * In the case that the internal oscillator is not used and the
+	 * clock is generated externally, the SLEEPCOUNT value can be very
+	 * small since the clock input is assumed to be stable before SoC
+	 * is taken out of deepsleep mode.  A value of 128 would be more than
+	 * adequate.
+	 */
+	int sleepcount;
+};
+
+extern unsigned int davinci_cpu_suspend_sz;
+extern void davinci_cpu_suspend(struct davinci_pm_config *);
+
+#endif
diff --git a/arch/arm/mach-davinci/pm.c b/arch/arm/mach-davinci/pm.c
new file mode 100644
index 0000000..fab953b
--- /dev/null
+++ b/arch/arm/mach-davinci/pm.c
@@ -0,0 +1,158 @@
+/*
+ * DaVinci Power Management Routines
+ *
+ * Copyright (C) 2009 Texas Instruments, Inc. http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/pm.h>
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/clk.h>
+#include <linux/spinlock.h>
+
+#include <asm/cacheflush.h>
+#include <asm/delay.h>
+
+#include <mach/da8xx.h>
+#include <mach/sram.h>
+#include <mach/pm.h>
+
+#include "clock.h"
+
+#define DEEPSLEEP_SLEEPCOUNT_MASK	0xFFFF
+
+static void (*davinci_sram_suspend) (struct davinci_pm_config *);
+static struct davinci_pm_config *pdata;
+
+static void davinci_sram_push(void *dest, void *src, unsigned int size)
+{
+	memcpy(dest, src, size);
+	flush_icache_range((unsigned long)dest, (unsigned long)(dest + size));
+}
+
+static void davinci_pm_suspend(void)
+{
+	unsigned val;
+
+	if (pdata->cpupll_reg_base != pdata->ddrpll_reg_base) {
+
+		/* Switch CPU PLL to bypass mode */
+		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val &= ~(PLLCTL_PLLENSRC | PLLCTL_PLLEN);
+		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+
+		udelay(PLL_BYPASS_TIME);
+
+		/* Powerdown CPU PLL */
+		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val |= PLLCTL_PLLPWRDN;
+		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+	}
+
+	/* Configure sleep count in deep sleep register */
+	val = __raw_readl(pdata->deepsleep_reg);
+	val &= ~DEEPSLEEP_SLEEPCOUNT_MASK,
+	val |= pdata->sleepcount;
+	__raw_writel(val, pdata->deepsleep_reg);
+
+	/* System goes to sleep in this call */
+	davinci_sram_suspend(pdata);
+
+	if (pdata->cpupll_reg_base != pdata->ddrpll_reg_base) {
+
+		/* put CPU PLL in reset */
+		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val &= ~PLLCTL_PLLRST;
+		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+
+		/* put CPU PLL in power down */
+		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val &= ~PLLCTL_PLLPWRDN;
+		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+
+		/* wait for CPU PLL reset */
+		udelay(PLL_RESET_TIME);
+
+		/* bring CPU PLL out of reset */
+		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val |= PLLCTL_PLLRST;
+		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+
+		/* Wait for CPU PLL to lock */
+		udelay(PLL_LOCK_TIME);
+
+		/* Remove CPU PLL from bypass mode */
+		val = __raw_readl(pdata->cpupll_reg_base + PLLCTL);
+		val &= ~PLLCTL_PLLENSRC;
+		val |= PLLCTL_PLLEN;
+		__raw_writel(val, pdata->cpupll_reg_base + PLLCTL);
+	}
+}
+
+static int davinci_pm_enter(suspend_state_t state)
+{
+	int ret = 0;
+
+	switch (state) {
+	case PM_SUSPEND_STANDBY:
+	case PM_SUSPEND_MEM:
+		davinci_pm_suspend();
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	return ret;
+}
+
+static struct platform_suspend_ops davinci_pm_ops = {
+	.enter		= davinci_pm_enter,
+	.valid		= suspend_valid_only_mem,
+};
+
+static int __init davinci_pm_probe(struct platform_device *pdev)
+{
+	pdata = pdev->dev.platform_data;
+	if (!pdata) {
+		dev_err(&pdev->dev, "cannot get platform data\n");
+		return -ENOENT;
+	}
+
+	davinci_sram_suspend = sram_alloc(davinci_cpu_suspend_sz, NULL);
+	if (!davinci_sram_suspend) {
+		dev_err(&pdev->dev, "cannot allocate SRAM memory\n");
+		return -ENOMEM;
+	}
+
+	davinci_sram_push(davinci_sram_suspend, davinci_cpu_suspend,
+						davinci_cpu_suspend_sz);
+
+	suspend_set_ops(&davinci_pm_ops);
+
+	return 0;
+}
+
+static int __exit davinci_pm_remove(struct platform_device *pdev)
+{
+	sram_free(davinci_sram_suspend, davinci_cpu_suspend_sz);
+	return 0;
+}
+
+static struct platform_driver davinci_pm_driver = {
+	.driver = {
+		.name	 = "pm-davinci",
+		.owner	 = THIS_MODULE,
+	},
+	.remove = __exit_p(davinci_pm_remove),
+};
+
+static int __init davinci_pm_init(void)
+{
+	return platform_driver_probe(&davinci_pm_driver, davinci_pm_probe);
+}
+late_initcall(davinci_pm_init);
diff --git a/arch/arm/mach-davinci/sleep.S b/arch/arm/mach-davinci/sleep.S
new file mode 100644
index 0000000..fb5e72b
--- /dev/null
+++ b/arch/arm/mach-davinci/sleep.S
@@ -0,0 +1,224 @@
+/*
+ * (C) Copyright 2009, Texas Instruments, Inc. http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR /PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
+ * MA 02111-1307 USA
+ */
+
+/* replicated define because linux/bitops.h cannot be included in assembly */
+#define BIT(nr)			(1 << (nr))
+
+#include <linux/linkage.h>
+#include <asm/assembler.h>
+#include <mach/psc.h>
+#include <mach/memory.h>
+
+#include "clock.h"
+
+/* Arbitrary, hardware currently does not update PHYRDY correctly */
+#define PHYRDY_CYCLES		0x1000
+
+/* Assume 25 MHz speed for the cycle conversions since PLLs are bypassed */
+#define PLL_BYPASS_CYCLES	(PLL_BYPASS_TIME * 25)
+#define PLL_RESET_CYCLES	(PLL_RESET_TIME	* 25)
+#define PLL_LOCK_CYCLES		(PLL_LOCK_TIME * 25)
+
+#define DEEPSLEEP_SLEEPENABLE_BIT	BIT(31)
+
+	.text
+/*
+ * Move DaVinci into deep sleep state
+ *
+ * Note: This code is copied to internal SRAM by PM code. When the DaVinci
+ *	 wakes up it continues execution at the point it went to sleep.
+ * Register Usage:
+ * 	r0: contains virtual base for DDR2 controller
+ * 	r1: contains virtual base for DDR2 Power and Sleep controller (PSC)
+ * 	r2: contains PSC number for DDR2
+ * 	r3: contains virtual base DDR2 PLL controller
+ * 	r4: contains virtual address of the DEEPSLEEP register
+ */
+ENTRY(davinci_cpu_suspend)
+	stmfd	sp!, {r0-r12, lr}		@ save registers on stack
+
+	ldr 	ip, CACHE_FLUSH
+	blx	ip
+
+	ldmia	r0, {r0-r4}
+
+	/*
+	 * Switch DDR to self-refresh mode.
+	 */
+
+	/* calculate SDRCR address */
+	ldr	ip, [r0, #DDR2_SDRCR_OFFSET]
+	bic	ip, ip, #DDR2_SRPD_BIT
+	orr	ip, ip, #DDR2_LPMODEN_BIT
+	str	ip, [r0, #DDR2_SDRCR_OFFSET]
+
+	ldr	ip, [r0, #DDR2_SDRCR_OFFSET]
+	orr	ip, ip, #DDR2_MCLKSTOPEN_BIT
+	str	ip, [r0, #DDR2_SDRCR_OFFSET]
+
+       mov	ip, #PHYRDY_CYCLES
+1:     subs	ip, ip, #0x1
+       bne	1b
+
+       /* Disable DDR2 LPSC */
+	mov	r7, r0
+	mov	r0, #0x2
+	bl davinci_ddr_psc_config
+	mov	r0, r7
+
+	/* Disable clock to DDR PHY */
+	ldr	ip, [r3, #PLLDIV1]
+	bic	ip, ip, #PLLDIV_EN
+	str	ip, [r3, #PLLDIV1]
+
+	/* Put the DDR PLL in bypass and power down */
+	ldr	ip, [r3, #PLLCTL]
+	bic	ip, ip, #PLLCTL_PLLENSRC
+	bic	ip, ip, #PLLCTL_PLLEN
+	str	ip, [r3, #PLLCTL]
+
+	/* Wait for PLL to switch to bypass */
+       mov	ip, #PLL_BYPASS_CYCLES
+2:     subs	ip, ip, #0x1
+       bne	2b
+
+       /* Power down the PLL */
+	ldr	ip, [r3, #PLLCTL]
+	orr	ip, ip, #PLLCTL_PLLPWRDN
+	str	ip, [r3, #PLLCTL]
+
+	/* Go to deep sleep */
+	ldr	ip, [r4]
+	orr	ip, ip, #DEEPSLEEP_SLEEPENABLE_BIT
+	/* System goes to sleep beyond after this instruction */
+	str	ip, [r4]
+
+	/* Wake up from sleep */
+
+	/* Clear sleep enable */
+	ldr	ip, [r4]
+	bic	ip, ip, #DEEPSLEEP_SLEEPENABLE_BIT
+	str	ip, [r4]
+
+	/* initialize the DDR PLL controller */
+
+	/* Put PLL in reset */
+	ldr	ip, [r3, #PLLCTL]
+	bic	ip, ip, #PLLCTL_PLLRST
+	str	ip, [r3, #PLLCTL]
+
+	/* Clear PLL power down */
+	ldr	ip, [r3, #PLLCTL]
+	bic	ip, ip, #PLLCTL_PLLPWRDN
+	str	ip, [r3, #PLLCTL]
+
+       mov	ip, #PLL_RESET_CYCLES
+3:     subs	ip, ip, #0x1
+       bne	3b
+
+       /* Bring PLL out of reset */
+	ldr	ip, [r3, #PLLCTL]
+	orr	ip, ip, #PLLCTL_PLLRST
+	str	ip, [r3, #PLLCTL]
+
+	/* Wait for PLL to lock (assume prediv = 1, 25MHz OSCIN) */
+       mov	ip, #PLL_LOCK_CYCLES
+4:     subs	ip, ip, #0x1
+       bne	4b
+
+       /* Remove PLL from bypass mode */
+	ldr	ip, [r3, #PLLCTL]
+	bic	ip, ip, #PLLCTL_PLLENSRC
+	orr	ip, ip, #PLLCTL_PLLEN
+	str	ip, [r3, #PLLCTL]
+
+	/* Start 2x clock to DDR2 */
+
+	ldr	ip, [r3, #PLLDIV1]
+	orr	ip, ip, #PLLDIV_EN
+	str	ip, [r3, #PLLDIV1]
+
+	/* Enable VCLK */
+
+       /* Enable DDR2 LPSC */
+	mov	r7, r0
+	mov	r0, #0x3
+	bl davinci_ddr_psc_config
+	mov	r0, r7
+
+	/* clear  MCLKSTOPEN */
+
+	ldr	ip, [r0, #DDR2_SDRCR_OFFSET]
+	bic	ip, ip, #DDR2_MCLKSTOPEN_BIT
+	str	ip, [r0, #DDR2_SDRCR_OFFSET]
+
+	ldr	ip, [r0, #DDR2_SDRCR_OFFSET]
+	bic	ip, ip, #DDR2_LPMODEN_BIT
+	str	ip, [r0, #DDR2_SDRCR_OFFSET]
+
+	/* Restore registers and return */
+	ldmfd   sp!, {r0-r12, pc}
+
+ENDPROC(davinci_cpu_suspend)
+
+/*
+ * Disables or Enables DDR2 LPSC
+ * Register Usage:
+ * 	r0: Enable or Disable LPSC r0 = 0x3 => Enable, r0 = 0x2 => Disable LPSC
+ * 	r1: contains virtual base for DDR2 Power and Sleep controller (PSC)
+ * 	r2: contains PSC number for DDR2
+ */
+ENTRY(davinci_ddr_psc_config)
+	/* Set next state in mdctl for DDR2 */
+	mov	r6, #MDCTL
+	add	r6, r6, r2, lsl #2
+	ldr	ip, [r1, r6]
+	bic	ip, ip, #MDSTAT_STATE_MASK
+	orr	ip, ip, r0
+	str	ip, [r1, r6]
+
+	/* Enable the Power Domain Transition Command */
+	ldr	ip, [r1, #PTCMD]
+	orr	ip, ip, #0x1
+	str	ip, [r1, #PTCMD]
+
+	/* Check for Transition Complete (PTSTAT) */
+ptstat_done:
+	ldr	ip, [r1, #PTSTAT]
+	and	ip, ip, #0x1
+	cmp 	ip, #0x0
+	bne	ptstat_done
+
+	/* Check for DDR2 clock disable completion; */
+	mov	r6, #MDSTAT
+	add	r6, r6, r2, lsl #2
+ddr2clk_stop_done:
+	ldr	ip, [r1, r6]
+	and	ip, ip, #MDSTAT_STATE_MASK
+	cmp	ip, r0
+	bne	ddr2clk_stop_done
+
+	mov	pc, lr
+ENDPROC(davinci_ddr_psc_config)
+
+CACHE_FLUSH:
+	.word	arm926_flush_kern_cache_all
+
+ENTRY(davinci_cpu_suspend_sz)
+	.word	. - davinci_cpu_suspend
+ENDPROC(davinci_cpu_suspend_sz)
-- 
1.6.6.rc2.1.g42108
