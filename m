From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 27 Jun 2016 14:53:16 +0200
Subject: BUG?: kernel does not (re)set irq smp_affinity to reboot_cpu
In-Reply-To: <20160627113143.GF1041@n2100.armlinux.org.uk>
References: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
 <5770EE21.90103@arm.com> <20160627094552.GE1041@n2100.armlinux.org.uk>
 <d3a266d3-2cfc-81c7-25a6-b39c8012bcf0@redhat.com>
 <20160627113143.GF1041@n2100.armlinux.org.uk>
Message-ID: <842a453d-3295-ffbd-f3dd-67baba1692d2@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On 27-06-16 13:31, Russell King - ARM Linux wrote:
> On Mon, Jun 27, 2016 at 12:55:26PM +0200, Hans de Goede wrote:
>> Hi Russel,
>>
>> On 27-06-16 11:45, Russell King - ARM Linux wrote:
>>> On Mon, Jun 27, 2016 at 10:13:05AM +0100, Marc Zyngier wrote:
>>>> I'm wondering if that's not an effect of this patch:
>>>>
>>>> https://lkml.org/lkml/2015/9/24/138
>>>>
>>>> missing on the ARM side (the corresponding arm64 patch is 217d453d473c).
>>>
>>> No, because we don't take the other CPUs offline through CPU hotplug at
>>> reboot - we stop them.  That's because CPU hotplug involves scheduling,
>>> and a reboot can't be scheduled as it can happen from IRQ contexts.
>>>
>>> For a long time, we have not supported IRQs on any CPU after the system
>>> has gone down for halt/reboot/poweroff etc:
>>>
>>> ipi_cpu_stop() disables IRQs and FIQs before entering an infinite loop.
>>> machine_{halt,power_off,restart}() in arch/arm/kernel/reboot.c disables
>>> IRQs on the requesting CPU.
>>>
>>> So, IRQs get disabled on _all_ CPUs.  Code after this point should not
>>> re-enable IRQs to be able to use drivers, which it sounds like what's
>>> happening in Hans scenario.  Remember, as I've said above, these paths
>>> should not even be scheduling, and should never be reliant on receiving
>>> interrupts.  *Especially* as they can themselves be called from IRQ
>>> context.
>>
>> First of all thanks for your input.
>>
>> Note this is not reboot, this is poweroff.
>
> I think I covered that - all the paths are indentical in the ARM
> architecture code, and have been identical in this respect well before
> any of the drivers you've pointed out.

They may be identical, but there is no _need_ for them to be identical
AFAICT.

>> And for poweroff many (ARM) boards depend on working i2c, which
>> depends on irqs, for example all these mfd drivers:
>>
>> drivers/mfd/rn5t618.c
>> drivers/mfd/twl4030-power.c
>> drivers/mfd/palmas.c
>> drivers/mfd/dm355evm_msp.c
>> drivers/mfd/tps6586x.c
>> drivers/mfd/retu-mfd.c
>> drivers/mfd/max8907.c
>> drivers/mfd/tps65910.c
>> drivers/mfd/tps80031.c
>> drivers/mfd/rk808.c
>> drivers/mfd/axp20x.c
>>
>> Define pm_power_off and use i2c.
>
> Right, so these drivers are all buggy, and need fixing.

Maybe if so many drivers need fixing, the conditions set
down for poweroff are wrong, and we need to fix those instead ?

Also a little correction on my previous maik, previously I
listed: drivers/memory/emif.c (omap4 / omap5) as calling
kernel_power_off() from an interrupt context, but it is
actually doing a return IRQ_WAKE_THREAD and running it
from a threaded interrupt handler.

That only leaves:

arch/arm/mach-ixp4xx/dsmg600-setup.c
arch/arm/mach-ixp4xx/nas100d-setup.c
arch/arm/mach-ixp4xx/nslu2-setup.c

Which directly call machine_power_off in interrupt context,
and they all 3 define their own pm_power_off which
directly toggles a gpio.

AFAIK these 3 are all single core machines, so they
might just as well directly call their own pm_power_off
implementation, at which point there are no callers
which call machine_power_off from a non-schedulable context.

