From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Jan 2013 11:29:52 +0000
Subject: [PATCHv2 1/4] clockevents: Add generic timer broadcast receiver
In-Reply-To: <alpine.LFD.2.02.1301141204421.7475@ionos>
References: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
 <1357742770-15028-2-git-send-email-mark.rutland@arm.com>
 <alpine.LFD.2.02.1301141204421.7475@ionos>
Message-ID: <20130114112951.GC7990@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 11:06:31AM +0000, Thomas Gleixner wrote:
> On Wed, 9 Jan 2013, Mark Rutland wrote:
> > +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> > +extern int tick_receive_broadcast(void);
> > +#else
> > +static inline int tick_receive_broadcast(void)
> > +{
> > +	return 0;
> > +}
> 
> What's the inline function for? If an arch does not have broadcasting
> support it should not have a receive broadcast function call either.

That was how this was originally structured [1], but Santosh suggested this
would break the build for !GENERIC_CLOCKEVENTS_BROADCAST [1]. It means that the
arch-specific receive path (i.e. IPI handler) doesn't have to be #ifdef'd,
which makes it less ugly.

I'm happy to have it the other way, with #ifdef'd IPI handlers.

> 
> > +#endif
> > +
> >  #ifdef CONFIG_GENERIC_CLOCKEVENTS
> >  extern void clockevents_notify(unsigned long reason, void *arg);
> >  #else
> > diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
> > index f113755..5079bb7 100644
> > --- a/kernel/time/tick-broadcast.c
> > +++ b/kernel/time/tick-broadcast.c
> > @@ -125,6 +125,18 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
> >  	return ret;
> >  }
> >  
> > +int tick_receive_broadcast(void)
> > +{
> > +	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
> > +	struct clock_event_device *evt = td->evtdev;
> > +
> > +	if (!evt)
> > +		return -ENODEV;
> 
> Is anything going to use the return value?

I'd added this after looking at the x86 lapic timers, where interrupts might
remain pending over a kexec, and lapic interrupts come up before timers are
registered. The return value is useful for shutting down the timer in that case
(see x86's local_apic_timer_interrupt).

If you don't agree I'll remove the return value.

> 
> Thanks,
> 
> 	tglx
>

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/138486.html
