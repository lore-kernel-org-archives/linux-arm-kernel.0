From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Tue, 29 Nov 2016 20:45:50 +0200
Subject: [PATCH v7 2/8] drm/sun8i: Add DT bindings documentation of
 Allwinner DE2
In-Reply-To: <36111311.d8ul9hQ2CU@avalon>
References: <cover.1480414715.git.moinejf@free.fr>
 <92fc53084274d5ab04fe28f2dc0b16cf5d94481e.1480414715.git.moinejf@free.fr>
 <36111311.d8ul9hQ2CU@avalon>
Message-ID: <3838250.G6PfJ7RzAX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Fran?ois,

A brief update.

On Tuesday 29 Nov 2016 20:41:30 Laurent Pinchart wrote:
> On Monday 28 Nov 2016 19:02:39 Jean-Francois Moine wrote:
> > Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
> > ---
> > 
> >  .../bindings/display/sunxi/sun8i-de2.txt           | 121 ++++++++++++++++
> >  1 file changed, 121 insertions(+)
> >  create mode 100644
> > 
> > Documentation/devicetree/bindings/display/sunxi/sun8i-de2.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun8i-de2.txt
> > b/Documentation/devicetree/bindings/display/sunxi/sun8i-de2.txt new file
> > mode 100644
> > index 0000000..edf38b8
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun8i-de2.txt
> > @@ -0,0 +1,121 @@
> > +Allwinner sun8i Display Engine 2 subsystem
> > +==========================================
> > +
> > +The Allwinner DE2 subsystem contains a display controller (DE2),
> > +one or two LCD controllers (Timing CONtrollers) and their external
> > +interfaces (encoders/connectors).
> > +
> > +          +-----------+
> > +          | DE2       |
> > +          |           |
> > +          | +-------+ |
> > +  plane --->|       | |   +------+
> > +          | | mixer |---->| TCON |---> encoder  ---> display
> > +  plane --->|       | |   +------+     connector     device
> > +          | +-------+ |
> > +          |           |
> > +          | +-------+ |
> > +  plane --->|       | |   +------+
> > +          | | mixer |---->| TCON |---> encoder  ---> display
> > +  plane --->|       | |   +------+     connector     device
> > +          | +-------+ |
> > +          +-----------+
> > +
> > +The DE2 contains a processor which mixes the input planes and creates
> > +the images which are sent to the TCONs.
> > +From the software point of vue, there are 2 independent real-time
> > +mixers, each one being statically associated to one TCON.
> > +
> > +The TCONs adjust the image format to the one of the display device.
> > +
> > +Display controller (DE2)
> > +========================
> > +
> > +Required properties:
> > +
> > +- compatible: value should be one of the following
> > +		"allwinner,sun8i-a83t-display-engine"
> > +		"allwinner,sun8i-h3-display-engine"
> > +
> > +- reg: base address and size of the I/O memory
> > +
> > +- clocks: must include clock specifiers corresponding to entries in the
> > +		clock-names property.
> > +
> > +- clock-names: must contain
> > +		"bus": bus gate
> > +		"clock": clock
> > +
> > +- resets: phandle to the reset of the device
> > +
> > +- ports: must contain a list of 2 phandles, indexed by mixer number,
> > +	and pointing to display interface ports of TCONs
> > +
> > +LCD controller (TCON)
> > +=====================
> > +
> > +Required properties:
> > +
> > +- compatible: should be
> > +		"allwinner,sun8i-a83t-tcon"
> > +
> > +- reg: base address and size of the I/O memory
> > +
> > +- clocks: must include clock specifiers corresponding to entries in the
> > +		clock-names property.
> > +
> > +- clock-names: must contain
> > +		"bus": bus gate
> > +		"clock": pixel clock
> > +
> > +- resets: phandle to the reset of the device
> > +
> > +- interrupts: interrupt number for the TCON
> > +
> > +- port: port node with endpoint definitions as defined in
> > +	Documentation/devicetree/bindings/media/video-interfaces.txt
> > +
> > +Example:
> > +
> > +	de: de-controller at 01000000 {
> > +		compatible = "allwinner,sun8i-h3-display-engine";
> > +		reg = <0x01000000 0x400000>;
> > +		clocks = <&ccu CLK_BUS_DE>, <&ccu CLK_DE>;
> > +		clock-names = "bus", "clock";
> > +		resets = <&ccu RST_BUS_DE>;
> > +		ports = <&tcon0_p>, <&tcon1_p>;
> 
> This isn't how the OF graph DT bindings are used. You should instead have
> 
> 	ports {
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 		port at 0 {

I forgot to add reg = <0>; (and similarly for port 1).

> 			de_out_0: endpoint {
> 				remote_endpoint = <&tcon0_hdmi>;
> 			};
> 		};
> 		port at 1 {
> 			/* No endpoint as the port is not connected */
> 		};
> 	};
> 
> > +	};
> > +
> > +	tcon0: lcd-controller at 01c0c000 {
> > +		compatible = "allwinner,sun8i-a83t-tcon";
> > +		reg = <0x01c0c000 0x400>;
> > +		clocks = <&ccu CLK_BUS_TCON0>, <&ccu CLK_TCON0>;
> > +		clock-names = "bus", "clock";
> > +		resets = <&ccu RST_BUS_TCON0>;
> > +		interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		tcon0_p: port {
> > +			tcon0_hdmi: endpoint {
> > +				remote-endpoint = <&hdmi_tcon0>;
> > +			};
> > +		};
> 
> and here
> 
> 	port {
> 		tcon0_hdmi: endpoint {
> 			remote-endpoint = <&de_out_0>;
> 		};
> 	};

The TCON has an output, so this should instead be

	port at 0 {
		reg = <0>;
 		tcon0_in: endpoint {
 			remote-endpoint = <&de_out_0>;
 		};
	};
	port at 1 {
		reg = <1>;
 		tcon1_out: endpoint {
 			remote-endpoint = <&hdmi_in>;
 		};
	};

(the second port requires adding the HDMI encoder to the example)

> > +	};
> > +
> > +	/* not used */
> > +	tcon1: lcd-controller at 01c0d000 {
> > +		compatible = "allwinner,sun8i-h3-tcon";
> > +		reg = <0x01c0d000 0x400>;
> > +		clocks = <&ccu CLK_BUS_TCON1>,
> > +			 <&ccu CLK_TCON0>;	/* no clock */
> > +		clock-names = "bus", "clock";
> > +		interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
> > +		status = "disabled";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		tcon1_p: port {
> > +			endpoint {
> > +				/* empty */
> > +			};
> > +		};
> 
> and here
> 
> 	port {
> 		/* No endpoint as the port is not connected */
> 	};
> 
> (although I'm not sure why you don't connect it)
> 
> > +	};

-- 
Regards,

Laurent Pinchart
