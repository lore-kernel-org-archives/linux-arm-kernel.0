From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 03 Apr 2015 13:07:19 +0200
Subject: Build regression in next-20150331
In-Reply-To: <CANMBJr4T5T6tFM+SPs9btc_qBRdMPL0QA4R_d1XXk7VBDqq_MA@mail.gmail.com>
References: <CANMBJr68RVNgVpkDohyOeH=wd=UgKBCFeuveqiUyNcQ_7vendQ@mail.gmail.com>
 <20150402082917.GS23123@twins.programming.kicks-ass.net>
 <CANMBJr4T5T6tFM+SPs9btc_qBRdMPL0QA4R_d1XXk7VBDqq_MA@mail.gmail.com>
Message-ID: <2449654.mrTjPJtNze@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, April 02, 2015 07:59:53 PM Tyler Baker wrote:
> On 2 April 2015 at 01:29, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, Apr 01, 2015 at 11:46:10PM +0200, Rafael J. Wysocki wrote:
> >
> >> > > ---
> >> > >  kernel/time/tick-internal.h |    2 ++
> >> > >  1 file changed, 2 insertions(+)
> >> > >
> >> > > Index: linux-pm/kernel/time/tick-internal.h
> >> > > ===================================================================
> >> > > --- linux-pm.orig/kernel/time/tick-internal.h
> >> > > +++ linux-pm/kernel/time/tick-internal.h
> >> > > @@ -110,7 +110,9 @@ static inline int tick_broadcast_update_
> >> > >  /* Set the periodic handler in non broadcast mode */
> >> > >  static inline void tick_set_periodic_handler(struct clock_event_device *dev, int broadcast)
> >> > >  {
> >> > > +#ifdef CONFIG_GENERIC_CLOCKEVENTS
> >> > >         dev->event_handler = tick_handle_periodic;
> >> > > +#endif
> >> > >  }
> >> > >  #endif /* !BROADCAST */
> >
> >> Peter, do you think the above is acceptable or do I need to do anything more
> >> sophisticated to fix this?  [The alternative would be probably to prepare an
> >> empty definition of tick_handle_periodic() for CONFIG_GENERIC_CLOCKEVENTS and
> >> move the definition of struct clock_event_device from under that Kconfig
> >> option.]
> >
> >
> > Does not something like the below make more sense? The entire broadcast
> > thing doesn't make sense if we don't have generic_clockevents.
> >
> > Should we wrap more in generic_clockevents there?
> >
> > ---
> >  kernel/time/tick-internal.h |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
> > index 2a1563a..5569e65 100644
> > --- a/kernel/time/tick-internal.h
> > +++ b/kernel/time/tick-internal.h
> > @@ -81,6 +81,7 @@ static inline int tick_check_oneshot_change(int allow_nohz) { return 0; }
> >  #endif /* !TICK_ONESHOT */
> >
> >  /* Broadcasting support */
> > +#ifdef CONFIG_GENERIC_CLOCKEVENTS
> >  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> >  extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
> >  extern void tick_install_broadcast_device(struct clock_event_device *dev);
> > @@ -114,6 +115,7 @@ static inline void tick_set_periodic_handler(struct clock_event_device *dev, int
> >         dev->event_handler = tick_handle_periodic;
> >  }
> >  #endif /* !BROADCAST */
> > +#endif /* GENERIC */
> >
> >  /* Functions related to oneshot broadcasting */
> >  #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_TICK_ONESHOT)
> 
> Tested-by: Tyler Baker <tyler.baker@linaro.org>
> 
> Looks good to me.
> 
> Applied on top of next-20150402[0]:

Cool, so FWIW

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Peter, I'm assiming that you'll make sure this goes into tip/timers/core.

> ---
>  kernel/time/tick-internal.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
> index 2a1563a..e332bb4 100644
> --- a/kernel/time/tick-internal.h
> +++ b/kernel/time/tick-internal.h
> @@ -81,6 +81,7 @@ static inline int tick_check_oneshot_change(int
> allow_nohz) { return 0; }
>  #endif /* !TICK_ONESHOT */
> 
>  /* Broadcasting support */
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS
>  #ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
>  extern int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu);
>  extern void tick_install_broadcast_device(struct clock_event_device *dev);
> @@ -114,7 +115,7 @@ static inline void
> tick_set_periodic_handler(struct clock_event_device *dev, int
>   dev->event_handler = tick_handle_periodic;
>  }
>  #endif /* !BROADCAST */
> +#endif /* GENERIC */
>  /* Functions related to oneshot broadcasting */
>  #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) &&
> defined(CONFIG_TICK_ONESHOT)
>  extern void tick_broadcast_setup_oneshot(struct clock_event_device *bc);
> ---
> 
> Tyler
> 
> [0] http://kernelci.org/build/tbaker/kernel/v4.0-rc6-8742-g76c8cce3+gcc-linaro-4.9-2015.02/

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
