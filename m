From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 20 Apr 2012 11:02:20 -0600
Subject: [PATCH 1/2] pinctrl: add pinctrl-mxs support
In-Reply-To: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
References: <1334823125-24159-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <4F91969C.2010201@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/19/2012 02:12 AM, Shawn Guo wrote:
> Add pinctrl support for Freescale MXS SoCs, i.MX23 and i.MX28.
> The driver supports device tree probe only.

> diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/fsl,mxs-pinctrl.txt


> +The pin configuration nodes act as a container for an arbitrary number of
> +subnodes.  Each of these subnodes represents some desired configuration for
> +a group of pins, and only affects those parameters that are explicitly listed.
> +In other words, a subnode that describes a drive strength parameter implies no
> +information pull-up. For this reason, even seemingly boolean values are

Perhaps insert "about" or "regarding" after "information"?


> +Those subnodes will fall into two categories.  One is to set up a group of
> +pins for a function, both mux selection and pin configurations.  For the same
> +function, all pin group nodes should use the same node name and be sorted
> +together in "reg" value.  And the other one is the pure pin configuration
> +node, which are used to configure some pins that need a different drive
> +strength, voltage or pull-up configurations from what specified in the pin
> +group node.

This paragraph isn't very clear to me, although reading it in
conjunction with the example makes more sense.

I don't like a couple of things about this binding:

1) Combining the mux function selection into the fsl,pinmux-ids doesn't
seem correct. That property is being overloaded to both identify which
pins that node applies to, and to (in some cases) specify the mux
function to select for those pins. I think those two aspects should be
separate properties.

2) The use of the reg property to indicate whether the mux field in
fsl,pinmux-ids is actually used or not seems bizarre and without precedent.

Instead, why not:

* Remove the special-case use of the reg property.
* Remove [3:0] mux selection from fsl,pinmux-ids.
* Add a new property e.g. fsl,mux-selection to describe which mux value
to select for the pins. Perhaps this could be a list if needed.

Another potential issue with this binding: Each pin configuration node
contains a list of pin IDs, and a list of mux values. However, the pin
configuration properties are single-valued not a list. I guess this
isn't a problem since you can always have multiple pin configuration
nodes to represent different sets of pins which need different
configuration, but it just seems odd to allow a list of mux values but
only a single value for everything else.

> diff --git a/drivers/pinctrl/pinctrl-imx23.c b/drivers/pinctrl/pinctrl-imx23.c

> +static struct of_device_id imx23_pinctrl_of_match[] __devinitdata = {
> +	{ .compatible = "fsl,imx23-pinctrl", },
> +	{ /* sentinel */ }
> +};

MODULE_DEVICE_TABLE(of, imx23_pinctrl_of_match); ?

Same thing in the iMX28 file.
