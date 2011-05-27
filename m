From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 May 2011 15:10:09 -0700
Subject: [PATCH 1/2] ARM: S5P: Cleanup s5p-time for HRTimer
Message-ID: <1306534210-32659-1-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/s5p-time.c |  217 ++++++++++++++++++------------------------
 1 files changed, 93 insertions(+), 124 deletions(-)

diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index 1f94d4a..6b26d80 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -36,41 +36,6 @@ static struct clk *tdiv_source;
 static struct clk *timerclk;
 static struct s5p_timer_source timer_source;
 static unsigned long clock_count_per_tick;
-static void s5p_timer_resume(void);
-
-static void s5p_time_stop(enum s5p_timer_mode mode)
-{
-	unsigned long tcon;
-
-	tcon = __raw_readl(S3C2410_TCON);
-
-	switch (mode) {
-	case S5P_PWM0:
-		tcon &= ~S3C2410_TCON_T0START;
-		break;
-
-	case S5P_PWM1:
-		tcon &= ~S3C2410_TCON_T1START;
-		break;
-
-	case S5P_PWM2:
-		tcon &= ~S3C2410_TCON_T2START;
-		break;
-
-	case S5P_PWM3:
-		tcon &= ~S3C2410_TCON_T3START;
-		break;
-
-	case S5P_PWM4:
-		tcon &= ~S3C2410_TCON_T4START;
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Timer %d\n", mode);
-		break;
-	}
-	__raw_writel(tcon, S3C2410_TCON);
-}
 
 static void s5p_time_setup(enum s5p_timer_mode mode, unsigned long tcnt)
 {
@@ -180,6 +145,75 @@ static void s5p_time_start(enum s5p_timer_mode mode, bool periodic)
 	__raw_writel(tcon, S3C2410_TCON);
 }
 
+static void s5p_time_stop(enum s5p_timer_mode mode)
+{
+	unsigned long tcon;
+
+	tcon = __raw_readl(S3C2410_TCON);
+
+	switch (mode) {
+	case S5P_PWM0:
+		tcon &= ~S3C2410_TCON_T0START;
+		break;
+
+	case S5P_PWM1:
+		tcon &= ~S3C2410_TCON_T1START;
+		break;
+
+	case S5P_PWM2:
+		tcon &= ~S3C2410_TCON_T2START;
+		break;
+
+	case S5P_PWM3:
+		tcon &= ~S3C2410_TCON_T3START;
+		break;
+
+	case S5P_PWM4:
+		tcon &= ~S3C2410_TCON_T4START;
+		break;
+
+	default:
+		printk(KERN_ERR "Invalid Timer %d\n", mode);
+		break;
+	}
+	__raw_writel(tcon, S3C2410_TCON);
+}
+
+static void s5p_timer_resume(void)
+{
+	/* event timer restart */
+	s5p_time_setup(timer_source.event_id, clock_count_per_tick);
+	s5p_time_start(timer_source.event_id, PERIODIC);
+
+	/* source timer restart */
+	s5p_time_setup(timer_source.source_id, TCNT_MAX);
+	s5p_time_start(timer_source.source_id, PERIODIC);
+}
+
+static cycle_t s5p_timer_read(struct clocksource *cs)
+{
+	unsigned long offset = 0;
+
+	switch (timer_source.source_id) {
+	case S5P_PWM0:
+	case S5P_PWM1:
+	case S5P_PWM2:
+	case S5P_PWM3:
+		offset = (timer_source.source_id * 0x0c) + 0x14;
+		break;
+
+	case S5P_PWM4:
+		offset = 0x40;
+		break;
+
+	default:
+		printk(KERN_ERR "Invalid Timer %d\n", timer_source.source_id);
+		return 0;
+	}
+
+	return (cycle_t) ~__raw_readl(S3C_TIMERREG(offset));
+}
+
 static int s5p_set_next_event(unsigned long cycles,
 				struct clock_event_device *evt)
 {
@@ -213,27 +247,6 @@ static void s5p_set_mode(enum clock_event_mode mode,
 	}
 }
 
