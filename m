From: jason@lakedaemon.net (Jason)
Date: Mon, 5 Mar 2012 09:38:19 -0500
Subject: [GIT PULL v3] ARM: kirkwood: fdt: convert kirkwood init funcs
 to fdt
In-Reply-To: <20120305141656.GA14449@lunn.ch>
References: <20120305141656.GA14449@lunn.ch>
Message-ID: <20120305143819.GE5050@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 05, 2012 at 03:16:56PM +0100, Andrew Lunn wrote:
> > On Sun, Mar 04, 2012 at 10:41:13PM -0500, Jason Cooper wrote:
> > >       rtc-mv: more accurate compatible strings
> > >       orion-wdt: more accurate compatible strings
> > ...
> > >  arch/arm/boot/dts/kirkwood-dreamplug.dts |   34 +++++++++++++++
> > >  arch/arm/boot/dts/kirkwood.dtsi          |   12 +++++
> > 
> > This is still bugging me.  If, say, orion_wdt.c is common to all of
> > plat-orion/ shouldn't it be in an 'orion.dtsi'?  With compatible =
> > "marvell,orion-wdt"?  Then, if hypothetically, kirkwood used the same
> > driver but had a small tweak, then kirkwood.dtsi would have
> > "marvell,kirkwood-wdt"?  Which would let the driver know that it needed
> > to apply the tweak because it was kirkwood.
> > 
> > In this scenario, since kirkwood and dreamplug currently need no
> > modifications to the default wdt driver, they would just inherit
> > orion.dtsi's "marvell,orion-wdt", right?
> > 
> > On the driver side, since it currently has no subarch or board specific
> > tweaks, then it is *only* good for the generic case,
> > "marvell,orion-wdt", and thus should only match it for now.
> > 
> > If the above is correct, then I should create orion.dtsi, which is
> > included by kirkwood.dtsi.  orion.dtsi should hold "marvell,orion-wdt"
> > and "marvell,orion-rtc".  The corresponding drivers should only match
> > those generic strings, since there are no specific tweaks.
> 
> Hi Jason
> 
> I would agree with you in principal, that most of the drivers used by
> kirkwood are generic orion drivers. There is one clear exception to
> this, and that is the audio driver, which is specific to Kirkwood.
> 
> However, what differs between all the different plat-orion SoC is the
> address map and interrupts. So the dove wdt is in a different place to
> the orion5x wdt, and uses a different interrupt line, etc.

Yes, I was just checking into that.  Seems to me then, it should be
defined at the lowest level where everything is the same.  So, since
kirkwood uses the same registers and irq lines across kirkwood boards,
placing orion_wdt in kirkwood.dtsi would be appropriate.

orion.dtsi doesn't make much sense unless there is something in common
across all the subarchs, attributes included.

Also, only devices which are common to *all* boards, and active would go
in kirkwood.dtsi.  Which is why we decided to place uart0 in
kirkwood-dreamplug.dts.  The serial port doesn't need to be enabled in
a production system, so including kirkwood.dtsi shouldn't enable it.

> So i expect in the end we have a dove.dtsi, a orion5x.dtsi, a
> mv78xx0.dtsi and a kirkwood.dtsi which all look very similar, but have
> different values for addresses and interrupts.

I'm coming to the same conclusion.

> Maybe DT has some why to handle this? 

I think this is the way it is Supposed To Be.

> As to naming, i think you are correct. It should be
> "marvell,orion-wdt" in all the different .dtsi files, since its the
> same SoC IP in all Orion devices. Same with "marvell,orion-rtc" since
> all orion based SoC have the same built in RTC IP.

Agreed.

thx,

Jason.
