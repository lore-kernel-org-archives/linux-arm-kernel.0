From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 15 May 2013 16:03:10 +0200 (CEST)
Subject: [PATCH v3 01/20] sh-pfc: Add DT support
In-Reply-To: <1368577100-3530-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1368577100-3530-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1368577100-3530-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <Pine.LNX.4.64.1305151417300.10596@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent

Thanks for your work on this! Sorry for jumping in so late in the game. 
Let's do it this way: I don't think my comments are serious enough to 
enforce a v4. If noone else complains, I'm fine with addressing them in an 
incremental patch. If you get more comments and have to do a v4, you can 
address mine too, otherwise I'm fine with this version going in and 
improving it slightly afterwards.

On Wed, 15 May 2013, Laurent Pinchart wrote:

> Support device instantiation through the device tree. The compatible
> property is used to select the SoC pinmux information.
> 
> Set the gpio_chip device field to the PFC device to enable automatic
> GPIO OF support.
> 
> Cc: devicetree-discuss at lists.ozlabs.org
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
>  .../bindings/pinctrl/renesas,pfc-pinctrl.txt       | 143 ++++++++++++
>  drivers/pinctrl/sh-pfc/core.c                      |  66 +++++-
>  drivers/pinctrl/sh-pfc/pinctrl.c                   | 244 +++++++++++++++++++++
>  3 files changed, 451 insertions(+), 2 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> new file mode 100644
> index 0000000..e7aae39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
> @@ -0,0 +1,143 @@
> +* Renesas Pin Function Controller (GPIO and Pin Mux/Config)
> +
> +The Pin Function Controller (PFC) is a Pin Mux/Config controller. On SH7372,
> +SH73A0, R8A73A4 and R8A7740 it also acts as a GPIO controller.
> +
> +
> +Pin Control
> +-----------
> +
> +Required Properties:
> +
> +  - compatible: should be one of the following.
> +    - "renesas,pfc-r8a73a4": for R8A73A4 (R-Mobile APE6) compatible pin-controller.
> +    - "renesas,pfc-r8a7740": for R8A7740 (R-Mobile A1) compatible pin-controller.
> +    - "renesas,pfc-r8a7778": for R8A7778 (R-Mobile M1) compatible pin-controller.
> +    - "renesas,pfc-r8a7779": for R8A7779 (R-Car H1) compatible pin-controller.
> +    - "renesas,pfc-r8a7790": for R8A7790 (R-Car H2) compatible pin-controller.
> +    - "renesas,pfc-sh7372": for SH7372 (SH-Mobile AP4) compatible pin-controller.
> +    - "renesas,pfc-sh73a0": for SH73A0 (SH-Mobile AG5) compatible pin-controller.
> +
> +  - reg: Base address and length of each memory resource used by the pin
> +    controller hardware module.
> +
> +The PFC node also acts as a container for pin configuration nodes. Please refer
> +to pinctrl-bindings.txt in this directory for the definition of the term "pin
> +configuration node" and for the common pinctrl bindings used by client devices.
> +
> +Each pin configuration node represents a desired configuration for a pin, a
> +pin group, or a list of pins or pin groups. The configuration can include the
> +function to select on those pin(s) and pin configuration parameters (such as
> +pull-up and pull-down).
> +
> +Pin configuration nodes contain pin configuration properties, either directly
> +or grouped in child subnodes. Both pin muxing and configuration parameters can
> +be grouped in that way and referenced as a single pin configuration node by
> +client devices.
> +
> +A configuration node or subnode must reference at least one pin (through the
> +pins or pin groups properties) and contain at least a function or one
> +configuration parameter. When the function is present only pin groups can be
> +used to reference pins.
> +
> +All pin configuration nodes and subnodes names are ignored. All of those nodes
> +are parsed through phandles and processed purely based on their content.
> +
> +Pin Configuration Node Properties:
> +
> +- renesas,pins : An array of strings, each string containing the name of a pin.
> +- renesas,groups : An array of strings, each string containing the name of a pin
> +  group.
> +
> +- renesas,function: A string containing the name of the function to mux to the
> +  pin group(s) specified by the renesas,groups property
> +
> +  Valid values for pin, group and function names can be found in the group and
> +  function arrays of the PFC data file corresponding to the SoC
> +  (drivers/pinctrl/sh-pfc/pfc-*.c)
> +
> +- renesas,pull-up: An integer representing the pull-up strength to be applied
> +  to all pins specified by the renesas,pins and renesas-groups properties.
> +  0 disables the pull-up, 1 enables it. Other values should not be used.
> +- renesas,pull-down: An integer representing the pull-down strength to be
> +  applied to all pins specified by the renesas,pins and renesas-groups
> +  properties. 0 disables the pull-down, 1 enables it. Other values should not
> +  be used.
> +
> +
> +GPIO
> +----
> +
> +Required Properties:
> +
> +  - gpio-controller: Marks the device node as a gpio controller.
> +
> +  - #gpio-cells: Should be 2. The first cell is the pin number and the second
> +    cell is used to specify optional parameters as bit flags. Only the GPIO
> +    active low flag (bit 0) is currently supported.
> +
> +The syntax of the gpio specifier used by client nodes should be the following
> +with values derived from the SoC user manual.
> +
> +  <[phandle of the gpio controller node]
> +   [pin number within the gpio controller]
> +   [flags and pull up/down]>

