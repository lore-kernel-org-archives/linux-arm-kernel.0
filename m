From: lkundrak@v3.sk (Lubomir Rintel)
Date: Mon, 10 Sep 2018 13:30:31 +0200
Subject: [PATCH 4/4] ARM: mmp/mmp2: dt: enable the clock
In-Reply-To: <20180910113031.42634-1-lkundrak@v3.sk>
References: <20180910113031.42634-1-lkundrak@v3.sk>
Message-ID: <20180910113031.42634-5-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device-tree booted MMP2 needs to enable the timer clock, otherwise
the it would stop ticking when the boot finishes.

It can also use the clock rate from the clk, the non-DT boards need to
keep using the hardcoded rates.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 arch/arm/mach-mmp/common.h |  2 +-
 arch/arm/mach-mmp/mmp2.c   |  2 +-
 arch/arm/mach-mmp/pxa168.c |  2 +-
 arch/arm/mach-mmp/time.c   | 29 +++++++++++++++++------------
 4 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/arm/mach-mmp/common.h b/arch/arm/mach-mmp/common.h
index 7e284d9c429f..5ac2851ef5d3 100644
--- a/arch/arm/mach-mmp/common.h
+++ b/arch/arm/mach-mmp/common.h
@@ -2,7 +2,7 @@
 #include <linux/reboot.h>
 #define ARRAY_AND_SIZE(x)	(x), ARRAY_SIZE(x)
 
-extern void timer_init(int irq);
+extern void timer_init(int irq, unsigned long rate);
 
 extern void __init mmp_map_io(void);
 extern void mmp_restart(enum reboot_mode, const char *);
diff --git a/arch/arm/mach-mmp/mmp2.c b/arch/arm/mach-mmp/mmp2.c
index afba5460cdaf..fb3e7e32c882 100644
--- a/arch/arm/mach-mmp/mmp2.c
+++ b/arch/arm/mach-mmp/mmp2.c
@@ -134,7 +134,7 @@ void __init mmp2_timer_init(void)
 	clk_rst = APBC_APBCLK | APBC_FNCLK | APBC_FNCLKSEL(1);
 	__raw_writel(clk_rst, APBC_TIMERS);
 
-	timer_init(IRQ_MMP2_TIMER1);
+	timer_init(IRQ_MMP2_TIMER1, 6500000);
 }
 
 /* on-chip devices */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 0f5f16fb8c66..77a358165a56 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -79,7 +79,7 @@ void __init pxa168_timer_init(void)
 	/* 3.25MHz, bus/functional clock enabled, release reset */
 	__raw_writel(TIMER_CLK_RST, APBC_TIMERS);
 
-	timer_init(IRQ_PXA168_TIMER1);
+	timer_init(IRQ_PXA168_TIMER1, 6500000);
 }
 
 void pxa168_clear_keypad_wakeup(void)
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 96ad1db0b04b..ed754a8eef79 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -22,6 +22,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
+#include <linux/clk.h>
 
 #include <linux/io.h>
 #include <linux/irq.h>
@@ -38,12 +39,6 @@
 #include "cputype.h"
 #include "clock.h"
 
-#ifdef CONFIG_CPU_MMP2
-#define MMP_CLOCK_FREQ		6500000
-#else
-#define MMP_CLOCK_FREQ		3250000
-#endif
-
 #define TIMERS_VIRT_BASE	TIMERS1_VIRT_BASE
 
 #define MAX_DELTA		(0xfffffffe)
@@ -189,19 +184,18 @@ static struct irqaction timer_irq = {
 	.dev_id		= &ckevt,
 };
 
-void __init timer_init(int irq)
+void __init timer_init(int irq, unsigned long rate)
 {
 	timer_config();
 
-	sched_clock_register(mmp_read_sched_clock, 32, MMP_CLOCK_FREQ);
+	sched_clock_register(mmp_read_sched_clock, 32, rate);
 
 	ckevt.cpumask = cpumask_of(0);
 
 	setup_irq(irq, &timer_irq);
 
-	clocksource_register_hz(&cksrc, MMP_CLOCK_FREQ);
-	clockevents_config_and_register(&ckevt, MMP_CLOCK_FREQ,
-					MIN_DELTA, MAX_DELTA);
+	clocksource_register_hz(&cksrc, rate);
+	clockevents_config_and_register(&ckevt, rate, MIN_DELTA, MAX_DELTA);
 }
 
 #ifdef CONFIG_OF
@@ -213,6 +207,7 @@ static const struct of_device_id mmp_timer_dt_ids[] = {
 void __init mmp_dt_init_timer(void)
 {
 	struct device_node *np;
+	struct clk *clk;
 	int irq, ret;
 
 	np = of_find_matching_node(NULL, mmp_timer_dt_ids);
@@ -221,6 +216,16 @@ void __init mmp_dt_init_timer(void)
 		goto out;
 	}
 
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		ret = PTR_ERR(clk);
+		goto out;
+	}
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		goto out;
+
 	irq = irq_of_parse_and_map(np, 0);
 	if (!irq) {
 		ret = -EINVAL;
@@ -231,7 +236,7 @@ void __init mmp_dt_init_timer(void)
 		ret = -ENOMEM;
 		goto out;
 	}
-	timer_init(irq);
+	timer_init(irq, clk_get_rate(clk) / 2);
 	return;
 out:
 	pr_err("Failed to get timer from device tree with error:%d\n", ret);
-- 
2.17.1
