From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 13 May 2015 16:47:07 +0100
Subject: [PATCH] bus: arm-ccn: Use hrtimer_start()
In-Reply-To: <2646197.ZVRR8xztig@wuerfel>
References: <alpine.DEB.2.11.1505131712320.4225@nanos>
 <1431530484-3389-1-git-send-email-pawel.moll@arm.com>
 <2646197.ZVRR8xztig@wuerfel>
Message-ID: <1431532027.3285.107.camel@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-05-13 at 16:32 +0100, Arnd Bergmann wrote:
> On Wednesday 13 May 2015 16:21:24 Pawel Moll wrote:
> > diff --git a/drivers/bus/arm-ccn.c b/drivers/bus/arm-ccn.c
> > index df5f307..7d9879e 100644
> > --- a/drivers/bus/arm-ccn.c
> > +++ b/drivers/bus/arm-ccn.c
> > @@ -921,9 +921,8 @@ static void arm_ccn_pmu_event_start(struct perf_event *event, int flags)
> >          * attribute).
> >          */
> >         if (!ccn->irq)
> > -               __hrtimer_start_range_ns(&ccn->dt.hrtimer,
> > -                               arm_ccn_pmu_timer_period(), 0,
> > -                               HRTIMER_MODE_REL_PINNED, 0);
> > +               hrtimer_start(&ccn->dt.hrtimer, arm_ccn_pmu_timer_period(),
> > +                               HRTIMER_MODE_REL_PINNED);
> >  
> >         /* Set the DT bus input, engaging the counter */
> >         arm_ccn_pmu_xp_dt_config(event, 1);
> 
> Is this correct by itself, or do we need to pull in the branch that
> contains c6eb3f70d44828 ("hrtimer: Get rid of hrtimer softirq")
> from Thomas? The other similar patches that Thomas did contain a
> comment about the conversion being safe after hrtimer_start()
> no longer uses a softirq, but it is still in use in 4.1-rc3.

That's why I asked who should carry this patch ;-)

Now, the answer to your question is: the result will not be worse than
the what was there before you pulled my updates, as the code was using
normal hrtimer_start(). It's just when I realised that it should be
pinned I looked at what x86 uncore pmu is doing and shamelessly (and
probably a bit mindlessly) copied the "do not wakeup" version from
there.

Pawel
