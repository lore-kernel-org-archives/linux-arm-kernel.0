From: gsi@denx.de (Gerhard Sittig)
Date: Sat, 22 Feb 2014 19:28:06 +0100
Subject: [PATCH] dt/bindings: update fsl-fec regarding compatible and
 clocks
In-Reply-To: <20140218144652.GG15716@S2101-09.ap.freescale.net>
References: <1392033008-20752-1-git-send-email-shawn.guo@linaro.org>
 <20140217212439.GZ4524@book.gsilab.sittig.org>
 <20140218020901.GA15716@S2101-09.ap.freescale.net>
 <20140218134430.GC4524@book.gsilab.sittig.org>
 <20140218144652.GG15716@S2101-09.ap.freescale.net>
Message-ID: <20140222182806.GF3327@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 22:46 +0800, Shawn Guo wrote:
> 
> On Tue, Feb 18, 2014 at 02:44:30PM +0100, Gerhard Sittig wrote:
> > [ ... ]
> 
> > > > >  - reg : Address and length of the register set for the device
> > > > >  - interrupts : Should contain fec interrupt
> > > > > +- clocks: phandle to the clocks feeding the FEC controller and phy. The
> > > > > +  following two are required:
> > > > > +   - "ipg": the peripheral access clock
> > > > > +   - "ahb": the bus clock for MAC
> > > > > +  The following two are optional:
> > > > > +   - "ptp": the sampling clock for PTP (IEEE 1588).  On SoC like i.MX6Q,
> > > > > +     the clock could come from either the internal clock control module
> > > > > +     or external oscillator via pad depending on board design.
> > > > > +   - "enet_out": the phy reference clock provided by SoC via pad, which
> > > > > +     is available on SoC like i.MX28.
> > > > > +- clock-names: Must contain the clock names described just above
> > > > > +
> > > > 
> > > > Listing 'clocks' under the "required properties" all of a sudden
> > > > invalidates existing device trees, if they don't carry the
> > > > property which before the change was not required, not even
> > > > documented.
> > > 
> > > Since the day we move to device tree clock lookup, the driver fec_main
> > > does not probe at all if the property is absent.
> > 
> > That's an implementation detail.  It's not what the spec says,
> > and neither is what the spec is to blindly follow after the / a
> > driver created the fact.  Instead, a binding gets designed, and
> > the software follows.
> > 
> > In reality, the doc may be behind as developers are more
> > concerned about the code.  But still when you "update" the
> > binding, don't break compatibility!  Even if you'd adjust all
> > drivers you can spot, it's still only Linux and not all device
> > tree users.
> 
> So what's your suggestion?  Add the properties as the optional?

Have there been i.MX device trees in mainline releases which lack
the clock specs?  If so, making the clock specs mandatory breaks
backwards compatibility for these existing device trees as well.

I assume that listing the clocks as optional keeps the binding
most compatible.  You might as well list them as recommended, if
optional is "too weak" for you.


I guess that listing the clocks as recommended, and telling which
clock names apply to which SoC variants, allows to keep using the
binding for all current implementations which were written
against this spec.  This way you might focus on i.MX and say "the
following SoCs require the following clock names", and still
leave the PowerPC stuff or other FEC users for a followup patch.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
