From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  1 Apr 2011 10:39:25 +0800
Subject: [PATCH 6/9] ARM: mmp: update the reset implementation
In-Reply-To: <1301625568-16583-5-git-send-email-haojian.zhuang@marvell.com>
References: <040101>
	<1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-3-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-4-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1301625568-16583-6-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both PXA910 and MMP2 need watchdog reset, so add these features.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/Makefile                   |    2 +-
 arch/arm/mach-mmp/include/mach/regs-mpmu.h   |   52 +++++++++++++
 arch/arm/mach-mmp/include/mach/regs-timers.h |    2 +
 arch/arm/mach-mmp/include/mach/system.h      |    8 +--
 arch/arm/mach-mmp/reset.c                    |  100 ++++++++++++++++++++++++++
 5 files changed, 156 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/regs-mpmu.h
 create mode 100644 arch/arm/mach-mmp/reset.c

diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
index 5c68382..6043f31 100644
--- a/arch/arm/mach-mmp/Makefile
+++ b/arch/arm/mach-mmp/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Marvell's PXA168 processors line
 #
 
-obj-y				+= common.o clock.o devices.o time.o
+obj-y				+= common.o clock.o devices.o time.o reset.o
 
 # SoC support
 obj-$(CONFIG_CPU_PXA168)	+= pxa168.o irq-pxa168.o
diff --git a/arch/arm/mach-mmp/include/mach/regs-mpmu.h b/arch/arm/mach-mmp/include/mach/regs-mpmu.h
new file mode 100644
index 0000000..e2fdc4e
--- /dev/null
+++ b/arch/arm/mach-mmp/include/mach/regs-mpmu.h
@@ -0,0 +1,52 @@
+/*
+ * linux/arch/arm/mach-mmp/include/mach/regs-mpmu.h
+ *
+ *   Main Power Management Unit
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __ASM_MACH_REGS_MPMU_H
+#define __ASM_MACH_REGS_MPMU_H
+
+#include <mach/addr-map.h>
+
+#define MPMU_VIRT_BASE		(APB_VIRT_BASE + 0x50000)
+#define MPMU_REG(off)		(MPMU_VIRT_BASE + (off))
+
+#define MPMU_CPCR		MPMU_REG(0x0000)
+#define MPMU_FCCR		MPMU_REG(0x0008)
+#define MPMU_POCR		MPMU_REG(0x000c)
+#define MPMU_POSR		MPMU_REG(0x0010)
+#define MPMU_SUCCR		MPMU_REG(0x0014)
+#define MPMU_VRCR		MPMU_REG(0x0018)
+#define MPMU_OHCR		MPMU_REG(0x001c)
+#define MPMU_CPRR		MPMU_REG(0x0020)
+#define MPMU_CCGR		MPMU_REG(0x0024)
+#define MPMU_GPCR		MPMU_REG(0x0030)
+#define MPMU_PLL2CR		MPMU_REG(0x0034)
+#define MPMU_SCCR		MPMU_REG(0x0038)
+#define MPMU_ISCCRX0		MPMU_REG(0x0040)
+#define MPMU_ISCCRX1		MPMU_REG(0x0044)
+#define MPMU_CWUCRM		MPMU_REG(0x004c)
+#define MPMU_PLL1_REG1		MPMU_REG(0x0050)
+#define MPMU_PLL1_REG2		MPMU_REG(0x0054)
+#define MPMU_PLL1_SSC		MPMU_REG(0x0058)
+#define MPMU_PLL2_REG1		MPMU_REG(0x0060)
+#define MPMU_PLL2_REG2		MPMU_REG(0x0064)
+#define MPMU_PLL2_SSC		MPMU_REG(0x0068)
+#define MPMU_SD_ROT_WAKE_CLR	MPMU_REG(0x007c)
+#define MPMU_PLL2_CTRL1		MPMU_REG(0x0414)
+#define MPMU_TS			MPMU_REG(0x0080)
+#define MPMU_WDTPCR		MPMU_REG(0x0200)
+#define MPMU_APCR		MPMU_REG(0x1000)
+#define MPMU_APSR		MPMU_REG(0x1004)
+#define MPMU_APRR		MPMU_REG(0x1020)
+#define MPMU_ACGR		MPMU_REG(0x1024)
+#define MPMU_ARSR		MPMU_REG(0x1028)
+#define MPMU_AWUCRS		MPMU_REG(0x1048)
+#define MPMU_AWUCRM		MPMU_REG(0x104c)
+
+#endif /* __ASM_MACH_REGS_MPMU_H */
diff --git a/arch/arm/mach-mmp/include/mach/regs-timers.h b/arch/arm/mach-mmp/include/mach/regs-timers.h
index 45589fe..17f56fe 100644
--- a/arch/arm/mach-mmp/include/mach/regs-timers.h
+++ b/arch/arm/mach-mmp/include/mach/regs-timers.h
@@ -15,6 +15,8 @@
 
 #define TIMERS1_VIRT_BASE	(APB_VIRT_BASE + 0x14000)
 #define TIMERS2_VIRT_BASE	(APB_VIRT_BASE + 0x16000)
