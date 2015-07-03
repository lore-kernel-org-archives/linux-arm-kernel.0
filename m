From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 3 Jul 2015 14:26:19 +0530
Subject: [PATCH 41/41] clocksource: zevio: Migrate to new 'set-state'
 interface
In-Reply-To: <55959B0F.5000306@linaro.org>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <2492473d6bb8f057af389d6db24af77462af2468.1434622147.git.viresh.kumar@linaro.org>
 <55959B0F.5000306@linaro.org>
Message-ID: <20150703085619.GD23297@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02-07-15, 22:11, Daniel Lezcano wrote:
> On 06/18/2015 12:54 PM, Viresh Kumar wrote:
> >Migrate zevio driver to the new 'set-state' interface provided by
> >clockevents core, the earlier 'set-mode' interface is marked obsolete
> >now.
> >
> >This also enables us to implement callbacks for new states of clockevent
> >devices, for example: ONESHOT_STOPPED.
> >
> >Cc: Daniel Tang <dt.tangr@gmail.com>
> >Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> >---
> 
> [ ... ]
> 
> >  static irqreturn_t zevio_timer_interrupt(int irq, void *dev_id)
> >@@ -162,7 +158,9 @@ static int __init zevio_timer_add(struct device_node *node)
> >  	if (timer->interrupt_regs && irqnr) {
> >  		timer->clkevt.name		= timer->clockevent_name;
> >  		timer->clkevt.set_next_event	= zevio_timer_set_event;
> >-		timer->clkevt.set_mode		= zevio_timer_set_mode;
> >+		timer->clkevt.set_state_shutdown = zevio_timer_shutdown;
> >+		timer->clkevt.set_state_oneshot = zevio_timer_set_oneshot;
> >+		timer->clkevt.tick_resume	= zevio_timer_set_oneshot;
> 
> Why is tick_resume added here ?

I am assuming you are lost because of reviewing too many similar
patches, but anyway below was part of the diff and so resume was
required :)

-       switch (mode) {
-       case CLOCK_EVT_MODE_RESUME:
-       case CLOCK_EVT_MODE_ONESHOT:
-               /* Enable timer interrupts */
-               writel(TIMER_INTR_MSK, timer->interrupt_regs + IO_INTR_MSK);
-               writel(TIMER_INTR_ALL, timer->interrupt_regs + IO_INTR_ACK);
-               break;

-- 
viresh
