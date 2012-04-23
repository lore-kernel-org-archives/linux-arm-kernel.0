From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Mon, 23 Apr 2012 15:47:03 +0800
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <20120422163255.GD26306@S2101-09.ap.freescale.net>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <20120421164713.GA3408@das-ThinkPad-X61>
 <20120422163255.GD26306@S2101-09.ap.freescale.net>
Message-ID: <20120423074702.GD24843@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 12:32:58AM +0800, Shawn Guo wrote:
> On Sun, Apr 22, 2012 at 12:47:13AM +0800, Dong Aisheng wrote:
> > On Thu, Apr 19, 2012 at 04:12:05PM +0800, Shawn Guo wrote:
> > > Add pinctrl support for Freescale MXS SoCs, i.MX23 and i.MX28.
> > > The driver supports device tree probe only.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > First, it seems i.MX23 and i.MX28 have the same situation as
> > other IMX families like i.MX6Q that they're all pin based
> > SoCs. Thus i think the correct thing to do now may be to
> > enhance pinctrl-imx core driver to support them all rather
> > than write a much similar one only for i.MX23 and i.MX28,
> > right?
> > 
> I would think there will be SoCs from other vendors sharing the same
> situation.  My view on this is to have them in and then look for the
> common pattern among these drivers and come up with some generic
> helper functions.
> 
We may get align with all FSL families first.
At least the binding part could be the same.
The most difference between MXS and IMX is different register layout.
For example, pinconf_set/get may be different.
One rough idea in my mind is that one callback in pinctrl-imx may
handle it.

> > >  .../bindings/pinctrl/fsl,mxs-pinctrl.txt           |  923 ++++++++++++++++++++
> > >  drivers/pinctrl/Kconfig                            |   15 +
> > >  drivers/pinctrl/Makefile                           |    3 +
> > >  drivers/pinctrl/pinctrl-imx23.c                    |  304 +++++++
> > >  drivers/pinctrl/pinctrl-imx28.c                    |  420 +++++++++
> > >  drivers/pinctrl/pinctrl-mxs.c                      |  508 +++++++++++
> > >  drivers/pinctrl/pinctrl-mxs.h                      |   91 ++
> > >  7 files changed, 2264 insertions(+), 0 deletions(-)
> > >  create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt
> > >  create mode 100644 drivers/pinctrl/pinctrl-imx23.c
> > >  create mode 100644 drivers/pinctrl/pinctrl-imx28.c
> > >  create mode 100644 drivers/pinctrl/pinctrl-mxs.c
> > >  create mode 100644 drivers/pinctrl/pinctrl-mxs.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt
> > > new file mode 100644
> > > index 0000000..7dfd3cf
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt
> > > @@ -0,0 +1,923 @@
> > > +* Freescale MXS Pin Controller
> > > +
> > > +The pins controlled by mxs pin controller are organized in banks, each bank
> > > +has 32 pins.  Each pin has 4 multiplexing functions, and generally, the 4th
> > > +function is GPIO.  The configuration on the pins includes drive strength,
> > > +voltage and pull-up.
> > > +
> > > +Required properties:
> > > +- compatible: "fsl,imx23-pinctrl" or "fsl,imx28-pinctrl"
> > > +- reg: Should contain the register physical address and length for the
> > > +  pin controller.
> > > +
> > > +Please refer to pinctrl-bindings.txt in this directory for details of the
> > > +common pinctrl bindings used by client devices, including the meaning of the
> > > +phrase "pin configuration node".
> > > +
> > [...]
> > 
> > > +The pin configuration nodes act as a container for an arbitrary number of
> > > +subnodes.  Each of these subnodes represents some desired configuration for
> > Do you allow sub nodes under pin configuration node?
> > I did not see it from the example.
> > 
> Why do we need sub nodes under pin configuration node?  To be clear,
> the "pin configuration node" defined in pinctrl-bindings.txt are those
> nodes under pinctrl at 80018000, like mmc0-4bit, mmc0-cd-cfg.
> 
The binding doc above indicates you allow an arbitrary number of subnodes.
Do not like Tegra, it seems you did not have sub node under pin configuration
node.
That why i asked that question.

