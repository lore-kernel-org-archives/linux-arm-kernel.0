From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 23 Apr 2013 17:46:25 +0200
Subject: [PATCH v3 04/13] clocksource: samsung_pwm_timer: Keep all driver data
 in a structure
In-Reply-To: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
References: <1366731994-7478-1-git-send-email-t.figa@samsung.com>
Message-ID: <1366731994-7478-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the driver to keep all its private data consistently
in a single struct, instead of keeping part as separate variables.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clocksource/samsung_pwm_timer.c | 157 +++++++++++++++-----------------
 1 file changed, 74 insertions(+), 83 deletions(-)

diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index d9048b8..e3257fa 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -52,21 +52,25 @@
 DEFINE_SPINLOCK(samsung_pwm_lock);
 EXPORT_SYMBOL(samsung_pwm_lock);
 
-struct samsung_timer_source {
+struct samsung_pwm_clocksource {
+	void __iomem *base;
+	unsigned int irq[SAMSUNG_PWM_NUM];
+	struct samsung_pwm_variant variant;
+
+	struct clk *timerclk;
+
 	unsigned int event_id;
 	unsigned int source_id;
 	unsigned int tcnt_max;
 	unsigned int tscaler_div;
 	unsigned int tdiv;
+
+	unsigned long clock_count_per_tick;
 };
 
-static struct samsung_pwm *pwm;
-static struct clk *timerclk;
-static struct samsung_timer_source timer_source;
-static unsigned long clock_count_per_tick;
+static struct samsung_pwm_clocksource pwm;
 
-static void samsung_timer_set_prescale(struct samsung_pwm *pwm,
-					unsigned int channel, u16 prescale)
+static void samsung_timer_set_prescale(unsigned int channel, u16 prescale)
 {
 	unsigned long flags;
 	u8 shift = 0;
@@ -77,30 +81,29 @@ static void samsung_timer_set_prescale(struct samsung_pwm *pwm,
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	reg = readl(pwm->base + REG_TCFG0);
+	reg = readl(pwm.base + REG_TCFG0);
 	reg &= ~(TCFG0_PRESCALER_MASK << shift);
 	reg |= (prescale - 1) << shift;
-	writel(reg, pwm->base + REG_TCFG0);
+	writel(reg, pwm.base + REG_TCFG0);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
 
-static void samsung_timer_set_divisor(struct samsung_pwm *pwm,
-					unsigned int channel, u8 divisor)
+static void samsung_timer_set_divisor(unsigned int channel, u8 divisor)
 {
 	u8 shift = TCFG1_SHIFT(channel);
 	unsigned long flags;
 	u32 reg;
 	u8 bits;
 
-	bits = (fls(divisor) - 1) - pwm->variant.div_base;
+	bits = (fls(divisor) - 1) - pwm.variant.div_base;
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	reg = readl(pwm->base + REG_TCFG1);
+	reg = readl(pwm.base + REG_TCFG1);
 	reg &= ~(TCFG1_MUX_MASK << shift);
 	reg |= bits << shift;
-	writel(reg, pwm->base + REG_TCFG1);
+	writel(reg, pwm.base + REG_TCFG1);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
@@ -115,9 +118,9 @@ static void samsung_time_stop(unsigned int channel)
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	tcon = __raw_readl(pwm->base + REG_TCON);
+	tcon = __raw_readl(pwm.base + REG_TCON);
 	tcon &= ~TCON_START(channel);
-	__raw_writel(tcon, pwm->base + REG_TCON);
+	__raw_writel(tcon, pwm.base + REG_TCON);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
@@ -133,16 +136,16 @@ static void samsung_time_setup(unsigned int channel, unsigned long tcnt)
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	tcon = __raw_readl(pwm->base + REG_TCON);
+	tcon = __raw_readl(pwm.base + REG_TCON);
 
 	tcnt--;
 
 	tcon &= ~(TCON_START(tcon_chan) | TCON_AUTORELOAD(tcon_chan));
 	tcon |= TCON_MANUALUPDATE(tcon_chan);
 
-	__raw_writel(tcnt, pwm->base + REG_TCNTB(channel));
-	__raw_writel(tcnt, pwm->base + REG_TCMPB(channel));
-	__raw_writel(tcon, pwm->base + REG_TCON);
+	__raw_writel(tcnt, pwm.base + REG_TCNTB(channel));
+	__raw_writel(tcnt, pwm.base + REG_TCMPB(channel));
+	__raw_writel(tcon, pwm.base + REG_TCON);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
@@ -157,7 +160,7 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 
 	spin_lock_irqsave(&samsung_pwm_lock, flags);
 
-	tcon = __raw_readl(pwm->base + REG_TCON);
+	tcon = __raw_readl(pwm.base + REG_TCON);
 
 	tcon &= ~TCON_MANUALUPDATE(channel);
 	tcon |= TCON_START(channel);
@@ -167,7 +170,7 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 	else
 		tcon &= ~TCON_AUTORELOAD(channel);
 
-	__raw_writel(tcon, pwm->base + REG_TCON);
+	__raw_writel(tcon, pwm.base + REG_TCON);
 
 	spin_unlock_irqrestore(&samsung_pwm_lock, flags);
 }
@@ -175,8 +178,8 @@ static void samsung_time_start(unsigned int channel, bool periodic)
 static int samsung_set_next_event(unsigned long cycles,
 				struct clock_event_device *evt)
 {
-	samsung_time_setup(timer_source.event_id, cycles);
-	samsung_time_start(timer_source.event_id, false);
+	samsung_time_setup(pwm.event_id, cycles);
+	samsung_time_start(pwm.event_id, false);
 
 	return 0;
 }
@@ -184,23 +187,23 @@ static int samsung_set_next_event(unsigned long cycles,
 static void samsung_timer_resume(void)
 {
 	/* event timer restart */
-	samsung_time_setup(timer_source.event_id, clock_count_per_tick);
-	samsung_time_start(timer_source.event_id, true);
+	samsung_time_setup(pwm.event_id, pwm.clock_count_per_tick);
+	samsung_time_start(pwm.event_id, true);
 
 	/* source timer restart */
-	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
-	samsung_time_start(timer_source.source_id, true);
+	samsung_time_setup(pwm.source_id, pwm.tcnt_max);
+	samsung_time_start(pwm.source_id, true);
 }
 
 static void samsung_set_mode(enum clock_event_mode mode,
 				struct clock_event_device *evt)
 {
-	samsung_time_stop(timer_source.event_id);
+	samsung_time_stop(pwm.event_id);
 
 	switch (mode) {
 	case CLOCK_EVT_MODE_PERIODIC:
-		samsung_time_setup(timer_source.event_id, clock_count_per_tick);
-		samsung_time_start(timer_source.event_id, true);
+		samsung_time_setup(pwm.event_id, pwm.clock_count_per_tick);
+		samsung_time_start(pwm.event_id, true);
 		break;
 
 	case CLOCK_EVT_MODE_ONESHOT:
@@ -228,9 +231,9 @@ static irqreturn_t samsung_clock_event_isr(int irq, void *dev_id)
 {
 	struct clock_event_device *evt = dev_id;
 
-	if (pwm->variant.has_tint_cstat) {
-		u32 mask = (1 << timer_source.event_id);
-		writel(mask | (mask << 5), pwm->base + REG_TINT_CSTAT);
+	if (pwm.variant.has_tint_cstat) {
+		u32 mask = (1 << pwm.event_id);
+		writel(mask | (mask << 5), pwm.base + REG_TINT_CSTAT);
 	}
 
 	evt->event_handler(evt);
@@ -251,39 +254,37 @@ static void __init samsung_clockevent_init(void)
 	unsigned long clock_rate;
 	unsigned int irq_number;
 
-	pclk = clk_get_rate(timerclk);
+	pclk = clk_get_rate(pwm.timerclk);
 
-	samsung_timer_set_prescale(pwm, timer_source.event_id,
-						timer_source.tscaler_div);
-	samsung_timer_set_divisor(pwm, timer_source.event_id,
-						timer_source.tdiv);
+	samsung_timer_set_prescale(pwm.event_id, pwm.tscaler_div);
+	samsung_timer_set_divisor(pwm.event_id, pwm.tdiv);
 
-	clock_rate = pclk / (timer_source.tscaler_div * timer_source.tdiv);
-	clock_count_per_tick = clock_rate / HZ;
+	clock_rate = pclk / (pwm.tscaler_div * pwm.tdiv);
+	pwm.clock_count_per_tick = clock_rate / HZ;
 
 	time_event_device.cpumask = cpumask_of(0);
 	clockevents_config_and_register(&time_event_device, clock_rate, 1, -1);
 
-	irq_number = pwm->irq[timer_source.event_id];
+	irq_number = pwm.irq[pwm.event_id];
 	setup_irq(irq_number, &samsung_clock_event_irq);
 
-	if (pwm->variant.has_tint_cstat) {
-		u32 mask = (1 << timer_source.event_id);
-		writel(mask | (mask << 5), pwm->base + REG_TINT_CSTAT);
+	if (pwm.variant.has_tint_cstat) {
+		u32 mask = (1 << pwm.event_id);
+		writel(mask | (mask << 5), pwm.base + REG_TINT_CSTAT);
 	}
 }
 
 static void __iomem *samsung_timer_reg(void)
 {
-	switch (timer_source.source_id) {
+	switch (pwm.source_id) {
 	case 0:
 	case 1:
 	case 2:
 	case 3:
-		return pwm->base + timer_source.source_id * 0x0c + 0x14;
+		return pwm.base + pwm.source_id * 0x0c + 0x14;
 
 	case 4:
-		return pwm->base + 0x40;
+		return pwm.base + 0x40;
 
 	default:
 		BUG();
@@ -314,23 +315,21 @@ static void __init samsung_clocksource_init(void)
 	unsigned long clock_rate;
 	int ret;
 
-	pclk = clk_get_rate(timerclk);
+	pclk = clk_get_rate(pwm.timerclk);
 
-	samsung_timer_set_prescale(pwm, timer_source.source_id,
-						timer_source.tscaler_div);
-	samsung_timer_set_divisor(pwm, timer_source.source_id,
-						timer_source.tdiv);
+	samsung_timer_set_prescale(pwm.source_id, pwm.tscaler_div);
+	samsung_timer_set_divisor(pwm.source_id, pwm.tdiv);
 
-	clock_rate = pclk / (timer_source.tscaler_div * timer_source.tdiv);
+	clock_rate = pclk / (pwm.tscaler_div * pwm.tdiv);
 
-	samsung_time_setup(timer_source.source_id, timer_source.tcnt_max);
-	samsung_time_start(timer_source.source_id, true);
+	samsung_time_setup(pwm.source_id, pwm.tcnt_max);
+	samsung_time_start(pwm.source_id, true);
 
 	setup_sched_clock(samsung_read_sched_clock,
-						pwm->variant.bits, clock_rate);
+						pwm.variant.bits, clock_rate);
 
 	ret = clocksource_mmio_init(reg, "samsung_clocksource_timer",
-					clock_rate, 250, pwm->variant.bits,
+					clock_rate, 250, pwm.variant.bits,
 					clocksource_mmio_readl_down);
 	if (ret)
 		panic("samsung_clocksource_timer: can't register clocksource\n");
@@ -338,19 +337,19 @@ static void __init samsung_clocksource_init(void)
 
 static void __init samsung_timer_resources(void)
 {
-	timerclk = clk_get(NULL, "timers");
-	if (IS_ERR(timerclk))
+	pwm.timerclk = clk_get(NULL, "timers");
+	if (IS_ERR(pwm.timerclk))
 		panic("failed to get timers clock for timer");
 
-	clk_prepare_enable(timerclk);
+	clk_prepare_enable(pwm.timerclk);
 
-	timer_source.tcnt_max = (1UL << pwm->variant.bits) - 1;
-	if (pwm->variant.bits == 16) {
-		timer_source.tscaler_div = 25;
-		timer_source.tdiv = 2;
+	pwm.tcnt_max = (1UL << pwm.variant.bits) - 1;
+	if (pwm.variant.bits == 16) {
+		pwm.tscaler_div = 25;
+		pwm.tdiv = 2;
 	} else {
-		timer_source.tscaler_div = 2;
-		timer_source.tdiv = 1;
+		pwm.tscaler_div = 2;
+		pwm.tdiv = 1;
 	}
 }
 
@@ -362,20 +361,17 @@ static void __init samsung_pwm_clocksource_init(void)
 	u8 mask;
 	int channel;
 
-	if (!pwm)
-		panic("no pwm clocksource device found");
-
-	mask = ~pwm->variant.output_mask & ((1 << SAMSUNG_PWM_NUM) - 1);
+	mask = ~pwm.variant.output_mask & ((1 << SAMSUNG_PWM_NUM) - 1);
 	channel = fls(mask) - 1;
 	if (channel < 0)
 		panic("failed to find PWM channel for clocksource");
-	timer_source.source_id = channel;
+	pwm.source_id = channel;
 
 	mask &= ~(1 << channel);
 	channel = fls(mask) - 1;
 	if (channel < 0)
 		panic("failed to find PWM channel for clock event");
-	timer_source.event_id = channel;
+	pwm.event_id = channel;
 
 	samsung_timer_resources();
 	samsung_clockevent_init();
@@ -391,14 +387,9 @@ static void __init samsung_pwm_alloc(struct device_node *np,
 	u32 val;
 	int i;
 
-	pwm = kzalloc(sizeof(*pwm), GFP_KERNEL);
-	if (!pwm) {
-		pr_err("%s: could not allocate PWM device struct\n", __func__);
-		return;
-	}
-	memcpy(&pwm->variant, variant, sizeof(pwm->variant));
+	memcpy(&pwm.variant, variant, sizeof(pwm.variant));
 	for (i = 0; i < SAMSUNG_PWM_NUM; ++i)
-		pwm->irq[i] = irq_of_parse_and_map(np, i);
+		pwm.irq[i] = irq_of_parse_and_map(np, i);
 
 	of_property_for_each_u32(np, "samsung,pwm-outputs", prop, cur, val) {
 		if (val >= SAMSUNG_PWM_NUM) {
@@ -406,7 +397,7 @@ static void __init samsung_pwm_alloc(struct device_node *np,
 								__func__);
 			continue;
 		}
-		pwm->variant.output_mask |= 1 << val;
+		pwm.variant.output_mask |= 1 << val;
 	}
 
 	of_address_to_resource(np, 0, &res);
@@ -416,8 +407,8 @@ static void __init samsung_pwm_alloc(struct device_node *np,
 		return;
 	}
 
-	pwm->base = ioremap(res.start, resource_size(&res));
-	if (!pwm->base) {
+	pwm.base = ioremap(res.start, resource_size(&res));
+	if (!pwm.base) {
 		pr_err("%s: failed to map PWM registers\n", __func__);
 		release_mem_region(res.start, resource_size(&res));
 		return;
-- 
1.8.2.1
