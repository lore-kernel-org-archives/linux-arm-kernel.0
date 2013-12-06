From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Dec 2013 18:00:42 +0100
Subject: [PATCH v2 1/6] ARM: brcmstb: add infrastructure for ARM-based
 Broadcom STB SoCs
In-Reply-To: <52A1717D.7000001@gmail.com>
References: <1385511748-27869-1-git-send-email-marc.ceeeee@gmail.com>
 <201312031601.04997.arnd@arndb.de> <52A1717D.7000001@gmail.com>
Message-ID: <201312061800.42563.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 December 2013, Marc C wrote:

> > This seems like stuff that should go into the device drivers for the
> > respective hardware blocks, not into platform code.
> 
> Understood. I'm not sure if you recall this [1] conversation, but short
> of having a big array of registers offsets per chip ID (which will
> probably grow to 10 or more), leveraging the DT to let the bootloader
> tell the kernel these randomly-located registers are proved to be very
> lightweight.

Right, but I didn't expect the code to look at these registers to be
outside of a device-driver context.
 
> Seems like there's one thing I could possibly factor out into a separate
> driver... the registers that assert a chip reset (sw-master-reset-reg).
> Maybe I could register a reset-controller driver specifically for this
> purpose?

I have not followed the latest developments regarding system-reset and
where that is supposed to be handled, but I'm sure it's in some driver,
probably drivers/power or drivers/reset.

> > We try hard to avoid having register available this early and outside
> > of device drivers. Can you try to make at least some (if not all) of
> > these more regular, and provide specific comments in the code why this
> > is not possible for the others?
> 
> Just to be sure, you're asking to reduce our dependence on touching
> these machine-specific registers?

Not touching them at all would be preferred (e.g. if the boot loader
could set them up to the correct per-board setting), but of course that
doesn't work for run-time settings or system-reset.

The most important part of my comment above is to have as little as
possible done "early", i.e. before init_machine(). Beyond that, the
preferred way to do any kind of register access from a device driver
with an abstract platform-independent interface. We have added a number
of new subsystems in the past few years (clk, irqchip, pinctrl, reset,
clocksource, regmap, syscon, ...) along these lines, to the extent where
most new platforms can now have an empty machine descriptor (if they
can use the standard psci_smp_ops, I mentioned already that we need
some more work to get non-standard smp_ops merged with cpuidle).

Chances are that a lot of the registers you are trying to map here
already have a subsystem that they can fit in as a device driver,
or that they do something generic enough that we should add another
subsystem to abstract them. If you need help figuring out which
subsystem they should use, we should take a closer look at the actual
register descriptions together. Is there a manual that is publically
available?

	Arnd
