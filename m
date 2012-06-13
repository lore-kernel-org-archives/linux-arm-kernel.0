From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 13 Jun 2012 18:14:08 +0200
Subject: [PATCH v2] arm: Add basic support for new Marvell Armada 370
 and Armada XP SoC
In-Reply-To: <201206121349.27696.arnd@arndb.de>
References: <1339433585-28087-1-git-send-email-gregory.clement@free-electrons.com>
 <201206121349.27696.arnd@arndb.de>
Message-ID: <20120613181408.7e03fcae@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd,

Le Tue, 12 Jun 2012 13:49:27 +0000,
Arnd Bergmann <arnd@arndb.de> a ?crit :

> > Andrew Lunn asked for refactoring the _restart() function to being used by
> > any MVEBU SOC, but we didn't find a nice way to do it. Indeed the registers
> > mapping differs between the SOC and the bit mask too. A solution could be to
> > get this mapping through the device tree, but we are not sure it was a good
> > usage of the device tree.
> 
> As I suggested in my reply to patch 4/8, I think this can be encapsulated
> in one file that acts as a driver for the generic ("bridge regs") registers
> and provides functions for that based on the "compatible" property.

The problem here is that those registers are part of a random set of
registers, that do not really constitute a sort of coherent "device",
as we have for other IP blocks (SATA controllers, SPI controllers,
etc.). First of all, the "bridge regs" name was unfortunate and a
left-over from early versions of the code, the datasheet does not refer
to them as "bridge registers" in any location.

On the Armada 370, the registers needed to restart the machine are part
of a "Miscellaneous Registers" section in the list of register
sections. This Miscellaneous Registers are 32 bits registers organized
as follows:

 * SoC Control Register
 * SoC Device Mux Register
 * Power Management Memory Power Down 2 Register
 * Power Management Memory Power Down 3 Register
 * Power Management Memory Power Down 4 Register
 * Power Management Memory Power Down 5 Register
 * Power Management Clock Gating Control Register
 * Power Management Memory Power Down 6 Register
 * Sample at Reset Register
 * Sample at Register High Register
 * Device ID Register
 * CPU SoC ID Register 
 * SYSRSTn Length Counter Register
 * RSTOUTn Mask Register -- this one needed for restart
 * System Soft Reset Register -- this one needed for restart
 * Shared SERDES 063 selectors Register
 * Boot ROM Routine and Error Code Register
 * PCI Express Boot Address Register

This registers are more or less contiguous, from offset 0x18204 to
0x182D4. As you can see, the purpose of those registers are very
different from one register to another, so it's kind of odd to create a
"driver" that would span those registers.

On the Armada XP, we have a "System Registers" area, subdivided by the
datasheet in "Configuration and Control", "QSGMII Control and Status",
"SERDES", "Power Management and Memory Power Down", "Thermal Manager",
"BootROM", "Interrupt, "Design for Testability". But from an
offset/address perspective, some registers of the "Power Management and
Memory Power Down" subsection are in the middle of the registers of the
"Configuration and Control" registers.

For the restart problem on Armada XP, the two registers of interest are
within the "Configuration and Control" subsection.

Our biggest problem is that all those registers do not really match
very well with a device/driver representation, so we don't know how to
nicely represent them in the device tree. How would you recommend to
handle these?

If further details are needed on the registers organization in order to
find the best solution, I'll be happy to provide them.

Thanks!

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
