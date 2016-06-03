From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Fri, 3 Jun 2016 13:10:09 +0200
Subject: [PATCH v3 2/2] [media] atmel-isc: DT binding for Image Sensor
 Controller driver
In-Reply-To: <20160602231609.GA24529@rob-hp-laptop>
References: <1464677903-28412-1-git-send-email-songjun.wu@atmel.com>
 <1464677903-28412-3-git-send-email-songjun.wu@atmel.com>
 <20160602231609.GA24529@rob-hp-laptop>
Message-ID: <20160603131009.456dc101@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Jun 2016 18:16:09 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, May 31, 2016 at 02:58:23PM +0800, Songjun Wu wrote:
> > DT binding documentation for ISC driver.
> > 
> > Signed-off-by: Songjun Wu <songjun.wu@atmel.com>
> > ---
> > 
> > Changes in v3:
> > - Remove the 'atmel,sensor-preferred'.
> > - Modify the isc clock node according to the Rob's remarks.
> > 
> > Changes in v2:
> > - Remove the unit address of the endpoint.
> > - Add the unit address to the clock node.
> > - Avoid using underscores in node names.
> > - Drop the "0x" in the unit address of the i2c node.
> > - Modify the description of 'atmel,sensor-preferred'.
> > - Add the description for the ISC internal clock.
> > 
> >  .../devicetree/bindings/media/atmel-isc.txt        | 88 ++++++++++++++++++++++
> >  1 file changed, 88 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/atmel-isc.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/media/atmel-isc.txt b/Documentation/devicetree/bindings/media/atmel-isc.txt
> > new file mode 100644
> > index 0000000..2ae1d60
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/atmel-isc.txt
> > @@ -0,0 +1,88 @@
> > +Atmel Image Sensor Controller (ISC)
> > +----------------------------------------------
> > +
> > +Required properties for ISC:
> > +- compatible
> > +	Must be "atmel,sama5d2-isc"
> > +- reg
> > +	Physical base address and length of the registers set for the device;
> > +- interrupts
> > +	Should contain IRQ line for the ISI;
> > +- clocks
> > +	List of clock specifiers, corresponding to entries in
> > +	the clock-names property;
> > +	Please refer to clock-bindings.txt.
> > +- clock-names
> > +	Required elements: "hclock", "ispck".
> > +- pinctrl-names, pinctrl-0
> > +	Please refer to pinctrl-bindings.txt.
> > +- isc-ispck
> > +	The clock for the ISC digital pipeline.
> > +	- compatible
> > +		Must be "atmel,sama5d2-isc-ispck".
> > +	- clock-cells
> > +		From common clock binding; should be set to 0.
> > +	- clocks
> > +		The clock source phandles.
> > +- isc-mck
> > +	The clock for the image sensor.
> > +	- compatible
> > +		Must be "atmel,sama5d2-isc-mck".
> > +	- clock-cells
> > +		From common clock binding; should be set to 0.
> > +	- clocks
> > +		The clock source phandles.
> > +
> > +ISC supports a single port node with parallel bus. It should contain one
> > +'port' child node with child 'endpoint' node. Please refer to the bindings
> > +defined in Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +
> > +Example:
> > +isc: isc at f0008000 {
> > +	compatible = "atmel,sama5d2-isc";
> > +	reg = <0xf0008000 0x4000>;
> > +	interrupts = <46 IRQ_TYPE_LEVEL_HIGH 5>;
> > +	clocks = <&isc_clk>, <&isc_ispck>;
> > +	clock-names = "hclock", "ispck";
> > +
> > +	port {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		isc_0: endpoint {
> > +			remote-endpoint = <&ov7740_0>;
> > +			hsync-active = <1>;
> > +			vsync-active = <0>;
> > +			pclk-sample = <1>;
> > +		};
> > +	};
> > +
> > +	isc_ispck: isc-ispck at 0 {  
> 
> Drop the unit-address. You should only have one if you have a reg 
> property.
> 
> > +		compatible = "atmel,sama5d2-isc-ispck";
> > +		#clock-cells = <0>;
> > +		clocks = <&isc_clk>, <&iscck>;
> > +	};
> > +
> > +	isc_mck: isc-mck at 1 {  
> 
> ditto.
> 
> I still think these should be implied by atmel,sama5d2-isc and not in 
> DT. The fact that you don't have any registers for them pretty much 
> indicates that. It is also strange that isc-ispck is used by isc. If 
> that is the only user, there is certainly no need to put it in DT.

I had a look at the block diagram, and it seems you are partially right.
The only clock that is really exported by the ISC is isc_mck (isc_pck is
not).
So I'd suggest dropping these clk sub-nodes, putting the #clock-cells,
and clock-names properties in the isc node, and then referencing the
isc node in you i2c device.

isc: isc at f0008000 {
	compatible = "atmel,sama5d2-isc";
	reg = <0xf0008000 0x4000>;
	interrupts = <46 IRQ_TYPE_LEVEL_HIGH 5>;
	clocks = <&isc_clk>, <&isc_ispck>;
	clock-names = "hclock", "ispck";
	#clock-cells = <0>;
	clock-output-names = "isc-mck";
};

i2c1: i2c at fc028000 {
	/* ... */
	ov7740: camera at 21 {
		/* ... */
		clocks = <&isc>;
		clock-names = "xvclk";
	}
};

If I'm wrong and the ISC IP is really exposing several clks, you just
have to change #clock-cells to 1, and use clocks = <&isc X>; in the i2c
device node.

Rob, Songjun, would you agree on this representation?

> 
> 
> > +		compatible = "atmel,sama5d2-isc-mck";
> > +		#clock-cells = <0>;
> > +		clocks = <&isc_clk>, <&iscck>, <&isc_gclk>;
> > +	};
> > +};
> > +
> > +i2c1: i2c at fc028000 {
> > +	ov7740: camera at 21 {
> > +	compatible = "ovti,ov7740";
> > +	reg = <0x21>;
> > +
> > +	clocks = <&isc_mck>;
> > +	clock-names = "xvclk";
> > +	assigned-clocks = <&isc_mck>;
> > +	assigned-clock-rates = <24000000>;
> > +
> > +	port {
> > +		ov7740_0: endpoint {
> > +			remote-endpoint = <&isc_0>;
> > +		};
> > +	};
> > +};
> > -- 
> > 2.7.4
> >   
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
