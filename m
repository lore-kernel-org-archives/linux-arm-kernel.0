From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Nov 2015 11:33:12 +0100
Subject: [PATCH] clocksource/drivers/arm_global_timer: Always use
 {readl|writel}_relaxed
In-Reply-To: <20151113175948.69f610e9@xhacker>
References: <1447403678-7217-1-git-send-email-jszhang@marvell.com>
 <10575502.sxpiT76bOp@wuerfel> <20151113175948.69f610e9@xhacker>
Message-ID: <25602407.8sIohphlWH@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 November 2015 17:59:48 Jisheng Zhang wrote:
> On Fri, 13 Nov 2015 10:28:01 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 13 November 2015 16:40:25 Jisheng Zhang wrote:
> > > On Fri, 13 Nov 2015 16:34:38 +0800
> > > > diff --git a/drivers/clocksource/arm_global_timer.c b/drivers/clocksource/arm_global_timer.c
> > > > index a2cb6fa..84a5a5d 100644
> > > > --- a/drivers/clocksource/arm_global_timer.c
> > > > +++ b/drivers/clocksource/arm_global_timer.c
> > > > @@ -99,27 +99,27 @@ static void gt_compare_set(unsigned long delta, int periodic)
> > > >  
> > > >  	counter += delta;
> > > >  	ctrl = GT_CONTROL_TIMER_ENABLE;
> > > > -	writel(ctrl, gt_base + GT_CONTROL);
> > > > -	writel(lower_32_bits(counter), gt_base + GT_COMP0);
> > > > -	writel(upper_32_bits(counter), gt_base + GT_COMP1);
> > > > +	writel_relaxed(ctrl, gt_base + GT_CONTROL);
> > > > +	writel_relaxed(lower_32_bits(counter), gt_base + GT_COMP0);
> > > > +	writel_relaxed(upper_32_bits(counter), gt_base + GT_COMP1);
> > > >  
> > > >  	if (periodic) {
> > > > -		writel(delta, gt_base + GT_AUTO_INC);
> > > > +		writel_relaxed(delta, gt_base + GT_AUTO_INC);
> > > >  		ctrl |= GT_CONTROL_AUTO_INC;
> > > >  	}
> > > >  
> > > >  	ctrl |= GT_CONTROL_COMP_ENABLE | GT_CONTROL_IRQ_ENABLE;
> > > > -	writel(ctrl, gt_base + GT_CONTROL);
> > > > +	writel_relaxed(ctrl, gt_base + GT_CONTROL);
> > > >  }  
> > 
> > This seems fine. Do you have any performance numbers to show how much
> > we save per call on a platform you care about, and how often it is
> > called for a typical workload?
> 
> To be honest, all my platforms don't make use of global timer for clockevent,
> we use dw_apb_timer and twd or arch_timer instead, but one performance impact
> I saw in our case can also apply for the case with global timer as clokevent:
> 
> there are 500-1000 short sleeps, yes not good userspace behavior, so we
> program clockevent device 500-1000 times/s. If the system is powered by CA9
> with outer L2 cache, the writel will contend for l2x0_lock for 500-1000 times/s.
> Then the L2 cache maintenance from other device driver have more chance to
> spinning at the l2x0_lock, so other device driver performance is impacted.

Just to make sure I get this right: which outer cache implementation do you
use in this case? Most Cortex-A9 use pl310, which does not require l2x0_lock
for outer_cache.sync(). The Aurora outer cache sync has a different method
and also doesn't use l2x0_lock. Finally, tauros3 doesn't need a cache sync
at all.

Did you look at an older kernel version? We used to do a loop in the
Aurora cache sync operation until I fixed that, so it should be a bit
faster now. It will still require doing the actual sync, but at least
there should not be any lock contention these days.

	Arnd
