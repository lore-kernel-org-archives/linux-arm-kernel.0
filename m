From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon,  3 Jun 2013 17:30:41 +0800
Subject: [PATCH v3 07/11] ARM: mmp: move timer registers into driver
In-Reply-To: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
References: <1370251845-31373-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1370251845-31373-8-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the definition of timer registers into timer-mmp driver.
And map timer registers in driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/include/mach/regs-timers.h | 44 ----------------------------
 drivers/clocksource/timer-mmp.c              | 38 ++++++++++++++++++++----
 2 files changed, 33 insertions(+), 49 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-timers.h

diff --git a/arch/arm/mach-mmp/include/mach/regs-timers.h b/arch/arm/mach-mmp/include/mach/regs-timers.h
deleted file mode 100644
index 45589fe..0000000
--- a/arch/arm/mach-mmp/include/mach/regs-timers.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * linux/arch/arm/mach-mmp/include/mach/regs-timers.h
- *
- *   Timers Module
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#ifndef __ASM_MACH_REGS_TIMERS_H
-#define __ASM_MACH_REGS_TIMERS_H
-
-#include <mach/addr-map.h>
-
-#define TIMERS1_VIRT_BASE	(APB_VIRT_BASE + 0x14000)
-#define TIMERS2_VIRT_BASE	(APB_VIRT_BASE + 0x16000)
-
-#define TMR_CCR		(0x0000)
-#define TMR_TN_MM(n, m)	(0x0004 + ((n) << 3) + (((n) + (m)) << 2))
-#define TMR_CR(n)	(0x0028 + ((n) << 2))
-#define TMR_SR(n)	(0x0034 + ((n) << 2))
-#define TMR_IER(n)	(0x0040 + ((n) << 2))
-#define TMR_PLVR(n)	(0x004c + ((n) << 2))
-#define TMR_PLCR(n)	(0x0058 + ((n) << 2))
-#define TMR_WMER	(0x0064)
-#define TMR_WMR		(0x0068)
-#define TMR_WVR		(0x006c)
-#define TMR_WSR		(0x0070)
-#define TMR_ICR(n)	(0x0074 + ((n) << 2))
-#define TMR_WICR	(0x0080)
-#define TMR_CER		(0x0084)
-#define TMR_CMR		(0x0088)
-#define TMR_ILR(n)	(0x008c + ((n) << 2))
-#define TMR_WCR		(0x0098)
-#define TMR_WFAR	(0x009c)
-#define TMR_WSAR	(0x00A0)
-#define TMR_CVWR(n)	(0x00A4 + ((n) << 2))
-
-#define TMR_CCR_CS_0(x)	(((x) & 0x3) << 0)
-#define TMR_CCR_CS_1(x)	(((x) & 0x7) << 2)
-#define TMR_CCR_CS_2(x)	(((x) & 0x3) << 5)
-
-#endif /* __ASM_MACH_REGS_TIMERS_H */
diff --git a/drivers/clocksource/timer-mmp.c b/drivers/clocksource/timer-mmp.c
index 553e3de..75cc961 100644
--- a/drivers/clocksource/timer-mmp.c
+++ b/drivers/clocksource/timer-mmp.c
@@ -30,19 +30,44 @@
 #include <linux/of_irq.h>
 
 #include <asm/sched_clock.h>
-#include <mach/addr-map.h>
-#include <mach/regs-timers.h>
-#include <mach/regs-apbc.h>
 #include <mach/irqs.h>
 #include <mach/cputype.h>
 #include <asm/mach/time.h>
 
-#define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
+#define TMR_CCR		(0x0000)
+#define TMR_TN_MM(n, m)	(0x0004 + ((n) << 3) + (((n) + (m)) << 2))
+#define TMR_CR(n)	(0x0028 + ((n) << 2))
+#define TMR_SR(n)	(0x0034 + ((n) << 2))
+#define TMR_IER(n)	(0x0040 + ((n) << 2))
+#define TMR_PLVR(n)	(0x004c + ((n) << 2))
+#define TMR_PLCR(n)	(0x0058 + ((n) << 2))
+#define TMR_WMER	(0x0064)
+#define TMR_WMR		(0x0068)
+#define TMR_WVR		(0x006c)
+#define TMR_WSR		(0x0070)
+#define TMR_ICR(n)	(0x0074 + ((n) << 2))
+#define TMR_WICR	(0x0080)
+#define TMR_CER		(0x0084)
+#define TMR_CMR		(0x0088)
+#define TMR_ILR(n)	(0x008c + ((n) << 2))
+#define TMR_WCR		(0x0098)
+#define TMR_WFAR	(0x009c)
+#define TMR_WSAR	(0x00A0)
+#define TMR_CVWR(n)	(0x00A4 + ((n) << 2))
+
+#define TMR_CCR_CS_0(x)	(((x) & 0x3) << 0)
+#define TMR_CCR_CS_1(x)	(((x) & 0x7) << 2)
+#define TMR_CCR_CS_2(x)	(((x) & 0x3) << 5)
+
+#define TIMERS1_PHY_BASE	(0xd4000000 + 0x14000)
+#define TIMERS2_PHY_BASE	(0xd4000000 + 0x16000)
+
+#define TIMERS_PHY_BASE		TIMERS1_PHY_BASE
 
 #define MAX_DELTA		(0xfffffffe)
 #define MIN_DELTA		(16)
 
-static void __iomem *mmp_timer_base = TIMERS_VIRT_BASE;
+static void __iomem *mmp_timer_base;
 
 /*
  * FIXME: the timer needs some delay to stablize the counter capture
@@ -191,6 +216,9 @@ static struct irqaction timer_irq = {
 
 void __init timer_init(int irq)
 {
+	mmp_timer_base = ioremap(TIMERS_PHY_BASE, PAGE_SIZE);
+	BUG_ON(!mmp_timer_base);
+
 	timer_config();
 
 	setup_sched_clock(mmp_read_sched_clock, 32, CLOCK_TICK_RATE);
-- 
1.8.1.2
