From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 25 Apr 2013 16:18:51 +0200 (CEST)
Subject: RFC: [PATCH] clocksource: tcb: fix min_delta calculation
In-Reply-To: <51793172.9030802@pengutronix.de>
References: <517687AB.1040309@pengutronix.de>
 <1366722524-25991-1-git-send-email-mkl@pengutronix.de>
 <51793172.9030802@pengutronix.de>
Message-ID: <alpine.LFD.2.02.1304251618220.21884@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 25 Apr 2013, Marc Kleine-Budde wrote:

> On 04/23/2013 03:08 PM, Marc Kleine-Budde wrote:
> > The commit
> > 
> >     77cc982 clocksource: use clockevents_config_and_register() where possible
> > 
> > switches from manually calculating min_delta_ns (and others) and
> > clockevents_register_device() to automatic calculation via
> > clockevents_config_and_register(). During this conversation the "+ 1" in
> > 
> >     min_delta_ns = clockevent_delta2ns(1, &clkevt.clkevt) + 1;
> > 
> > was lost. This leads to problems with schedule_delayed_work() with a delay of
> > "1". Resulting in the work not scheduled in time.
> > 
> > This patch fixes the problem by increasing the min_delta to "2" ticks.
> > 
> > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> 
> Who will take care of this patch?

If you had cc'ed me in the first place ...
 
> Marc
> 
> > ---
> >  drivers/clocksource/tcb_clksrc.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clocksource/tcb_clksrc.c b/drivers/clocksource/tcb_clksrc.c
> > index 8a61872..7cf6dc7 100644
> > --- a/drivers/clocksource/tcb_clksrc.c
> > +++ b/drivers/clocksource/tcb_clksrc.c
> > @@ -197,7 +197,7 @@ static void __init setup_clkevents(struct atmel_tc *tc, int clk32k_divisor_idx)
> >  
> >  	clkevt.clkevt.cpumask = cpumask_of(0);
> >  
> > -	clockevents_config_and_register(&clkevt.clkevt, 32768, 1, 0xffff);
> > +	clockevents_config_and_register(&clkevt.clkevt, 32768, 2, 0xffff);
> >  
> >  	setup_irq(irq, &tc_irqaction);
> >  }
> > 
> 
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
> 
