From: pebolle@tiscali.nl (Paul Bolle)
Date: Mon, 20 Apr 2015 11:26:44 +0200
Subject: [PATCH v13 2/3] power-domain: rockchip: add power domain driver
In-Reply-To: <1429440280-18915-1-git-send-email-wxt@rock-chips.com>
References: <1429438552-17733-1-git-send-email-wxt@rock-chips.com>
 <1429440280-18915-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1429522004.14597.8.camel@x220>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2015-04-19 at 18:44 +0800, Caesar Wang wrote:
> --- a/arch/arm/mach-rockchip/Makefile
> +++ b/arch/arm/mach-rockchip/Makefile

+obj-$(CONFIG_PM_GENERIC_DOMAINS) += pm_domains.o

PM_GENERIC_DOMAINS is a bool symbol, so pm_domains.o can never be part
of a module. Is that correct?

> --- /dev/null
> +++ b/arch/arm/mach-rockchip/pm_domains.c

> +#include <linux/module.h>

This include could probably be dropped.

> +static const struct of_device_id rockchip_pm_domain_dt_match[] = {
> +	{
> +		.compatible = "rockchip,rk3288-power-controller",
> +		.data = (void *)&rk3288_pmu,
> +	},
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, rockchip_pm_domain_dt_match);

The MODULE_DEVICE_TABLE() macro will be preprocessed away for built-in
code, according to include/linux/module.h.

> +static struct platform_driver rockchip_pm_domain_driver = {
> +	.probe = rockchip_pm_domain_probe,
> +	.driver = {
> +		.name   = "rockchip-pm-domain",
> +		.owner  = THIS_MODULE,

According to include/linux/export.h THIS_MODULE is equivalent to NULL
for built-in code. So I think this line is not needed.

> +		.of_match_table = rockchip_pm_domain_dt_match,
> +		/*
> +		 * We can't forcibly eject devices form power domain,
> +		 * so we can't really remove power domains once they
> +		 * were added.
> +		 */
> +		.suppress_bind_attrs = true,
> +	},
> +};

Thanks,


Paul Bolle
