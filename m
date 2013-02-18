From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 18 Feb 2013 13:43:39 +0530
Subject: [PATCH 1/7] ARM: Exynos: add a register base address variable in mct
 controller driver
In-Reply-To: <1361175225-19282-1-git-send-email-thomas.abraham@linaro.org>
References: <1361175225-19282-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <1361175225-19282-2-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the MCT register read/writes use a fixed remapped address S5P_VA_SYSTIMER.
With device tree support for MCT controller, it is possible to remove the
static remap of the MCT controller address space and do the remap during the
initialization of the MCT controller with the physical address obtained from
the device tree.

So in preparation of adding device tree support for MCT controller, add a new
register base address variable that will hold the remapped MCT controller base
address and convert all MCT register read/writes to use this new variable as
the base address instead of the fixed S5P_VA_SYSTIMER.

While at it, the MCT register offset and bit mask definitions are moved into
the MCT controller driver file since there are no other consumers of these
definitions.

Cc: Changhwan Youn <chaos.youn@samsung.com>
Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 arch/arm/mach-exynos/include/mach/regs-mct.h |   53 --------------
 arch/arm/mach-exynos/mct.c                   |   97 ++++++++++++++++---------
 2 files changed, 62 insertions(+), 88 deletions(-)
 delete mode 100644 arch/arm/mach-exynos/include/mach/regs-mct.h

diff --git a/arch/arm/mach-exynos/include/mach/regs-mct.h b/arch/arm/mach-exynos/include/mach/regs-mct.h
deleted file mode 100644
index 80dd02a..0000000
--- a/arch/arm/mach-exynos/include/mach/regs-mct.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* arch/arm/mach-exynos4/include/mach/regs-mct.h
- *
- * Copyright (c) 2011 Samsung Electronics Co., Ltd.
- *		http://www.samsung.com
- *
- * EXYNOS4 MCT configutation
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
-*/
-
-#ifndef __ASM_ARCH_REGS_MCT_H
-#define __ASM_ARCH_REGS_MCT_H __FILE__
-
-#include <mach/map.h>
-
-#define EXYNOS4_MCTREG(x)		(S5P_VA_SYSTIMER + (x))
-
-#define EXYNOS4_MCT_G_CNT_L		EXYNOS4_MCTREG(0x100)
-#define EXYNOS4_MCT_G_CNT_U		EXYNOS4_MCTREG(0x104)
-#define EXYNOS4_MCT_G_CNT_WSTAT		EXYNOS4_MCTREG(0x110)
-
-#define EXYNOS4_MCT_G_COMP0_L		EXYNOS4_MCTREG(0x200)
-#define EXYNOS4_MCT_G_COMP0_U		EXYNOS4_MCTREG(0x204)
-#define EXYNOS4_MCT_G_COMP0_ADD_INCR	EXYNOS4_MCTREG(0x208)
-
-#define EXYNOS4_MCT_G_TCON		EXYNOS4_MCTREG(0x240)
-
-#define EXYNOS4_MCT_G_INT_CSTAT		EXYNOS4_MCTREG(0x244)
-#define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
-#define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
-
-#define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
-#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
-#define EXYNOS4_MCT_L_MASK		(0xffffff00)
-
-#define MCT_L_TCNTB_OFFSET		(0x00)
-#define MCT_L_ICNTB_OFFSET		(0x08)
-#define MCT_L_TCON_OFFSET		(0x20)
-#define MCT_L_INT_CSTAT_OFFSET		(0x30)
-#define MCT_L_INT_ENB_OFFSET		(0x34)
-#define MCT_L_WSTAT_OFFSET		(0x40)
-
-#define MCT_G_TCON_START		(1 << 8)
-#define MCT_G_TCON_COMP0_AUTO_INC	(1 << 1)
-#define MCT_G_TCON_COMP0_ENABLE		(1 << 0)
-
-#define MCT_L_TCON_INTERVAL_MODE	(1 << 2)
-#define MCT_L_TCON_INT_START		(1 << 1)
-#define MCT_L_TCON_TIMER_START		(1 << 0)
-
-#endif /* __ASM_ARCH_REGS_MCT_H */
diff --git a/arch/arm/mach-exynos/mct.c b/arch/arm/mach-exynos/mct.c
index 577ee1b..e3d67ec 100644
--- a/arch/arm/mach-exynos/mct.c
+++ b/arch/arm/mach-exynos/mct.c
@@ -29,9 +29,36 @@
 
 #include <mach/map.h>
 #include <mach/irqs.h>