Note this does not mean that all pm_power_off implementations
are going to be happy with machine_power_off leaving irqs
enabled, I would esp. expect the efi and psci implementations
to potentially be unhappy about this. See below for a proposal
to deal with this.

>> So although you may very well be right that using irqs to implement poweroff
>> is not how things should be, in practice we've been using them for this for
>> quite a while now and this usually works fine.
>
> ... and they're all violating the conditions set down for by the
> architecture for an orderly poweroff

This sounds a lot like "we're doing things this way because we always
have been doings things this way", which does not really sound like
a good argument to me.

> presumably the reason this
> works for !SMP cases is because somewhere along the path, they're
> re-enabling IRQs behind the back of architecture code.
>
>> So it seems that the assumption that machine_power_off may be called
>> from irq context is not always true, specifically it is only true on
>> certain platforms (mach-ixp4xx, omap4, omap5 and whatever uses
>> ab8500.c). I would expect the pm_power_off implementations on these
>> platforms to indeed not use irqs themselves, that would indeed be
>> bad.
>
> Right, but the overriding thing here is that it _may_ be called from
> IRQ context _and_ pm_power_off() is called with IRQs disabled.  That
> second one is the more important point - pm_power_off() handlers are
> called with a non-schedulable context.
>
>> Which brings us back to our original problem, how do we fix
>> irq smp_affinity on power off ?
>
> Only if we accept that pm_power_off() should be called with IRQs
> enabled, which we haven't ascertained yet.

<snip>

> Now, we could do as you are suggesting, and route IRQs to the
> remaining CPU via all shutdown paths, but that would be papering over
> the fundamental bug here: if a function is called with IRQs disabled,
> it (or any called function) has no business re-enabling IRQs.

Which brings us to the fundamental question why are we disabling
irqs in machine_poweroff ?

Maybe this is necessary on some boards (efi, psci?), but at the
same time it breaks things badly on other boards. Thinking about
this more I actually believe that on boards with a i2c pmic
pm_power_off MUST be called with irqs enabled:

(from your second reply:)

 > More to that, the I2C core layer is setup to allow i2c_transfer() to
 > be called from non-schedulable contexts:
 >
 >                 if (in_atomic() || irqs_disabled()) {
 >                         ret = adap->trylock_bus(adap, I2C_LOCK_SEGMENT);
 >                         if (!ret)
 >                                 /* I2C activity is ongoing. */
 >                                 return -EAGAIN;
 >
 > prior to calling into the adapters ->master_xfer() function.  This
 > acknowledges that, if i2c_transfer() is called in a context which
 > is not schedulable or IRQs are disabled, the adapters ->master_xfer()
 > needs to handle this situation.

So what happens if we disable irqs as you suggest and machine_power_off
gets called when an i2c transfer is ongoing?

Then the i2c write in the pmic's pm_power_off implementation would
fail with EAGAIN, now we can but a retry loop with busy waiting around
this, but since irqs are disabled, the ongoing transfer will never
complete, so we will just sit there forever.

IOW if we hit a race where we do machine_power_off while an ongoing
i2c transfer is happening on the same i2c bus as the pmic, the only
way we can reliable poweroff is to actually _allow_ irqs so that
that transfer can complete and we can then do the poweroff.

IOW for i2c pmics pm_power_off MUST be called with irqs enabled.


So I see 2 solutions for this:

1) Never disable irqs in arm's machine_power_off, this assumes that
all pm_power_off implementations are safe to run with irqs enabled,
which is a big unknown really; or

2) Add a pm_power_off_needs_irqs flag and make machine_power_off
behave accordingly when that is set


2 would allow us to properly deal with the i2c pmic case (which currently
seems to work by chance as long as irq-balanced does not mess things up
wrt irq affinity), while at the same time ensuring that we do not break
any non i2c pm_power_off methods which may rely on irqs being turned off.

Regards,

Hans



p.s.

Something related to this is that most pmic drivers do:

         if (!pm_power_off)
                 pm_power_off = foo_power_off;

Which seems hardly race free, either we assume there is only one
driver per platform implementing pm_power_off and the
if() is not necessary, or we need some locking here. Maybe
a pm_set_power_off_func() helper would be a good idea ?
