From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 May 2015 18:19:06 +0200
Subject: [PATCH] bus: arm-ccn: Use hrtimer_start()
In-Reply-To: <1431532027.3285.107.camel@arm.com>
References: <alpine.DEB.2.11.1505131712320.4225@nanos>
 <2646197.ZVRR8xztig@wuerfel> <1431532027.3285.107.camel@arm.com>
Message-ID: <2471873.V16atfgj9f@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 May 2015 16:47:07 Pawel Moll wrote:
> On Wed, 2015-05-13 at 16:32 +0100, Arnd Bergmann wrote:
> > On Wednesday 13 May 2015 16:21:24 Pawel Moll wrote:
> > > diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
> > > index df5f307..7d9879e 100644
> > > --- a/drivers/bus/arm-ccn.c
> > > +++ b/drivers/bus/arm-ccn.c
> > > @@ -921,9 +921,8 @@ static void arm_ccn_pmu_event_start(struct perf_event *event, int flags)
> > >          * attribute).
> > >          */
> > >         if (!ccn->irq)
> > > -               __hrtimer_start_range_ns(&ccn->dt.hrtimer,
> > > -                               arm_ccn_pmu_timer_period(), 0,
> > > -                               HRTIMER_MODE_REL_PINNED, 0);
> > > +               hrtimer_start(&ccn->dt.hrtimer, arm_ccn_pmu_timer_period(),
> > > +                               HRTIMER_MODE_REL_PINNED);
> > >  
> > >         /* Set the DT bus input, engaging the counter */
> > >         arm_ccn_pmu_xp_dt_config(event, 1);
> > 
> > Is this correct by itself, or do we need to pull in the branch that
> > contains c6eb3f70d44828 ("hrtimer: Get rid of hrtimer softirq")
> > from Thomas? The other similar patches that Thomas did contain a
> > comment about the conversion being safe after hrtimer_start()
> > no longer uses a softirq, but it is still in use in 4.1-rc3.
> 
> That's why I asked who should carry this patch 
> 
> Now, the answer to your question is: the result will not be worse than
> the what was there before you pulled my updates, as the code was using
> normal hrtimer_start(). It's just when I realised that it should be
> pinned I looked at what x86 uncore pmu is doing and shamelessly (and
> probably a bit mindlessly) copied the "do not wakeup" version from
> there.

Ok, got it. I've rewritten the commit message now to reflect this,
and have applied your patch on top of the next/drivers branch.

Thanks a lot for the fast roundtrip in fixing it. Hopefully, tomorrow's
linux-next works better now.

	Arnd

commit a78a3c8ef715b94de3ab27633866d4bde3e2226f
Author: Pawel Moll <pawel.moll@arm.com>
Date:   Wed May 13 16:21:24 2015 +0100

    bus: arm-ccn: Use hrtimer_start() again
    
    hrtimer_start() will no longer defer already expired timers to the
    softirq in 4.2, and the __hrtimer_start_range_ns() function is
    getting removed, causing build errors when both the tip tree and
    the arm-ccn changes are merged.
    
    This changes the code back to using hrtimer_start, which will
    do the right thing after this branch gets merged with the
    timers update from tip.
    
    As pointed out after a discussion on the mailing list, the result will
    not be worse than the what was there before you pulled my updates, as
    the code was using normal hrtimer_start(). It's just when I realised
    that it should be pinned I looked at what x86 uncore pmu is doing and
    shamelessly (and probably a bit mindlessly) copied the "do not wakeup"
    version from there.
    
    Reported-by: Mark Brown <mark.brown@arm.com>
    Signed-off-by: Pawel Moll <pawel.moll@arm.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
index df5f307f3244..7d9879e166cf 100644
--- a/drivers/bus/arm-ccn.c
+++ b/drivers/bus/arm-ccn.c
@@ -921,9 +921,8 @@ static void arm_ccn_pmu_event_start(struct perf_event *event, int flags)
 	 * attribute).
 	 */
 	if (!ccn->irq)
-		__hrtimer_start_range_ns(&ccn->dt.hrtimer,
-				arm_ccn_pmu_timer_period(), 0,
-				HRTIMER_MODE_REL_PINNED, 0);
+		hrtimer_start(&ccn->dt.hrtimer, arm_ccn_pmu_timer_period(),
+				HRTIMER_MODE_REL_PINNED);
 
 	/* Set the DT bus input, engaging the counter */
 	arm_ccn_pmu_xp_dt_config(event, 1);
