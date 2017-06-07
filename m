From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 7 Jun 2017 23:38:10 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170607150908.kytgtzwgjjnxtsp3@piout.net>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai>
 <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai>
 <20170607150908.kytgtzwgjjnxtsp3@piout.net>
Message-ID: <20170607213810.GK2345@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 05:09:08PM +0200, Alexandre Belloni wrote:
> On 07/06/2017 at 16:17:35 +0200, Daniel Lezcano wrote:
> > > > > This driver uses regmap and syscon to be able to probe early in the boot
> > > > > and avoid having to switch on the TCB clocksource later. Using regmap also
> > > > > means that unused TCB channels may be used by other drivers (PWM for
> > > > > example).
> > > > 
> > > > Can you give more details, I fail to understand how regmap and syscon help to
> > > > probe sooner than timer_init()?
> > > 
> > > 
> > > Because before that, the tcb driver relied on atmel_tclib to share the
> > > TCBs and it happened way too late, at arch_initcall() time.
> > 
> > So is it still necesary to use regmap? I would like to take the opportunity to
> > move the init routine to the common init routine if possible:
> > 
> > 	https://patchwork.kernel.org/patch/9768845/
> > 
> 
> It is still necessary because we want to be able to share the timer
> between multiple drivers. For example, you can have the clocksource on
> channel 0, clockevent on channel 1 and a pwm on channel 2

The hardware timer can be shared, the channels used in different subsystem.

Each channel are used exclusively.

What is the benefit of regmap? It has a cost, and takes a lock at each read.

For instance:

+static u64 tc_get_cycles(struct clocksource *cs)
+{
+	u32		lower, upper, tmp;
+
+	do {
+		regmap_read(tc.regmap, ATMEL_TC_CV(1), &upper);
+		regmap_read(tc.regmap, ATMEL_TC_CV(0), &lower);
+		regmap_read(tc.regmap, ATMEL_TC_CV(1), &tmp);
+	} while (upper != tmp);
+
+	return (upper << 16) | lower;
+}

Is:

+static u64 tc_get_cycles(struct clocksource *cs)
+{
+	u32		lower, upper, tmp;
+
+	do {
+		regmap_read(tc.regmap, ATMEL_TC_CV(1), &upper);
			lock();
			lot-of-things();
			unlock();
+		regmap_read(tc.regmap, ATMEL_TC_CV(0), &lower);
			lock();
			lot-of-things();
			unlock();
+		regmap_read(tc.regmap, ATMEL_TC_CV(1), &tmp);
			lock();
			lot-of-things();
			unlock();
+	} while (upper != tmp);
+
+	return (upper << 16) | lower;
+}

I suggest to look what is in 'lot-of-things()' and especially what is doing
regcache_read().

May be you can reconsider the regmap? This driver is the only one use the
regmap AFAICT and I don't think it is adequate.

> > > > Can you explain why we have two clocks here?
> > > > 
> > > 
> > > Each channel have its clock, I can add a comment if you want.
> > 
> > I don't understand. Why do we have two clocks?
> > 
> > One channel is driven by one clock and the second one takes the overflow signal
> > from the first one, so no second clock is involved there, no?
> > 
> 
> Those are the peripheral clocks, they are not used by the counters but
> used to be able to read/write the registers.

Mmh, strange. Why is the clk[0]'s rate used in this case?

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
