From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 14 Jan 2013 15:36:12 +0000
Subject: [PATCHv2 1/4] clockevents: Add generic timer broadcast receiver
In-Reply-To: <alpine.LFD.2.02.1301141318460.7475@ionos>
References: <1357742770-15028-1-git-send-email-mark.rutland@arm.com>
 <1357742770-15028-2-git-send-email-mark.rutland@arm.com>
 <alpine.LFD.2.02.1301141204421.7475@ionos>
 <20130114112951.GC7990@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1301141247020.7475@ionos>
 <20130114121247.GD7990@e106331-lin.cambridge.arm.com>
 <alpine.LFD.2.02.1301141318460.7475@ionos>
Message-ID: <20130114153612.GF7990@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 02:17:26PM +0000, Thomas Gleixner wrote:
> On Mon, 14 Jan 2013, Mark Rutland wrote:
> > On Mon, Jan 14, 2013 at 11:50:55AM +0000, Thomas Gleixner wrote:
> > > On Mon, 14 Jan 2013, Mark Rutland wrote:
> > > 
> > > > On Mon, Jan 14, 2013 at 11:06:31AM +0000, Thomas Gleixner wrote:
> > > > > On Wed, 9 Jan 2013, Mark Rutland wrote:
> > > > > > +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> > > > > > +extern int tick_receive_broadcast(void);
> > > > > > +#else
> > > > > > +static inline int tick_receive_broadcast(void)
> > > > > > +{
> > > > > > +	return 0;
> > > > > > +}
> > > > > 
> > > > > What's the inline function for? If an arch does not have broadcasting
> > > > > support it should not have a receive broadcast function call either.
> > > > 
> > > > That was how this was originally structured [1], but Santosh suggested this
> > > > would break the build for !GENERIC_CLOCKEVENTS_BROADCAST [1]. It means that the
> > > > arch-specific receive path (i.e. IPI handler) doesn't have to be #ifdef'd,
> > > > which makes it less ugly.
> > > 
> > > Hmm. If you want to keep the IPI around unconditionally the inline
> > > makes some sense, though the question is whether keeping an unused IPI
> > > around makes sense in the first place. I'd rather see a warning that
> > > an unexpected IPI happened than a silent inline function being called.
> > 
> > How about I add a warning (e.g. "Impossible timer broadcast received.") and
> > return -EOPNOTSUPP when !GENERIC_CLOCKEVENTS_BROADCAST?
> 
> You still need to do something with the return value in the arch IPI
> code, right?

Good point. Having the stub when !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST is
clearly problematic.

I'll go with your original suggestion, removing the tick_receive_broadcast stub
for !CONFIG_GENERIC_CLOCKEVENTS_BROADCAST and I'll #idef the IPI_TIMER handler.
That way it'll fall down to the standard warning for an unexpected/unknown IPI
for arch/arm at least.

> > > > > Is anything going to use the return value?
> > > > 
> > > > I'd added this after looking at the x86 lapic timers, where interrupts might
> > > > remain pending over a kexec, and lapic interrupts come up before timers are
> > > > registered. The return value is useful for shutting down the timer in that case
> > > > (see x86's local_apic_timer_interrupt).
> > > 
> > > Right, though then you need to check for evt->event_handler as well.
> > 
> > I thought this previously also [1], but I couldn't find any path such that a
> > tick_cpu_device would have an evtdev without an event_handler. We always set the
> > handler before setting evtdev, and alway wipe evtdev before wiping the handler.
> > 
> > Have I missed something?
> 
> That's an x86 specific issue. Though we could try and make that
> functionality completely generic.

Just to check: is the evt->event_handler check necessary?

> Thanks,
> 
> 	tglx
> 

Thanks,
Mark.
