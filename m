From: tony@atomide.com (Tony Lindgren)
Date: Mon, 25 Sep 2017 07:25:20 -0700
Subject: [PATCH 01/10] dt-bindings: bus: Minimal TI sysc interconnect
 target module binding
In-Reply-To: <20170925063545.nn3gr5drea6o2g6m@squirrel.local>
References: <20170920224621.16236-1-tony@atomide.com>
 <20170920224621.16236-2-tony@atomide.com>
 <20170925063545.nn3gr5drea6o2g6m@squirrel.local>
Message-ID: <20170925142520.GE4394@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Matthijs van Duin <matthijsvanduin@gmail.com> [170924 23:36]:
> On Wed, Sep 20, 2017 at 03:46:12PM -0700, Tony Lindgren wrote:
> > +- compatible	shall be one of the following generic types:
> > +
> > +		"ti,sysc-type1"
> > +		"ti,sysc-type2"
> > +		"ti,sysc-type3"
> 
> Is the meaning of these documented anywhere?  I'm assuming one of them
> corresponds to the standard omap2/3 sysconfig/sysstatus:

Yes that's the type1 sysc. Pretty much the only documentation is what
we already have defined in the kernel, see:

$ grep "#define SYSC_TYPE" arch/arm/mach-omap2/omap_hwmod.h

> 	sysconfig:
> 	bit   0     rw  auto-idle / auto-gating
> 	bit   1     -x  soft-reset
> 	bit   2     rw  wakeup enabled
> 	bits  3- 4  rw  (slave) idle mode
> 	bit   5     rw  emu-free
> 	bits  6- 7  z-
> 	bit   8     rw  interface clock not gated when module in idle
> 	bit   9     rw  functional clock not gated when module in idle
> 	bits 10-11  z-
> 	bits 12-13  rw  standby mode (master idle mode)
> 	sysstatus:
> 	bit   0     r-  reset done
> 
> and one to the standard omap4/5 sysconfig:
> 
> 	bit   0     rx  soft-reset
> 	bit   1     rw  emu-free
> 	bits  2- 3  rw  (slave) idle mode
> 	bits  4- 5  rw  standby mode (master idle mode)
> 	bits  6- 7  z-
> 	bits  8-15  rw  auxiliary clocks (rare)

Yeah and that's what we call sysc type 2 in the kernel.

> What's the third?  I'm not really aware of any other standard layout,
> just a whole bunch of non-standard ones.

The sysc type3 is what we have on am335x/ti81xx, see:

$ git grep -B10 -A1 "&omap_hwmod_sysc_type3" arch/arm/mach-omap2

> > +		or one of the following derivative types for hardware
> > +		needing special workarounds:
> 
> To add to the collection: omap4/5 isp5 (part of iss) has:
> 	bit   0     r-  auto-idle / auto-gating
> 	bit   1     rx  soft-reset (requires special procedure)
> 	bits  2- 3  z-
> 	bits  4- 5  rw  standby mode (master idle mode)

OK, I don't think we have that yet.

> > +Note that other SoCs, such as am335x can have multipe child devices. On am335x
> > +there are two MUSB instances, two USB PHY instances, and a single CPPI41 DMA
> > +instance as children of a single interconnet target module.
> 
> ISS (omap4/5, dm814x) is also fun since it has top-level sysconfig, but
> most of the child modules (e.g. isp5 and simcop) also have their own
> sysconfig, and some child modules of simcop again have sysconfig.

Interesting. Sounds like there's yet another interconnect instance
lurking there similar to L4 ABE?

Regards,

Tony
