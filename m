From: robh@kernel.org (Rob Herring)
Date: Tue, 25 Sep 2018 11:15:00 -0500
Subject: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
 bindings
In-Reply-To: <CY1PR02MB2138C05E97C1EFAEA921CB5CB81A0@CY1PR02MB2138.namprd02.prod.outlook.com>
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
 <1534447304-12919-2-git-send-email-jollys@xilinx.com>
 <20180820194628.GA26783@bogus>
 <CY1PR02MB2138C05E97C1EFAEA921CB5CB81A0@CY1PR02MB2138.namprd02.prod.outlook.com>
Message-ID: <CAL_JsqJOz_z9dHcG5dfx=UTXQMaLTQKBPu+vTrTOt=sdAabqSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 12:51 PM Jolly Shah <JOLLYS@xilinx.com> wrote:
>
> Hi Rob,
>
> > -----Original Message-----
> > From: Rob Herring [mailto:robh at kernel.org]
> > Sent: Monday, August 20, 2018 12:46 PM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: matthias.bgg at gmail.com; andy.gross at linaro.org; shawnguo at kernel.org;
> > geert+renesas at glider.be; bjorn.andersson at linaro.org;
> > sean.wang at mediatek.com; m.szyprowski at samsung.com; Michal Simek
> > <michals@xilinx.com>; mark.rutland at arm.com; Rajan Vaja
> > <RAJANV@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Rajan Vaja
> > <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> > Subject: Re: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
> > bindings
> >
> > On Thu, Aug 16, 2018 at 12:21:42PM -0700, Jolly Shah wrote:
> > > From: Rajan Vaja <rajan.vaja@xilinx.com>
> > >
> > > Add documentation to describe ZynqMP power domain bindings.
> > >
> > > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > > ---
> > >  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 47
> > ++++++++++++++++++++++
> >
> > This should be with all the other power domain bindings.
> >
> > >  1 file changed, 47 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > > re.txt
> > > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > > re.txt
> > > index d215d15..5fa10a0 100644
> > > ---
> > > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > > re.txt
> > > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > > +++ rmware.txt
> > > @@ -64,6 +64,29 @@ Output clocks are registered based on clock
> > > information received  from firmware. Output clocks indexes are
> > > mentioned in  include/dt-bindings/clock/xlnx,zynqmp-clk.h.
> > >
> > > +-----------------------------------------------------------
> > > +Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
> > > +-----------------------------------------------------------
> > > +The binding for zynqmp-power-controller follow the common generic PM
> > > +domain binding[1].
> > > +
> > > +[1] Documentation/devicetree/bindings/power/power_domain.txt
> > > +
> > > +== Zynq MPSoC Generic PM Domain Node ==
> > > +
> > > +Required properties:
> > > + - compatible:     Must be: "xlnx,zynqmp-power-controller"
> > > +
> > > +This node contains a number of subnodes, each representing a single
> > > +PM domain that PM domain consumer devices reference.
> > > +
> > > +== PM Domain Nodes ==
> > > +
> > > +Required properties:
> > > + - #power-domain-cells:    Number of cells in a PM domain specifier. Must
> > be 0.
> > > + - pd-id:          Domain identifier as defined by platform firmware.
> > > +                   This identifier is passed to the PM firmware.
> >
> > Make this a cell for the power domain consumer.
> [Jolly] We have more than one Ids for GPU device. Also they don't have parent child relationship and hence are defined as flat hierarchy. (shown in example below)

Then the gpu node should have:

power-domains = <&pd 58 &pd 20 &pd 21>;

Also, for this and the firmware reset binding, there is no reason that
I see to make these all subnodes. A single firmware node can be a
provider of multiple functions. You only need child nodes if the
sub-functions have their own resources (clks, irqs, etc.). IOW, don't
create nodes just because you want to instantiate drivers that way. DT
is not the only way to instantiate devices for drivers.

Rob