-#include <mach/regs-mct.h>
 #include <asm/mach/time.h>
 
+#define EXYNOS4_MCTREG(x)		(x)
+#define EXYNOS4_MCT_G_CNT_L		EXYNOS4_MCTREG(0x100)
+#define EXYNOS4_MCT_G_CNT_U		EXYNOS4_MCTREG(0x104)
+#define EXYNOS4_MCT_G_CNT_WSTAT		EXYNOS4_MCTREG(0x110)
+#define EXYNOS4_MCT_G_COMP0_L		EXYNOS4_MCTREG(0x200)
+#define EXYNOS4_MCT_G_COMP0_U		EXYNOS4_MCTREG(0x204)
+#define EXYNOS4_MCT_G_COMP0_ADD_INCR	EXYNOS4_MCTREG(0x208)
+#define EXYNOS4_MCT_G_TCON		EXYNOS4_MCTREG(0x240)
+#define EXYNOS4_MCT_G_INT_CSTAT		EXYNOS4_MCTREG(0x244)
+#define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
+#define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
+#define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
+#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
+#define EXYNOS4_MCT_L_MASK		(0xffffff00)
+
+#define MCT_L_TCNTB_OFFSET		(0x00)
+#define MCT_L_ICNTB_OFFSET		(0x08)
+#define MCT_L_TCON_OFFSET		(0x20)
+#define MCT_L_INT_CSTAT_OFFSET		(0x30)
+#define MCT_L_INT_ENB_OFFSET		(0x34)
+#define MCT_L_WSTAT_OFFSET		(0x40)
+#define MCT_G_TCON_START		(1 << 8)
+#define MCT_G_TCON_COMP0_AUTO_INC	(1 << 1)
+#define MCT_G_TCON_COMP0_ENABLE		(1 << 0)
+#define MCT_L_TCON_INTERVAL_MODE	(1 << 2)
+#define MCT_L_TCON_INT_START		(1 << 1)
+#define MCT_L_TCON_TIMER_START		(1 << 0)
+
 #define TICK_BASE_CNT	1
 
 enum {
@@ -39,64 +66,62 @@ enum {
 	MCT_INT_PPI
 };
 
+static void __iomem *reg_base;
 static unsigned long clk_rate;
 static unsigned int mct_int_type;
 
 struct mct_clock_event_device {
 	struct clock_event_device *evt;
-	void __iomem *base;
+	unsigned long base;
 	char name[10];
 };
 
-static void exynos4_mct_write(unsigned int value, void *addr)
+static void exynos4_mct_write(unsigned int value, unsigned long offset)
 {
-	void __iomem *stat_addr;
+	unsigned long stat_addr;
 	u32 mask;
 	u32 i;
 
-	__raw_writel(value, addr);
+	__raw_writel(value, reg_base + offset);
 
-	if (likely(addr >= EXYNOS4_MCT_L_BASE(0))) {
-		u32 base = (u32) addr & EXYNOS4_MCT_L_MASK;
-		switch ((u32) addr & ~EXYNOS4_MCT_L_MASK) {
-		case (u32) MCT_L_TCON_OFFSET:
-			stat_addr = (void __iomem *) base + MCT_L_WSTAT_OFFSET;
+	if (likely(offset >= EXYNOS4_MCT_L_BASE(0))) {
+		stat_addr = (offset & ~EXYNOS4_MCT_L_MASK) + MCT_L_WSTAT_OFFSET;
+		switch (offset & EXYNOS4_MCT_L_MASK) {
+		case MCT_L_TCON_OFFSET:
 			mask = 1 << 3;		/* L_TCON write status */
 			break;
-		case (u32) MCT_L_ICNTB_OFFSET:
-			stat_addr = (void __iomem *) base + MCT_L_WSTAT_OFFSET;
+		case MCT_L_ICNTB_OFFSET:
 			mask = 1 << 1;		/* L_ICNTB write status */
 			break;
-		case (u32) MCT_L_TCNTB_OFFSET:
-			stat_addr = (void __iomem *) base + MCT_L_WSTAT_OFFSET;
+		case MCT_L_TCNTB_OFFSET:
 			mask = 1 << 0;		/* L_TCNTB write status */
 			break;
 		default:
 			return;
 		}
 	} else {
-		switch ((u32) addr) {
-		case (u32) EXYNOS4_MCT_G_TCON:
+		switch (offset) {
+		case EXYNOS4_MCT_G_TCON:
 			stat_addr = EXYNOS4_MCT_G_WSTAT;
 			mask = 1 << 16;		/* G_TCON write status */
 			break;
-		case (u32) EXYNOS4_MCT_G_COMP0_L:
+		case EXYNOS4_MCT_G_COMP0_L:
 			stat_addr = EXYNOS4_MCT_G_WSTAT;
 			mask = 1 << 0;		/* G_COMP0_L write status */
 			break;
-		case (u32) EXYNOS4_MCT_G_COMP0_U:
+		case EXYNOS4_MCT_G_COMP0_U:
 			stat_addr = EXYNOS4_MCT_G_WSTAT;
 			mask = 1 << 1;		/* G_COMP0_U write status */
 			break;
-		case (u32) EXYNOS4_MCT_G_COMP0_ADD_INCR:
+		case EXYNOS4_MCT_G_COMP0_ADD_INCR:
 			stat_addr = EXYNOS4_MCT_G_WSTAT;
 			mask = 1 << 2;		/* G_COMP0_ADD_INCR w status */
 			break;
-		case (u32) EXYNOS4_MCT_G_CNT_L:
+		case EXYNOS4_MCT_G_CNT_L:
 			stat_addr = EXYNOS4_MCT_G_CNT_WSTAT;
 			mask = 1 << 0;		/* G_CNT_L write status */
 			break;
-		case (u32) EXYNOS4_MCT_G_CNT_U:
+		case EXYNOS4_MCT_G_CNT_U:
 			stat_addr = EXYNOS4_MCT_G_CNT_WSTAT;
 			mask = 1 << 1;		/* G_CNT_U write status */
 			break;
@@ -107,12 +132,12 @@ static void exynos4_mct_write(unsigned int value, void *addr)
 
 	/* Wait maximum 1 ms until written values are applied */
 	for (i = 0; i < loops_per_jiffy / 1000 * HZ; i++)
-		if (__raw_readl(stat_addr) & mask) {
-			__raw_writel(mask, stat_addr);
+		if (__raw_readl(reg_base + stat_addr) & mask) {
+			__raw_writel(mask, reg_base + stat_addr);
 			return;
 		}
 
-	panic("MCT hangs after writing %d (addr:0x%08x)\n", value, (u32)addr);
+	panic("MCT hangs after writing %d (offset:0x%lx)\n", value, offset);
 }
 
 /* Clocksource handling */
@@ -123,7 +148,7 @@ static void exynos4_mct_frc_start(u32 hi, u32 lo)
 	exynos4_mct_write(lo, EXYNOS4_MCT_G_CNT_L);
 	exynos4_mct_write(hi, EXYNOS4_MCT_G_CNT_U);
 
-	reg = __raw_readl(EXYNOS4_MCT_G_TCON);
+	reg = __raw_readl(reg_base + EXYNOS4_MCT_G_TCON);
 	reg |= MCT_G_TCON_START;
 	exynos4_mct_write(reg, EXYNOS4_MCT_G_TCON);
 }
@@ -131,12 +156,12 @@ static void exynos4_mct_frc_start(u32 hi, u32 lo)
 static cycle_t exynos4_frc_read(struct clocksource *cs)
 {
 	unsigned int lo, hi;
-	u32 hi2 = __raw_readl(EXYNOS4_MCT_G_CNT_U);
+	u32 hi2 = __raw_readl(reg_base + EXYNOS4_MCT_G_CNT_U);
 
 	do {
 		hi = hi2;
-		lo = __raw_readl(EXYNOS4_MCT_G_CNT_L);
-		hi2 = __raw_readl(EXYNOS4_MCT_G_CNT_U);
+		lo = __raw_readl(reg_base + EXYNOS4_MCT_G_CNT_L);
+		hi2 = __raw_readl(reg_base + EXYNOS4_MCT_G_CNT_U);
 	} while (hi != hi2);
 
 	return ((cycle_t)hi << 32) | lo;
@@ -168,7 +193,7 @@ static void exynos4_mct_comp0_stop(void)
 {
 	unsigned int tcon;
 
-	tcon = __raw_readl(EXYNOS4_MCT_G_TCON);
+	tcon = __raw_readl(reg_base + EXYNOS4_MCT_G_TCON);
 	tcon &= ~(MCT_G_TCON_COMP0_ENABLE | MCT_G_TCON_COMP0_AUTO_INC);
 
 	exynos4_mct_write(tcon, EXYNOS4_MCT_G_TCON);
@@ -181,7 +206,7 @@ static void exynos4_mct_comp0_start(enum clock_event_mode mode,
 	unsigned int tcon;
 	cycle_t comp_cycle;
 
-	tcon = __raw_readl(EXYNOS4_MCT_G_TCON);
+	tcon = __raw_readl(reg_base + EXYNOS4_MCT_G_TCON);
 
 	if (mode == CLOCK_EVT_MODE_PERIODIC) {
 		tcon |= MCT_G_TCON_COMP0_AUTO_INC;
@@ -274,12 +299,12 @@ static void exynos4_mct_tick_stop(struct mct_clock_event_device *mevt)
 {
 	unsigned long tmp;
 	unsigned long mask = MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START;
-	void __iomem *addr = mevt->base + MCT_L_TCON_OFFSET;
+	unsigned long offset = mevt->base + MCT_L_TCON_OFFSET;
 
-	tmp = __raw_readl(addr);
+	tmp = __raw_readl(reg_base + offset);
 	if (tmp & mask) {
 		tmp &= ~mask;
-		exynos4_mct_write(tmp, addr);
+		exynos4_mct_write(tmp, offset);
 	}
 }
 
@@ -298,7 +323,7 @@ static void exynos4_mct_tick_start(unsigned long cycles,
 	/* enable MCT tick interrupt */
 	exynos4_mct_write(0x1, mevt->base + MCT_L_INT_ENB_OFFSET);
 
-	tmp = __raw_readl(mevt->base + MCT_L_TCON_OFFSET);
+	tmp = __raw_readl(reg_base + mevt->base + MCT_L_TCON_OFFSET);
 	tmp |= MCT_L_TCON_INT_START | MCT_L_TCON_TIMER_START |
 	       MCT_L_TCON_INTERVAL_MODE;
 	exynos4_mct_write(tmp, mevt->base + MCT_L_TCON_OFFSET);
@@ -350,7 +375,7 @@ static int exynos4_mct_tick_clear(struct mct_clock_event_device *mevt)
 		exynos4_mct_tick_stop(mevt);
 
 	/* Clear the MCT tick interrupt */
-	if (__raw_readl(mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1) {
+	if (__raw_readl(reg_base + mevt->base + MCT_L_INT_CSTAT_OFFSET) & 1) {
 		exynos4_mct_write(0x1, mevt->base + MCT_L_INT_CSTAT_OFFSET);
 		return 1;
 	} else {
@@ -453,6 +478,8 @@ static void __init exynos4_timer_resources(void)
 
 	clk_rate = clk_get_rate(mct_clk);
 
+	reg_base = S5P_VA_SYSTIMER;
+
 #ifdef CONFIG_LOCAL_TIMERS
 	if (mct_int_type == MCT_INT_PPI) {
 		int err;
-- 
1.7.5.4
