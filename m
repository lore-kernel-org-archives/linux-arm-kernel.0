From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 30 Apr 2014 18:56:53 +0200
Subject: [RFC PATCH] sched_clock: also call
 register_current_timer_delay() if possible
In-Reply-To: <20140430132628.GC15719@arm.com>
References: <1398860614-29469-1-git-send-email-bigeasy@linutronix.de>
 <20140430124800.GC21876@arm.com> <5360F42C.9080401@linutronix.de>
 <20140430132628.GC15719@arm.com>
Message-ID: <20140430165653.GA26716@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Will Deacon | 2014-04-30 14:26:28 [+0100]:

Hi Will,

>I don't think that's the problem I was referring to. What I mean is that a
>clocksource might overflow at any number of bits, so the delay calculation
>needs to take this into account when it does:
>
>	while ((get_cycles() - start) < cycles)
>
>because a premature overflow from get_cycles() will cause us to return
>early. The solution is to mask the result of the subtraction before the
>comparison to match the width of the clock.

So I got this:

diff --git a/arch/arm/include/asm/delay.h b/arch/arm/include/asm/delay.h
index dff714d..49c2e93 100644
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -18,6 +18,7 @@
 struct delay_timer {
 	unsigned long (*read_current_timer)(void);
 	unsigned long freq;
+	unsigned int bits;
 };
 
 extern struct arm_delay_ops {
@@ -25,6 +26,7 @@ extern struct arm_delay_ops {
 	void (*const_udelay)(unsigned long);
 	void (*udelay)(unsigned long);
 	unsigned long ticks_per_jiffy;
+	u32 mask;
 } arm_delay_ops;
 
 #define __delay(n)		arm_delay_ops.delay(n)
diff --git a/arch/arm/lib/delay.c b/arch/arm/lib/delay.c
index 5306de3..dd32cc9 100644
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -50,8 +50,9 @@ EXPORT_SYMBOL_GPL(read_current_timer);
 static void __timer_delay(unsigned long cycles)
 {
 	cycles_t start = get_cycles();
+	cycles_t mask = arm_delay_ops.mask;
 
-	while ((get_cycles() - start) < cycles)
+	while (((get_cycles() - start) & mask) < cycles)
 		cpu_relax();
 }
 
@@ -69,6 +70,10 @@ static void __timer_udelay(unsigned long usecs)
 
 void __init register_current_timer_delay(const struct delay_timer *timer)
 {
+	if (timer->bits > 32) {
+		pr_err("timer delay bits are limited to 32bit.\n");
+		return;
+	}
 	if (!delay_calibrated) {
 		pr_info("Switching to timer-based delay loop\n");
 		delay_timer			= timer;
@@ -79,6 +84,7 @@ void __init register_current_timer_delay(const struct delay_timer *timer)
 		arm_delay_ops.delay		= __timer_delay;
 		arm_delay_ops.const_udelay	= __timer_const_udelay;
 		arm_delay_ops.udelay		= __timer_udelay;
+		arm_delay_ops.mask		= (1ULL << timer->bits) - 1;
 
 		delay_calibrated		= true;
 	} else {
diff --git a/arch/arm/mach-imx/time.c b/arch/arm/mach-imx/time.c
index 65222ea..7ee80f5 100644
--- a/arch/arm/mach-imx/time.c
+++ b/arch/arm/mach-imx/time.c
@@ -131,6 +131,7 @@ static int __init mxc_clocksource_init(struct clk *timer_clk)
 
 	imx_delay_timer.read_current_timer = &imx_read_current_timer;
 	imx_delay_timer.freq = c;
+	imx_delay_timer.bits = 32;
 	register_current_timer_delay(&imx_delay_timer);
 
 	sched_clock_reg = reg;
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index a709cfa..aec6a61 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -241,6 +241,7 @@ static void __init nmdk_timer_init(void __iomem *base, int irq,
 
 	mtu_delay_timer.read_current_timer = &nmdk_timer_read_current_timer;
 	mtu_delay_timer.freq = rate;
+	mtu_delay_timer.bits = 32;
 	register_current_timer_delay(&mtu_delay_timer);
 }
 
diff --git a/drivers/clocksource/timer-u300.c b/drivers/clocksource/timer-u300.c
index 5dcf756..39633aa 100644
--- a/drivers/clocksource/timer-u300.c
+++ b/drivers/clocksource/timer-u300.c
@@ -389,6 +389,7 @@ static void __init u300_timer_init_of(struct device_node *np)
 
 	u300_delay_timer.read_current_timer = &u300_read_current_timer;
 	u300_delay_timer.freq = rate;
+	u300_delay_timer.bits = 32;
 	register_current_timer_delay(&u300_delay_timer);
 
 	/*

Is this what you had in mind? If so, there is one user of
register_current_timer_delay() which I didn't convert. That is
arch_timer_delay_timer_register(). It returns arch_counter_get_cntvct()
which seems to return an u64 (which is truncated to 32bit). However
arch_counter_register() registers the clocksource with 56bits. So this
does not look too good, right?
The other thing I noticed is
|arch/arm/include/asm/timex.h:typedef unsigned long cycles_t;

This works for clocksource because timekeeping is using
|include/linux/clocksource.h:typedef u64 cycle_t;

instead.
Do I assume correct, that the arch_timer is really providing a number
wider than 32bit? Shouldn't I then promote cycles_t to 64bit if that
timer is active? Unless you have better suggestions of course :)

>Will

Sebastian
