From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Wed, 19 Jul 2017 07:54:23 +0200
Subject: [PATCH] pinctrl: Convert to using %pOF instead of full_name
In-Reply-To: <20170718214339.7774-43-robh@kernel.org>
References: <20170718214339.7774-43-robh@kernel.org>
Message-ID: <20170719055423.GB6246@kozik-book>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 18, 2017 at 04:43:23PM -0500, Rob Herring wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Ray Jui <rjui@broadcom.com>
> Cc: Scott Branden <sbranden@broadcom.com>
> Cc: bcm-kernel-feedback-list at broadcom.com
> Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Barry Song <baohua@kernel.org>
> Cc: linux-gpio at vger.kernel.org
> Cc: linux-rpi-kernel at lists.infradead.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: kernel at stlinux.com
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-renesas-soc at vger.kernel.org
> ---
>  drivers/pinctrl/bcm/pinctrl-bcm2835.c     | 25 +++++++++++--------------
>  drivers/pinctrl/devicetree.c              |  4 ++--
>  drivers/pinctrl/freescale/pinctrl-imx.c   |  8 +++-----
>  drivers/pinctrl/pinconf-generic.c         |  7 +++----
>  drivers/pinctrl/pinctrl-at91-pio4.c       | 11 +++++------
>  drivers/pinctrl/pinctrl-st.c              |  2 +-
>  drivers/pinctrl/pinctrl-tb10x.c           |  4 ++--
>  drivers/pinctrl/samsung/pinctrl-samsung.c |  6 +++---
>  drivers/pinctrl/sh-pfc/pinctrl.c          |  2 +-
>  drivers/pinctrl/sirf/pinctrl-sirf.c       |  6 +++---
>  10 files changed, 34 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> index 230883168e99..3e71e5d782ee 100644
> --- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
> @@ -692,8 +692,7 @@ static int bcm2835_pctl_dt_node_to_map_func(struct bcm2835_pinctrl *pc,
>  	struct pinctrl_map *map = *maps;
> 
>  	if (fnum >= ARRAY_SIZE(bcm2835_functions)) {
> -		dev_err(pc->dev, "%s: invalid brcm,function %d\n",
> -			of_node_full_name(np), fnum);
> +		dev_err(pc->dev, "%pOF: invalid brcm,function %d\n", np, fnum);
>  		return -EINVAL;
>  	}
> 
> @@ -713,8 +712,7 @@ static int bcm2835_pctl_dt_node_to_map_pull(struct bcm2835_pinctrl *pc,
>  	unsigned long *configs;
> 
>  	if (pull > 2) {
> -		dev_err(pc->dev, "%s: invalid brcm,pull %d\n",
> -			of_node_full_name(np), pull);
> +		dev_err(pc->dev, "%pOF: invalid brcm,pull %d\n", np, pull);
>  		return -EINVAL;
>  	}
> 
> @@ -745,8 +743,7 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
> 
>  	pins = of_find_property(np, "brcm,pins", NULL);
>  	if (!pins) {
> -		dev_err(pc->dev, "%s: missing brcm,pins property\n",
> -				of_node_full_name(np));
> +		dev_err(pc->dev, "%pOF: missing brcm,pins property\n", np);
>  		return -EINVAL;
>  	}
> 
> @@ -755,8 +752,8 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
> 
>  	if (!funcs && !pulls) {
>  		dev_err(pc->dev,
> -			"%s: neither brcm,function nor brcm,pull specified\n",
> -			of_node_full_name(np));
> +			"%pOF: neither brcm,function nor brcm,pull specified\n",
> +			np);
>  		return -EINVAL;
>  	}
> 
> @@ -766,15 +763,15 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
> 
>  	if (num_funcs > 1 && num_funcs != num_pins) {
>  		dev_err(pc->dev,
> -			"%s: brcm,function must have 1 or %d entries\n",
> -			of_node_full_name(np), num_pins);
> +			"%pOF: brcm,function must have 1 or %d entries\n",
> +			np, num_pins);
>  		return -EINVAL;
>  	}
> 
>  	if (num_pulls > 1 && num_pulls != num_pins) {
>  		dev_err(pc->dev,
> -			"%s: brcm,pull must have 1 or %d entries\n",
> -			of_node_full_name(np), num_pins);
> +			"%pOF: brcm,pull must have 1 or %d entries\n",
> +			np, num_pins);
>  		return -EINVAL;
>  	}
> 
> @@ -793,8 +790,8 @@ static int bcm2835_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
>  		if (err)
>  			goto out;
>  		if (pin >= ARRAY_SIZE(bcm2835_gpio_pins)) {
> -			dev_err(pc->dev, "%s: invalid brcm,pins value %d\n",
> -				of_node_full_name(np), pin);
> +			dev_err(pc->dev, "%pOF: invalid brcm,pins value %d\n",
> +				np, pin);
>  			err = -EINVAL;
>  			goto out;
>  		}
> diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
> index 0e5c9f14a706..0a20afc2210c 100644
> --- a/drivers/pinctrl/devicetree.c
> +++ b/drivers/pinctrl/devicetree.c
> @@ -117,8 +117,8 @@ static int dt_to_map_one_config(struct pinctrl *p,
>  	for (;;) {
>  		np_pctldev = of_get_next_parent(np_pctldev);
>  		if (!np_pctldev || of_node_is_root(np_pctldev)) {
> -			dev_info(p->dev, "could not find pctldev for node %s, deferring probe\n",
> -				np_config->full_name);
> +			dev_info(p->dev, "could not find pctldev for node %pOF, deferring probe\n",
> +				np_config);
>  			of_node_put(np_pctldev);
>  			/* OK let's just assume this will appear later then */
>  			return -EPROBE_DEFER;
> diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
> index 72aca758f4c6..1f0095a69407 100644
> --- a/drivers/pinctrl/freescale/pinctrl-imx.c
> +++ b/drivers/pinctrl/freescale/pinctrl-imx.c
> @@ -573,16 +573,14 @@ static int imx_pinctrl_parse_groups(struct device_node *np,
>  		list = of_get_property(np, "pins", &size);
>  		if (!list) {
>  			dev_err(info->dev,
> -				"no fsl,pins and pins property in node %s\n",
> -				np->full_name);
> +				"no fsl,pins and pins property in node %pOF\n", np);
>  			return -EINVAL;
>  		}
>  	}
> 
>  	/* we do not check return since it's safe node passed down */
>  	if (!size || size % pin_size) {
> -		dev_err(info->dev, "Invalid fsl,pins or pins property in node %s\n",
> -			np->full_name);
> +		dev_err(info->dev, "Invalid fsl,pins or pins property in node %pOF\n", np);
>  		return -EINVAL;
>  	}
> 
> @@ -666,7 +664,7 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
>  	func->name = np->name;
>  	func->num_group_names = of_get_child_count(np);
>  	if (func->num_group_names == 0) {
> -		dev_err(info->dev, "no groups defined in %s\n", np->full_name);
> +		dev_err(info->dev, "no groups defined in %pOF\n", np);
>  		return -EINVAL;
>  	}
>  	func->group_names = devm_kcalloc(info->dev, func->num_group_names,
> diff --git a/drivers/pinctrl/pinconf-generic.c b/drivers/pinctrl/pinconf-generic.c
> index fc0c230aa11f..4cf901c78130 100644
> --- a/drivers/pinctrl/pinconf-generic.c
> +++ b/drivers/pinctrl/pinconf-generic.c
> @@ -316,16 +316,15 @@ int pinconf_generic_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>  	if (ret < 0) {
>  		/* EINVAL=missing, which is fine since it's optional */
>  		if (ret != -EINVAL)
> -			dev_err(dev, "%s: could not parse property function\n",
> -				of_node_full_name(np));
> +			dev_err(dev, "%pOF: could not parse property function\n",
> +				np);
>  		function = NULL;
>  	}
> 
>  	ret = pinconf_generic_parse_dt_config(np, pctldev, &configs,
>  					      &num_configs);
>  	if (ret < 0) {
> -		dev_err(dev, "%s: could not parse node property\n",
> -			of_node_full_name(np));
> +		dev_err(dev, "%pOF: could not parse node property\n", np);
>  		return ret;
>  	}
> 
> diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
> index dc8591543dee..b1ca838dd80a 100644
> --- a/drivers/pinctrl/pinctrl-at91-pio4.c
> +++ b/drivers/pinctrl/pinctrl-at91-pio4.c
> @@ -494,8 +494,8 @@ static int atmel_pctl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
>  	ret = pinconf_generic_parse_dt_config(np, pctldev, &configs,
>  					      &num_configs);
>  	if (ret < 0) {
> -		dev_err(pctldev->dev, "%s: could not parse node property\n",
> -			of_node_full_name(np));
> +		dev_err(pctldev->dev, "%pOF: could not parse node property\n",
> +			np);
>  		return ret;
>  	}
> 
> @@ -504,8 +504,7 @@ static int atmel_pctl_dt_subnode_to_map(struct pinctrl_dev *pctldev,
> 
>  	num_pins = pins->length / sizeof(u32);
>  	if (!num_pins) {
> -		dev_err(pctldev->dev, "no pins found in node %s\n",
> -			of_node_full_name(np));
> +		dev_err(pctldev->dev, "no pins found in node %pOF\n", np);
>  		ret = -EINVAL;
>  		goto exit;
>  	}
> @@ -584,8 +583,8 @@ static int atmel_pctl_dt_node_to_map(struct pinctrl_dev *pctldev,
> 
>  	if (ret < 0) {
>  		pinctrl_utils_free_map(pctldev, *map, *num_maps);
> -		dev_err(pctldev->dev, "can't create maps for node %s\n",
> -			np_config->full_name);
> +		dev_err(pctldev->dev, "can't create maps for node %pOF\n",
> +			np_config);
>  	}
> 
>  	return ret;
> diff --git a/drivers/pinctrl/pinctrl-st.c b/drivers/pinctrl/pinctrl-st.c
> index 3ae8066bc127..1703977de7cf 100644
> --- a/drivers/pinctrl/pinctrl-st.c
> +++ b/drivers/pinctrl/pinctrl-st.c
> @@ -1537,7 +1537,7 @@ static int st_gpiolib_register_bank(struct st_pinctrl *info,
>  			return err;
>  		}
>  	} else {
> -		dev_info(dev, "No IRQ support for %s bank\n", np->full_name);
> +		dev_info(dev, "No IRQ support for %pOF bank\n", np);
>  	}
> 
>  	return 0;
> diff --git a/drivers/pinctrl/pinctrl-tb10x.c b/drivers/pinctrl/pinctrl-tb10x.c
> index edfba506e958..09d35006acb2 100644
> --- a/drivers/pinctrl/pinctrl-tb10x.c
> +++ b/drivers/pinctrl/pinctrl-tb10x.c
> @@ -557,8 +557,8 @@ static int tb10x_dt_node_to_map(struct pinctrl_dev *pctl,
>  	int ret = 0;
> 
>  	if (of_property_read_string(np_config, "abilis,function", &string)) {
> -		pr_err("%s: No abilis,function property in device tree.\n",
> -			np_config->full_name);
> +		pr_err("%pOF: No abilis,function property in device tree.\n",
> +			np_config);
>  		return -EINVAL;
>  	}
> 
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index f542642eed8d..20b59bb02196 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -679,7 +679,7 @@ static int samsung_pinctrl_create_function(struct device *dev,
> 
>  	npins = of_property_count_strings(func_np, "samsung,pins");
>  	if (npins < 1) {
> -		dev_err(dev, "invalid pin list in %s node", func_np->name);
> +		dev_err(dev, "invalid pin list in %pOFn node", func_np);
>  		return -EINVAL;
>  	}
> 
> @@ -696,8 +696,8 @@ static int samsung_pinctrl_create_function(struct device *dev,
>  							i, &gname);
>  		if (ret) {
>  			dev_err(dev,
> -				"failed to read pin name %d from %s node\n",
> -				i, func_np->name);
> +				"failed to read pin name %d from %pOFn node\n",
> +				i, func_np);
>  			return ret;
>  		}
> 

For Samsung pinctrl:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
