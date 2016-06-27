From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jun 2016 14:57:23 +0100
Subject: BUG?: kernel does not (re)set irq smp_affinity to reboot_cpu
In-Reply-To: <842a453d-3295-ffbd-f3dd-67baba1692d2@redhat.com>
References: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
 <5770EE21.90103@arm.com>
 <20160627094552.GE1041@n2100.armlinux.org.uk>
 <d3a266d3-2cfc-81c7-25a6-b39c8012bcf0@redhat.com>
 <20160627113143.GF1041@n2100.armlinux.org.uk>
 <842a453d-3295-ffbd-f3dd-67baba1692d2@redhat.com>
Message-ID: <20160627135723.GH1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 02:53:16PM +0200, Hans de Goede wrote:
> Hi Russell,
> 
> On 27-06-16 13:31, Russell King - ARM Linux wrote:
> >I think I covered that - all the paths are indentical in the ARM
> >architecture code, and have been identical in this respect well before
> >any of the drivers you've pointed out.
> 
> They may be identical, but there is no _need_ for them to be identical
> AFAICT.

Well, the need for this comes from the need for drivers to work on any
architecture, so all architectures need to implement pm_power_off()
(and the other hooks) so they work the same way.

So, we can't just change it on ARM and be at odds with everything else.
We need to have consistency here.  If we want to change it on ARM, we
need all the other architectures to also change with us.

> Maybe if so many drivers need fixing, the conditions set
> down for poweroff are wrong, and we need to fix those instead ?

The drivers which need fixing are the I2C drivers, not the drivers
calling into the I2C layer.

> >... and they're all violating the conditions set down for by the
> >architecture for an orderly poweroff
> 
> This sounds a lot like "we're doing things this way because we always
> have been doings things this way", which does not really sound like
> a good argument to me.

It's all to do with providing a _stable_ interface that works the same
across all architectures.  We can't have one architecture going off and
doing something different with a cross-arch interface.

> >Now, we could do as you are suggesting, and route IRQs to the
> >remaining CPU via all shutdown paths, but that would be papering over
> >the fundamental bug here: if a function is called with IRQs disabled,
> >it (or any called function) has no business re-enabling IRQs.
> 
> Which brings us to the fundamental question why are we disabling
> irqs in machine_poweroff ?

See above.

> Maybe this is necessary on some boards (efi, psci?), but at the
> same time it breaks things badly on other boards. Thinking about
> this more I actually believe that on boards with a i2c pmic
> pm_power_off MUST be called with irqs enabled:
> 
> (from your second reply:)
> 
> > More to that, the I2C core layer is setup to allow i2c_transfer() to
> > be called from non-schedulable contexts:
> >
> >                 if (in_atomic() || irqs_disabled()) {
> >                         ret = adap->trylock_bus(adap, I2C_LOCK_SEGMENT);
> >                         if (!ret)
> >                                 /* I2C activity is ongoing. */
> >                                 return -EAGAIN;
> >
> > prior to calling into the adapters ->master_xfer() function.  This
> > acknowledges that, if i2c_transfer() is called in a context which
> > is not schedulable or IRQs are disabled, the adapters ->master_xfer()
> > needs to handle this situation.
> 
> So what happens if we disable irqs as you suggest and machine_power_off
> gets called when an i2c transfer is ongoing?

Right... and you also need to ask that very same question again, even
with IRQs enabled.  Enabling IRQs doesn't fix that problem, because I
think you'll find that no one bothers checking that (eg) a write to
the TWL device actually succeeded.  regmap just propagates the error
code that it received from the I2C layer, twl_i2c_write() prints an
error message, and also propagates the error code.  twl_i2c_write_u8()
again propagates the error code, and twl4030_power_off() just prints
more about a failure.

Enabling IRQs actually does nothing to solve this underlying problem,
all it does is paper over the problem and hopes that it goes away.

In order to solve this, it requires an additional step: _all_ the
drivers doing this _also_ need to check the return value from the I2C
write return code and retry if it's EAGAIN.  Retry how many times,
and after what period?

So, we'd need to fix a load of drivers all over the place.

> Something related to this is that most pmic drivers do:
> 
>         if (!pm_power_off)
>                 pm_power_off = foo_power_off;
> 
> Which seems hardly race free, either we assume there is only one
> driver per platform implementing pm_power_off and the
> if() is not necessary, or we need some locking here. Maybe
> a pm_set_power_off_func() helper would be a good idea ?

pm_power_off started as a hook into the APM/ACPI code, and has ended up
being re-used by for these drivers.  There's probably saner solutions
to this (a notifier, like the restart path) than having
pm_set_power_off_func().  In any case, it's going to need some locking
to make it truely safe.

It's also a cross-arch issue: various of the drivers using it are also
used on other architectures as well (eg, TWL drivers.)

So, to summarise, whatever changes we make need to be cross-architecture
changes, and can't be done in isolation on just ARM.  Moreover, all these
drivers implementing pm_power_off() also need fixing to check the return
code from the i2c transaction and do something sensible with it.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
