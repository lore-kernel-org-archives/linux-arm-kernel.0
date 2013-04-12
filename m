From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 12 Apr 2013 21:17:27 +0200
Subject: [PATCH v5 11/14] clocksource: samsung-pwm: Configure dividers directly
In-Reply-To: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
References: <1365794250-14436-1-git-send-email-t.figa@samsung.com>
Message-ID: <1365794250-14436-12-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Clock dividers present in the PWM blocks are used to generate signal for
PWM timers internally, so there is no need to export them using clock
API.

This patch moves handling of those dividers to the clocksource driver to
not use the clock API anymore.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung_pwm.c | 111 ++++++++++++++++++++------------------
 1 file changed, 60 insertions(+), 51 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm.c b/drivers/clocksource/samsung_pwm.c
index 3219ecc..29b480a 100644
--- a/drivers/clocksource/samsung_pwm.c
+++ b/drivers/clocksource/samsung_pwm.c
@@ -277,6 +277,15 @@ EXPORT_SYMBOL(samsung_pwm_get);
  * Clocksource driver
  */
 
+#define REG_TCFG0			0x00
+#define REG_TCFG1			0x04
+
+#define TCFG0_PRESCALER_MASK		0xff
+#define TCFG0_PRESCALER1_SHIFT		8
+
+#define TCFG1_SHIFT(x)	  		((x) * 4)
+#define TCFG1_MUX_MASK	  		0xf
+
 struct samsung_timer_source {
 	unsigned int event_id;
 	unsigned int source_id;
@@ -286,16 +295,51 @@ struct samsung_timer_source {
 };
 
 static struct samsung_pwm *pwm;
-
-static struct clk *tin_event;
-static struct clk *tin_source;
-static struct clk *tdiv_event;
-static struct clk *tdiv_source;
 static struct clk *timerclk;
 static struct samsung_timer_source timer_source;
 static unsigned long clock_count_per_tick;
 static void samsung_timer_resume(void);
 
+static void samsung_timer_set_prescale(struct samsung_pwm *pwm,
+					unsigned int channel, u16 prescale)
+{
+	unsigned long flags;
+	u8 shift = 0;
+	u32 reg;
+
+	if (channel >= 2)
+		shift = TCFG0_PRESCALER1_SHIFT;
+
+	spin_lock_irqsave(&pwm->slock, flags);
+
+	reg = readl(pwm->base + REG_TCFG0);
+	reg &= ~(TCFG0_PRESCALER_MASK << shift);
+	reg |= (prescale - 1) << shift;
+	writel(reg, pwm->base + REG_TCFG0);
+
+	spin_unlock_irqrestore(&pwm->slock, flags);
+}
+
+static void samsung_timer_set_divisor(struct samsung_pwm *pwm,
+					unsigned int channel, u8 divisor)
+{
+	u8 shift = TCFG1_SHIFT(channel);
+	unsigned long flags;
+	u32 reg;
+	u8 bits;
+
+	bits = (fls(divisor) - 1) - pwm->variant.div_base;
+
+	spin_lock_irqsave(&pwm->slock, flags);
+
+	reg = readl(pwm->base + REG_TCFG1);
+	reg &= ~(TCFG1_MUX_MASK << shift);
+	reg |= bits << shift;
+	writel(reg, pwm->base + REG_TCFG1);
+
+	spin_unlock_irqrestore(&pwm->slock, flags);
+}
+
 static void samsung_time_stop(enum samsung_timer_mode mode)
 {
 	unsigned long tcon;
@@ -531,18 +575,15 @@ static void __init samsung_clockevent_init(void)
 	unsigned long pclk;
 	unsigned long clock_rate;
 	unsigned int irq_number;
-	struct clk *tscaler;
 
 	pclk = clk_get_rate(timerclk);
 
-	tscaler = clk_get_parent(tdiv_event);
-
-	clk_set_rate(tscaler, pclk / timer_source.tscaler_div);
-	clk_set_rate(tdiv_event,
-			pclk / (timer_source.tdiv * timer_source.tscaler_div));
-	clk_set_parent(tin_event, tdiv_event);
+	samsung_timer_set_prescale(pwm, timer_source.event_id,
+						timer_source.tscaler_div);
+	samsung_timer_set_divisor(pwm, timer_source.event_id,
+						timer_source.tdiv);
 
-	clock_rate = clk_get_rate(tin_event);
+	clock_rate = pclk / (timer_source.tscaler_div * timer_source.tdiv);
 	clock_count_per_tick = clock_rate / HZ;
 
 	time_event_device.cpumask = cpumask_of(0);
@@ -607,11 +648,12 @@ static void __init samsung_clocksource_init(void)
 
 	pclk = clk_get_rate(timerclk);
 
-	clk_set_rate(tdiv_source,
-			pclk / (timer_source.tdiv * timer_source.tscaler_div));
-	clk_set_parent(tin_source, tdiv_source);
+	samsung_timer_set_prescale(pwm, timer_source.source_id,
+						timer_source.tscaler_div);
+	samsung_timer_set_divisor(pwm, timer_source.source_id,
+						timer_source.tdiv);
 
-	clock_rate = clk_get_rate(tin_source);
+	clock_rate = pclk / (timer_source.tscaler_div * timer_source.tdiv);
 
 	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
 	samsung_time_start(timer_source.source_id, true);
@@ -628,44 +670,11 @@ static void __init samsung_clocksource_init(void)
 
 static void __init samsung_timer_resources(void)
 {
-
-	unsigned long event_id = timer_source.event_id;
-	unsigned long source_id = timer_source.source_id;
-	char devname[15];
-
 	timerclk = clk_get(NULL, "timers");
 	if (IS_ERR(timerclk))
 		panic("failed to get timers clock for timer");
 
-	clk_enable(timerclk);
-
-	sprintf(devname, "s3c24xx-pwm.%lu", event_id);
-	s3c_device_timer[event_id].id = event_id;
-	s3c_device_timer[event_id].dev.init_name = devname;
-
-	tin_event = clk_get(&s3c_device_timer[event_id].dev, "pwm-tin");
-	if (IS_ERR(tin_event))
-		panic("failed to get pwm-tin clock for event timer");
-
-	tdiv_event = clk_get(&s3c_device_timer[event_id].dev, "pwm-tdiv");
-	if (IS_ERR(tdiv_event))
-		panic("failed to get pwm-tdiv clock for event timer");
-
-	clk_enable(tin_event);
-
-	sprintf(devname, "s3c24xx-pwm.%lu", source_id);
-	s3c_device_timer[source_id].id = source_id;
-	s3c_device_timer[source_id].dev.init_name = devname;
-
-	tin_source = clk_get(&s3c_device_timer[source_id].dev, "pwm-tin");
-	if (IS_ERR(tin_source))
-		panic("failed to get pwm-tin clock for source timer");
-
-	tdiv_source = clk_get(&s3c_device_timer[source_id].dev, "pwm-tdiv");
-	if (IS_ERR(tdiv_source))
-		panic("failed to get pwm-tdiv clock for source timer");
-
-	clk_enable(tin_source);
+	clk_prepare_enable(timerclk);
 
 	timer_source.tcnt_max = (1UL << pwm->variant.bits) - 1;
 	if (pwm->variant.bits == 16) {
-- 
1.8.1.5
