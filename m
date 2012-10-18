From: balbi@ti.com (Felipe Balbi)
Date: Thu, 18 Oct 2012 22:34:40 +0300
Subject: [RFC/NOT FOR MERGING 1/5] arm: omap: fix up _od_suspend_noirq
 and _od_resume_noirq
In-Reply-To: <87vce77hba.fsf@deeprootsystems.com>
References: <1350488043-5053-1-git-send-email-balbi@ti.com>
 <1350488043-5053-2-git-send-email-balbi@ti.com>
 <871ugvivso.fsf@deeprootsystems.com>
 <20121018165525.GA6385@arwen.pp.htv.fi>
 <87ipa7d6cy.fsf@deeprootsystems.com>
 <20121018175027.GA7917@arwen.pp.htv.fi>
 <87vce77hba.fsf@deeprootsystems.com>
Message-ID: <20121018193440.GA8609@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Oct 18, 2012 at 11:42:33AM -0700, Kevin Hilman wrote:
> >> Again, this is required because system suspend disables runtime PM
> >> transitions at a certain point, if the device is used after that point,
> >> there is *no other way* for the driver to properly manage the idle
> >> transition (or, if there is, please explain it to me.)
> >
> > Can you please let me know of any situation where e.g. I2C/SPI would be
> > needed after all its children are suspended ?
> 
> There lots of I2C users who are not children of the I2C bus device.  Any
> users of regulators on the I2C-connected PMIC for example (MMC comes to
> mind, and is not a child of the I2C bus.).  Also, enable/disable of GPIO
> IRQ lines on I2C GPIO expanders.  The devices using those GPIO IRQs are
> not children of the I2C bus. 

MMC isn't a child of I2C, indeed, but the regulator is a child of TWL
which is a child of the I2C bus.

> Stated differently, I2C devices themselves (PMIC, GPIO expanders, etc.)
> are children of the I2C bus device.  But *users* of those devices will
> be other drivers who have no parent/child relationship with the I2C bus
> device in the driver model.

correct, but MMC is not suspended as late as suspend_noirq() is it ?
Looks like only I2C can fall into this category because of exactly
regulators and I/O expanders. So wouldn't implementing
omap_i2c_suspend_noirq() and omap_i2c_resume_noirq() solve the same
problem ?

> >> > so you shouldn't forcefully resume the device.
> >> 
> >> Note it's only forcefully resumed *if* it was forcefully suspended by
> >> suspend_noirq.
> >
> > likewise, you shouldn't forcefully runtime suspend a device. The device
> > driver needs to be required to provide suspend/resume functions if it
> > cares.
> 
> I don't think you've fully understood the problem being solved here.
> 
> This is for devices who designed for use throughout the suspend process
> (IOW, *after* their suspend callbacks have been called.)

is there no way for a device to tell PM core that it doesn't want to be
suspended during ->suspend_early or ->suspend but only on
->suspend_noirq ? Isn't the fact that we don't implement ->suspend_early
and ->suspend enough to keep the device running ? I think that will be
the case with the patch which adds the extra check on
_od_suspend_noirq(), no ?

And before you reply, if the device implements none of the suspend
methods, then you shouldn't suspend it at all, because you'd be masking
a bug in the driver, IMHO.

> >> But even then, with your proposed changes, I don't think the device will
> >> be properly idled (including the omap_device_idle) in these important cases:
> >> 
> >> 1) I2C is used by some other device *after* its ->suspend method has
> >>    been called.
> >
> > how can that happen ? I2C's ->suspend method will only be called after
> > all its children are suspended.
> 
> Unfortunately, drivers which use I2C are not all children of the I2C bus
> device in the driver model (see above.)
> 
> This gets to a much bigger problem with the linux driver model today.
> There are *many* power relationships/dependencies between devices that 
> are not modeled by driver model device hierarchy.

Ok. Now I see a good point :-) You're correct, thanks

> >> It doesn't matter if the driver has noirq methods.  If it is not yet
> >> runtime suspended, it is forceably runtime suspended.   The generic
> >
> > if it's not yet runtime suspended, you need to call the driver's
> > ->suspend_* method (depending on the suspend phase you are right now),
> 
> You're confusing system suspend and runtime suspend, and forgetting that
> we might want to use runtime PM *during* system suspend/resume.

Maybe I wasn't clear enough. What I meant to say was that if the device
isn't runtime_suspended by the time you should be calling its
->suspend_noirq method, then calling the device's runtime_suspend()
method looks very weird to me.

It really seems, to me, that implementing suspend_noirq() on e.g. I2C
controller driver should do the trick provided you call
->suspend_noirq() instead of ->runtime_suspend(). I mean, if we do exact
the same thing on runtime_suspend() and suspend_noirq() (namely disable
IRQs, save context, etc), then it should make no difference which method
you call, right ?

> Again, the reason a device may not yet runtime suspended is because it
> was in use during suspend, and runtime PM has been disabled by the PM
> core during system PM.  If the PM core did not disable runtime PM, the
> drivers runtime PM methods would be called, and we would not need to
> implement this in the PM domain layer.

fair enough, but what I still don't get is why you need to call exactly
->runtime_suspend. What's the problem with calling ->suspend_noirq() ?

Again, look at the last patch. Note that I do the same thing on both
->suspend (should be ->suspend_noirq()) and ->runtime_suspend(), with a
slight difference:

on ->suspend(_noirq) if the device is already runtime_suspended, I just
return 0, otherwise I follow the same procedure and (due to the other
patches) omap_device_idle() will be called the same way. The device will
be suspended, but (let's assume) PM runtime doesn't know about it. No
problem, during resume you will call omap_device_resume() and later call
pm_generic_resume(_noirq) which will call omap_i2c_resume(_noirq) which
will:

reenable_irqs();
restore_context();

pm_runtime_disable(dev);
pm_runtime_set_active(dev); /* we have already resumed the device */
pm_runtime_enable(dev);

return 0;

> >> noirq calls are just there in case the driver has noirq callbacks.
> >
> > I get that, but why would you suspend a device which doesn't want to be
> > suspended in suspend_noirq(), but using its runtime_suspend method ?
> 
> What do you mean "doesn't want to be suspended"?  If a device doesn't

by "doesn't want to be suspended" I mean that it hasn't implemented a
noirq method.

> want to be suspended, it needs to return an error from one of its
> suspend methods.   Barring that, the system *will* suspend, and in order
> to hit low power states, we have to properly idle each device.
> 
> The underlying assumption is that by the time the noirq phase runs, the
> device should already be runtime suspended.  If it is not, then one of
> the following ha happened:
> 
> - device was used during suspend, but after runtime PM was disabled by
>   the PM core (during system suspend)
> 
> - runtime PM disabled from userspace
> 
> In both cases, *somebody* has to properly idle the device and "finish"

yes, and that somebody is omap_device_idle() right ? Now my question
remains: why is it so important to call device's ->runtime_suspend
method. Why couldn't you call device's ->suspend_noirq method instead ?

> the runtime suspend late in the suspend phase.  As recommended by
> Rafael, we handle this at the PM domain level.
> 
> > If I2C dies on a suspend/resume transition, it's a bug in the I2C
> > driver, no ?
> 
> Sure, but this has nothing to do with I2C dying.

Imagine that instead of calling ->runtime_suspend we were to call
->suspend_noirq, but the device doesn't implement that. What would
happen ? no context save, no context restore, I2C dead.

ps: I'll continue reading the code and further test my series to see
if I can understand what you say here.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121018/7af66528/attachment.sig>