-static void s5p_timer_resume(void)
-{
-	/* event timer restart */
-	s5p_time_setup(timer_source.event_id, clock_count_per_tick);
-	s5p_time_start(timer_source.event_id, PERIODIC);
-
-	/* source timer restart */
-	s5p_time_setup(timer_source.source_id, TCNT_MAX);
-	s5p_time_start(timer_source.source_id, PERIODIC);
-}
-
-void __init s5p_set_timer_source(enum s5p_timer_mode event,
-				 enum s5p_timer_mode source)
-{
-	s3c_device_timer[event].dev.bus = &platform_bus_type;
-	s3c_device_timer[source].dev.bus = &platform_bus_type;
-
-	timer_source.event_id = event;
-	timer_source.source_id = source;
-}
-
 static struct clock_event_device time_event_device = {
 	.name		= "s5p_event_timer",
 	.features	= CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
@@ -290,29 +303,13 @@ static void __init s5p_clockevent_init(void)
 	setup_irq(irq_number, &s5p_clock_event_irq);
 }
 
-static cycle_t s5p_timer_read(struct clocksource *cs)
-{
-	unsigned long offset = 0;
-
-	switch (timer_source.source_id) {
-	case S5P_PWM0:
-	case S5P_PWM1:
-	case S5P_PWM2:
-	case S5P_PWM3:
-		offset = (timer_source.source_id * 0x0c) + 0x14;
-		break;
-
-	case S5P_PWM4:
-		offset = 0x40;
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Timer %d\n", timer_source.source_id);
-		return 0;
-	}
-
-	return (cycle_t) ~__raw_readl(S3C_TIMERREG(offset));
-}
+struct clocksource time_clocksource = {
+	.name		= "s5p_clocksource_timer",
+	.rating		= 250,
+	.read		= s5p_timer_read,
+	.mask		= CLOCKSOURCE_MASK(32),
+	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
+};
 
 /*
  * Override the global weak sched_clock symbol with this
@@ -325,63 +322,25 @@ static DEFINE_CLOCK_DATA(cd);
 
 unsigned long long notrace sched_clock(void)
 {
-	u32 cyc;
-	unsigned long offset = 0;
+	cycle_t cyc;
+	unsigned long irq_flags;
 
-	switch (timer_source.source_id) {
-	case S5P_PWM0:
-	case S5P_PWM1:
-	case S5P_PWM2:
-	case S5P_PWM3:
-		offset = (timer_source.source_id * 0x0c) + 0x14;
-		break;
-
-	case S5P_PWM4:
-		offset = 0x40;
-		break;
+	local_irq_save(irq_flags);
+	cyc = s5p_timer_read(&time_clocksource);
 
-	default:
-		printk(KERN_ERR "Invalid Timer %d\n", timer_source.source_id);
-		return 0;
-	}
+	local_irq_restore(irq_flags);
 
-	cyc = ~__raw_readl(S3C_TIMERREG(offset));
 	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
 }
 
 static void notrace s5p_update_sched_clock(void)
 {
-	u32 cyc;
-	unsigned long offset = 0;
+	cycle_t cyc;
 
-	switch (timer_source.source_id) {
-	case S5P_PWM0:
-	case S5P_PWM1:
-	case S5P_PWM2:
-	case S5P_PWM3:
-		offset = (timer_source.source_id * 0x0c) + 0x14;
-		break;
-
-	case S5P_PWM4:
-		offset = 0x40;
-		break;
-
-	default:
-		printk(KERN_ERR "Invalid Timer %d\n", timer_source.source_id);
-	}
-
-	cyc = ~__raw_readl(S3C_TIMERREG(offset));
+	cyc = s5p_timer_read(&time_clocksource);
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
-struct clocksource time_clocksource = {
-	.name		= "s5p_clocksource_timer",
-	.rating		= 250,
-	.read		= s5p_timer_read,
-	.mask		= CLOCKSOURCE_MASK(32),
-	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
-};
-
 static void __init s5p_clocksource_init(void)
 {
 	unsigned long pclk;
@@ -436,6 +395,16 @@ static void __init s5p_timer_resources(void)
 	clk_enable(tin_source);
 }
 
+void __init s5p_set_timer_source(enum s5p_timer_mode event,
+				 enum s5p_timer_mode source)
+{
+	s3c_device_timer[event].dev.bus = &platform_bus_type;
+	s3c_device_timer[source].dev.bus = &platform_bus_type;
+
+	timer_source.event_id = event;
+	timer_source.source_id = source;
+}
+
 static void __init s5p_timer_init(void)
 {
 	s5p_timer_resources();
-- 
1.7.4.4