+#define CP_TIMERS2_VIRT_BASE	(APB_VIRT_BASE + 0x80000)
+#define MMP2_TIMERS2_VIRT_BASE	(APB_VIRT_BASE + 0x80000)
 
 #define TMR_CCR		(0x0000)
 #define TMR_TN_MM(n, m)	(0x0004 + ((n) << 3) + (((n) + (m)) << 2))
diff --git a/arch/arm/mach-mmp/include/mach/system.h b/arch/arm/mach-mmp/include/mach/system.h
index 1a8a25e..31e15cf 100644
--- a/arch/arm/mach-mmp/include/mach/system.h
+++ b/arch/arm/mach-mmp/include/mach/system.h
@@ -16,11 +16,5 @@ static inline void arch_idle(void)
 	cpu_do_idle();
 }
 
-static inline void arch_reset(char mode, const char *cmd)
-{
-	if (cpu_is_pxa168())
-		cpu_reset(0xffff0000);
-	else
-		cpu_reset(0);
-}
+extern void arch_reset(char mode, const char *cmd);
 #endif /* __ASM_MACH_SYSTEM_H */
diff --git a/arch/arm/mach-mmp/reset.c b/arch/arm/mach-mmp/reset.c
new file mode 100644
index 0000000..57fa65e
--- /dev/null
+++ b/arch/arm/mach-mmp/reset.c
@@ -0,0 +1,100 @@
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <mach/regs-mpmu.h>
+#include <mach/regs-timers.h>
+#include <mach/cputype.h>
+#include <linux/delay.h>
+
+#define REG_RTC_BR0     	(APB_VIRT_BASE + 0x010014)
+
+#define MPMU_APRR_CPR   	(1 << 0)
+#define MPMU_APRR_WDTR  	(1 << 4)
+#define MPMU_CPRR_DSPR  	(1 << 2)
+#define MPMU_CPRR_BBR   	(1 << 3)
+
+static void do_wdt_reset(const char *cmd)
+{
+	unsigned int reg, backup;
+	unsigned int watchdog_virt_base;
+	int i;
+	int match = 0, count = 0;
+
+	if (cpu_is_pxa910())
+		watchdog_virt_base = CP_TIMERS2_VIRT_BASE;
+	else if (cpu_is_pxa168())
+		watchdog_virt_base = TIMERS1_VIRT_BASE;
+	else if (cpu_is_mmp2())
+		watchdog_virt_base = MMP2_TIMERS2_VIRT_BASE;
+	else
+		return;
+
+	/* reset/enable WDT clock */
+	writel(0x7, MPMU_WDTPCR);
+	readl(MPMU_WDTPCR);
+	writel(0x3, MPMU_WDTPCR);
+	readl(MPMU_WDTPCR);
+
+	if (cpu_is_pxa910()) {
+		/* stores recovery flag into RTC register */
+		if (cmd && !strcmp(cmd, "recovery")) {
+			for (i = 0, backup = 0; i < 4; i++) {
+				backup <<= 8;
+				backup |= *(cmd + i);
+			}
+			do {
+				writel(backup, REG_RTC_BR0);
+			} while (readl(REG_RTC_BR0) != backup);
+		}
+	}
+
+	/* enable WDT reset */
+	writel(0xbaba, watchdog_virt_base + TMR_WFAR);
+	writel(0xeb10, watchdog_virt_base + TMR_WSAR);
+	writel(0x3, watchdog_virt_base + TMR_WMER);
+
+	if (cpu_is_pxa910()) {
+		/*hold CP first */
+		reg = readl(MPMU_APRR) | MPMU_APRR_CPR;
+		writel(reg, MPMU_APRR);
+		udelay(10);
+		/*CP reset MSA */
+		reg = readl(MPMU_CPRR) | MPMU_CPRR_DSPR | MPMU_CPRR_BBR;
+		writel(reg, MPMU_CPRR);
+		udelay(10);
+	}
+	/* negate hardware reset to the WDT after system reset */
+	reg = readl(MPMU_APRR) | MPMU_APRR_WDTR;
+	writel(reg, MPMU_APRR);
+
+	/* clear previous WDT status */
+	writel(0xbaba, watchdog_virt_base + TMR_WFAR);
+	writel(0xeb10, watchdog_virt_base + TMR_WSAR);
+	writel(0, watchdog_virt_base + TMR_WSR);
+
+	match = readl(watchdog_virt_base + TMR_WMR);
+	count = readl(watchdog_virt_base + TMR_WVR);
+
+	if (match - count > 0x20) {
+		/* set match counter */
+		writel(0xbaba, watchdog_virt_base + TMR_WFAR);
+		writel(0xeb10, watchdog_virt_base + TMR_WSAR);
+		writel(0x20 + count, watchdog_virt_base + TMR_WMR);
+	}
+}
+
+void arch_reset(char mode, const char *cmd)
+{
+	switch (mode) {
+	case 's':
+		/* Jump into ROM */
+		if (cpu_is_pxa168()) {
+			cpu_reset(0xffff0000);
+			break;
+		}
+	case 'w':
+	default:
+		do_wdt_reset(cmd);
+		break;
+	}
+}
-- 
1.5.6.5
