From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 4 Feb 2016 12:11:07 +0100
Subject: [PATCH v4 2/2] drm: sunxi: Add a basic DRM driver for Allwinner
 DE2
In-Reply-To: <20160202215036.GA25521@rob-hp-laptop>
References: <cover.1454435944.git.moinejf@free.fr>
 <76ae5b406ad64b2717c0b1c62c3005a62b2715b8.1454435944.git.moinejf@free.fr>
 <20160202215036.GA25521@rob-hp-laptop>
Message-ID: <20160204121107.2fa6d12c161ce37a3901f118@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Feb 2016 15:50:36 -0600
Rob Herring <robh@kernel.org> wrote:

> > diff --git a/Documentation/devicetree/bindings/display/sunxi.txt b/Documentation/devicetree/bindings/display/sunxi.txt
> > new file mode 100644
> > index 0000000..35f9763
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/sunxi.txt
> > @@ -0,0 +1,81 @@
> > +Allwinner sunxi display subsystem
> > +=================================
> > +
> > +The sunxi display subsystems contain a display controller (DE),
> > +one or two LCD controllers (TCON) and their external interfaces.
> > +
> > +Display controller
> > +==================
> > +
> > +Required properties:
> > +
> > +- compatible: value should be one of the following
> > +		"allwinner,sun8i-h3-display-engine"
> > +
> > +- clocks: must include clock specifiers corresponding to entries in the
> > +		clock-names property.
> > +
> > +- clock-names: must contain
> > +		gate: for DE activation
> > +		clock: DE clock
> > +
> > +- resets: phandle to the reset of the device
> > +
> > +- ports: phandle's to the LCD ports
> > +
> > +LCD controller
> > +==============
> > +
> > +Required properties:
> > +
> > +- compatible: value should be one of the following
> > +		"allwinner,sun8i-h3-lcd"
> > +
> > +- clocks: must include clock specifiers corresponding to entries in the
> > +		clock-names property.
> > +
> > +- clock-names: must contain
> > +		gate: for LCD activation
> > +		clock: pixel clock
> > +
> > +- resets: phandle to the reset of the device
> > +
> > +- port: port node with endpoint definitions as defined in
> > +	Documentation/devicetree/bindings/media/video-interfaces.txt
> 
> Define how many ports and endpoints.

As told in some other mail, such a video binding should be generic.
The number of ports depends on the hardware. Most SoCs have only one
port per LCD, but some other have many ports as the A83T (3 ports from
the LCD0).

> > +
> > +Example:
> > +
> > +	de: de-controller at 01000000 {
> > +		compatible = "allwinner,sun8i-h3-display-engine";
> > +		...
> > +		clocks = <&bus_gates 44>, <&de_clk>;
> > +		clock-names = "gate", "clock";
> > +		resets = <&ahb_rst 44>;
> > +		ports = <&lcd0_p>;
> 
> This is pointless if you only have one item in ports. Is this really a 
> separate h/w block? Can't you move all this into the node below?

Well, this example is extracted from the H3 where the DE and LCDs have
different clocks, I/O resources and functions (the DE builds the video
frames while the LCDs - TCONs - convert them to video flows).

The example is not complete because there are 2 LCDs in the H3:
		ports = <&lcd0_p>,		/* HDMI */
			<&lcd1_p>;		/* TV (CVBS) */
But, for SoCs with only one LCD, the description would be the same.

> > +	};
> > +
> > +	lcd0: lcd-controller at 01c0c000 {
> > +		compatible = "allwinner,sun8i-h3-lcd";
> > +		...
> > +		clocks = <&bus_gates 35>, <&tcon0_clk>;
> > +		clock-names = "gate", "clock";
> > +		resets = <&ahb_rst 35>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		lcd0_p: port {
> > +			lcd0_ep: endpoint {
> > +				remote-endpoint = <&hdmi_ep>;
> > +			};
> > +		};
> > +	};


-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
