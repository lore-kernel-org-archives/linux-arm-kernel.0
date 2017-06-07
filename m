From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 7 Jun 2017 17:09:08 +0200
Subject: [PATCH 46/58] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <20170607141735.GH2345@mai>
References: <20170530215139.9983-1-alexandre.belloni@free-electrons.com>
 <20170530215139.9983-47-alexandre.belloni@free-electrons.com>
 <20170606152104.GC2345@mai>
 <20170606180559.pkrr7ux2qqnmsd6y@piout.net>
 <20170607141735.GH2345@mai>
Message-ID: <20170607150908.kytgtzwgjjnxtsp3@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2017 at 16:17:35 +0200, Daniel Lezcano wrote:
> > > > This driver uses regmap and syscon to be able to probe early in the boot
> > > > and avoid having to switch on the TCB clocksource later. Using regmap also
> > > > means that unused TCB channels may be used by other drivers (PWM for
> > > > example).
> > > 
> > > Can you give more details, I fail to understand how regmap and syscon help to
> > > probe sooner than timer_init()?
> > 
> > 
> > Because before that, the tcb driver relied on atmel_tclib to share the
> > TCBs and it happened way too late, at arch_initcall() time.
> 
> So is it still necesary to use regmap? I would like to take the opportunity to
> move the init routine to the common init routine if possible:
> 
> 	https://patchwork.kernel.org/patch/9768845/
> 

It is still necessary because we want to be able to share the timer
between multiple drivers. For example, you can have the clocksource on
channel 0, clockevent on channel 1 and a pwm on channel 2

> > > Can you explain why we have two clocks here?
> > > 
> > 
> > Each channel have its clock, I can add a comment if you want.
> 
> I don't understand. Why do we have two clocks?
> 
> One channel is driven by one clock and the second one takes the overflow signal
> from the first one, so no second clock is involved there, no?
> 

Those are the peripheral clocks, they are not used by the counters but
used to be able to read/write the registers.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
