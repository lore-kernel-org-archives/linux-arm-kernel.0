From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 6 Dec 2011 17:42:04 +0800
Subject: [RFC PATCH 1/3] pinctrl: imx: add pinmux imx core driver
In-Reply-To: <1322999384-7886-1-git-send-email-b29396@freescale.com>
References: <1322999384-7886-1-git-send-email-b29396@freescale.com>
Message-ID: <20111206094203.GC3864@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 04, 2011 at 07:49:42PM +0800, Dong Aisheng wrote:
> +static struct pinmux_ops imx_pmx_ops = {
> +	.list_functions = imx_pmx_list_funcs,
> +	.get_function_name = imx_pmx_get_func_name,
> +	.get_function_groups = imx_pmx_get_groups,
> +	.enable = imx_pmx_enable,
> +};

The pinmux core code will check the pinmux_ops as below.  !ops->disable
is one of the checking, while you do not have .disable hook.

int pinmux_check_ops(const struct pinmux_ops *ops)
{
        /* Check that we implement required operations */
        if (!ops->list_functions ||
            !ops->get_function_name ||
            !ops->get_function_groups ||
            !ops->enable ||
            !ops->disable)
                return -EINVAL;

        return 0;
}

[...]

> +static int __init imx_pmx_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct imx_pmx *ipmx;
> +	struct resource *res;
> +	struct imx_pinctrl_info *info;
> +	resource_size_t res_size;
> +
> +	info = (struct imx_pinctrl_info *)pdev->id_entry->driver_data;
> +	if (!info || !info->pins || !info->groups || !info->functions
> +		|| (info->maxpin > info->npins)) {

You must mean !(info->maxpin > info->npins) here?

Regards,
Shawn

> +		dev_err(&pdev->dev, "wrong pinctrl info\n");
> +		return -EINVAL;
> +	}
