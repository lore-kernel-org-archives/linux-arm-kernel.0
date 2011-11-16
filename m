From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 16 Nov 2011 18:17:03 +0000
Subject: [PATCH 5/5] ARM: vexpress: DT-based support for CoreTiles
 Express A5x2 and A9x4
In-Reply-To: <1321460559.3137.358.camel@hornet.cambridge.arm.com>
References: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
 <1321036026-23411-6-git-send-email-pawel.moll@arm.com>
 <20111116153656.GC2073@localhost.localdomain>
 <1321460559.3137.358.camel@hornet.cambridge.arm.com>
Message-ID: <20111116181703.GK2073@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 16, 2011 at 04:22:39PM +0000, Pawel Moll wrote:
> On Wed, 2011-11-16 at 15:36 +0000, Dave Martin wrote:
> > > +/include/ "skeleton.dtsi"
> > > +
> > > +/ {
> > > +	model = "V2P-CA5s";
> > > +	arm,hbi = <0x225>;
> > 
> > Are these part numbers formally hex numbers?  Is so, fine.  Otherwise
> > maybe it would me safer to make properties of this kind strings.
> 
> Hex values. See
> http://infocenter.arm.com/help/topic/com.arm.doc.dui0447e/CACBEHGJ.html

Ok, I guess that's correct, then.

> > > +config ARCH_VEXPRESS_V2P_CA5S_CA9
> > > +	bool "DT: CoreTiles Express A5x2 and A9x4"
> > 
> > This "DT" stuff is a bit cryptic -- also it's an implementation feature
> > rather than part of the core nature of this config option.
> 
> Yeah, I know. I just didn't feel very verbose doing the Kconfig changes.

As a newcomer to the Linux kernel a while ago, I found the plethora of
rather descriptive config help text really helpful.


These days, there are too many items (particulary from vendor trees)
where the help text, if present at all, is something like:

config BLAG_SLAD_BUP
	help
	  Enable the BLAG slad bup


or

config SCARY_UNSAFE_ONLY_ENABLE_IF_YOU_KNOW_WHAT_IT_DOES

	(no help to explain what the option does)

or examples such as the RCU subsystem, where although the invididual
items are reasonably documented, there is nowhere a statement of
what RCU does, why you want it, or even what it stands for.  Of
course, it's obvious to people who already know what it is, but
those aren't the people who documentation is written for.



I think we should do our best to sustain the quality, especially for
early examples of particular features which may get used as exemplars.

> 
> > Also, pedaitically, the product name is "CoreTile Express".
> 
> Ha ha - I wanted to express the plurality of A5 _and_ a9 ;-) Never mind,
> will change it.

I know -- I did say it was a pedantic point.  Change that or not, as you
wish.
 
> > Finally, this option does not support those core tiles, as such; rather
> > it supports particular whole-platform configurations involving those
> > core tiles.
> > 
> > How about "CoreTile Express A5x2 and A9x4 based platform support"
> 
> Fine with me - I'll use your wording :-)
> 
> > > +	select ARCH_VEXPRESS_RS1
> > > +	select ARCH_VEXPRESS_DT
> > > +	select ARM_ERRATA_720789
> > > +	select ARM_ERRATA_751472
> > > +	select ARM_ERRATA_753970
> > > +	help
> > > +	  This option enabled Device Tree based support for
> > > +	  CoreTile Express A5x2 (V2P-CA5s) and
> > > +	  CoreTile Express A9x4 (V2P-CA9).
> > > +
> > > +	  Note that you must provide kernel with a valid DTB
> > > +	  for the board if you want to use this option.
> > 
> > For the above reasons, the following alternative text might be a bit
> > more user-friendly:
> > 
> > 	help
> > 	  This option enables support for systems using any of the the following
> > 	  ARM core tiles on the Versatile Express motherboard:
> > 
> > 	      CoreTile Express A5x2 (V2P-CA5s)
> > 	      CoreTile Express A9x4 (V2P-CA9)
> > 
> > 	  You must boot using a Flattened Device Tree in order to use these
> > 	  platforms.  The traditional (ATAGs) boot method is not usable on
> > 	  these boards with this option.
> > 
> > 	  If you want your kernel to run on one of these platforms and your
> > 	  bootloader supports Flattened Device Tree based booting, say Y.
> 
> Same here - will copy this :-)
> 
> > Do we still support the "old style" V2P-CA9x4 support?  If so, we could
> > add a comment explaining that is available as an alternative, for now.
> 
> We do, with the non-DT option (Russell wouldn't be very happy if his
> serial port multiplexer stopped working ;-)
> 
> > >  endmenu
> > > diff --git a/arch/arm/mach-vexpress/Makefile b/arch/arm/mach-vexpress/Makefile
> > > index 90551b9..06e3687 100644
> > > --- a/arch/arm/mach-vexpress/Makefile
> > > +++ b/arch/arm/mach-vexpress/Makefile
> > > @@ -4,5 +4,6 @@
> > >  
> > >  obj-y					:= v2m.o
> > >  obj-$(CONFIG_ARCH_VEXPRESS_CA9X4)	+= ct-ca9x4.o
> > > +obj-$(CONFIG_ARCH_VEXPRESS_V2P_CA5S_CA9) += v2p-ca5s_ca9.o
> > >  obj-$(CONFIG_SMP)			+= platsmp.o
> > >  obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
> > > diff --git a/arch/arm/mach-vexpress/v2p-ca5s_ca9.c b/arch/arm/mach-vexpress/v2p-ca5s_ca9.c
> > 
> > [...]
> > 
> > > +DT_MACHINE_START(VEXPRESS_V2P_CA5S_CA9, "ARM Versatile Express")
> > 
> > We could try to name the platform fully here, but these strings would
> > get very long -- so I agree it best to leave that to be specified in
> > the device tree.
> 
> Having such machine name here and model in the dts gives such a nice
> message in the log:
> 
> Machine: ARM Versatile Express, model: V2P-CA9
> 
> Which is sort-of-correct.

Happy to go with your judgment on that.

Cheers
---Dave
