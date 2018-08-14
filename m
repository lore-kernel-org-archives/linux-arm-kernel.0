From: robh@kernel.org (Rob Herring)
Date: Tue, 14 Aug 2018 16:42:52 -0600
Subject: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
In-Reply-To: <20180814164343.GA13848@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
 <20180813181808.GA2357@ravnborg.org>
 <20180813220454.GA28913@rob-hp-laptop>
 <20180814164343.GA13848@ravnborg.org>
Message-ID: <20180814224252.GA20667@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 14, 2018 at 06:43:43PM +0200, Sam Ravnborg wrote:
> Hi Rob.
> 
> > I don't know that 2 registers for a backlight PWM constitute an MFD. A 
> > single node can be both an LCD controller and a PWM.
> 
> Current suggestion from v1 patchset looks like this:
> 	lcdc0: lcdc at 700000 {
> 		compatible = "atmel,at91sam9263-lcdc-mfd";
> 		reg = <0x700000 0x1000>;
> 		interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
> 		clocks = <&lcd_clk>, <&lcd_clk>;
> 		clock-names = "lcdc_clk", "hclk";
> 
> 		lcdc-display-controller {
> 			compatible = "atmel,lcdc-display-controller";
> 			lcd-supply = <&lcdc_reg>;
> 
> 			port at 0 {
> 			};
> 		};
> 
> 		lcdc_pwm: lcdc-pwm {
> 			compatible = "atmel,lcdc-pwm";
> 			#pwm-cells = <3>;
> 		};
> 
> 	};
> 
>         backlight: backlight {
>                 compatible = "pwm-backlight";
>                 pwms = <&lcdc_pwm 0 50000 0>;
>         };
> 
> 
> We could have described the full binding in one file, rather than in
> three files like it is done in v1. But the structure was done so it matched
> what was done for hlcdc.
> 
> 
> If I understand the proposal from you correct an example binding would
> look like this:
> 
>        lcdc0: lcdc at 700000 {
>                 compatible = "atmel,at91sam9263-lcdc";
>                 reg = <0x700000 0x1000>;
>                 interrupts = <26 IRQ_TYPE_LEVEL_HIGH 3>;
>                 clocks = <&lcd_clk>, <&lcd_clk>;
>                 clock-names = "lcdc_clk", "hclk";
> 
>                 lcd-supply = <&lcdc_reg>;
> 
>                 port at 0 {
>                 };
> 
>                 #pwm-cells = <3>;
>         };
> 
>         backlight: backlight {
>                 compatible = "pwm-backlight";
>                 pwms = <&lcd0 0 50000 0>;
>         };
> 
> 
> This is doable, but IMO it is less obvious that the LCDC IP core implements
> two different features - a PWM and a LCD controller.

Features don't equate to nodes. If the sub-blocks can be separately 
instantiated or have their own resources then sub-nodes make sense. 
Otherwise, it's a single device (node) with multiple providers.

> Right now the preference is to stay with the v1 approach:
> - It is a mirror of what we do today for hlcdc, so no suprises

Which BTW doesn't appear to have actually been reviewed.

Do these IP blocks actually share anything? 

Consistency is nice, but keeping compatibility with the existing binding 
by extending things in a backwards compatible way is more important. 
Implementing a new driver is not license to change the binding. Shall I 
let u-boot or *BSD developers change the binding too for their driver?

> - It shows in a nice way that the LCDC IP core implments both an LCD controller and a PWM
> - The pwm functionality is not hiddin inside the lcdc stuff, and it is thus
>   simpler to add good pin-ctrl handles with nice names that matches the usage.
>   (I could always add more pin-ctrl, but it is common to refer to a single pin-ctrl.

Does anyone actually use this for a non-backlight PWM? I'm not sure the 
abstraction is worth it. The driver could just register itself as a 
backlight provider rather than a PWM provider.

> One DT related Q:
> The LCD Controller supports BGR565, but as this is less common some HW implmentations
> exchange R and B, expessed in the old binding as wiring-mode like this:
> 
> 	atmel,lcd-wiring-mode: lcd wiring mode "RGB" or "BRG"
> 
> How can we express this wiring-mode in a generic way, both in DT and in code?
> Is it something that in DRM belongs to the panel, the encoder, the connector, or?
> And can any of the exisitng flags be used?

I thought we had come up with a common definition, but I guess it didn't 
make it upstream. It's definitely needed and I've been rejecting 
anything new that's vendor specific.

Rob
