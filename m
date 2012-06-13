From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jun 2012 19:19:34 +0000
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370 and
 Armada XP SoC
In-Reply-To: <20120613181408.7e03fcae@skate>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <201206121349.27696.arnd@arndb.de> <20120613181408.7e03fcae@skate>
Message-ID: <201206131919.34861.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 June 2012, Thomas Petazzoni wrote:
> Hello Arnd,
> 
> Le Tue, 12 Jun 2012 13:49:27 +0000,
> Arnd Bergmann <arnd@arndb.de> a ?crit :
> 
> > > Andrew Lunn asked for refactoring the _restart() function to being used by
> > > any MVEBU SOC, but we didn't find a nice way to do it. Indeed the registers
> > > mapping differs between the SOC and the bit mask too. A solution could be to
> > > get this mapping through the device tree, but we are not sure it was a good
> > > usage of the device tree.
> > 
> > As I suggested in my reply to patch 4/8, I think this can be encapsulated
> > in one file that acts as a driver for the generic ("bridge regs") registers
> > and provides functions for that based on the "compatible" property.
> 
> The problem here is that those registers are part of a random set of
> registers, that do not really constitute a sort of coherent "device",
> as we have for other IP blocks (SATA controllers, SPI controllers,
> etc.). First of all, the "bridge regs" name was unfortunate and a
> left-over from early versions of the code, the datasheet does not refer
> to them as "bridge registers" in any location.
> 
> On the Armada 370, the registers needed to restart the machine are part
> of a "Miscellaneous Registers" section in the list of register
> sections. This Miscellaneous Registers are 32 bits registers organized
> as follows:
> 
>  * SoC Control Register
>  * SoC Device Mux Register
>  * Power Management Memory Power Down 2 Register
>  * Power Management Memory Power Down 3 Register
>  * Power Management Memory Power Down 4 Register
>  * Power Management Memory Power Down 5 Register
>  * Power Management Clock Gating Control Register
>  * Power Management Memory Power Down 6 Register
>  * Sample at Reset Register
>  * Sample at Register High Register
>  * Device ID Register
>  * CPU SoC ID Register 
>  * SYSRSTn Length Counter Register
>  * RSTOUTn Mask Register -- this one needed for restart
>  * System Soft Reset Register -- this one needed for restart
>  * Shared SERDES 063 selectors Register
>  * Boot ROM Routine and Error Code Register
>  * PCI Express Boot Address Register
> 
> This registers are more or less contiguous, from offset 0x18204 to
> 0x182D4. As you can see, the purpose of those registers are very
> different from one register to another, so it's kind of odd to create a
> "driver" that would span those registers.

We have the same problem on other platforms as well.

> On the Armada XP, we have a "System Registers" area, subdivided by the
> datasheet in "Configuration and Control", "QSGMII Control and Status",
> "SERDES", "Power Management and Memory Power Down", "Thermal Manager",
> "BootROM", "Interrupt, "Design for Testability". But from an
> offset/address perspective, some registers of the "Power Management and
> Memory Power Down" subsection are in the middle of the registers of the
> "Configuration and Control" registers.
> 
> For the restart problem on Armada XP, the two registers of interest are
> within the "Configuration and Control" subsection.
> 
> Our biggest problem is that all those registers do not really match
> very well with a device/driver representation, so we don't know how to
> nicely represent them in the device tree. How would you recommend to
> handle these?

I think there should be a "system controller" device that takes care of
all of those registers in the device tree, and a file to provide accessor
functions for the individual registers. It should be fairly straightforward
to implement this, but there are multiple ways of how to get there,
depending on how these register areas differ between the various SOCs
in the mvebu family:

1. If the layout is identical or very similar for all of these, I would
just do one driver that provides high-level accessors for each
register, such as the "restart" function. Small differences can be
handled by looking up a part number, e.g. the PCI access functions 
could return an error on parts that have no PCI.

2. If the individual registers are all the same but their location
differs, you might want to represent each set of registers as an
individual device node and then look up the location when probing
for the system controller device. You would however not make that
a "simple_bus", so you don't get a platform_device for each of them.

3. If they are very different, you can just export a "regmap" from
the main driver, and use different offsets in drivers using that,
depending on the specific SOC.

	Arnd
