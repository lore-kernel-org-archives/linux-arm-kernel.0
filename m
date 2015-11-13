From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 13 Nov 2015 17:59:48 +0800
Subject: [PATCH] clocksource/drivers/arm_global_timer: Always use
 {readl|writel}_relaxed
In-Reply-To: <10575502.sxpiT76bOp@wuerfel>
References: <1447403678-7217-1-git-send-email-jszhang@marvell.com>
 <20151113164025.344a0faf@xhacker>	<10575502.sxpiT76bOp@wuerfel>
Message-ID: <20151113175948.69f610e9@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd,

On Fri, 13 Nov 2015 10:28:01 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> On Friday 13 November 2015 16:40:25 Jisheng Zhang wrote:
> > On Fri, 13 Nov 2015 16:34:38 +0800
> > Jisheng Zhang <jszhang@marvell.com> wrote:
> >   
> > > This driver use both readl/writel and their relaxed version, this patch
> > > tries to unify the io accesses.  
> > 
> > I'm sorry. This is the version I'd like to send for review and merge. Can you
> > please kindly have a review?  
> 
> I would prefer to use write_relaxed() as sparingly as we can, it is too
> hard to verify each case to ensure that we don't have to watch out
> for ordering or locking issues.
> 
> > > diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> > > index a2cb6fa..84a5a5d 100644
> > > --- a/drivers/clocksource/arm_global_timer.c
> > > +++ b/drivers/clocksource/arm_global_timer.c
> > > @@ -99,27 +99,27 @@ static void gt_compare_set(unsigned long delta, int periodic)
> > >  
> > >  	counter += delta;
> > >  	ctrl = GT_CONTROL_TIMER_ENABLE;
> > > -	writel(ctrl, gt_base + GT_CONTROL);
> > > -	writel(lower_32_bits(counter), gt_base + GT_COMP0);
> > > -	writel(upper_32_bits(counter), gt_base + GT_COMP1);
> > > +	writel_relaxed(ctrl, gt_base + GT_CONTROL);
> > > +	writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
> > > +	writel_relaxed(upper_32_bits(counter), gt_base + GT_COMP1);
> > >  
> > >  	if (periodic) {
> > > -		writel(delta, gt_base + GT_AUTO_INC);
> > > +		writel_relaxed(delta, gt_base + GT_AUTO_INC);
> > >  		ctrl |= GT_CONTROL_AUTO_INC;
> > >  	}
> > >  
> > >  	ctrl |= GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE;
> > > -	writel(ctrl, gt_base + GT_CONTROL);
> > > +	writel_relaxed(ctrl, gt_base + GT_CONTROL);
> > >  }  
> 
> This seems fine. Do you have any performance numbers to show how much
> we save per call on a platform you care about, and how often it is
> called for a typical workload?

To be honest, all my platforms don't make use of global timer for clockevent,
we use dw_apb_timer and twd or arch_timer instead, but one performance impact
I saw in our case can also apply for the case with global timer as clokevent:

there are 500-1000 short sleeps, yes not good userspace behavior, so we
program clockevent device 500-1000 times/s. If the system is powered by CA9
with outer L2 cache, the writel will contend for l2x0_lock for 500-1000 times/s.
Then the L2 cache maintenance from other device driver have more chance to
spinning at the l2x0_lock, so other device driver performance is impacted.

Thanks,
Jisheng

> 
> I see that _gt_counter_read() already uses readl_relaxed(), and it
> seems to be a much bigger win there, as we read the clock more
> often than we write the comparator, so the person who did that
> probably thought that this one wasn't important enough. Can you
> add an explanation in the changelog why you think that was a
> mistake?
> 
> Unifying the accessors across a driver is not enough of a reason
> I think.
> 
> > >  static int gt_clockevent_shutdown(struct clock_event_device *evt)
> > >  {
> > >  	unsigned long ctrl;
> > >  
> > > -	ctrl = readl(gt_base + GT_CONTROL);
> > > +	ctrl = readl_relaxed(gt_base + GT_CONTROL);
> > >  	ctrl &= ~(GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE |
> > >  		  GT_CONTROL_AUTO_INC);
> > > -	writel(ctrl, gt_base + GT_CONTROL);
> > > +	writel_relaxed(ctrl, gt_base + GT_CONTROL);
> > >  	return 0;
> > >  }  
> 
> This is certainly not performance critical, better leave it using
> the standard accessors.
> 
> > > @@ -212,11 +212,11 @@ static u64 notrace gt_sched_clock_read(void)
> > >  
> > >  static void __init gt_clocksource_init(void)
> > >  {
> > > -	writel(0, gt_base + GT_CONTROL);
> > > -	writel(0, gt_base + GT_COUNTER0);
> > > -	writel(0, gt_base + GT_COUNTER1);
> > > +	writel_relaxed(0, gt_base + GT_CONTROL);
> > > +	writel_relaxed(0, gt_base + GT_COUNTER0);
> > > +	writel_relaxed(0, gt_base + GT_COUNTER1);
> > >  	/* enables timer on all the cores */
> > > -	writel(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
> > > +	writel_relaxed(GT_CONTROL_TIMER_ENABLE, gt_base + GT_CONTROL);
> > >  
> > >  #ifdef CONFIG_CLKSRC_ARM_GLOBAL_TIMER_SCHED_CLOCK
> > >  	sched_clock_register(gt_sched_clock_read, 64, gt_clk_rate);  
> > 
> >   
> 
> Same here.
> 
> 	Arnd
