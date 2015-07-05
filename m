From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 5 Jul 2015 09:07:19 +0530
Subject: [PATCH 16/41] clocksource: pxa: Migrate to new 'set-state'
 interface
In-Reply-To: <87h9pk9bfe.fsf@belgarion.home>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <cover.1434622147.git.viresh.kumar@linaro.org>
 <3aa5c1a740911258698769cbbb8f60ee02178848.1434622147.git.viresh.kumar@linaro.org>
 <87h9pk9bfe.fsf@belgarion.home>
Message-ID: <20150705033719.GC7510@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

On 04-07-15, 17:42, Robert Jarzmik wrote:
> > +	/* initializing, released, or preparing for suspend */
> > +	timer_writel(timer_readl(OIER) & ~OIER_E0, OIER);
> > +	timer_writel(OSSR_M0, OSSR);
> > +	return 0;
> For consistency, please leave an empty line before that return statement.

Its already applied by Daniel now, and the change is too trivial to
request for an update to his tree. Maybe we should leave it as is for
now.

> > @@ -147,13 +133,14 @@ static void pxa_timer_resume(struct clock_event_device *cedev)
> >  #endif
> >  
> >  static struct clock_event_device ckevt_pxa_osmr0 = {
> > -	.name		= "osmr0",
> > -	.features	= CLOCK_EVT_FEAT_ONESHOT,
> > -	.rating		= 200,
> > -	.set_next_event	= pxa_osmr0_set_next_event,
> > -	.set_mode	= pxa_osmr0_set_mode,
> > -	.suspend	= pxa_timer_suspend,
> > -	.resume		= pxa_timer_resume,
> > +	.name			= "osmr0",
> > +	.features		= CLOCK_EVT_FEAT_ONESHOT,
> > +	.rating			= 200,
> > +	.set_next_event		= pxa_osmr0_set_next_event,
> > +	.set_state_shutdown	= pxa_osmr0_shutdown,
> > +	.set_state_oneshot	= pxa_osmr0_shutdown,
> A bit weird to have a "set_state_oneshot" function to point to a function called
> "X_shutdown".

What's weird (or looks weird) is that we stop the timer when requested
to switch to oneshot mode. But that's what we really wanted, because
set_next_event is the one that will program the timer in oneshot mode.

> As I don't have a clear idea on what's this new interface for,

It just provides per-state API's for what's being done in set_mode()
earlier.

> I'll just hope it's the intended purpose. The code does look equivalent to me
> anyway.
> 
> Apart from the cosmetic comment, once it is fixed :
> Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Thanks.

-- 
viresh
