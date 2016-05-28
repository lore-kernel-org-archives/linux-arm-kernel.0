From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sat, 28 May 2016 17:33:53 +0800
Subject: [PATCH 4/4] clocksource: sp804: support 64bit mode for hisilicon
 timer64
In-Reply-To: <1464428033-52106-1-git-send-email-wangkefeng.wang@huawei.com>
References: <1464428033-52106-1-git-send-email-wangkefeng.wang@huawei.com>
Message-ID: <1464428033-52106-5-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a kind of 64bit mode timer in hisilicon soc(like Hip05, Hip06 and
some arm32 soc), it is very similar with ARM sp804 Dual Timers, but TimerX
LOAD/Value/BGLoad are 64bit(two 32bit regs), and reg offset is different.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 .../devicetree/bindings/timer/arm,sp804.txt        |  1 +
 drivers/clocksource/timer-sp.h                     |  1 +
 drivers/clocksource/timer-sp804.c                  | 76 ++++++++++++++++++----
 3 files changed, 66 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/arm,sp804.txt b/Documentation/devicetree/bindings/timer/arm,sp804.txt
index 5cd8eee7..d8e8f8f 100644
--- a/Documentation/devicetree/bindings/timer/arm,sp804.txt
+++ b/Documentation/devicetree/bindings/timer/arm,sp804.txt
@@ -17,6 +17,7 @@ Optional properties:
 - arm,sp804-has-irq = <#>: In the case of only 1 timer irq line connected, this
 	specifies if the irq connection is for timer 1 or timer 2. A value of 1
 	or 2 should be used.
+- hisilicon,timer64: Support hisilicon 64bit mode timer.
 
 Example:
 
diff --git a/drivers/clocksource/timer-sp.h b/drivers/clocksource/timer-sp.h
index 050d885..adf82f4 100644
--- a/drivers/clocksource/timer-sp.h
+++ b/drivers/clocksource/timer-sp.h
@@ -16,6 +16,7 @@
 #define TIMER_VALUE	0x04			/* ACVR ro */
 #define TIMER_CTRL	0x08			/* ACVR rw */
 #define TIMER_CTRL_ONESHOT	(1 << 0)	/*  CVR */
+/* Used in hisilicon timer64, it means enabling 64bit mode */
 #define TIMER_CTRL_32BIT	(1 << 1)	/*  CVR */
 #define TIMER_CTRL_DIV1		(0 << 2)	/* ACVR */
 #define TIMER_CTRL_DIV16	(1 << 2)	/* ACVR */
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index 2ff8777..7f1d947 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -34,6 +34,16 @@
 
 #include "timer-sp.h"
 
+#define TIMER64_2_BASE	0x40
+#define TIMER64_LOAD_L	0x00
+#define TIMER64_LOAD_H	0x04
+#define TIMER64_VALUE_L	0x08
+#define TIMER64_VALUE_H	0x0C
+
+#define HISI_OFFSET	0x8
+
+static int timer64_offset;
+
 static long __init sp804_get_clock_rate(struct clk *clk, const char *name)
 {
 	long rate;
@@ -78,8 +88,8 @@ static inline void sp804_load_mode_set(void __iomem *base, unsigned long load, i
 	unsigned long ctrl = TIMER_CTRL_32BIT | TIMER_CTRL_IE |
 			     mode | TIMER_CTRL_ENABLE;
 
-	writel(load, base + TIMER_LOAD);
-	writel(ctrl, base + TIMER_CTRL);
+	writel(load, base + TIMER_LOAD); /* equal TIMER64_LOAD_L when timer64*/
+	writel(ctrl, base + TIMER_CTRL + timer64_offset);
 }
 
 static void __iomem *sched_clock_base;
@@ -89,11 +99,37 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clock_base + TIMER_VALUE);
 }
 
+static u64 notrace hisi_timer64_read(void)
+{
+	u32 val_lo, val_hi, tmp_hi;
+
+	do {
+		val_hi = readl_relaxed(sched_clock_base + TIMER64_VALUE_H);
+		val_lo = readl_relaxed(sched_clock_base + TIMER64_VALUE_L);
+		tmp_hi = readl_relaxed(sched_clock_base + TIMER64_VALUE_H);
+	} while (val_hi != tmp_hi);
+
+	return ((u64) val_hi << 32) | val_lo;
+}
+
 void __init sp804_timer_disable(void __iomem *base)
 {
-	writel(0, base + TIMER_CTRL);
+	writel(0, base + TIMER_CTRL + timer64_offset);
 }
 
