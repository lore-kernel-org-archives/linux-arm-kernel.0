From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Wed, 20 Jun 2018 13:18:33 +0200
Subject: [PATCH v5 2/6] clocksource/drivers: Add a new driver for the
 Atmel ARM TC blocks
In-Reply-To: <alpine.DEB.2.21.1806201244110.10546@nanos.tec.linutronix.de>
References: <20180619211929.22908-1-alexandre.belloni@bootlin.com>
 <20180619211929.22908-3-alexandre.belloni@bootlin.com>
 <alpine.DEB.2.21.1806201037240.10546@nanos.tec.linutronix.de>
 <20180620094649.GA2766@piout.net>
 <alpine.DEB.2.21.1806201156510.10546@nanos.tec.linutronix.de>
 <20180620103259.GA7737@piout.net>
 <alpine.DEB.2.21.1806201244110.10546@nanos.tec.linutronix.de>
Message-ID: <20180620111833.GE7737@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/06/2018 12:58:01+0200, Thomas Gleixner wrote:
> > There are only a count up and count up then down modes. As the counter
> > value is in a read only register, the only configurable starting value
> > is 0 so it will always start by counting up. I'm pretty sure the up/down
> > mode will not help us.
> 
> Hmm, fair enough.
> 
> Though the manual says:
> 
>      A trigger resets the counter and starts the counter clock. Three types
>      of triggers are common to both modes, and a fourth external trigger is
>      available to each mode.
> 
>      ...
> 
>      Software Trigger: Each channel has a software trigger, available by
>      setting SWTRG in TC_CCR.
> 
> So the question is whether you can't do the following:
> 
>      stop_counter()
>      issue_sw_trigger()  ---> resets the counter to zero
>      write_compare()
>      start_counter()
> 
> So that should avoid all te mess with comparing to the free running counter
> as long as you have two blocks of counters, but then one of them will be
> 16bit only assumed that there are always 3 counter channels in the TC.
> 
> Just a thought, but the code you have should work as well.
> 

Ah yes, sure, I misunderstood your first comment then. the driver will
register one or two clockevent devices, depending on the number of
available channels.

The first one is based on the clocksource counter and does the counter
comparison you don't like. the second one uses its own channel in the
way you describe (set RC, reset counter, start counter).

This was necessary because some people are running out of TCB channels
as they use the remaining ones as PWMs. But it is still better to use
one channel as clocksource and clockevent that use the PIT.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
