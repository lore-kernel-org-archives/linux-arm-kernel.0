From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 07 Jan 2016 15:45:32 +0100
Subject: [PATCH 3/3] arm: dts: bcm5301x: Add syscon based reboot in DT
In-Reply-To: <20160105222605.GL31867@broadcom.com>
References: <1450474676-10210-1-git-send-email-jonmason@broadcom.com>
 <2180042.V6T2Tnxp6B@wuerfel> <20160105222605.GL31867@broadcom.com>
Message-ID: <2695666.f4UPYAJLqz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 05 January 2016 17:26:06 Jon Mason wrote:
> On Fri, Dec 18, 2015 at 10:44:28PM +0100, Arnd Bergmann wrote:
> > On Friday 18 December 2015 16:37:56 Jon Mason wrote:
> > > +       cru: cru at 1800c184 {
> > > +               compatible = "syscon";
> > > +               reg = <0x1800c184 0xc>;
> > > +       };
> > 
> > It's unusual for a device to start at such an odd address. Are you sure
> > it's not a larger device starting at 0x1800c000 or 0x18000000?
> 
> The CRU (Clock and Reset Unit) starts at 0x1800c100, with the
> following layout:
> 
> CRU Clock Management at 0x1800c100-0x1800c180
> CRU Reset at 0x1800c184
> CRU Period Sample Clock at 0x1800c188
> CRU Interrupt register at 0x1800c18c
> CRU MDIO Control at 0x1800c190
> CRU GPIO at 0x1800c1c0-0x1800c1e0
> CRU SDIO 0x1800c200-0x1800c214
> CRU RoboSW Interrupt at 0x1800c280
> CRU Straps Control at 0x1800c2a0
> 
> The clock driver is already referencing the registers between
> 0x1800c100-0x1800c180, and the GPIO driver is referencing registers
> between 0x1800c1c0-0x1800c1e0.
> 
> The reset part of the syscon seems to be the only useful thing in this
> block.  Am I approaching this incorrectly?

I think the problem is how the gpio controller has a device node
that overlaps with one of the devices of the chip.

If the data sheet lists a "Clock and Reset Unit" at those addresses,
that is a strong indication that this is actually a specific
piece of hardware, and it should be represented as one device node
in DT, with the sub-registers being exposed by that driver in
some way. A typical way would be to have a syscon node like

	cru: syscon at 1800c100 {
		compatible = "brcm,bcm53010-clock-reset-unit", "syscon";
		reg = <0x1800c100 100>;
	};

that represents the entire unit. You can then have syscon references
in each driver that uses it, and/or create a high-level driver that
binds to the "brcm,bcm53010-clock-reset-unit" compatible string and that
exports a set of functions for other drivers to be used if you prefer
to do this as functional abstraction rather than register based.

> > Also, please provide a more specific compatible string based on the
> > name of the device in the data sheet. The node name in contrast should
> > be more generic, e.g.
> > 
> > 	cru: system-controller at 1800c000 {
> > 		compatible = "brcm,bcm53010-cru", "syscon";
> 
> This is very similar between the NS and NSP (and NS2) platforms.  I'll
> verify the layout and see if this can't be "brcm,iproc-cru" or
> something similar.

If it's only "very similar" but not identical, don't use the same compatible
string, at least not as the only one. You should be able to identify the
specific device by looking at its compatible string in case you want to
write a high-level driver that knows about the differences later (the driver
should not need to inquire the chip name, it should only look at one device
node).

	Arnd