How should pull up / down be specified? Above you say only "active low" is 
supported so far.

Actually, I'm a bit confused by how pinctrl and GPIO DT nodes should be 
implemented:

> +
> +
> +Examples
> +--------
> +
> +Example 1: SH73A0 (SH-Mobile AG5) pin controller node
> +
> +	pfc: pfc at e6050000 {
> +		compatible = "renesas,pfc-sh73a0";
> +		reg = <0xe6050000 0x8000>,
> +		      <0xe605801c 0x1c>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};

In this example you add one node, that implements both - a pinctrl and a 
GPIO controller. However, on some platforms you add two DT nodes: one for 
pinctrl and one for GPIO. While doing that your GPIO node has a compatible 
string like

		compatible = "renesas,gpio-r8a7778", "renesas,gpio-rcar";

Do I understand it right, that a separate DT node is used for a GPIO 
controller if the controllers are really well separated on the hardware, 
probably, don't share register address ranges? Is there a driver in the 
kernel, that actually probes those compatible strings? Or the driver for 
those GPIO controllers isn't DT based? Maybe at least a short explanation 
and an example with two DT nodes here, or a reference to another 
documentation would help.

[snip]

> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
> index 3b2fd43..5fa1c6b 100644
> --- a/drivers/pinctrl/sh-pfc/core.c
> +++ b/drivers/pinctrl/sh-pfc/core.c
> @@ -18,6 +18,7 @@
>  #include <linux/ioport.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/of_device.h>
>  #include <linux/pinctrl/machine.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> @@ -348,14 +349,74 @@ int sh_pfc_config_mux(struct sh_pfc *pfc, unsigned mark, int pinmux_type)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF

Not sure, is it really a good idea to use this #ifdef here? I think you 
could drop all 3 of them in this hunk:

[snip]

>  static int sh_pfc_probe(struct platform_device *pdev)
>  {
> +	const struct platform_device_id *platid = platform_get_device_id(pdev);
> +#ifdef CONFIG_OF

also here

> +	struct device_node *np = pdev->dev.of_node;
> +#endif
>  	const struct sh_pfc_soc_info *info;
>  	struct sh_pfc *pfc;
>  	int ret;
>  
> -	info = pdev->id_entry->driver_data
> -	      ? (void *)pdev->id_entry->driver_data : pdev->dev.platform_data;
> +	if (platid)
> +		info = (const void *)platid->driver_data;
> +#ifdef CONFIG_OF

and here.

> +	else if (np)
> +		info = of_match_device(sh_pfc_of_table, &pdev->dev)->data;
> +#endif
> +	else
> +		info = pdev->dev.platform_data;
> +
>  	if (info == NULL)
>  		return -ENODEV;
>  

[snip]

> +static int sh_pfc_dt_node_to_map(struct pinctrl_dev *pctldev,
> +				 struct device_node *np,
> +				 struct pinctrl_map **map, unsigned *num_maps)
> +{
> +	struct sh_pfc_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> +	struct device *dev = pmx->pfc->dev;
> +	struct device_node *child;
> +	unsigned int index;
> +	int ret;
> +
> +	*map = NULL;
> +	*num_maps = 0;
> +	index = 0;
> +
> +	for_each_child_of_node(np, child) {
> +		ret = sh_pfc_dt_subnode_to_map(dev, child, map, num_maps,
> +					       &index);
> +		if (ret < 0)
> +			goto done;
> +	}
> +
> +	/* If no mapping has been found in child nodes try the config node. */
> +	if (*num_maps == 0) {
> +		ret = sh_pfc_dt_subnode_to_map(dev, np, map, num_maps, &index);
> +		if (ret < 0)
> +			goto done;
> +	}
> +
> +	if (*num_maps == 0) {
> +		dev_err(dev, "no mapping found in node %s\n", np->full_name);
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
> +	ret = 0;
> +
> +done:
> +	if (ret < 0)
> +		sh_pfc_dt_free_map(pctldev, *map, *num_maps);
> +
> +	return ret;
> +}

Maybe simpler

+	if (*num_maps)
+		return 0;
+
+	dev_err(dev, "no mapping found in node %s\n", np->full_name);
+	ret = -EINVAL;
+
+done:
+	sh_pfc_dt_free_map(pctldev, *map, *num_maps);
+
+	return ret;

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
