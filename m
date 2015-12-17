From: peda@axentia.se (Peter Rosin)
Date: Thu, 17 Dec 2015 23:19:17 +0000
Subject: [RESEND RFC PATCH 0/2] Expose the PIO_ISR register on SAMA5D3
In-Reply-To: <CACRpkdY9Nwg3B1bAJ53Y-tJJywC=ENvFR6S99+wUKzcUHTa5TQ@mail.gmail.com>
References: <1449544808-3163-1-git-send-email-peda@lysator.liu.se>
 <CACRpkdYN=n=Q+UpLbWjxJHP-FYi_e4cHFE_d1_fR2r7QYcqgYQ@mail.gmail.com>
 <566C6122.6040406@kernel.org>
 <85d1850f20c141b2952d93be72199fdf@EMAIL.axentia.se>
 <CACRpkdY9Nwg3B1bAJ53Y-tJJywC=ENvFR6S99+wUKzcUHTa5TQ@mail.gmail.com>
Message-ID: <a5deeb3722254bd08d7a7e071fd42e7f@EMAIL.axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> On Mon, Dec 14, 2015 at 11:38 AM, Peter Rosin <peda@axentia.se> wrote:
> 
> I think I atleast half-understand what you're trying to do.

Good. It's really not that complicated, but I'm perhaps not describing
it very clearly...

> > Userspace does the following when doing this w/o the isr patches:
> >
> > 1. select signal using the MUX
> > 2. set the DAC so high that INPUT is never reaching that level.
> >    C (and thus gpio) is now stable
> > 3. start waiting for interrupts on gpio
> > 4. adjust the DAC level to the level of interest
> > 5. abort on interrupt or timeout
> (...)
> > With the isr patches, the above transforms into:
> >
> > 1. select signal using the MUX
> > 2. set the DAC so high that INPUT is never reaching that level.
> >    C (and thus gpio) is now stable
> > 3. read the isr bit to clear it
> > 4. adjust the DAC level to the level of interest
> > 5. read the isr bit again after 50ms
> >
> > The result is available directly in the isr bit, no interrupts needed.
> 
> The problem I see here as kernel developer is that there is a fuzzy
> and implicit separation of concerns between userspace and
> kernelspace.
> 
> IMO reading hardware registers is the domain of the kernel, and
> then the result thereof is presented to userspace. The kernel
> handles hardware, simply.
> 
> I think we need to reverse out of this solution and instead ask
> the question what the kernel should provide your userspace.
> Maybe parts of what you have in userspace needs to actually
> go into the kernel?
> 
> The goal of IIO seems to be to present raw and calibrated
> (SI unit) data to userspace. So what data is it you want, and
> why can't you just get that directly from the kernel without
> tricksing around with reading registers bits in userspace?

This all makes sense. The reason is that I'm not familiar with
the kernel APIs. I have to wrap my head around how to set up
work to be performed later, etc etc. All of that is in all
likelihood pretty straightforward, but I feel that I am
flundering around every step of the way. End result; I find
myself trying to do as little as possible inside the kernel.

I.e. I have a pretty clear picture of what needs to be done, but
the devil is in the details...

> If a kernel module needs to read an interrupt bit directly from the
> GPIO controller is another thing. That is akin to how polling
> network drivers start polling registers for incoming packages
> instead of waiting for them to fire interrupts. Just that these are
> dedicated IRQ lines, not GPIOs.

Yes, there was also the NACK to adding new gpio sysfs files which
emphasizes this.

> As struct irq_chip has irq_get_irqchip_state() I think this
> is actually possible to achieve this by implementing that
> and calling irq_get_irqchip_state().

I'll have a peek into that, but see below.

> > I have realized that I could work with one-shot-interrupts. Then the
> > urgency to disable interrupts go away, as only one interrupt would
> > be served. That was not my immediate solution though, as I have been
> > using isr type registers in this way several times before.
> 
> That sounds like the right solution. With ONESHOT a threaded IRQ
> will have its line masked until you return from the ISR thread. Would this
> work for your usecase?

The ISR thread would need to be able to disable further interrupts
before it returned, is that possible without deadlock? If so, it's
a good fit.

> I suspect this require you to move the logic into the kernel? Into IIO?

Yes, and yes IIO seems about right to me too.

> > If this is to be done in IIO, I imagine that the sanest thing would
> > be to integrate the whole DAC-loop and present a finished envelope
> > value to user space? This envelope detector would have to be pretty
> > configurable, or it will be next to useless to anybody but me.
> 
> Makes sense to me, but must be ACKed by Jonathan. But it
> sounds pretty cool does it not?

Right, but I don't see why it should be a problem? An envelope detector
surely fits IIO.

> > I could imaging that this new IIO driver should be able to work
> > with any DAC type device, which in my case would be the mcp4531
> > dpot. Which is not a DAC, maybe that could be solved with a new
> > dac-dpot driver, applicable to cases where a dpot is wired as a
> > simple voltage divider? The new IIO driver also needs to know how
> > to get a reading from the comparator. I think the driver should
> > support having a latch between the comparator and the gpio, so it
> > need to know how to optionally "reset the comparator". That
> > would have solved the whole problem, you would never have seen
> > any of this if I had such a latch on my board. But the isr
> > register is a latch, so...
> >
> > Regardless, I think such a driver still needs support from gpio
> > and/or pinctrl. Either exposing the isr register or supporting
> > one-shot-interrupts that disarm themselves before restoring the
> > processor interrupt flag (maybe that exists?).
> 
> All irqchips support one-shot interrupts as long as you request a
> threaded IRQ I think.
> 
> Your GPIO driver must support IRQs though but AT91 surely does.
> Maybe you will need to implement irq_get_irqchip_state() on it
> if you insist on polling the interrupt.

If I get the oneshot irqs to work, that indeed seems like the better
and more general solution.

> > Otherwise the
> > core problem remains unsolved. Also, this imaginary IIO driver
> > probably have to be totally oblivious of the MUX, or the number
> > of possibilities explode.
> 
> Usually we try to follow the UNIX philisophy to do one thing
> and do it good.
> 
> You haven't said much about how that MUX works, if it's another
> userspace ThingOfABob or what it is. There is no generic
> kernel framework for muxes so I see why people would want to
> drive that using userspace GPIO lines for example.
> 
> If it is pinmuxing in a standard chip of some kind, pinctrl
> handles it.

I'm afraid it's currently done from userspace with gpio-sysfs. If
that's not changed, I need userspace to control *when* the kernel
performs the envelope detector logic.

Thanks for your feedback! I think I have enough info to get
started. Now I just need to find the time...

Cheers,
Peter