> > > +a group of pins, and only affects those parameters that are explicitly listed.
> > > +In other words, a subnode that describes a drive strength parameter implies no
> > > +information pull-up. For this reason, even seemingly boolean values are
> > > +actually tristates in this binding: unspecified, off, or on. Unspecified is
> > > +represented as an absent property, and off/on are represented as integer
> > > +values 0 and 1.
> > > +
> > > +Those subnodes will fall into two categories.  One is to set up a group of
> > > +pins for a function, both mux selection and pin configurations.  For the same
> > > +function, all pin group nodes should use the same node name and be sorted
> > > +together in "reg" value.  And the other one is the pure pin configuration
> > > +node, which are used to configure some pins that need a different drive
> > > +strength, voltage or pull-up configurations from what specified in the pin
> > > +group node.
> > > +
> > That's indeed a limitation and raised by Sascha in my first pinctrl binding
> > that you need create a pure pin config node to reconfigure pins which needs
> > different setting in the same group.
> 
> I would not think it's a limitation but a design standing for hardware
> reality.  Generally, when we have a group pins functional for
The hardware reality is that each pin should be able to configure the pad
respectively.
But the binding you're using did not allow it...

> a particular function, most of the pins in the group share the same pin
> configuration requirement, and only few individual pin needs a different
> configuration.  For example, I have 10 pins for function mmc0-8bit,
> among of which 8 data pins + cmd pin require the same configuration,
> while only clk pin requires a different one.  Another better example,
> all 28 pins for function lcdif-24bit share the same one configuration.
> What's point to repeat the configuration data for all these 28 pins?
> 
It's from the HW pointer of view since IMX is pin based SoC.

> > After received some other people's suggestion, finally i remove this limitation
> > and allow each pin to set its pad config value in the same group.
> > See my pinctrl imx v2 driver patch and provide comment if you have different
> > option.
> 
> It works for you, because you have pin configuration data bond to the
> raw register value for each pin, since on imx there is a dedicated
> configuration register for each pin.  The mxs pinctrl controller is
> different from imx.  It has configuration data of multiple pins packed
> in one register.  I cannot really use the raw register approach but
> need to have multiple properties to represent the pin configuration.
> 
Well, it's true, i.MX23/28 have two registers for pad config.
But i guess this could be handled in driver.
The difference is how to interpret these data in pinctrl-imx for different
SoCs. That means for MXS, you can implement a slight different pinconf_group_set/get
and pinmux_enable/disable.

> > Basically i think we should try to get one unified binding method for all FSL
> > SoC families rather than find two if no big differences.
> > 
> Though the SoCs in mxs family are called i.MX23 and i.MX28, they are
> different architecture from imx.  The pin controllers are completely
> different ones.
> 
But the using is the same right, all are pin based SoC.
At least the binding could be the same.

> > > +Required subnode-properties:
> > > +- fsl,pinmux-ids: An integer array.  Each integer in the array specify a pin
> > > +  with given mux function, with bank, pin and mux packed as below.
> > > +
> > > +    [15..12] : bank number
> > > +    [11..4]  : pin number
> > > +    [3..0]   : mux selection
> > > +
> > Can you use a simple id here and hide these information in driver?
> 
> I do not think I want to do that.  All these information are natural
> hardware data, and there is no harm for binding reader to know how
> these hardware information are being encoded in pinmux-id.
> 
Yes, you can do that but it does not help too much.
User will not decode those raw data by manually referencing the data sheet
to know how these data are composed.
They only want to know what this data represents and how to use it.

