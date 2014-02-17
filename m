From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 17 Feb 2014 12:08:24 +0100
Subject: [PATCH v3 1/7] Documentation: Add device tree bindings for
 Freescale i.MX GPC
In-Reply-To: <20140217104936.GB18920@e106331-lin.cambridge.arm.com>
References: <1392631503-17283-1-git-send-email-p.zabel@pengutronix.de>
 <1392631503-17283-2-git-send-email-p.zabel@pengutronix.de>
 <20140217104936.GB18920@e106331-lin.cambridge.arm.com>
Message-ID: <1392635304.3456.8.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

thank you for the comments.

Am Montag, den 17.02.2014, 10:49 +0000 schrieb Mark Rutland:
> On Mon, Feb 17, 2014 at 10:04:57AM +0000, Philipp Zabel wrote:
> > The i.MX6 contains a power controller that controls power gating and
> > sequencing for the SoC's power domains.
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> >  .../devicetree/bindings/power/fsl,imx-gpc.txt      | 61 ++++++++++++++++++++++
> >  1 file changed, 61 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> > new file mode 100644
> > index 0000000..3ec8c0e
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/fsl,imx-gpc.txt
> > @@ -0,0 +1,61 @@
> > +Freescale i.MX General Power Controller
> > +=======================================
> > +
> > +The i.MX6Q General Power Control (GPC) block contains DVFS load tracking
> > +counters and Power Gating Control (PGC) for the CPU and PU (GPU/VPU) power
> > +domains.
> > +
> > +Required properties:
> > +- compatible: Should be "fsl,imx6q-gpc"
> > +- reg: should be register base and length as documented in the
> > +  datasheet
> > +- interrupts: Should contain GPC interrupt request 1
> 
> Does the unit have multiple interrupts?

According to the i.MX6 Reference Manuals, interrupt 121 is the "GPC
interrupt request 1". The following interrupt 122 (which also is listed
in the current imx6qdl.dtsi) is "Reserved". I think the answer is no,
maybe Shawn can correct me.

> If so it would be good to use interrupt-names so they can be describe
> unambiguously.
> 
> > +- pu-supply: Link to the LDO regulator powering the PU power domain
> > +- #address-cells, #size-cells: Should be <1>
> 
> This seems to be to map child nodes into the same address space. Is
> there any need that these are precisely 1, or could they be anything
> that maps the child nodes in?

I guess there is not. Should I just drop this line?

> > +
> > +The gpc node should contain 'power-domain' subnodes for each power domain.
> > +These serve as phandle targets for devices belonging to the power domain:
> > +
> > +Power domains controlled by a PGC register set
> > +==============================================
> > +
> > +Required properties:
> > +- compatible: Should be "fsl,imx6q-power-domain"
> > +- reg: should be register base and length as documented in the
> > +  datasheet
> > +
> > +Specifying power domain for IP modules
> > +======================================
> > +
> > +IP cores belonging to a power domain should contain a 'power-domain' property
> > +that is a phandle pointing to the power-domain subnode of the gpc device node.
> > +
> > +Required properties:
> > +- power-domain: A phandle pointing to the power-domain device tree node
> 
> This sounds a little generic. Is there a standard power-domain binding?
> If not it might be better for the moment for this to be
> fsl,power-domain.

So far I am only aware of samsung,power-domain, so I'll change this to
fsl,power-domain accordingly.

regards
Philipp
