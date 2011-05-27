From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 27 May 2011 15:10:10 -0700
Subject: [PATCH 2/2] ARM: S5P: Add 64bit PWM timer counter for sched_clock
In-Reply-To: <1306534210-32659-1-git-send-email-kgene.kim@samsung.com>
References: <1306534210-32659-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1306534210-32659-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sangbeom Kim <sbkim73@samsung.com>

Basically, PWM timer works with 33Mhz on S5P SoCs and counter
overflow every 128 secs. So it is needed 64-bit counter for
supporting proper sched_clock() by 32-bit timer. This patch
handle overflow control and can solve the problem of suspend
to resume

Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/plat-s5p/s5p-time.c |   80 +++++++++++++++++++++++++++++++++++++++--
 1 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-s5p/s5p-time.c b/arch/arm/plat-s5p/s5p-time.c
index 6b26d80..ecc576f 100644
--- a/arch/arm/plat-s5p/s5p-time.c
+++ b/arch/arm/plat-s5p/s5p-time.c
@@ -36,6 +36,12 @@ static struct clk *tdiv_source;
 static struct clk *timerclk;
 static struct s5p_timer_source timer_source;
 static unsigned long clock_count_per_tick;
+static unsigned long long s5p_sched_timer_overflows;
+static unsigned long long time_stamps;
+static unsigned long long old_overflows;
+static cycle_t last_ticks;
+static unsigned int sched_timer_running;
+static unsigned int pending_irq;
 
 static void s5p_time_setup(enum s5p_timer_mode mode, unsigned long tcnt)
 {
@@ -188,6 +194,7 @@ static void s5p_timer_resume(void)
 	/* source timer restart */
 	s5p_time_setup(timer_source.source_id, TCNT_MAX);
 	s5p_time_start(timer_source.source_id, PERIODIC);
+	sched_timer_running = 1;
 }
 
 static cycle_t s5p_timer_read(struct clocksource *cs)
@@ -223,6 +230,15 @@ static int s5p_set_next_event(unsigned long cycles,
 	return 0;
 }
 
+static void s5p_val_init(void)
+{
+	last_ticks = 0;
+	s5p_sched_timer_overflows = 0;
+	old_overflows = 0;
+	sched_timer_running = 0;
+	pending_irq = 0;
+}
+
 static void s5p_set_mode(enum clock_event_mode mode,
 				struct clock_event_device *evt)
 {
@@ -239,6 +255,7 @@ static void s5p_set_mode(enum clock_event_mode mode,
 
 	case CLOCK_EVT_MODE_UNUSED:
 	case CLOCK_EVT_MODE_SHUTDOWN:
+		s5p_val_init();
 		break;
 
 	case CLOCK_EVT_MODE_RESUME:
@@ -322,15 +339,41 @@ static DEFINE_CLOCK_DATA(cd);
 
 unsigned long long notrace sched_clock(void)
 {
-	cycle_t cyc;
+	cycle_t ticks, elapsed_ticks = 0;
+	unsigned long long increment = 0;
+	unsigned int overflow_cnt = s5p_sched_timer_overflows - old_overflows;
 	unsigned long irq_flags;
 
 	local_irq_save(irq_flags);
-	cyc = s5p_timer_read(&time_clocksource);
-
+	ticks = s5p_timer_read(&time_clocksource);
+
+	if (likely(sched_timer_running)) {
+		if (overflow_cnt) {
+			increment = (overflow_cnt - 1)
+			  * (clocksource_cyc2ns(time_clocksource.read(&time_clocksource),
+			     time_clocksource.mult, time_clocksource.shift));
+			elapsed_ticks = time_clocksource.mask - last_ticks
+					+ ticks;
+		} else {
+			if (unlikely(last_ticks > ticks)) {
+				pending_irq = 1;
+				elapsed_ticks = time_clocksource.mask
+						- last_ticks + ticks;
+				s5p_sched_timer_overflows++;
+			} else {
+				elapsed_ticks = ticks - last_ticks;
+			}
+		}
+
+		time_stamps += clocksource_cyc2ns(elapsed_ticks,
+				time_clocksource.mult, time_clocksource.shift)
+				+ increment;
+		old_overflows = s5p_sched_timer_overflows;
+		last_ticks = ticks;
+	}
 	local_irq_restore(irq_flags);
 
-	return cyc_to_sched_clock(&cd, cyc, (u32)~0);
+	return time_stamps;
 }
 
 static void notrace s5p_update_sched_clock(void)
@@ -341,10 +384,32 @@ static void notrace s5p_update_sched_clock(void)
 	update_sched_clock(&cd, cyc, (u32)~0);
 }
 
+irqreturn_t s5p_clock_source_isr(int irq, void *dev_id)
+{
+	if (unlikely(pending_irq))
+		pending_irq = 0;
+	else
+		s5p_sched_timer_overflows++;
+
+	return IRQ_HANDLED;
+}
+
+static struct irqaction s5p_clock_source_irq = {
+	.name		= "s5p_source_irq",
+	.flags		= IRQF_DISABLED ,
+	.handler	= s5p_clock_source_isr,
+};
+
 static void __init s5p_clocksource_init(void)
 {
 	unsigned long pclk;
 	unsigned long clock_rate;
+	unsigned int irq_number;
+	unsigned long cstat;
+
+	/* Clear each timer interrupt pending bit */
+	cstat = __raw_readl(S3C64XX_TINT_CSTAT);
+	__raw_writel(cstat, S3C64XX_TINT_CSTAT);
 
 	pclk = clk_get_rate(timerclk);
 
@@ -355,11 +420,15 @@ static void __init s5p_clocksource_init(void)
 
 	s5p_time_setup(timer_source.source_id, TCNT_MAX);
 	s5p_time_start(timer_source.source_id, PERIODIC);
+	sched_timer_running = 1;
 
 	init_sched_clock(&cd, s5p_update_sched_clock, 32, clock_rate);
 
 	if (clocksource_register_hz(&time_clocksource, clock_rate))
 		panic("%s: can't register clocksource\n", time_clocksource.name);
+
+	irq_number = timer_source.source_id + IRQ_TIMER0;
+	setup_irq(irq_number, &s5p_clock_source_irq);
 }
 
 static void __init s5p_timer_resources(void)
@@ -368,6 +437,9 @@ static void __init s5p_timer_resources(void)
 	unsigned long event_id = timer_source.event_id;
 	unsigned long source_id = timer_source.source_id;
 
+	s5p_val_init();
+	time_stamps = 0;
+
 	timerclk = clk_get(NULL, "timers");
 	if (IS_ERR(timerclk))
 		panic("failed to get timers clock for timer");
-- 
1.7.4.4
