From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Jul 2013 18:05:29 +0800
Subject: [PATCH v6 07/11] ARM: mmp: move timer registers into driver
In-Reply-To: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
References: <1374833133-21119-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1374833133-21119-8-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the definition of timer registers into timer-mmp driver.
And map timer registers in driver.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 arch/arm/mach-mmp/common.h                   |  2 +-
 arch/arm/mach-mmp/include/mach/addr-map.h    |  3 ++
 arch/arm/mach-mmp/include/mach/regs-timers.h | 44 ----------------------------
 arch/arm/mach-mmp/mmp2.c                     |  2 +-
 arch/arm/mach-mmp/pxa168.c                   |  2 +-
 arch/arm/mach-mmp/pxa910.c                   |  2 +-
 drivers/clocksource/timer-mmp.c              | 37 ++++++++++++++++++-----
 7 files changed, 37 insertions(+), 55 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-timers.h

diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index cf445ba..22e67c6 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -1,7 +1,7 @@
 #include <linux/reboot.h>
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
-extern void timer_init(int irq);
+extern void timer_init(void __iomem *base, int irq);
 
 extern void __init mmp_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-mmp/include/mach/addr-map.h b/arch/arm/mach-mmp/include/mach/addr-map.h
index f88a44c..169c280 100644
--- a/arch/arm/mach-mmp/include/mach/addr-map.h
+++ b/arch/arm/mach-mmp/include/mach/addr-map.h
@@ -43,4 +43,7 @@
 #define CIU_VIRT_BASE		(AXI_VIRT_BASE + 0x82c00)
 #define CIU_REG(x)		(CIU_VIRT_BASE + (x))
 
+#define TIMER1_VIRT_BASE	(APB_VIRT_BASE + 0x14000)
+#define TIMER2_VIRT_BASE	(APB_VIRT_BASE + 0x16000)
+
 #endif /* __ASM_MACH_ADDR_MAP_H */
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
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index 09fbe7d..f26ea9d 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -131,7 +131,7 @@ void __init mmp2_timer_init(void)
 	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
 	__raw_writel(clk_rst, APBC_TIMERS);
 
-	timer_init(IRQ_MMP2_TIMER1);
+	timer_init(TIMER1_VIRT_BASE, IRQ_MMP2_TIMER1);
 }
 
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 144e997..b6b3d5b 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -78,7 +78,7 @@ void __init pxa168_timer_init(void)
 	/* 3.25MHz, bus/functional clock enabled, release reset */
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA168_TIMER1);
+	timer_init(TIMER1_VIRT_BASE, IRQ_PXA168_TIMER1);
 }
 
 void pxa168_clear_keypad_wakeup(void)
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 96e125b..df379c2 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -112,7 +112,7 @@ void __init pxa910_timer_init(void)
 	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA910_AP1_TIMER1);
+	timer_init(TIMER1_VIRT_BASE, IRQ_PXA910_AP1_TIMER1);
 }
 
 /* on-chip devices */
diff --git a/drivers/clocksource/timer-mmp.c b/drivers/clocksource/timer-mmp.c
index ddc1b15..937d51e 100644
--- a/drivers/clocksource/timer-mmp.c
+++ b/drivers/clocksource/timer-mmp.c
@@ -30,19 +30,39 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
 
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
 
 #define MAX_DELTA		(0xfffffffe)
 #define MIN_DELTA		(16)
 
-static void __iomem *mmp_timer_base = TIMERS_VIRT_BASE;
+static void __iomem *mmp_timer_base;
 
 /*
  * FIXME: the timer needs some delay to stablize the counter capture
@@ -189,8 +209,11 @@ static struct irqaction timer_irq = {
 	.dev_id		= &ckevt,
 };
 
-void __init timer_init(int irq)
+void __init timer_init(void __iomem *base, int irq)
 {
+	BUG_ON(!base);
+	mmp_timer_base = base;
+
 	timer_config();
 
 	setup_sched_clock(mmp_read_sched_clock, 32, CLOCK_TICK_RATE);
@@ -231,7 +254,7 @@ void __init mmp_dt_init_timer(void)
 		ret = -ENOMEM;
 		goto out;
 	}
-	timer_init(irq);
+	timer_init(mmp_timer_base, irq);
 	return;
 out:
 	pr_err("Failed to get timer from device tree with error:%d\n", ret);
-- 
1.8.1.2