+static cycle_t hisi_clocksource_read(struct clocksource *cs)
+{
+	return hisi_timer64_read();
+}
+
+static struct clocksource hisi_clocksource = {
+	.name	= "hisilicon_timer64",
+	.rating	= 200,
+	.read	= hisi_clocksource_read,
+	.mask	= CLOCKSOURCE_MASK(64),
+	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
+};
+
 void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 						     const char *name,
 						     struct clk *clk,
@@ -106,15 +142,25 @@ void __init __sp804_clocksource_and_sched_clock_init(void __iomem *base,
 
 	/* setup timer 0 as free-running clocksource */
 	sp804_timer_disable(base);
-	writel(0xffffffff, base + TIMER_VALUE);
+	writel(0xffffffff, base + TIMER_VALUE); /* equal TIMER64_LOAD_H when tiemr64*/
+	if (timer64_offset) {
+		writel(0xffffffff, base + TIMER64_VALUE_L);
+		writel(0xffffffff, base + TIMER64_VALUE_H);
+	}
 	sp804_load_mode_set(base, 0xffffffff, TIMER_CTRL_PERIODIC & ~TIMER_CTRL_IE);
 
-	clocksource_mmio_init(base + TIMER_VALUE, name,
-		rate, 200, 32, clocksource_mmio_readl_down);
+	if (timer64_offset)
+		clocksource_register_hz(&hisi_clocksource, rate);
+	else
+		clocksource_mmio_init(base + TIMER_VALUE, name, rate, 200, 32,
+				      clocksource_mmio_readl_down);
 
 	if (use_sched_clock) {
 		sched_clock_base = base;
-		sched_clock_register(sp804_read, 32, rate);
+		if (timer64_offset)
+			sched_clock_register(hisi_timer64_read, 64, rate);
+		else
+			sched_clock_register(sp804_read, 32, rate);
 	}
 }
 
@@ -130,7 +176,7 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 	struct clock_event_device *evt = dev_id;
 
 	/* clear the interrupt */
-	writel(1, clkevt_base + TIMER_INTCLR);
+	writel(1, clkevt_base + TIMER_INTCLR + timer64_offset);
 
 	evt->event_handler(evt);
 
@@ -139,7 +185,7 @@ static irqreturn_t sp804_timer_interrupt(int irq, void *dev_id)
 
 static inline void timer_shutdown(struct clock_event_device *evt)
 {
-	writel(0, clkevt_base + TIMER_CTRL);
+	writel(0, clkevt_base + TIMER_CTRL + timer64_offset);
 }
 
 static int sp804_shutdown(struct clock_event_device *evt)
@@ -204,6 +250,7 @@ void __init __sp804_clockevents_init(void __iomem *base, unsigned int irq, struc
 static void __init sp804_of_init(struct device_node *np)
 {
 	static bool initialized = false;
+	int timer_2_base = TIMER_2_BASE;
 	void __iomem *base;
 	int irq;
 	u32 irq_num = 0;
@@ -214,9 +261,14 @@ static void __init sp804_of_init(struct device_node *np)
 	if (WARN_ON(!base))
 		return;
 
+	if (of_property_read_bool(np, "hisilicon,timer64")) {
+		timer64_offset = HISI_OFFSET;
+		timer_2_base = TIMER64_2_BASE;
+	}
+
 	/* Ensure timers are disabled */
 	sp804_timer_disable(base);
-	sp804_timer_disable(base + TIMER_2_BASE);
+	sp804_timer_disable(base + timer_2_base);
 
 	if (initialized || !of_device_is_available(np))
 		goto err;
@@ -242,11 +294,11 @@ static void __init sp804_of_init(struct device_node *np)
 
 	of_property_read_u32(np, "arm,sp804-has-irq", &irq_num);
 	if (irq_num == 2) {
-		__sp804_clockevents_init(base + TIMER_2_BASE, irq, clk2, name);
+		__sp804_clockevents_init(base + timer_2_base, irq, clk2, name);
 		__sp804_clocksource_and_sched_clock_init(base, name, clk1, 1);
 	} else {
 		__sp804_clockevents_init(base, irq, clk1 , name);
-		__sp804_clocksource_and_sched_clock_init(base + TIMER_2_BASE,
+		__sp804_clocksource_and_sched_clock_init(base + timer_2_base,
 							 name, clk2, 1);
 	}
 	initialized = true;
-- 
1.7.12.4
