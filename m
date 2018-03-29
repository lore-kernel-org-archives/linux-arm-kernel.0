From: alexandre.belloni@bootlin.com (Alexandre Belloni)
Date: Thu, 29 Mar 2018 15:02:20 +0200
Subject: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
In-Reply-To: <e3235587-8362-e1fc-a813-39f790a1c8b4@linaro.org>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
 <3478710.yJBBt3uoRT@ada> <20180329104542.GK13942@piout.net>
 <3103570.fW0XyqvKVi@ada> <20180329114255.GL13942@piout.net>
 <e3235587-8362-e1fc-a813-39f790a1c8b4@linaro.org>
Message-ID: <20180329130220.GM13942@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/03/2018 at 14:07:34 +0200, Daniel Lezcano wrote:
> On 29/03/2018 13:42, Alexandre Belloni wrote:
> > On 29/03/2018 at 13:31:18 +0200, Alexander Dahl wrote:
> >> Pretty sure. I rebuilt the whole BSP and added another line to the kernel 
> >> source to see if the tree I applied the patches to, was actually built:
> >>
> >>
> >> diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/timer-atmel-tcb.c
> >> index 7fde9cfbf203..f85affc74a86 100644
> >> --- a/drivers/clocksource/timer-atmel-tcb.c
> >> +++ b/drivers/clocksource/timer-atmel-tcb.c
> >> @@ -222,7 +222,8 @@ static int __init tc_clkevt_register(struct device_node *node,
> >>                 goto err_slow;
> >>         clk_disable(tce.clk);
> >>  
> >> -       clockevents_config_and_register(&tce.clkevt, 32768, 1, bits - 1);
> >> +       pr_info( "*** bits: 0x%x, BIT(bits): 0x%lx\n", bits, BIT(bits) );
> >> +       clockevents_config_and_register(&tce.clkevt, 32768, 1, BIT(bits) - 1);
> >>  
> >>         ret = request_irq(tce.irq, tc_clkevt2_irq, IRQF_TIMER | IRQF_SHARED,
> >>                           tce.clkevt.name, &tce);
> >>
> >>
> > 
> > I've just tested on a g20, old driver:
> > INT                NAME          RATE             MAX
> >  16 [vel     at91_tick,]   175 Ints/s     (max:   231)
> >  19 [ vel     tc_clkevt]   129 Ints/s     (max:   129)
> > 
> > 
> > new driver:
> > INT                NAME          RATE             MAX
> >  17 [vel     timer at fffa]   129 Ints/s     (max:   129)
> >  18 [     vel     ttyS0]   175 Ints/s     (max:   231)
> 
> Can you give in both platforms how fast the clocksource wraps up ?
> 

sam9g20, old:
clocksource: pit: mask: 0xfffffff max_cycles: 0xfffffff, max_idle_ns: 14370379250 ns
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
clocksource: tcb_clksrc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 114963034405 ns

sam9g20, new:
clocksource: timer at fffa0000:0,1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 114963034405 ns
sched_clock: 32 bits at 16MHz, resolution 60ns, wraps every 129171948513ns

sama5d4, old:
clocksource: pit: mask: 0x7ffffff max_cycles: 0x7ffffff, max_idle_ns: 10859434279 ns
sched_clock: 32 bits at 100 Hz, resolution 10000000ns, wraps every 21474836475000000ns
clocksource: tcb_clksrc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 173750949719 ns

sama5d4, new:
clocksource: timer at fc024000:0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 173750949719 ns
sched_clock: 32 bits at 11MHz, resolution 90ns, wraps every 195225786322ns

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
