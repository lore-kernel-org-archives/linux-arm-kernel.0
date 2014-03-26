From: chao.xie@marvell.com (Chao Xie)
Date: Wed, 26 Mar 2014 12:52:41 +0800
Subject: [PATCH 2/4] arm: mmp: make SOCes without DT use new timer driver
In-Reply-To: <1395809563-31872-1-git-send-email-chao.xie@marvell.com>
References: <1395809563-31872-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1395809563-31872-3-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

For no DT support, directly call new timer's APIs to initialize
timer.
It need to initialize the timer first, then initialize the clock
event device or clock source which are based on counter.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mach-mmp/common.h |  2 --
 arch/arm/mach-mmp/mmp2.c   | 23 ++++++++++++++++++++++-
 arch/arm/mach-mmp/pxa168.c | 23 ++++++++++++++++++++++-
 arch/arm/mach-mmp/pxa910.c | 24 +++++++++++++++++++++++-
 4 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index cf445ba..015b209 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -1,8 +1,6 @@
 #include <linux/reboot.h>
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
-extern void timer_init(int irq);
-
 extern void __init mmp_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
 extern void __init pxa168_clk_init(void);
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index a70b553..57f7206 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -16,12 +16,14 @@
 #include <linux/irq.h>
 #include <linux/irqchip/mmp.h>
 #include <linux/platform_device.h>
+#include <linux/mmp_timer.h>
 
 #include <asm/hardware/cache-tauros2.h>
 
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
+#include <mach/regs-timers.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
 #include <mach/dma.h>
@@ -133,7 +135,26 @@ void __init mmp2_timer_init(void)
 	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
 	__raw_writel(clk_rst, APBC_TIMERS);
 
-	timer_init(IRQ_MMP2_TIMER1);
+	/*
+	 * Make use of timer 1 which id is 0.
+	 * It has no shadow and crsr regsiters.
+	 * The fast lock is 6.5M.
+	 * apb bus is 26M.
+	 */
+	mmp_timer_init(0, TIMERS1_VIRT_BASE, 0, 6500000, 26000000);
+
+	/*
+	 * Enable counter 1 to be clock source.
+	 * The frequency is 32K.
+	 */
+	mmp_counter_clocksource_init(0, 1, 200, 32768);
+
+	/*
+	 * Enable counter 0 to be clock event device.
+	 * The frequency is 32K.
+	 * Only one cpu and there is no broadcast timer.
+	 */
+	mmp_counter_clockevent_init(0, 0, 200, IRQ_MMP2_TIMER1, 32768, 0, 0);
 }
 
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 144e997..015b7355 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 #include <linux/platform_data/mv_usb.h>
+#include <linux/mmp_timer.h>
 
 #include <asm/mach/time.h>
 #include <asm/system_misc.h>
@@ -22,6 +23,7 @@
 #include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
 #include <mach/regs-apmu.h>
+#include <mach/regs-timers.h>
 #include <mach/irqs.h>
 #include <mach/dma.h>
 #include <mach/devices.h>
@@ -78,7 +80,26 @@ void __init pxa168_timer_init(void)
 	/* 3.25MHz, bus/functional clock enabled, release reset */
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA168_TIMER1);
+	/*
+	 * Make use of timer 1 which id is 0.
+	 * It has no shadow and crsr regsiters.
+	 * The fast lock is 3.25M.
+	 * apb bus is 26M.
+	 */
+	mmp_timer_init(0, TIMERS1_VIRT_BASE, 0, 3250000, 26000000);
+
+	/*
+	 * Enable counter 1 to be clock source.
+	 * The frequency is 32K.
+	 */
+	mmp_counter_clocksource_init(0, 1, 200, 32768);
+
+	/*
+	 * Enable counter 0 to be clock event device.
+	 * The frequency is 32K.
+	 * Only one cpu and there is no broadcast timer.
+	 */
+	mmp_counter_clockevent_init(0, 0, 200, IRQ_PXA168_TIMER1, 32768, 0, 0);
 }
 
 void pxa168_clear_keypad_wakeup(void)
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index eb57ee1..98a4307 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -15,11 +15,13 @@
 #include <linux/irq.h>
 #include <linux/irqchip/mmp.h>
 #include <linux/platform_device.h>
+#include <linux/mmp_timer.h>
 
 #include <asm/hardware/cache-tauros2.h>
 #include <asm/mach/time.h>
 #include <mach/addr-map.h>
 #include <mach/regs-apbc.h>
+#include <mach/regs-timers.h>
 #include <mach/cputype.h>
 #include <mach/irqs.h>
 #include <mach/dma.h>
@@ -114,7 +116,27 @@ void __init pxa910_timer_init(void)
 	__raw_writel(APBC_APBCLK | APBC_RST, APBC_TIMERS);
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA910_AP1_TIMER1);
+	/*
+	 * Make use of timer 1 which id is 0.
+	 * It has no shadow and crsr regsiters.
+	 * The fast lock is 3.25M.
+	 * apb bus is 26M.
+	 */
+	mmp_timer_init(0, TIMERS1_VIRT_BASE, 0, 3250000, 26000000);
+
+	/*
+	 * Enable counter 1 to be clock source.
+	 * The frequency is 32K.
+	 */
+	mmp_counter_clocksource_init(0, 1, 200, 32768);
+
+	/*
+	 * Enable counter 0 to be clock event device.
+	 * The frequency is 32K.
+	 * Only one cpu and there is no broadcast timer.
+	 */
+	mmp_counter_clockevent_init(0, 0, 200, IRQ_PXA910_AP1_TIMER1,
+				    32768, 0, 0);
 }
 
 /* on-chip devices */
-- 
1.8.3.2
