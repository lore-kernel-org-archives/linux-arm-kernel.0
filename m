From: sam@ravnborg.org (Sam Ravnborg)
Date: Fri, 24 Aug 2018 17:58:24 +0200
Subject: [PATCH v1 2/7] dt-binding: add bindings for Atmel LCDC mfd
In-Reply-To: <20180824104517.29f24f44@bbrezillon>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-2-sam@ravnborg.org>
 <20180824104517.29f24f44@bbrezillon>
Message-ID: <20180824155824.GC26678@ravnborg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris.

> > +The LCDC IP exposes two subdevices:
> > + - a PWM chip: see ../pwm/atmel-lcdc-pwm.txt
> > + - a Display Controller: see ../display/atmel/lcdc-display-controller.txt
> > +
> > +Example:
> > +	lcdc0: lcdc at 700000 {
> > +		compatible = "atmel,at91sam9263-lcdc-mfd";
> > +		reg = <0x700000 0x1000>;
> > +		interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
> > +		clocks = <&lcd_clk>, <&lcd_clk>;
> > +		clock-names = "lcdc_clk", "hclk";
> > +
> > +		lcdc-display-controller {
> > +			compatible = "atmel,lcdc-display-controller";
> > +			lcd-supply = <&lcdc_reg>;
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> > +
> > +			port at 0 {
> > +				reg = <0>;
> > +				#address-cells = <1>;
> > +				#size-cells = <0>;
> > +				lcdc_panel_output: endpoint at 0 {
> > +					reg = <0>;
> > +					remote-endpoint = <&panel_input>;
> > +				};
> > +			};
> > +		};
> > +
> > +		lcdc_pwm: lcdc-pwm {
> > +			compatible = "atmel,lcdc-pwm";
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&pinctrl_lcdc_pwm>;
> > +			#pwm-cells = <3>;
> > +		};
> > +
> > +	};
> 
> Also, I don't remember why I decided to declare distinct nodes for the
> PWM and display controller, but you should probably try to only declare
> the lcdc node. Something like that:
> 
> 	lcdc0: lcdc at 700000 {
> 		compatible = "atmel,at91sam9263-lcdc";
> 		reg = <0x700000 0x1000>;
> 		interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
> 		clocks = <&lcd_clk>, <&lcd_clk>;
> 		clock-names = "lcdc_clk", "hclk";
> 		pinctrl-names = "default";
> 		pinctrl-0 = <&pinctrl_lcdc_pwm ...>;
> 		#pwm-cells = <3>;
> 		#address-cells = <1>;
> 		#size-cells = <0>;
> 
> 		port at 0 {
> 			reg = <0>;
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			lcdc_panel_output: endpoint at 0 {
> 				reg = <0>;
> 				remote-endpoint = <&panel_input>;
> 			};
> 		};
> 	};
> 
> Note that this representation does not prevent us from having an MFD
> which declares the PWM and Display Engine, it's just that all devs will
> point to the same of_node.

I have something similar in my tree now, just need to figure out the mfd parts.

> 
> > +
> > +		lcdc-display-controller {
> > +			compatible = "atmel,lcdc-display-controller";
> > +			lcd-supply = <&lcdc_reg>;
> 
> Hm, is this a regulator for the LCD controller or the LCD? If it's for
> the LCD it should be placed under the panel node.
It was added only because I could do it and I was (and continue to be) a
DT newbie.  Will drop it in v2 as this is just an example which this part do
not add any value to.

> > +	panel: panel {
> > +		compatible = "logictechnologies,lttd800480070-l2rt", "simple-panel";
Reminds me that I need to dig out a panel-simple patch for a few
displays I use (logic + seiko).
But they are otherwise not related to this work.

	Sam
