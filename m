From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 19 Jun 2015 07:44:46 +0530
Subject: [PATCH 06/41] clocksource: exynos_mct: Migrate to new
 'set-state' interface
In-Reply-To: <CALW4P+KrWdAPmG_H8uutDCh5OUgkiRC6UmwM3-C1WwV0CF2_Qg@mail.gmail.com>
References: <cover.1434622147.git.viresh.kumar@linaro.org>
 <a1d7ad942bfc08b91b7ae0d9ba3b19b579f469c9.1434622147.git.viresh.kumar@linaro.org>
 <CALW4P+KrWdAPmG_H8uutDCh5OUgkiRC6UmwM3-C1WwV0CF2_Qg@mail.gmail.com>
Message-ID: <20150619021446.GC4376@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexey,

On 18-06-15, 19:38, Alexey Klimov wrote:
> (adding samsung list and Krzysztof to c/c)

Thanks.

> Please don't forget to send patches to platform list and platform maintainers.

Hmmm, I cc'd Kukjin on this patch as he was the one Acking most of the
patches on this driver recently (had a look at git log). Also looked
at MAINTAINERS and the driver itself to look for maintainers, and
kukjin was all I can find. Yes, get_maintainers gave the two names you
added, but many a times it generates list longer than required and so
I don't completely depend on that.

Anyway, thanks.

> On Thu, Jun 18, 2015 at 1:54 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > +static int set_state_shutdown(struct clock_event_device *evt)
> > +{
> > +       exynos4_mct_tick_stop(this_cpu_ptr(&percpu_mct_tick));

Let me clarify the purpose of this patch and the series.

Its only about breaking the older ->set_mode() callback into state
based callbacks and not change the way things were done. And so no
improvements in this patch. If there are improvements possible on the
driver, then they must be done separately.

> Passed evt pointer isn't used

Its a callback from clockevents core, and we can't get rid of the
argument. :)

> and instead you're going to locate
> percpu_mct_tick struct knowing current cpu number offset.

That's the way ->set_mode() was doing it and so I didn't touched it to
keep this patch simple.

> What do you think, since evt is embedded into percpu_mct_tick
> structure then maybe it will be cheaper to calculate percpu_mct_tick
> using container_of()?
> 
> struct mct_clock_event_device *mevt;
> mevt = container_of(evt, struct mct_clock_event_device, evt);

Ofcourse, but that has to be fixed for many routines and should be
done in a separate patch. It doesn't belong to this one.
 
> > @@ -455,7 +447,10 @@ static int exynos4_local_timer_setup(struct clock_event_device *evt)
> >         evt->name = mevt->name;
> >         evt->cpumask = cpumask_of(cpu);
> >         evt->set_next_event = exynos4_tick_set_next_event;
> > -       evt->set_mode = exynos4_tick_set_mode;
> > +       evt->set_state_periodic = set_state_periodic;
> > +       evt->set_state_shutdown = set_state_shutdown;
> > +       evt->set_state_oneshot = set_state_shutdown;
> > +       evt->tick_resume = set_state_shutdown;
> 
> Do i correctly understand that during massive hot-plug cpu events (i
> guess that will lead to CPU_STARING notification) on power management
> this *_timer_setup() function will be called?

I hope so.

> And here code performs setting of rather constant values and copying.
> You're going to increase number of such strange assignments.
> 
> Well, just lazy-thinking. Can we do something like this:
> 
> for_each_possible_cpu(cpu) {
>           exynos4_local_timer_setup_prepare(&per_cpu(percpu_mct_tick,
> cpu).evt, cpu);
> }
> 
> somewhere in exynos_mct init functions and assign most of these values
> for each evt structure?
> And make *_timer_setup() function lighter moving some code to
> prepare/init functions.

I agree.. But again, that has to be done in a separate patch.

> If it makes any sense i can take a look and try to prepare patch.

Sure..

> Do you need testers? I can test it on odroid-xu3.

That will be good.

> Can't find in emails similar patch for ARM arch timer. Any plans about
> it? Or if it's already converted to 'set-state' then could you please
> share a link?

https://git.linaro.org/people/daniel.lezcano/linux.git/shortlog/refs/heads/clockevents/4.3

-- 
viresh
