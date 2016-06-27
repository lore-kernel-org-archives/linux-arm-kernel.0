From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 27 Jun 2016 12:55:26 +0200
Subject: BUG?: kernel does not (re)set irq smp_affinity to reboot_cpu
In-Reply-To: <20160627094552.GE1041@n2100.armlinux.org.uk>
References: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
 <5770EE21.90103@arm.com> <20160627094552.GE1041@n2100.armlinux.org.uk>
Message-ID: <d3a266d3-2cfc-81c7-25a6-b39c8012bcf0@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russel,

On 27-06-16 11:45, Russell King - ARM Linux wrote:
> On Mon, Jun 27, 2016 at 10:13:05AM +0100, Marc Zyngier wrote:
>> I'm wondering if that's not an effect of this patch:
>>
>> https://lkml.org/lkml/2015/9/24/138
>>
>> missing on the ARM side (the corresponding arm64 patch is 217d453d473c).
>
> No, because we don't take the other CPUs offline through CPU hotplug at
> reboot - we stop them.  That's because CPU hotplug involves scheduling,
> and a reboot can't be scheduled as it can happen from IRQ contexts.
>
> For a long time, we have not supported IRQs on any CPU after the system
> has gone down for halt/reboot/poweroff etc:
>
> ipi_cpu_stop() disables IRQs and FIQs before entering an infinite loop.
> machine_{halt,power_off,restart}() in arch/arm/kernel/reboot.c disables
> IRQs on the requesting CPU.
>
> So, IRQs get disabled on _all_ CPUs.  Code after this point should not
> re-enable IRQs to be able to use drivers, which it sounds like what's
> happening in Hans scenario.  Remember, as I've said above, these paths
> should not even be scheduling, and should never be reliant on receiving
> interrupts.  *Especially* as they can themselves be called from IRQ
> context.

First of all thanks for your input.

Note this is not reboot, this is poweroff. And for poweroff many
(ARM) boards depend on working i2c, which depends on irqs, for example
all these mfd drivers:

drivers/mfd/rn5t618.c
drivers/mfd/twl4030-power.c
drivers/mfd/palmas.c
drivers/mfd/dm355evm_msp.c
drivers/mfd/tps6586x.c
drivers/mfd/retu-mfd.c
drivers/mfd/max8907.c
drivers/mfd/tps65910.c
drivers/mfd/tps80031.c
drivers/mfd/rk808.c
drivers/mfd/axp20x.c

Define pm_power_off and use i2c.

So although you may very well be right that using irqs to implement poweroff
is not how things should be, in practice we've been using them for this for
quite a while now and this usually works fine.

So I would prefer to see a fix which does not involve all these drivers /
their i2c host drivers needing to implement a polling version of the i2c
transfers just to get poweroff to work.

Looking closer at poweroff being called from irq context, a quick grep gives
the following files calling machine_power_off or kernel_power_off
(with non arm relevant drivers and arch hits not under arch/arm / arch/arm64
filtered out):

arch/arm/mach-ixp4xx/dsmg600-setup.c
arch/arm/mach-ixp4xx/nas100d-setup.c
arch/arm/mach-ixp4xx/nslu2-setup.c
drivers/hwmon/ab8500.c
drivers/memory/emif.c
kernel/power/hibernate.c
kernel/power/poweroff.c
kernel/reboot.c
kernel/rcu/rcuperf.c
kernel/torture.c

mach-ixp4xx/* indeed call power_off from irq context
ab8500.c      calls kernel_power_off from a workqueue
emif.c        is used on omap4 / omap5 and indeed calls power_off from irq context
hibernate.c   I've not checked callers of the hibernate() function, but I'm pretty
               sure this is a context where sleeping is allowed
reboot.c      calls machine_power_off from a syscall or a workqueue
poweroff.c    calls machine_power_off from a workqueue
rcuperf.c     calls kernel_power_off() in a kernel thread
torture.c     calls kernel_power_off() in a kernel thread

So it seems that the assumption that machine_power_off may be called
from irq context is not always true, specifically it is only true on
certain platforms (mach-ixp4xx, omap4, omap5 and whatever uses
ab8500.c). I would expect the pm_power_off implementations on these
platforms to indeed not use irqs themselves, that would indeed be
bad.

However I do not believe that a few platforms calling power_off directly
from irq context means that we should forbid the use of sleeping code /
interrupts in all pm_power_off handlers, that seems counter productive,
esp. since a lot of pm_power_off handlers actually rely on i2c and
thus irqs (without some major work) being available.

###

Which brings us back to our original problem, how do we fix
irq smp_affinity on power off ?

The first solution which comes to mind is to simple not call smp_send_stop()
in the arm machine_power_off() implementation, AFAICT the purpose of smp_send_stop()
is to make sure that all the non reboot-cpus are in a clean state for when the
machine actually boots up again so as to not have them still accessing
RAM, etc. while the bootloader/rom is running on the reboot-cpu. This does not
seem necessary for poweroff. Note I'm not very familiar with all the details
here so likely this is a stupid idea.

Assuming my first solution is a bad idea, then we will likely need to do
something similar to the hotplug cpu code on shutdown to reset affinities.

I guess that messing with irq affinity while in an interrupt handler
is a bad idea, so whatever fix we come up with should probably check for
being in a context where sleeping is allowed and if not then skip this,
so as to not break the few callers of machine_power_off from irq context;
or alternatively and perhaps better we can fix those few callers to use
a workqueue. All core kernel code already ensures this, so I guess this
is already a requirement on x86?

Regards,

Hans
