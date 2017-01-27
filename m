From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 27 Jan 2017 19:02:14 +0100
Subject: [PATCH 1/4] dt-bindings: add multidomain support to i.MX GPC DT
 binding
In-Reply-To: <20170123162618.tohyqu5wluhrcmvd@rob-hp-laptop>
References: <20170120155225.31905-1-l.stach@pengutronix.de>
 <20170120155225.31905-2-l.stach@pengutronix.de>
 <20170123162618.tohyqu5wluhrcmvd@rob-hp-laptop>
Message-ID: <1485540134.28751.34.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 23.01.2017, 10:26 -0600 schrieb Rob Herring:
> On Fri, Jan 20, 2017 at 04:52:22PM +0100, Lucas Stach wrote:
> > This adds a new binding for the Freescale i.MX GPC block, which allows
> > to describe multiple power domains in a more natural way. The driver
> > will continue to support the old binding for existing DTBs, but new
> > features like the additional domains present on i.MX6SX will only be
> > usable with the new binding.
> >
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  .../devicetree/bindings/power/fsl,imx-gpc.txt      | 81 ++++++++++++++--------
> >  1 file changed, 54 insertions(+), 27 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> > index 65cc0345747d..e5b660018d63 100644
> > --- a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> > +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> > @@ -1,22 +1,41 @@
> >  Freescale i.MX General Power Controller
> >  =======================================
> >  
> > -The i.MX6Q General Power Control (GPC) block contains DVFS load tracking
> > -counters and Power Gating Control (PGC) for the CPU and PU (GPU/VPU) power
> > -domains.
> > +The i.MX6 General Power Control (GPC) block contains DVFS load tracking
> > +counters and Power Gating Control (PGC).
> >  
> >  Required properties:
> >  - compatible: Should be "fsl,imx6q-gpc" or "fsl,imx6sl-gpc"
> >  - reg: should be register base and length as documented in the
> >    datasheet
> > -- interrupts: Should contain GPC interrupt request 1
> > -- pu-supply: Link to the LDO regulator powering the PU power domain
> > -- clocks: Clock phandles to devices in the PU power domain that need
> > -	  to be enabled during domain power-up for reset propagation.
> > -- #power-domain-cells: Should be 1, see below:
> > +- interrupts: Should contain one interrupt specifier for the GPC interrupt
> > +- clocks: Must contain an entry for each entry in clock-names.
> > +  See Documentation/devicetree/bindings/clocks/clock-bindings.txt for details.
> > +- clock-names: Must include the following entries:
> > +  - ipg
> > +- pgc: a list of child nodes describing the SoC power domains controlled by the
> > +  power gating controller.
> 
> pgc is a node, not a property. Call it 'power-domains' instead.
> 
'power-domains' is commonly used to refer to the the domains from the
client devices. While it should be technically possible to have it as a
node in the GPC, I think this is confusing.
'pgc' is the name used in the reference manual for the sub-block of the
GPC that controls the power domains, so the current naming is actually a
pretty accurate DT description of the hardware organization.

> >  
> > -The gpc node is a power-controller as documented by the generic power domain
> > -bindings in Documentation/devicetree/bindings/power/power_domain.txt.
> > +The power domains are generic power domain providers as documented in
> > +Documentation/devicetree/bindings/power/power_domain.txt. They are described as
> > +subnodes of the GPC and should contain the following
> > +
> > +Required properties:
> > +- reg: the DOMAIN_INDEX as used by the client devices to refer to this
> > +  power domain
> > +  The following DOMAIN_INDEX values are valid for i.MX6Q:
> > +  ARM_DOMAIN     0
> > +  PU_DOMAIN      1
> > +  The following additional DOMAIN_INDEX value is valid for i.MX6SL:
> > +  DISPLAY_DOMAIN 2
> > +
> > +- #power-domain-cells: Should be 0
> > +
> > +Optional properties:
> > +- clocks: a number of phandles to clocks that need to be enabled during domain
> > +  power-up sequencing to ensure reset propagation into devices located inside
> > +  this power domain
> > +- domain-supply: a phandle to the regulator powering this domain
> 
> 'power-supply' is more common for when we don't really have a name.
> 
Will change.

Regards,
Lucas 
