From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 21 Apr 2012 09:51:07 +0800
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <4F91969C.2010201@wwwdotorg.org>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
 <4F91969C.2010201@wwwdotorg.org>
Message-ID: <20120421015052.GA6808@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 20, 2012 at 11:02:20AM -0600, Stephen Warren wrote:
> On 04/19/2012 02:12 AM, Shawn Guo wrote:
> > Add pinctrl support for Freescale MXS SoCs, i.MX23 and i.MX28.
> > The driver supports device tree probe only.
> 
> > diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt
> 
> 
> > +The pin configuration nodes act as a container for an arbitrary number of
> > +subnodes.  Each of these subnodes represents some desired configuration for
> > +a group of pins, and only affects those parameters that are explicitly listed.
> > +In other words, a subnode that describes a drive strength parameter implies no
> > +information pull-up. For this reason, even seemingly boolean values are
> 
> Perhaps insert "about" or "regarding" after "information"?
> 
Absolutely.

> 
> > +Those subnodes will fall into two categories.  One is to set up a group of
> > +pins for a function, both mux selection and pin configurations.  For the same
> > +function, all pin group nodes should use the same node name and be sorted
> > +together in "reg" value.  And the other one is the pure pin configuration
> > +node, which are used to configure some pins that need a different drive
> > +strength, voltage or pull-up configurations from what specified in the pin
> > +group node.
> 
> This paragraph isn't very clear to me, although reading it in
> conjunction with the example makes more sense.
> 
> I don't like a couple of things about this binding:
> 
> 1) Combining the mux function selection into the fsl,pinmux-ids doesn't
> seem correct. That property is being overloaded to both identify which
> pins that node applies to, and to (in some cases) specify the mux
> function to select for those pins. I think those two aspects should be
> separate properties.
> 
I fully agree with this observation.  But we decided to have the
binding combine these two aspects into one entity, a given pin on
given mux selection, because all existing mach-mxs users use this
entity to identify a pin (That long list of valid pinmux-ids value
is copied from existing mach-mxs pinctrl driver).  I have to admit
this is a compromise to ease the users and engineering.

> 2) The use of the reg property to indicate whether the mux field in
> fsl,pinmux-ids is actually used or not seems bizarre and without precedent.
> 
That's actually the side-effect of fsl,pinmux-ids definition and reg
property.  The main purpose of reg property is to distinguish the
category of the subnodes.  The driver will create a pin group for the
nodes that have reg property (called pin group node in the binding),
while ignore the ones that do not have reg property (called pure pin
configuration node).

> Instead, why not:
> 
> * Remove the special-case use of the reg property.
> * Remove [3:0] mux selection from fsl,pinmux-ids.
> * Add a new property e.g. fsl,mux-selection to describe which mux value
> to select for the pins. Perhaps this could be a list if needed.
> 
This is basically what Dong's imx patch does.  It ends up with something
like "fsl,mux = <0 0 1 1 1 1 1 1 1 1>;" for a group of pins specified
in "fsl,pins".  Sascha does not like it, because it makes the pinctrl
migration hard, and every time we touch "fsl,mux", we need to look at
hardware manual to find the meaning of these mux numbers.

> Another potential issue with this binding: Each pin configuration node
> contains a list of pin IDs, and a list of mux values. However, the pin
> configuration properties are single-valued not a list. I guess this
> isn't a problem since you can always have multiple pin configuration
> nodes to represent different sets of pins which need different
> configuration, but it just seems odd to allow a list of mux values but
> only a single value for everything else.
> 
We define the pins in the node with "reg" property as a pin group and
force the same pin configuration for each pin in the group.  Additional
pure pin configuration nodes (nodes without "reg") can be used to tweak
some particular pins that actually need a different configuration than
what group node specifies.

> > diff --git a/drivers/pinctrl/pinctrl-imx23.c b/drivers/pinctrl/pinctrl-imx23.c
> 
> > +static struct of_device_id imx23_pinctrl_of_match[] __devinitdata = {
> > +	{ .compatible = "fsl,imx23-pinctrl", },
> > +	{ /* sentinel */ }
> > +};
> 
> MODULE_DEVICE_TABLE(of, imx23_pinctrl_of_match); ?
> 
Yes, I missed that.  Thanks.

> Same thing in the iMX28 file.
> 

-- 
Regards,
Shawn
