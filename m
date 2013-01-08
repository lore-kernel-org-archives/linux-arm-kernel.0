From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 8 Jan 2013 14:47:38 +0200
Subject: [v2 4/9] clocksource: tegra: Reorganize funcs by clock functionarities
In-Reply-To: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com>
References: <1357649263-1098-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1357649263-1098-5-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Relocate functions by clock functionarities{RTC, TMR}. Also created
some new functions as helper.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 drivers/clocksource/tegra20_timer.c |  160 +++++++++++++++++++----------------
 1 file changed, 86 insertions(+), 74 deletions(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index 5bc1429..1d25de8 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -35,6 +35,83 @@
 #define RTC_SHADOW_SECONDS     0x0c
 #define RTC_MILLISECONDS       0x10
 
+static void __iomem *rtc_base;
+static struct timespec persistent_ts;
+static u64 persistent_ms, last_persistent_ms;
+
+/*
+ * tegra_rtc_read - Reads the Tegra RTC registers
+ * Care must be taken that this funciton is not called while the
+ * tegra_rtc driver could be executing to avoid race conditions
+ * on the RTC shadow register
+ */
+static u64 tegra_rtc_read_ms(void)
+{
+	u32 ms = readl(rtc_base + RTC_MILLISECONDS);
+	u32 s = readl(rtc_base + RTC_SHADOW_SECONDS);
+	return (u64)s * MSEC_PER_SEC + ms;
+}
+
+/*
+ * tegra_read_persistent_clock -  Return time from a persistent clock.
+ *
+ * Reads the time from a source which isn't disabled during PM, the
+ * 32k sync timer.  Convert the cycles elapsed since last read into
+ * nsecs and adds to a monotonically increasing timespec.
+ * Care must be taken that this funciton is not called while the
+ * tegra_rtc driver could be executing to avoid race conditions
+ * on the RTC shadow register
+ */
+static void tegra_read_persistent_clock(struct timespec *ts)
+{
+	u64 delta;
+	struct timespec *tsp = &persistent_ts;
+
+	last_persistent_ms = persistent_ms;
+	persistent_ms = tegra_rtc_read_ms();
+	delta = persistent_ms - last_persistent_ms;
+
+	timespec_add_ns(tsp, delta * NSEC_PER_MSEC);
+	*ts = *tsp;
+}
+
+static const struct of_device_id rtc_match[] __initconst = {
+	{ .compatible = "nvidia,tegra20-rtc" },
+	{}
+};
+
+static void __init tegra20_init_rtc(void)
+{
+	struct device_node *np;
+	struct clk *clk;
+
+	np = of_find_matching_node(NULL, rtc_match);
+	if (!np) {
+		pr_err("Failed to find RTC DT node\n");
+		BUG();
+	}
+
+	rtc_base = of_iomap(np, 0);
+	if (!rtc_base) {
+		pr_err("Can't map RTC registers");
+		BUG();
+	}
+
+	/*
+	 * rtc registers are used by read_persistent_clock, keep the rtc clock
+	 * enabled
+	 */
+	clk = clk_get_sys("rtc-tegra", NULL);
+	if (IS_ERR(clk))
+		pr_warn("Unable to get rtc-tegra clock\n");
+	else
+		clk_prepare_enable(clk);
+
+	of_node_put(np);
+
+	register_persistent_clock(NULL, tegra_read_persistent_clock);
+}
+
 #define TIMERUS_CNTR_1US 0x10
 #define TIMERUS_USEC_CFG 0x14
 #define TIMERUS_CNTR_FREEZE 0x4c
@@ -48,10 +125,6 @@
 #define TIMER_PCR 0x4
 
 static void __iomem *timer_reg_base;
-static void __iomem *rtc_base;
-
-static struct timespec persistent_ts;
-static u64 persistent_ms, last_persistent_ms;
 
 #define timer_writel(value, reg) \
 	__raw_writel(value, timer_reg_base + (reg))
@@ -103,46 +176,10 @@ static u32 notrace tegra_read_sched_clock(void)
 	return timer_readl(TIMERUS_CNTR_1US);
 }
 
