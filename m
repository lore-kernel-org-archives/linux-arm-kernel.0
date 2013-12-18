From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 19 Dec 2013 00:03:59 +0800
Subject: [PATCH v3 6/7] Documentation: add the binding file for Quadspi
 driver
In-Reply-To: <20131218153029.GF8064@book.gsilab.sittig.org>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <1387184330-14448-7-git-send-email-b32955@freescale.com>
 <20131218153029.GF8064@book.gsilab.sittig.org>
Message-ID: <20131218160355.GA1145@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 04:30:29PM +0100, Gerhard Sittig wrote:
> > +++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
> > @@ -0,0 +1,31 @@
> > +* Freescale Quad Serial Peripheral Interface(QuadSPI)
> > +
> > +Required properties:
> > +- compatible : Should be "fsl,vf610-qspi"
> > +- reg : Offset and length of the register set for the device
> > +- interrupts : Should contain the interrupt for the device
> > +- clocks : The clocks needed by the QuadSPI controller
> > +- clock-names : the name of the clocks
> > +- fsl,nor-num : Contains the number of SPI NOR chips connected to
> > +                the controller.
> > +- fsl,nor-size : the size of each SPI NOR.
> > +- fsl,max-frequency : the frequency at which the SPI NOR works.
> 
> Those "fsl,*" properties somehow feel strange.  I comment on
> details below the example since this should even better show why
> I feel so.
> 
> > +
> > +Example:
> > +
> > +qspi0: quadspi at 40044000 {
> > +	compatible = "fsl,vf610-qspi";
> > +	reg = <0x40044000 0x1000>;
> > +	interrupts = <0 24 0x04>;
> > +	clocks = <&clks VF610_CLK_QSPI0_EN>,
> > +		<&clks VF610_CLK_QSPI0>;
> > +	clock-names = "qspi_en", "qspi";
> > +	fsl,nor-num = <1>;
> > +	fsl,nor-size = <0x1000000>;
> > +	fsl,max-frequency = <66000000>;
> > +	status = "okay";
> > +
> > +	flash0: s25fl128s at 0 {
> > +		....
> > +	};
> > +};
> 
> 
> The number of chips connected to the controller should reflect in
> the child nodes of the SPI NOR controller, and need not get
> specified in redundant ways and with potential for errors when
> they can get determined at runtime.
thanks. I have already removed this property in the next version.


> 
> The capacity of the flash chip as well as the maximum frequency
> which the flash chip operates at should be features of the flash
> chip (in combination with the board), i.e. of the child node and
agree.
thanks.

> not the controller.  SPI slaves already have a documented
> property for the purpose of limiting transfer rates when they are
> lower than the controller's i.e. busses capabilities.  Can't tell
> from the top of my head whether there is a property for the
> maximum frequency which a controller should use across the whole
> bus.  In any case, either the property needs to get moved, or the
> description should get updated to say "the max frequency at which
> the controller will send data" or something.
> 
> The capacity of the flash chip should be a consequence of either
> having gathered CFI information (if available) or having
> identified the chip by its JEDEC ID and looked up its features in
> an internal database.  Users should not need to specify the
> capacity of the flash chip in the device tree.

I will remove it in the next version.

> 
> 
> If the 'fsl,nor-size' property remains (which I doubt at the
> moment), you cannot describe "the size of each" chip in one
> single-cell spec.  So the documentation should get extended to
> reflect multi-chip setups.  But I'd rather assume that the
> property is not needed at all.
> 
> You can omit the 'status = "okay"' line since that is the default
> already in the absence of the keyword.  This property is most
> useful to declare yet not enable by default components in .dtsi
> files and to do enable them in individual board files if
> applicable.  This aspect need not be shown in the binding example
> of a QSPI controller.
> 
> I'd suggest to use symbolic names for the flags in the last
> interrupt specifier cell, as you do for clock items.
I will use the symbolic name if it has.
But if it not have a symbolic name, i have to keep it as it is now.

Thanks
Huang Shijie
