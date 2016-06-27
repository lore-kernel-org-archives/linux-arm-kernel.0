From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Jun 2016 12:31:43 +0100
Subject: BUG?: kernel does not (re)set irq smp_affinity to reboot_cpu
In-Reply-To: <d3a266d3-2cfc-81c7-25a6-b39c8012bcf0@redhat.com>
References: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
 <5770EE21.90103@arm.com>
 <20160627094552.GE1041@n2100.armlinux.org.uk>
 <d3a266d3-2cfc-81c7-25a6-b39c8012bcf0@redhat.com>
Message-ID: <20160627113143.GF1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 12:55:26PM +0200, Hans de Goede wrote:
> Hi Russel,
> 
> On 27-06-16 11:45, Russell King - ARM Linux wrote:
> >On Mon, Jun 27, 2016 at 10:13:05AM +0100, Marc Zyngier wrote:
> >>I'm wondering if that's not an effect of this patch:
> >>
> >>https://lkml.org/lkml/2015/9/24/138
> >>
> >>missing on the ARM side (the corresponding arm64 patch is 217d453d473c).
> >
> >No, because we don't take the other CPUs offline through CPU hotplug at
> >reboot - we stop them.  That's because CPU hotplug involves scheduling,
> >and a reboot can't be scheduled as it can happen from IRQ contexts.
> >
> >For a long time, we have not supported IRQs on any CPU after the system
> >has gone down for halt/reboot/poweroff etc:
> >
> >ipi_cpu_stop() disables IRQs and FIQs before entering an infinite loop.
> >machine_{halt,power_off,restart}() in arch/arm/kernel/reboot.c disables
> >IRQs on the requesting CPU.
> >
> >So, IRQs get disabled on _all_ CPUs.  Code after this point should not
> >re-enable IRQs to be able to use drivers, which it sounds like what's
> >happening in Hans scenario.  Remember, as I've said above, these paths
> >should not even be scheduling, and should never be reliant on receiving
> >interrupts.  *Especially* as they can themselves be called from IRQ
> >context.
> 
> First of all thanks for your input.
> 
> Note this is not reboot, this is poweroff.

I think I covered that - all the paths are indentical in the ARM
architecture code, and have been identical in this respect well before
any of the drivers you've pointed out.

> And for poweroff many (ARM) boards depend on working i2c, which
> depends on irqs, for example all these mfd drivers:
> 
> drivers/mfd/rn5t618.c
> drivers/mfd/twl4030-power.c
> drivers/mfd/palmas.c
> drivers/mfd/dm355evm_msp.c
> drivers/mfd/tps6586x.c
> drivers/mfd/retu-mfd.c
> drivers/mfd/max8907.c
> drivers/mfd/tps65910.c
> drivers/mfd/tps80031.c
> drivers/mfd/rk808.c
> drivers/mfd/axp20x.c
> 
> Define pm_power_off and use i2c.

Right, so these drivers are all buggy, and need fixing.

> So although you may very well be right that using irqs to implement poweroff
> is not how things should be, in practice we've been using them for this for
> quite a while now and this usually works fine.

... and they're all violating the conditions set down for by the
architecture for an orderly poweroff - presumably the reason this
works for !SMP cases is because somewhere along the path, they're
re-enabling IRQs behind the back of architecture code.

> So it seems that the assumption that machine_power_off may be called
> from irq context is not always true, specifically it is only true on
> certain platforms (mach-ixp4xx, omap4, omap5 and whatever uses
> ab8500.c). I would expect the pm_power_off implementations on these
> platforms to indeed not use irqs themselves, that would indeed be
> bad.

Right, but the overriding thing here is that it _may_ be called from
IRQ context _and_ pm_power_off() is called with IRQs disabled.  That
second one is the more important point - pm_power_off() handlers are
called with a non-schedulable context.

> Which brings us back to our original problem, how do we fix
> irq smp_affinity on power off ?

Only if we accept that pm_power_off() should be called with IRQs
enabled, which we haven't ascertained yet.

Even on x86, pm_power_off() is generally called with IRQs disabled,
and more - the APICs are disabled along with the system IOMMU in the
case of x86_64.  These are only avoided if the reboot mode is set to
"force" (reboot_force).

Now, we could do as you are suggesting, and route IRQs to the
remaining CPU via all shutdown paths, but that would be papering over
the fundamental bug here: if a function is called with IRQs disabled,
it (or any called function) has no business re-enabling IRQs.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
