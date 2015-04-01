From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 01 Apr 2015 23:46:10 +0200
Subject: Build regression in next-20150331
In-Reply-To: <CANMBJr76ap0qL+yxrwe5ECWRgFRgbtdKNBGoSd8SOzrhzDjTrg@mail.gmail.com>
References: <CANMBJr68RVNgVpkDohyOeH=wd=UgKBCFeuveqiUyNcQ_7vendQ@mail.gmail.com>
 <2720045.6sPXjyyvfF@vostro.rjw.lan>
 <CANMBJr76ap0qL+yxrwe5ECWRgFRgbtdKNBGoSd8SOzrhzDjTrg@mail.gmail.com>
Message-ID: <2863807.lxHPvZ2AsE@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, March 31, 2015 08:37:32 PM Tyler Baker wrote:
> Hi Rafael,
> 
> On 31 March 2015 at 16:27, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, April 01, 2015 01:03:52 AM Rafael J. Wysocki wrote:
> >> On Tuesday, March 31, 2015 11:39:37 AM Tyler Baker wrote:
> >> > Hi Thomas, Rafael,
> >> >
> >> > I was notified this morning by the kernelci.org system that a new
> >> > build error has been detected in next-20150331[0][1][2]. It seems that
> >> > "clockevents: Remove CONFIG_GENERIC_CLOCKEVENTS_BUILD"
> >> > c9439b1d6eb4ada5c2faf3970ac0d2bc4bd20e14 is the culprit.

[cut]

> >
> > Please try the one below instead.
> >
> > Rafael
> >
> >
> > ---
> >  kernel/time/tick-internal.h |    2 ++
> >  1 file changed, 2 insertions(+)
> >
> > Index: linux-pm/kernel/time/tick-internal.h
> > ===================================================================
> > --- linux-pm.orig/kernel/time/tick-internal.h
> > +++ linux-pm/kernel/time/tick-internal.h
> > @@ -110,7 +110,9 @@ static inline int tick_broadcast_update_
> >  /* Set the periodic handler in non broadcast mode */
> >  static inline void tick_set_periodic_handler(struct clock_event_device *dev, int broadcast)
> >  {
> > +#ifdef CONFIG_GENERIC_CLOCKEVENTS
> >         dev->event_handler = tick_handle_periodic;
> > +#endif
> >  }
> >  #endif /* !BROADCAST */
> 
> Thanks for the quick response. I've applied this patch on top of
> next-20150331 and I can confirm this fixes the build error reported in
> this thread. The test results can be found here[0].

OK, thanks for verifying.

Peter, do you think the above is acceptable or do I need to do anything more
sophisticated to fix this?  [The alternative would be probably to prepare an
empty definition of tick_handle_periodic() for CONFIG_GENERIC_CLOCKEVENTS and
move the definition of struct clock_event_device from under that Kconfig
option.]

Rafael