-/*
- * tegra_rtc_read - Reads the Tegra RTC registers
- * Care must be taken that this funciton is not called while the
- * tegra_rtc driver could be executing to avoid race conditions
- * on the RTC shadow register
- */
-static u64 tegra_rtc_read_ms(void)
-{
-	u32 ms = readl(rtc_base + RTC_MILLISECONDS);
-	u32 s = readl(rtc_base + RTC_SHADOW_SECONDS);
-	return (u64)s * MSEC_PER_SEC + ms;
-}
-
-/*
- * tegra_read_persistent_clock -  Return time from a persistent clock.
- *
- * Reads the time from a source which isn't disabled during PM, the
- * 32k sync timer.  Convert the cycles elapsed since last read into
- * nsecs and adds to a monotonically increasing timespec.
- * Care must be taken that this funciton is not called while the
- * tegra_rtc driver could be executing to avoid race conditions
- * on the RTC shadow register
- */
-static void tegra_read_persistent_clock(struct timespec *ts)
-{
-	u64 delta;
-	struct timespec *tsp = &persistent_ts;
-
-	last_persistent_ms = persistent_ms;
-	persistent_ms = tegra_rtc_read_ms();
-	delta = persistent_ms - last_persistent_ms;
-
-	timespec_add_ns(tsp, delta * NSEC_PER_MSEC);
-	*ts = *tsp;
-}
-
 static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
-	timer_writel(1<<30, TIMER3_BASE + TIMER_PCR);
+	timer_writel(1 << 30, TIMER3_BASE + TIMER_PCR);
 	evt->event_handler(evt);
 	return IRQ_HANDLED;
 }
@@ -159,12 +196,7 @@ static const struct of_device_id timer_match[] __initconst = {
 	{}
 };
 
-static const struct of_device_id rtc_match[] __initconst = {
-	{ .compatible = "nvidia,tegra20-rtc" },
-	{}
-};
-
-static void __init tegra20_init_timer(void)
+static void __init tegra20_init_tmr(void)
 {
 	struct device_node *np;
 	struct clk *clk;
@@ -200,30 +232,6 @@ static void __init tegra20_init_timer(void)
 
 	of_node_put(np);
 
-	np = of_find_matching_node(NULL, rtc_match);
-	if (!np) {
-		pr_err("Failed to find RTC DT node\n");
-		BUG();
-	}
-
-	rtc_base = of_iomap(np, 0);
-	if (!rtc_base) {
-		pr_err("Can't map RTC registers");
-		BUG();
-	}
-
-	/*
-	 * rtc registers are used by read_persistent_clock, keep the rtc clock
-	 * enabled
-	 */
-	clk = clk_get_sys("rtc-tegra", NULL);
-	if (IS_ERR(clk))
-		pr_warn("Unable to get rtc-tegra clock\n");
-	else
-		clk_prepare_enable(clk);
-
-	of_node_put(np);
-
 	switch (rate) {
 	case 12000000:
 		timer_writel(0x000b, TIMERUS_USEC_CFG);
@@ -241,8 +249,6 @@ static void __init tegra20_init_timer(void)
 		WARN(1, "Unknown clock rate");
 	}
 
-	setup_sched_clock(tegra_read_sched_clock, 32, 1000000);
-
 	if (clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
 		"timer_us", 1000000, 300, 32, clocksource_mmio_readl_up)) {
 		pr_err("Failed to register clocksource\n");
@@ -263,10 +269,16 @@ static void __init tegra20_init_timer(void)
 	tegra_clockevent.cpumask = cpu_all_mask;
 	tegra_clockevent.irq = tegra_timer_irq.irq;
 	clockevents_register_device(&tegra_clockevent);
+}
+
+static void __init tegra20_init_timer(void)
+{
+	tegra20_init_tmr();
+	setup_sched_clock(tegra_read_sched_clock, 32, 1000000);
+	tegra20_init_rtc();
 #ifdef CONFIG_HAVE_ARM_TWD
 	twd_local_timer_of_register();
 #endif
-	register_persistent_clock(NULL, tegra_read_persistent_clock);
 }
 CLOCKSOURCE_OF_DECLARE(tegra20, "nvidia,tegra20-timer", tegra20_init_timer);
 
-- 
1.7.9.5
