From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 19 Apr 2012 23:28:59 +0800
Subject: [PATCH 1/3] pinctrl: pinctrl-imx: add imx pinctrl core driver
In-Reply-To: <1334333915-1174-1-git-send-email-b29396@freescale.com>
References: <1334333915-1174-1-git-send-email-b29396@freescale.com>
Message-ID: <20120419152857.GE22219@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 14, 2012 at 12:18:33AM +0800, Dong Aisheng wrote:
> +config PINCTRL_IMX
> +	bool "Freescale IMX core pinctrl driver"
> +	depends on ARCH_MXC
> +
I would expect it just be:

config PINCTRL_IMX
        bool

It should be selected by PINCTRL_IMX6Q, which should in turn be
selected by arch/soc config.  Neither PINCTRL_IMX nor PINCTRL_IMX6Q
should be user visible option.

> +	/* generate mux map */
> +	parent = of_get_parent(np);
> +	if (!parent)
> +		return -EINVAL;
> +

You need to call of_node_put(parent), when you are done with the node.

> +	info->ngroups = 0;
> +	for_each_child_of_node(np, child)
> +		info->ngroups += of_get_child_count(child);
> +	info->groups = devm_kzalloc(&pdev->dev, nfuncs * sizeof(struct imx_pin_group),

s/nfuncs/info->ngroups?

> +static inline void imx_pmx_desc_init(struct pinctrl_desc *pmx_desc,
> +				const struct imx_pinctrl_info *info)
> +{
> +	pmx_desc->pins = info->pins;
> +	pmx_desc->npins = info->npins;
> +}
> +
I do not see much point with this inline function.

> +/**
> + * struct imx_pmx_func - describes IMX pinmux functions
> + * @name: the name of this specific function
> + * @groups: corresponding pin groups
> + */
> +struct imx_pmx_func {
> +	const char *name;
> +	const char **groups;
> +	unsigned num_groups;

Missed from kernel doc above.

If you make kernel doc, you need to make it perfectly right :)

> +};
> +
> +/**
> + * struct imx_pin_reg - describe a pin reg map
> + * The last 3 members are used for select input setting
> + * @pid: pin id
> + * @mux_reg: mux register offset
> + * @conf_reg: config register offset
> + * @mux: mux mode
> + * @input_reg: select input register offset for this mux if any
> + *  0 if no select input setting needed.
> + * @input_val: the value set to select input register
> + */
> +struct imx_pin_reg {
> +	unsigned int pid;
> +	unsigned int mux_reg;
> +	unsigned int conf_reg;
> +	unsigned int mux_mode;

Name mismatch with kernel doc.

> +	unsigned int input_reg;
> +	unsigned int input_val;
> +};
> +
> +/*
> + * struct imx_config_properties - describes the available dt pin config properties
> + * @property: the property name of a config
> + * @off: the bit offset of this config in pin config register
> + */
> +struct imx_config_properties {
> +	const char *property;
> +	const unsigned int off;
> +	const unsigned int mask;

Missed from kernel doc above.

> +};
> +
> +struct imx_pinctrl_info {
> +	struct device *dev;
> +	u32 type;

Since you have "enum imx_pinctrl_type", shouldn't it be used here?

Regards,
Shawn

> +	const struct pinctrl_pin_desc *pins;
> +	unsigned int npins;
> +	const struct imx_pin_reg *pin_regs;
> +	unsigned int npin_regs;
> +	const struct imx_config_properties *conf_properties;
> +	unsigned int nconf_properties;
> +	struct imx_pin_group *groups;
> +	unsigned int ngroups;
> +	struct imx_pmx_func *functions;
> +	unsigned int nfunctions;
> +};
> +
