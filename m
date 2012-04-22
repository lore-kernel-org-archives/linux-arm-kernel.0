From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 23 Apr 2012 00:32:58 +0800
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <20120421164713.GA3408@das-ThinkPad-X61>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <20120421164713.GA3408@das-ThinkPad-X61>
Message-ID: <20120422163255.GD26306@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 22, 2012 at 12:47:13AM +0800, Dong Aisheng wrote:
> On Thu, Apr 19, 2012 at 04:12:05PM +0800, Shawn Guo wrote:
> > Add pinctrl support for Freescale MXS SoCs, i.MX23 and i.MX28.
> > The driver supports device tree probe only.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> First, it seems i.MX23 and i.MX28 have the same situation as
> other IMX families like i.MX6Q that they're all pin based
> SoCs. Thus i think the correct thing to do now may be to
> enhance pinctrl-imx core driver to support them all rather
> than write a much similar one only for i.MX23 and i.MX28,
> right?
> 
I would think there will be SoCs from other vendors sharing the same
situation.  My view on this is to have them in and then look for the
common pattern among these drivers and come up with some generic
helper functions.

> >  .../bindings/pinctrl/fsl,mxs-pinctrl.txt           |  923 ++++++++++++++++++++
> >  drivers/pinctrl/Kconfig                            |   15 +
> >  drivers/pinctrl/Makefile                           |    3 +
> >  drivers/pinctrl/pinctrl-imx23.c                    |  304 +++++++
> >  drivers/pinctrl/pinctrl-imx28.c                    |  420 +++++++++
> >  drivers/pinctrl/pinctrl-mxs.c                      |  508 +++++++++++
> >  drivers/pinctrl/pinctrl-mxs.h                      |   91 ++
> >  7 files changed, 2264 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt
> >  create mode 100644 drivers/pinctrl/pinctrl-imx23.c
> >  create mode 100644 drivers/pinctrl/pinctrl-imx28.c
> >  create mode 100644 drivers/pinctrl/pinctrl-mxs.c
> >  create mode 100644 drivers/pinctrl/pinctrl-mxs.h
> > 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt
> > new file mode 100644
> > index 0000000..7dfd3cf
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt
> > @@ -0,0 +1,923 @@
> > +* Freescale MXS Pin Controller
> > +
> > +The pins controlled by mxs pin controller are organized in banks, each bank
> > +has 32 pins.  Each pin has 4 multiplexing functions, and generally, the 4th
> > +function is GPIO.  The configuration on the pins includes drive strength,
> > +voltage and pull-up.
> > +
> > +Required properties:
> > +- compatible: "fsl,imx23-pinctrl" or "fsl,imx28-pinctrl"
> > +- reg: Should contain the register physical address and length for the
> > +  pin controller.
> > +
> > +Please refer to pinctrl-bindings.txt in this directory for details of the
> > +common pinctrl bindings used by client devices, including the meaning of the
> > +phrase "pin configuration node".
> > +
> [...]
> 
> > +The pin configuration nodes act as a container for an arbitrary number of
> > +subnodes.  Each of these subnodes represents some desired configuration for
> Do you allow sub nodes under pin configuration node?
> I did not see it from the example.
> 
Why do we need sub nodes under pin configuration node?  To be clear,
the "pin configuration node" defined in pinctrl-bindings.txt are those
nodes under pinctrl at 80018000, like mmc0-4bit, mmc0-cd-cfg.

> > +a group of pins, and only affects those parameters that are explicitly listed.
> > +In other words, a subnode that describes a drive strength parameter implies no
> > +information pull-up. For this reason, even seemingly boolean values are
> > +actually tristates in this binding: unspecified, off, or on. Unspecified is
> > +represented as an absent property, and off/on are represented as integer
> > +values 0 and 1.
> > +
> > +Those subnodes will fall into two categories.  One is to set up a group of
> > +pins for a function, both mux selection and pin configurations.  For the same
> > +function, all pin group nodes should use the same node name and be sorted
> > +together in "reg" value.  And the other one is the pure pin configuration
> > +node, which are used to configure some pins that need a different drive
> > +strength, voltage or pull-up configurations from what specified in the pin
> > +group node.
> > +
> That's indeed a limitation and raised by Sascha in my first pinctrl binding
> that you need create a pure pin config node to reconfigure pins which needs
> different setting in the same group.

