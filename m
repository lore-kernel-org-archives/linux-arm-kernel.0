From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 29 Mar 2018 12:45:42 +0200
Subject: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
In-Reply-To: <3478710.yJBBt3uoRT@ada>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
 <20180328153135.GG13942@piout.net>
 <20180328155033.GH13942@piout.net> <3478710.yJBBt3uoRT@ada>
Message-ID: <20180329104542.GK13942@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/03/2018 at 10:01:26 +0200, Alexander Dahl wrote:
> Hei hei,
> 
> Am Mittwoch, 28. M?rz 2018, 17:50:33 CEST schrieb Alexandre Belloni:
> > On 28/03/2018 at 17:31:35 +0200, Alexandre Belloni wrote:
> > > > Do you have an explanation of why the rate is much higher ?
> > > 
> > > The core is giving deltas of 31 clocks instead of much more than that, I
> > > guess I messed up the initialization somewhere.
> > 
> > I did mess up.
> > 
> > Alexander, can you test that:
> 
> Well, I just did.
> 
> > 
> > diff --git a/drivers/clocksource/timer-atmel-tcb.c
> > b/drivers/clocksource/timer-atmel-tcb.c index 7fde9cfbf203..bbbacf8c46b0
> > 100644
> > --- a/drivers/clocksource/timer-atmel-tcb.c
> > +++ b/drivers/clocksource/timer-atmel-tcb.c
> > @@ -222,7 +222,7 @@ static int __init tc_clkevt_register(struct device_node
> > *node, goto err_slow;
> >  	clk_disable(tce.clk);
> > 
> > -	clockevents_config_and_register(&tce.clkevt, 32768, 1, bits - 1);
> > +	clockevents_config_and_register(&tce.clkevt, 32768, 1, BIT(bits) - 1);
> > 
> >  	ret = request_irq(tce.irq, tc_clkevt2_irq, IRQF_TIMER | IRQF_SHARED,
> >  			  tce.clkevt.name, &tce);
> > 
> > This will behave exactly the same as before on 16bits TCB and will have
> > much less interrupts on 32 bits platforms.
> 
> This is the result:
> 
> INT                NAME          RATE             MAX
>  17 [vel     timer at fffa]  1837 Ints/s     (max:  1912)
>  26 [      vel     eth0]     3 Ints/s     (max:    11)
> 
> This is not much lower than the ~2150 I reported yesterday?
> 
> I'm sorry I can just test this on at91sam9g20 currently, I have no 
> understanding of the subsystem, I can't do a decent review.

Hum, are you sure, I went from:

INT                NAME          RATE             MAX
 16 [evel     timer at fc0]  1027 Ints/s     (max:  1028)
 21 [ evel     at_xdmac]     3 Ints/s     (max:     3)
 30 [    evel     ttyS0]     2 Ints/s     (max:     2)

to:

INT                NAME          RATE             MAX
 16 [evel     timer at fc0]     6 Ints/s     (max:     9)
 21 [ evel     at_xdmac]     2 Ints/s     (max:     2)
 30 [    evel     ttyS0]     2 Ints/s     (max:     2)



-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
