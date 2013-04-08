From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Mon, 08 Apr 2013 21:27:40 +0200
Subject: [PATCH 7/9] intel: cpuidle: remove stop/start critical timings
In-Reply-To: <51630115.6040205@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
 <5161DC9C.3020703@linaro.org> <51630115.6040205@linaro.org>
Message-ID: <6514915.cyFSTtqpte@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, April 08, 2013 07:40:37 PM Daniel Lezcano wrote:
> On 04/07/2013 10:52 PM, Daniel Lezcano wrote:
> > On 04/05/2013 12:31 AM, Rafael J. Wysocki wrote:
> >> On Wednesday, April 03, 2013 02:15:20 PM Daniel Lezcano wrote:
> >>> The start/stop_critical_timings are called from arch/x86/kernel/process.c
> >>> in the cpu_idle loop function.
> >>>
> >>> Remove the ones in the cpuidle driver.
> >>>
> >>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> For this one I need an ACK from Len.
> >>
> >> Len, any objections?
> >
> > Len ? ping ...
> 
> Rafael,
> 
> this patch is not dependent from any patch in the series, is it possible
> you apply the patchset except this patch ?
> 
> May be you can apply it later when Len acks it, or I can resend it, no ?
> 
> I have a lot of code consolidation patches awaiting for this patchset to
> be merged.

OK, I'll take the rest of your patches in this series (except for [1/9]
which also is not depended on by anything AFAICS).

Thanks,
Rafael


> > ---
> >  drivers/idle/intel_idle.c |    3 ---
> >  1 file changed, 3 deletions(-)
> >
> > diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
> > index 5d66750..c99c31e 100644
> > --- a/drivers/idle/intel_idle.c
> > +++ b/drivers/idle/intel_idle.c
> > @@ -339,7 +339,6 @@ static int intel_idle(struct cpuidle_device *dev,
> >  	if (!(lapic_timer_reliable_states & (1 << (cstate))))
> >  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ENTER, &cpu);
> >  
> > -	stop_critical_timings();
> >  	if (!need_resched()) {
> >  
> >  		__monitor((void *)&current_thread_info()->flags, 0, 0);
> > @@ -348,8 +347,6 @@ static int intel_idle(struct cpuidle_device *dev,
> >  			__mwait(eax, ecx);
> >  	}
> >  
> > -	start_critical_timings();
> > -
> >  	if (!(lapic_timer_reliable_states & (1 << (cstate))))
> >  		clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_EXIT, &cpu);
> >  
> >
> >
> 
> 
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