I would not think it's a limitation but a design standing for hardware
reality.  Generally, when we have a group pins functional for
a particular function, most of the pins in the group share the same pin
configuration requirement, and only few individual pin needs a different
configuration.  For example, I have 10 pins for function mmc0-8bit,
among of which 8 data pins + cmd pin require the same configuration,
while only clk pin requires a different one.  Another better example,
all 28 pins for function lcdif-24bit share the same one configuration.
What's point to repeat the configuration data for all these 28 pins?

> After received some other people's suggestion, finally i remove this limitation
> and allow each pin to set its pad config value in the same group.
> See my pinctrl imx v2 driver patch and provide comment if you have different
> option.

It works for you, because you have pin configuration data bond to the
raw register value for each pin, since on imx there is a dedicated
configuration register for each pin.  The mxs pinctrl controller is
different from imx.  It has configuration data of multiple pins packed
in one register.  I cannot really use the raw register approach but
need to have multiple properties to represent the pin configuration.

> Basically i think we should try to get one unified binding method for all FSL
> SoC families rather than find two if no big differences.
> 
Though the SoCs in mxs family are called i.MX23 and i.MX28, they are
different architecture from imx.  The pin controllers are completely
different ones.

> > +Required subnode-properties:
> > +- fsl,pinmux-ids: An integer array.  Each integer in the array specify a pin
> > +  with given mux function, with bank, pin and mux packed as below.
> > +
> > +    [15..12] : bank number
> > +    [11..4]  : pin number
> > +    [3..0]   : mux selection
> > +
> Can you use a simple id here and hide these information in driver?

I do not think I want to do that.  All these information are natural
hardware data, and there is no harm for binding reader to know how
these hardware information are being encoded in pinmux-id.

> Like:
> MX28_PAD_GPMI_D00__GPMI_D0	0
> MX28_PAD_GPMI_D01__GPMI_D1	1
> MX28_PAD_GPMI_D02__GPMI_D2	2
> MX28_PAD_GPMI_D03__GPMI_D3	3
> MX28_PAD_GPMI_D04__GPMI_D4	4
> ...
> I did it for pinctrl imx.
> 
I do not want my pinctrl-mxs driver as big as pinctrl-imx in terms of
lines of code.

> > +  For the pure pin configuration nodes, the mux selection packed in the
> > +  integer takes no effect, which means the mux selection of the pins that
> > +  need separate configuration will also have to be set up by group node.
> > +  In other word, the pin group node should include all the pins for given
> > +  function, regardless of whether separate pin configuration nodes are needed
> > +  to configure some pins differently or not.
> > +
> Then we did some duplicated things.
> 
It requires the pin group node list all the pins for particular function
for some reason.  For pin-only type of controller, there is no hardware
pingroup.  When we define a pin group (virtual pingroup in Stephen's
term) for a particular function, the group should really include all
the pins required by the function.  This conforms to the "pingroup"
concept of pinctrl system, it could require multiple hardware pingroups
compose all the pins that particular function needs, but should really
require one virtual pingroup do that.

> > +  Valid values for these integers are listed below.
> > +
> > +- reg: Should be the index of the pin group nodes for same function.  This
> > +  property is required only for pin group nodes, and should not be present
> > +  in any pure pin configuration nodes.
> > +
> > +Optional subnode-properties:
> > +- fsl,drive-strength: Integer.
> > +    0: 4 mA
> > +    1: 8 mA
> > +    2: 12 mA
> > +    3: 16 mA
> > +- fsl,voltage: Integer.
> > +    0: 1.8 V
> > +    1: 3.3 V
> > +- fsl,pull-up: Integer.
> > +    0: Disable the internal pull-up
> > +    1: Enable the internal pull-up
> > +
> You already use raw data for mux, i really don't think it helps too much
> to not for config.
> 
Besides the fact that one register packs pin configuration data for
multiple pins, the reason for such binding is users will be able
to touch the data without looking at hardware manual. 

> > +Examples:
> > +
> > +pinctrl at 80018000 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	compatible = "fsl,imx28-pinctrl";
> > +	reg = <0x80018000 2000>;
> > +
> > +	mmc0_4bit_pins_a: mmc0-4bit at 0 {
> "mmc0-4bit" is more likely be a group,
> but you use it as function name, right?
> 
Yes, mmc0-4bit is used as function name.  As there will be multiple
(virtual) pingroup could functional as mmc0-4bit, those groups will
be named as the combination of function name and "reg" value, like
mmc0-4bit.0, mmc0-4bit.1

-- 
Regards,
Shawn
