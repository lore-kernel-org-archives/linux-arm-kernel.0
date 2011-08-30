From: scottwood@freescale.com (Scott Wood)
Date: Tue, 30 Aug 2011 16:09:08 -0500
Subject: Arm device tree wonder
In-Reply-To: <1314734987.11994.YahooMailNeo@web132211.mail.ird.yahoo.com>
References: <1314734987.11994.YahooMailNeo@web132211.mail.ird.yahoo.com>
Message-ID: <4E5D5174.9060405@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/2011 03:09 PM, Pierre Beaumon wrote:
> From I understanding the goal of the FDT, is to limit board code for each soc and simplify machine code.
> 
> === info provided by FDT ===
> 
> We describe the mapping of controllers on the soc (irq, memory map). But this info won't change for a given SOC.
> What's the point of describing the interrupt controller, timer on FDT ?
> Do we really expect to support new SOC without any kernel modification ?

Depending on how closely it resembles a previously supported SoC, the
changes might be minimal.

> If not why not include for once this info in the kernel and avoid to duplicate it for each board ?

DTC recently grew the ability to do overlay trees, which in combination
with include files lets you factor out the SoC stuff into its own file.

For example, see arch/powerpc/boot/dts/p4080si.dtsi and
arch/powerpc/boot/dts/p4080ds.dts

> Also most controller aren't stable across SOC version :
> - there are bugs in hardware (for example omap3 errata is 100 pages) and new revisions correct them
> - new revisions add new features
> 
> How the driver is aware of the revision on the controller. Most of
> the time hardware guys are lazy and don't provide this info in the
> controller (no version register). The driver need to deduce it from
> the SOC version/revision (with dynamic detection).

You can still use the SOC version info.  You could also encode whatever
information is relevant into the device's compatible string, or other
properties.

> FDT doesn't seem to provide this info and shouldn't (what if a board got different SOC revisions).

On Freescale powerpc boards we usually patch up things like this from
U-Boot, though this has some drawbacks.  It could also be done from
early Linux platform code, or some update program that sits between
firmware and Linux (such as a U-Boot standalone application).  We use
these updates for board-level things as well, such as when certain
devices are enabled/disabled by jumper or similar config.

It's also possible to have the driver just find out about the SOC
revision from elsewhere, though this can be awkward in a virtualized
environment if you need to mix emulated devices that belong to different
SOC types.

> This means there still a link between driver and machine code for hardware probing.
> 
> === in or out kernel tree FDT ? ===
> 
> Also when the driver is improved (support new feature, ...), how new
> configuration should be provided to FDT ? Can we break the FDT API or
> should we provide only new property ?

The FDT is not a driver configuration medium.  It is supposed to just
describe the hardware.

> If we want to support out of kernel FDT, I think we can't break the API.
> 
> But what happen if a board/SOC vendor provide a board with a crappy
> FDT mapping, we can rewrite it and do new mapping in mainline
> kernel. But that means the vendor FDT is not supported anymore, and
> we can't boot new kernel on this board without overriding the vendor
> FDT.

In general, if you're relying on a binding that hasn't been accepted
into mainline Linux (or possibly some other designated binding
repository, such as devicetree.org), you're at risk of breakage.  Same
as with other APIs.

You can usually have the code support both the new and old bindings, though.

> Sometime when doing a board, we discover too late board bug that can
> be workaround in the board code. How this will work with FDT ? Should
> be do like in x86 with quirk in kernel according to dmi indentifier
> or have machine code somewhere ?

On powerpc we still have board code (identified by string, not
enumeration).  Even if we eventually develop the ability to boot on an
unrecognized board purely based on the other things in the device tree
(provided all the needed support is actually there), the ability to
match the toplevel compatible when special handling is needed would
still be there.

> Arm is different of other architecture (sparc/powerpc) where FDT is
> used because there are lot's of Soc with different controllers.
> Nearly all vendor got its own uart, i2c, ... I am waiting to see how
> it will work on arm.

How is this different from powerpc?

> But please don't forget arm isn't only used on laptop/netbook that
> want generic kernel. It is used for a wide variety of applications.
> These applications may not be found in the mainline kernel, but that
> don't mean nobody use them.

This can also be said of powerpc.

> Also I believe one big arm problem is a lack of common infrastructure
> that lead to code duplication. Some machine try to do too much
> things. omap2 (mach-omap2 + plat-omap) is about 80 KSLOC over
> 400KSLOC (76 mach + plat directories). That 8 times bigger than the
> average ((80/2)/(400/76))! There are either common stuff that should
> be shared, or some stuff should be moved in drivers.
> 
> Also the directory organization of mach-*, plat-* is quite complex. 
> Why not put a top level directory with the soc family name, and then
> put in that directory mach-*/plat-* directories.

Why have such a rigid structure at all, versus just having various bits
of code that support various things, glued together however the device
tree and/or board code specify?

-Scott
