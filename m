From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 15 Jul 2011 13:02:52 -0700
Subject: [PATCH 1/2] ARM: Tegra: Harmony: Register and configure WM8903
	IRQ GPIO
In-Reply-To: <20110715000510.GD32716@opensource.wolfsonmicro.com>
References: <1310589618-16080-1-git-send-email-swarren@nvidia.com>
	<20110714122520.GB14249@sirena.org.uk>
	<74CDBE0F657A3D45AFBB94109FB122FF049E834971@HQMAIL01.nvidia.com>
	<20110715000510.GD32716@opensource.wolfsonmicro.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF049E834CCC@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Brown wrote at Thursday, July 14, 2011 6:05 PM:
> On Thu, Jul 14, 2011 at 08:49:28AM -0700, Stephen Warren wrote:
> > Mark Brown wrote at Thursday, July 14, 2011 6:25 AM:
> 
> > > This seems silly - we should fix this in the core code rather than have
> > > every single board that ahppens to use an interrupt which is also
> > > available as a GPIO manually faff around with gpiolib.
> 
> > That seems a good goal.
> 
> > However, how does the WM8903 driver know whether the interrupt number
> > it's passed is a straight-up dedicated interrupt (hence the calls aren't
> > required), or a GPIO (hence they are)?
> 
> It shouldn't - I said "core code" for a reason :)

Ah, yes.

[Grant, Thomas, as GPIO/IRQ maintainers, do you agree that (a) below is
something the core IRQ code should be doing?]

There are two aspects to this:

a) The generic gpio_request/gpio_direction_input. This could be handled
by the core irq code if struct irq_chip grew a to_irq function, and a
__irq_to_gpio/irq_to_gpio global function were created to mirror
gpio_to_irq.

b) On Tegra at least, we need to call tegra_gpio_enable to configure the
pin to be a GPIO. This isn't performed by the Tegra GPIO driver during
gpio_request, since such configuration is supposed to be outside the
domain of the GPIO driver, but deferred to perhaps a pinmux driver. Should
the same be true of request_irq; should it require the user to somehow
call tegra_gpio_enable elsewhere? It'd be asymmetric to how gpio_request
worked, but Tegra's irq_chip could easily call tegra_gpio_enable from
within irq_chip.startup, thus simplifying any code that wants to use
interrupt-that-are-GPIOs.

The alternative is for the board files to have a list of GPIOs for which
to call tegra_gpio_enable, and indeed, that's what we do have in Tegra
e.g. in board-seaboard-pinmux.c.

I suppose with the new pinmux API, there will simply be a pinmux table in
either the board file or Device Tree, and that will allow "GPIO" as a legal
"special function" for each pin, and for pins which are really "GPIO
interrupts", we'll just need to list "GPIO" in that pinmux table, so perhaps
everything will just fall out cleanly that way. I suppose that a pinmux
driver could even expose an "interrupt" special function for relevant pins
just to clearly document the usage, even if this maps to the same thing as
configuring a pin as a GPIO.

> > I guess the answer is that there should be an interrupt API to map from
> > interrupt to GPIO number, returning <0 when there is no GPIO backing the
> > IRQ, and an op in struct irq_chip to implement that? However, that's not
> > there right now as far as I can tell.
> 
> Yes, exactly - but it should not be complicated to add one and since
> you're doing this anyway it'd make sense to do the core change rather
> than faffing around the edges of the system.

Sure, it doesn't look too hard.

A complication is that ARM doesn't define gpio_to_irq in a single central
header, but rather one per subarchitecture, I suppose since not all 
subarchitectures implement/require gpiolib. Still, I think this mostly
just means cut/pasting "#define irq_to_gpio __irq_to_gpio" into each
mach-foo's gpio.h for now, so /probably/ not a big deal...

> > Finally, there are some pinmux interactions that need to be dealt with;
> > on Tegra, the pinmux allows the tristate/drive status of pins to be set
> > on a group basis (a group being a set of 1-n pins). However, gpio enable
> > (which overrides the pinmux's setting of tristate/drive) can be set on
> > a per-pin basis. At least on Seaboard, the WM8903 IRQ is an input pin
> > in a group that otherwise needs to contain output pins, so we really
> > want to enable the WM8903 IRQ GPIO pin as a GPIO, and set it to input,
> > before setting up that pinmux group to drive the pins. Without this,
> > there may be a brief period where both Tegra and the WM8903 are driving
> > this IRQ signal, which can't be good for hardware.
> 
> If the pinmux stuff can't work this out then it needs to be worked on
> until it can, this is pretty basic stuff.  I had thought that the plan
> was to support a big block configuration done by the board which set
> everything up en masse and would presumably cope with stuff like this?

Maybe the solution for Tegra, once we have the new pinmux API in place,
is for the pinmux driver initialization to program all pins in HW as
input GPIOs, and hence tri-stated. That way, there can never be any
conflict with external HW. If/once a pin/group is requested as a
particular special function, the tri-state can be removed, since then
we'll know the board-specific direction. Some though may have to be
given to not tri-stating any pins required for basic SDRAM or UART
access during the boot process, but this is probably workable.

-- 
nvpublic