Why i ask you if we can do as IMX did is because i'm trying to align the binding
with all FSL families.
IMX SoCs can not use MXS way since it does not like MXS that has bank number,
but MXS can surely use IMX way that only tell user a simple id and what this
simple id means.

> > Like:
> > MX28_PAD_GPMI_D00__GPMI_D0	0
> > MX28_PAD_GPMI_D01__GPMI_D1	1
> > MX28_PAD_GPMI_D02__GPMI_D2	2
> > MX28_PAD_GPMI_D03__GPMI_D3	3
> > MX28_PAD_GPMI_D04__GPMI_D4	4
> > ...
> > I did it for pinctrl imx.
> > 
> I do not want my pinctrl-mxs driver as big as pinctrl-imx in terms of
> lines of code.
> 
Not too much.
About 500 extra lines of code for each SoC pinctrl driver.
But it gets better readability and it's hw specific things and definitely
can be put in driver.
And you do not need to decode the data which can make the driver more simply.

> > > +  For the pure pin configuration nodes, the mux selection packed in the
> > > +  integer takes no effect, which means the mux selection of the pins that
> > > +  need separate configuration will also have to be set up by group node.
> > > +  In other word, the pin group node should include all the pins for given
> > > +  function, regardless of whether separate pin configuration nodes are needed
> > > +  to configure some pins differently or not.
> > > +
> > Then we did some duplicated things.
> > 
> It requires the pin group node list all the pins for particular function
> for some reason.  For pin-only type of controller, there is no hardware
> pingroup.  When we define a pin group (virtual pingroup in Stephen's
> term) for a particular function, the group should really include all
> the pins required by the function.  This conforms to the "pingroup"
> concept of pinctrl system, it could require multiple hardware pingroups
> compose all the pins that particular function needs, but should really
> require one virtual pingroup do that.
> 
Hmm, it's true for IMX.
I meant duplicated config for the same pin in the same group if
we did not support per pin based config.

> > > +  Valid values for these integers are listed below.
> > > +
> > > +- reg: Should be the index of the pin group nodes for same function.  This
> > > +  property is required only for pin group nodes, and should not be present
> > > +  in any pure pin configuration nodes.
> > > +
> > > +Optional subnode-properties:
> > > +- fsl,drive-strength: Integer.
> > > +    0: 4 mA
> > > +    1: 8 mA
> > > +    2: 12 mA
> > > +    3: 16 mA
> > > +- fsl,voltage: Integer.
> > > +    0: 1.8 V
> > > +    1: 3.3 V
> > > +- fsl,pull-up: Integer.
> > > +    0: Disable the internal pull-up
> > > +    1: Enable the internal pull-up
> > > +
> > You already use raw data for mux, i really don't think it helps too much
> > to not for config.
> > 
> Besides the fact that one register packs pin configuration data for
> multiple pins, the reason for such binding is users will be able
> to touch the data without looking at hardware manual. 
> 
When dtc macro is avaiable, you do not need this too.
That's why i removed it for imx.

> > > +Examples:
> > > +
> > > +pinctrl at 80018000 {
> > > +	#address-cells = <1>;
> > > +	#size-cells = <0>;
> > > +	compatible = "fsl,imx28-pinctrl";
> > > +	reg = <0x80018000 2000>;
> > > +
> > > +	mmc0_4bit_pins_a: mmc0-4bit at 0 {
> > "mmc0-4bit" is more likely be a group,
> > but you use it as function name, right?
> > 
> Yes, mmc0-4bit is used as function name.  As there will be multiple
> (virtual) pingroup could functional as mmc0-4bit, those groups will
> be named as the combination of function name and "reg" value, like
> mmc0-4bit.0, mmc0-4bit.1
> 
I meant 'mmc0' should be the correct function name rather than 'mmc0-4bit'.
4bit is just different using which is board specific while the pin in the group
still functions the same.
Thus 'mmc0-4bit' surely should be only different group name.

Regards
Dong Aisheng
