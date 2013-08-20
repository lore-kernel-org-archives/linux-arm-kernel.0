From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Aug 2013 20:56:17 +0800
Subject: [PATCH v2 1/7] pinctrl: imx1 core driver
In-Reply-To: <1376921234-26682-2-git-send-email-mpa@pengutronix.de>
References: <1376921234-26682-1-git-send-email-mpa@pengutronix.de>
 <1376921234-26682-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20130820125614.GE29114@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Looks good to me.  A couple of small comments below.

On Mon, Aug 19, 2013 at 04:07:08PM +0200, Markus Pargmann wrote:
> +/*
> + * Write to a register with 2 bits per pin. The function will automatically
> + * use the next register if the pin is managed in the second register.
> + */
> +static void imx1_write_2bit(struct imx1_pinctrl *ipctl, unsigned int pin_id,
> +		u32 value, u32 reg_offset)
> +{
> +	void __iomem *reg = imx1_mem(ipctl, pin_id) + reg_offset;
> +	int offset = (pin_id % 16) * 2; /* offset, regardless of register used */
> +	int mask = ~(0x3 << offset); /* Mask for 2 bits@offset */
> +	u32 old_val;
> +	u32 new_val;
> +
> +	dev_dbg(ipctl->dev, "write: register 0x%p offset %d value 0x%x\n",
> +			reg, offset, value);
> +
> +	/* Use the next register if the pin's port pin number is >=16 */
> +	if (pin_id % 32 >= 16)
> +		reg += 0x04;
> +
> +	/* Get current state of pins */
> +	old_val = readl(reg);
> +	old_val &= mask;
> +
> +	new_val = value & 0x3; /* Make sure value is really 2 bit */
> +	new_val <<= offset;
> +	new_val |= old_val;/* Set new state for pin_id */
> +
> +	writel(new_val, reg);
> +}
> +
> +static void imx1_write_bit(struct imx1_pinctrl *ipctl, unsigned int pin_id,
> +		u32 value, u32 reg_offset)
> +{
> +	void __iomem *reg = imx1_mem(ipctl, pin_id) + reg_offset;
> +	int offset = pin_id % 32;
> +	int mask = ~BIT_MASK(offset);
> +	u32 old_val;
> +	u32 new_val;
> +
> +	/* Get current state of pins */
> +	old_val = readl(reg);
> +	old_val &= mask;
> +
> +	new_val = value & 0x1; /* Make sure value is really 2 bit */

Copy&past error in comment.

> +	new_val <<= offset;
> +	new_val |= old_val;/* Set new state for pin_id */
> +
> +	writel(new_val, reg);
> +}

<snip>

> +static int imx1_pinctrl_parse_groups(struct device_node *np,
> +				    struct imx1_pin_group *grp,
> +				    struct imx1_pinctrl_soc_info *info,
> +				    u32 index)
> +{
> +	int size;
> +	const __be32 *list;
> +	int i;
> +
> +	dev_dbg(info->dev, "group(%d): %s\n", index, np->name);
> +
> +	/* Initialise group */
> +	grp->name = np->name;
> +
> +	/*
> +	 * the binding format is fsl,pins = <PIN_FUNC_ID CONFIG ...>,

It does not match the bindings.

> +	 * do sanity check and calculate pins number
> +	 */
> +	list = of_get_property(np, "fsl,pins", &size);
> +	/* we do not check return since it's safe node passed down */
> +	if (!size || size % 12) {
> +		dev_notice(info->dev, "Not a valid fsl,pins property (%s)\n",
> +				np->name);
> +		return -EINVAL;
> +	}
> +
> +	grp->npins = size / 12;
> +	grp->pins = devm_kzalloc(info->dev,
> +			grp->npins * sizeof(struct imx1_pin), GFP_KERNEL);
> +	grp->pin_ids = devm_kzalloc(info->dev,
> +			grp->npins * sizeof(unsigned int), GFP_KERNEL);
> +
> +	if (!grp->pins || !grp->pin_ids)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < grp->npins; i++) {
> +		grp->pins[i].pin_id = be32_to_cpu(*list++);
> +		grp->pins[i].mux_id = be32_to_cpu(*list++);
> +		grp->pins[i].config = be32_to_cpu(*list++);
> +
> +		grp->pin_ids[i] = grp->pins[i].pin_id;
> +	}
> +
> +	return 0;
> +}

<snip>

> +static int imx1_pinctrl_parse_dt(struct platform_device *pdev,
> +		struct imx1_pinctrl *pctl, struct imx1_pinctrl_soc_info *info)
> +{
> +	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *child;
> +	int ret;
> +	u32 nfuncs = 0;
> +	u32 ngroups = 0;
> +	u32 ifunc = 0;
> +	u32 base_addr;
> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	ret = of_property_read_u32(np, "reg", &base_addr);

It seems base_addr is used nowhere?

Shawn

> +	if (ret)
> +		return ret;
> +
> +	for_each_child_of_node(np, child) {
> +		++nfuncs;
> +		ngroups += of_get_child_count(child);
> +	}
> +
> +	if (!nfuncs) {
> +		dev_err(&pdev->dev, "No pin functions defined\n");
> +		return -EINVAL;
> +	}
> +
> +	info->nfunctions = nfuncs;
> +	info->functions = devm_kzalloc(&pdev->dev,
> +			nfuncs * sizeof(struct imx1_pmx_func), GFP_KERNEL);
> +
> +	info->ngroups = ngroups;
> +	info->groups = devm_kzalloc(&pdev->dev,
> +			ngroups * sizeof(struct imx1_pin_group), GFP_KERNEL);
> +
> +
> +	if (!info->functions || !info->groups)
> +		return -ENOMEM;
> +
> +	for_each_child_of_node(np, child) {
> +		ret = imx1_pinctrl_parse_functions(child, info, ifunc++);
> +		if (ret == -ENOMEM)
> +			return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
