From: JOLLYS@xilinx.com (Jolly Shah)
Date: Fri, 24 Aug 2018 22:22:03 +0000
Subject: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
 bindings
In-Reply-To: <20180820194628.GA26783@bogus>
References: <1534447304-12919-1-git-send-email-jollys@xilinx.com>
 <1534447304-12919-2-git-send-email-jollys@xilinx.com>
 <20180820194628.GA26783@bogus>
Message-ID: <CY1PR02MB2138CD14431A976812492D0BB8360@CY1PR02MB2138.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Monday, August 20, 2018 12:46 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: matthias.bgg at gmail.com; andy.gross at linaro.org; shawnguo at kernel.org;
> geert+renesas at glider.be; bjorn.andersson at linaro.org;
> sean.wang at mediatek.com; m.szyprowski at samsung.com; Michal Simek
> <michals@xilinx.com>; mark.rutland at arm.com; Rajan Vaja
> <RAJANV@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Rajan Vaja
> <RAJANV@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v2 1/3] dt-bindings: power: Add ZynqMP power domain
> bindings
> 
> On Thu, Aug 16, 2018 at 12:21:42PM -0700, Jolly Shah wrote:
> > From: Rajan Vaja <rajan.vaja@xilinx.com>
> >
> > Add documentation to describe ZynqMP power domain bindings.
> >
> > Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> > Signed-off-by: Jolly Shah <jollys@xilinx.com>
> > ---
> >  .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 47
> ++++++++++++++++++++++
> 
> This should be with all the other power domain bindings.
> 

The firmware node has clock, reset and power domain subnodes. Please suggest the right location for binding.

> >  1 file changed, 47 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > index d215d15..5fa10a0 100644
> > ---
> > a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmwa
> > re.txt
> > +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-fi
> > +++ rmware.txt
> > @@ -64,6 +64,29 @@ Output clocks are registered based on clock
> > information received  from firmware. Output clocks indexes are
> > mentioned in  include/dt-bindings/clock/xlnx,zynqmp-clk.h.
> >
> > +-----------------------------------------------------------
> > +Device Tree Bindings for the Xilinx Zynq MPSoC PM domains
> > +-----------------------------------------------------------
> > +The binding for zynqmp-power-controller follow the common generic PM
> > +domain binding[1].
> > +
> > +[1] Documentation/devicetree/bindings/power/power_domain.txt
> > +
> > +== Zynq MPSoC Generic PM Domain Node ==
> > +
> > +Required properties:
> > + - compatible:	Must be: "xlnx,zynqmp-power-controller"
> > +
> > +This node contains a number of subnodes, each representing a single
> > +PM domain that PM domain consumer devices reference.
> > +
> > +== PM Domain Nodes ==
> > +
> > +Required properties:
> > + - #power-domain-cells:	Number of cells in a PM domain specifier. Must
> be 0.
> > + - pd-id:		Domain identifier as defined by platform firmware.
> > +			This identifier is passed to the PM firmware.
> 
> Make this a cell for the power domain consumer.
> 

I am not clear here. Do you suggest to move pd-id property under consumer nodes? Right now, consumer nodes use power-domains property as below:

usb0: usb0 at ff9d0000 {
                        #address-cells = <2>;
	          ...................................................
                        power-domains = <&pd_usb0>;
	};

Thanks,
Jolly Shah

> > +
> >  -------
> >  Example
> >  -------
> > @@ -78,5 +101,29 @@ firmware {
> >  			clocks = <&pss_ref_clk>, <&video_clk>,
> <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
> >  			clock-names = "pss_ref_clk", "video_clk",
> "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
> >  		};
> > +		zynqmp-power-controller {
> > +			compatible = "xlnx,zynqmp-power-controller";
> > +
> > +			pd_usb0: pd-usb0 {
> > +				pd-id = <22>;
> > +				#power-domain-cells = <0>;
> > +			};
> > +
> > +			pd_sata: pd-sata {
> > +				pd-id = <28>;
> > +				#power-domain-cells = <0>;
> > +			};
> > +
> > +			pd_gpu : pd-gpu {
> > +				pd-id = <58 20 21>;
> > +				#power-domain-cells = <0>;
> > +			};
> > +		};
> >  	};
> >  };
> > +
> > +sata0: ahci at SATA_AHCI_HBA {
> 
> Don't use defines in unit-addresses (or reg for that matter). It's pointless
> indirection.
> 
> > +	...
> > +	power-domains = <&pd_sata>;
> > +	...
> > +};
> > --
> > 2.7.4
> >
