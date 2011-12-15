From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 15 Dec 2011 16:18:28 +0800
Subject: [RFC PATCH v2 2/4] pinctrl: imx: add pinmux imx driver
In-Reply-To: <1323878622-26602-3-git-send-email-b29396@freescale.com>
References: <1323878622-26602-1-git-send-email-b29396@freescale.com>
 <1323878622-26602-3-git-send-email-b29396@freescale.com>
Message-ID: <20111215081825.GB22541@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2011 at 12:03:40AM +0800, Dong Aisheng wrote:
> The driver contains the initial support for imx53 and
> imx6q.
> 
> Signed-off-by: Dong Aisheng <dong.aisheng@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Shawn Guo <shanw.guo@freescale.com>
> ---
>  drivers/pinctrl/Kconfig           |   20 ++
>  drivers/pinctrl/Makefile          |    3 +
>  drivers/pinctrl/pinmux-imx-core.c |  435 ++++++++++++++++++++++++++++++++++++
>  drivers/pinctrl/pinmux-imx-core.h |   86 +++++++
>  drivers/pinctrl/pinmux-imx53.c    |  443 +++++++++++++++++++++++++++++++++++++
>  drivers/pinctrl/pinmux-imx6q.c    |  433 ++++++++++++++++++++++++++++++++++++
>  6 files changed, 1420 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
> index e17e2f8..268c212 100644
> --- a/drivers/pinctrl/Kconfig
> +++ b/drivers/pinctrl/Kconfig
> @@ -20,6 +20,26 @@ config DEBUG_PINCTRL
>  	help
>  	  Say Y here to add some extra checks and diagnostics to PINCTRL calls.
>  
> +config PINMUX_IMX
> +	bool "Freescale IMX core pinmux driver"
> +	depends on ARCH_MXC
> +
> +config PINMUX_IMX53
> +	bool "IMX53 pinmux driver"
> +	depends on ARCH_MX5
> +	select PINMUX
> +	select PINMUX_IMX
> +	help
> +	  Say Y here to enable the imx6q pinmux driver

s/imx6q/imx53

> +
> +config PINMUX_IMX6Q
> +	bool "IMX6Q pinmux driver"
> +	depends on SOC_IMX6Q
> +	select PINMUX
> +	select PINMUX_IMX
> +	help
> +	  Say Y here to enable the imx6q pinmux driver
> +

[...]

> +#ifdef CONFIG_OF
> +static int __devinit imx_pmx_parse_functions(struct device_node *np,
> +			struct imx_pinctrl_info *info, u32 num)
> +{
> +	struct imx_pmx_func *function;
> +	struct imx_pin_group *group;
> +	int ret, len;
> +
> +	dev_dbg(info->dev, "parse function %d\n", num);
> +
> +	group = &info->groups[num];
> +	function = &info->functions[num];
> +
> +	/* Initialise group */
> +	ret = of_property_read_string(np, "grp_name", &group->name);
> +	if (ret) {
> +		dev_err(info->dev, "failed to get grp_name\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "num_pins", &group->num_pins);
> +	if (ret) {
> +		dev_err(info->dev, "failed to get num_pins\n");
> +		return ret;
> +	}
> +
> +	ret = of_property_read_u32(np, "num_mux", &group->num_mux);
> +	if (ret) {
> +		dev_err(info->dev, "failed to get num_mux\n");
> +		return ret;
> +	}
> +
> +	if (group->num_pins != group->num_mux)
> +		return -EINVAL;
> +
> +	group->pins = devm_kzalloc(info->dev, group->num_pins * sizeof(unsigned int),
> +				GFP_KERNEL);
> +	group->mux_mode = devm_kzalloc(info->dev, group->num_mux * sizeof(unsigned int),
> +				GFP_KERNEL);
> +	if (!group->pins || !group->mux_mode)
> +		return -ENOMEM;
> +
> +	/* sanity check */
> +	if (of_get_property(np, "grp_pins", &len) &&
> +		len != group->num_pins * sizeof(unsigned int)) {

Since we can figure out the 'num_pins' here, why do we bother to
encode it in dts?

> +		dev_err(info->dev, "wrong pins number?\n");
> +		return -EINVAL;
> +	}
> +
> +	if (of_get_property(np, "grp_mux", &len) &&
> +		len != group->num_mux * sizeof(unsigned int)) {

ditto

> +		dev_err(info->dev, "wrong pin mux number?\n");
> +		return -EINVAL;
> +	}

-- 
Regards,
Shawn
