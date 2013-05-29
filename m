From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 29 May 2013 10:01:05 +0200
Subject: [PATCH v4 02/21] sh-pfc: Add DT support
In-Reply-To: <CACRpkdZNv5AO48Bmquyr8mBQvgjBMCk3Ob8ngutSq8RV1HFT0w@mail.gmail.com>
References: <1369138482-5871-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1369138482-5871-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <CACRpkdZNv5AO48Bmquyr8mBQvgjBMCk3Ob8ngutSq8RV1HFT0w@mail.gmail.com>
Message-ID: <1544149.k900vg9Sxe@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Thanks for the review.

On Friday 24 May 2013 10:52:42 Linus Walleij wrote:
> On Tue, May 21, 2013 at 2:14 PM, Laurent Pinchart wrote:
> > Support device instantiation through the device tree. The compatible
> > property is used to select the SoC pinmux information.
> > 
> > Set the gpio_chip device field to the PFC device to enable automatic
> > GPIO OF support.
> > 
> > Cc: devicetree-discuss at lists.ozlabs.org
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> (...)
> 
> (Again I'm rather nervous about all the device tree binding reviewing being
> dropped in the lap of Linux subsystem maintainers and then expecting them
> to be good and OS-neutral... Not your fault though.)

I agree with you. I'm open to review from other OS vendors :-)

> > +Pin Configuration Node Properties:
> > +
> > +- renesas,pins : An array of strings, each string containing the name of
> > +  a pin.
> > +- renesas,groups : An array of strings, each string containing the name
> > +  of a pin group.
> > +
> > +- renesas,function: A string containing the name of the function to mux
> > +  to the pin group(s) specified by the renesas,groups property
> > +
> > +  Valid values for pin, group and function names can be found in the
> > +  group and function arrays of the PFC data file corresponding to the
> > +  SoC (drivers/pinctrl/sh-pfc/pfc-*.c)
> > +
> > +- renesas,pull-up: An integer representing the pull-up strength to be
> > +  applied to all pins specified by the renesas,pins and renesas-groups
> > +  properties. 0 disables the pull-up, 1 enables it. Other values should
> > + not be used.
>
> Then just use a boolean.

I meant that other values should not be used for now. Future revisions of the 
GPIO core might allow controlling the pull-up strength, hence the integer 
property. Same for the pull-down property. This is especially true if we 
device to implement generic pinconf bindings.

> > +- renesas,pull-down: An integer representing the pull-down strength to be
> > +  applied to all pins specified by the renesas,pins and renesas-groups
> > +  properties. 0 disables the pull-down, 1 enables it. Other values should
> > +  not be used.
> 
> Just use a boolean oneliner then.
> 
> But I prefer that you define something really generic in
> Documentation/devicetree/bindings/pinconf.txt for anyone using
> generic pin config, then reference that.
> 
> This way we can have a more general config binding for any system
> using generic pin config, mapping to the configs we have in
> <linux/pinctrl/pinconf-generic.h>
> 
> The upside is that we could move the pinconf generic parsing code
> to drivers/pinctrl/pinconf-generic.c and thus avoid code duplication.
> 
> We have so far not tried much to standardize pinctrl bindings, but
> this would be a good opportunity.

I agree. I'll reply to the "[PATCH v2 6/9] pinctrl-tz1090: add TZ1090 pinctrl 
driver" mail thread to further discuss the pinconf generic bindings.

> > +On SH7372, SH73A0, R8A73A4 and R8A7740 the PFC node is also a GPIO
> > +controller node.
> > +
> > +Required Properties:
> > +
> > +  - gpio-controller: Marks the device node as a gpio controller.
> > +
> > +  - #gpio-cells: Should be 2. The first cell is the pin number and the
> > +    second cell is used to specify optional parameters as bit flags.
> > +    Only the GPIO active low flag (bit 0) is currently supported.
> 
> I suggest these properties shall be defined in an include file using that
> new include hierarchy, since you're using pinconf generic.
> 
> include/dt-bindings/gpio/gpio.h
> Referenced by <dt-bindings/gpio/gpio.h> in the .dts[i] files.

Agreed, I'll fix that.

> In Linux-next you find how tegra machines and the imx6sl DTs have
> started to use this facility for symbolic names.
> 
> And for that you should reference
> <dt-bindings/gpio/gpio.h>
> 
> Use the symbolic names GPIO_ACTIVE_HIGH and GPIO_ACTIVE_LOW
> here.
> 
> (...)
> 
> > +Example 2: A GPIO LED node that references a GPIO
> > +
> > +       leds {
> > +               compatible = "gpio-leds";
> > +               led1 {
> > +                       gpios = <&pfc 20 1>; /* Active low */
> 
> #include <dt-bindings/gpio/gpio.h>
> gpios = <&pfc 20 GPIO_ACTIVE_LOW>;
> 
> (...)
> 
> > +Example 3: KZM-A9-GT (SH-Mobile AG5) default pin state hog and pin
> > control maps +           for the MMCIF and SCIFA4 devices
> > +
> > +       &pfc {
> > +               pinctrl-0 = <&scifa4_pins>;
> > +               pinctrl-names = "default";
> > +
> > +               mmcif_pins: mmcif {
> > +                       mux {
> > +                               renesas,groups = "mmc0_data8_0",
> > "mmc0_ctrl_0"; +                               renesas,function = "mmc0";
> > +                       };
> > +                       cfg {
> > +                               renesas,groups = "mmc0_data8_0";
> > +                               renesas,pins = "PORT279";
> > +                               renesas,pull-up = <1>;
> 
> Just
> renesas,pull-up;
> 
> Or go for the generic pinconf binding I'm suggesting.
> Then I guess it'd be something like:
> 
> pinconf-bias-pull-up;
> 
> (Quite readable.)
> 
> (...)
> 
> > +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> > +static const struct sh_pfc_config_param sh_pfc_config_params[] = {
> > +       { "renesas,pull-up", PIN_CONFIG_BIAS_PULL_UP },
> > +       { "renesas,pull-down", PIN_CONFIG_BIAS_PULL_DOWN },
> > +};
> 
> So these should be checked as booleans instead:
>
> > +       for (i = 0; i < ARRAY_SIZE(sh_pfc_config_params); ++i) {
> > +               const struct sh_pfc_config_param *param =
> > +                       &sh_pfc_config_params[i];
> > +               unsigned long config;
> > +               u32 val;
> > +
> > +               ret = of_property_read_u32(np, param->name, &val);
> 
> of_property_read_bool()
> 
> Though I much rather like this code added as helper lib in pinconf-
> generic.c. Use drivers/pinctrl/pinconf.h for API.

-- 
Regards,

Laurent Pinchart
