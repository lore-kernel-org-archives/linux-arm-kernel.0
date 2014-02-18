From: gsi@denx.de (Gerhard Sittig)
Date: Tue, 18 Feb 2014 14:44:30 +0100
Subject: [PATCH] dt/bindings: update fsl-fec regarding compatible and
 clocks
In-Reply-To: <20140218020901.GA15716@S2101-09.ap.freescale.net>
References: <1392033008-20752-1-git-send-email-shawn.guo@linaro.org>
 <20140217212439.GZ4524@book.gsilab.sittig.org>
 <20140218020901.GA15716@S2101-09.ap.freescale.net>
Message-ID: <20140218134430.GC4524@book.gsilab.sittig.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 10:09 +0800, Shawn Guo wrote:
> 
> On Mon, Feb 17, 2014 at 10:24:39PM +0100, Gerhard Sittig wrote:
> > On Mon, Feb 10, 2014 at 19:50 +0800, Shawn Guo wrote:
> > > 
> > > Update fsl-fec to explicitly list the supported compatible strings
> > > and add missing 'clocks' and 'clock-names' properties.  It does not
> > > change anything about how kernel drive works.  Instead, it just reflects
> > > how kernel driver works today.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/net/fsl-fec.txt |   19 ++++++++++++++++++-
> > >  1 file changed, 18 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/net/fsl-fec.txt b/Documentation/devicetree/bindings/net/fsl-fec.txt
> > > index 845ff84..3ebd395 100644
> > > --- a/Documentation/devicetree/bindings/net/fsl-fec.txt
> > > +++ b/Documentation/devicetree/bindings/net/fsl-fec.txt
> > > @@ -1,9 +1,26 @@
> > >  * Freescale Fast Ethernet Controller (FEC)
> > >  
> > >  Required properties:
> > > -- compatible : Should be "fsl,<soc>-fec"
> > > +- compatible : Should contain one of the following:
> > > +		"fsl,imx25-fec"
> > > +		"fsl,imx27-fec"
> > > +		"fsl,imx28-fec"
> > > +		"fsl,imx6q-fec"
> > > +		"fsl,mvf600-fec"
> > 
> > This appears to miss all the PowerPC based SoCs.  See
> >   git grep 'fsl,.*-fec' arch/*/boot/dts
> 
> Hmm, this is a binding for IMX FEC/ENET, and the driver is
> drivers/net/ethernet/freescale/fec_main.c.

The binding text says otherwise.  It claims to apply for
"fsl,<soc>-fec" compatibles.

It's funny how the first line of the source you point to talks
about being a FEC driver for MPC8xx. :)  But that doesn't matter
here, as it's just a comment in some code.

> I think I've listed all the compatibles that the driver
> supports.

You got it backwards.  The binding is not the after-the-fact
documentation of a specific Linux driver.  Instead the Linux
driver is (supposed to be) an implementation of what the binding
specifies.  And in this case, there are several drivers, each
managing a subset of the compatibles space, each supposed to
follow the spec.  See

  git grep 'fsl,.*-fec' drivers/net/ethernet

> > >  - reg : Address and length of the register set for the device
> > >  - interrupts : Should contain fec interrupt
> > > +- clocks: phandle to the clocks feeding the FEC controller and phy. The
> > > +  following two are required:
> > > +   - "ipg": the peripheral access clock
> > > +   - "ahb": the bus clock for MAC
> > > +  The following two are optional:
> > > +   - "ptp": the sampling clock for PTP (IEEE 1588).  On SoC like i.MX6Q,
> > > +     the clock could come from either the internal clock control module
> > > +     or external oscillator via pad depending on board design.
> > > +   - "enet_out": the phy reference clock provided by SoC via pad, which
> > > +     is available on SoC like i.MX28.
> > > +- clock-names: Must contain the clock names described just above
> > > +
> > 
> > Listing 'clocks' under the "required properties" all of a sudden
> > invalidates existing device trees, if they don't carry the
> > property which before the change was not required, not even
> > documented.
> 
> Since the day we move to device tree clock lookup, the driver fec_main
> does not probe at all if the property is absent.

That's an implementation detail.  It's not what the spec says,
and neither is what the spec is to blindly follow after the / a
driver created the fact.  Instead, a binding gets designed, and
the software follows.

In reality, the doc may be behind as developers are more
concerned about the code.  But still when you "update" the
binding, don't break compatibility!  Even if you'd adjust all
drivers you can spot, it's still only Linux and not all device
tree users.

> > The PowerPC based chips probably have differing sets of clocks.
> > I'm aware of the MPC512x, where one "per" clock is sufficient,
> > and even this spec is optional.  Other machines may not have yet
> > been converted to CCF.
> 
> Again, the binding is created for IMX FEC/ENET controller and the driver
> fec_main, so I'm not sure you should look at this binding for
> PowerPC/MPC512x stuff at all.

See above, the binding is _not_ specific to i.MX, it's a FEC
binding.  Which happens to apply to several architectures, as the
FEC is used in several SoCs.  And keep in mind that the device
tree binding is OS agnostic, Linux details just are not the
reference.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office at denx.de
