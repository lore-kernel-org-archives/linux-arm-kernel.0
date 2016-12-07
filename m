From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 7 Dec 2016 22:08:50 +0800
Subject: [PATCH v3 2/3] soc: zte: pm_domains: Add support for zx296718
 board
In-Reply-To: <1481091204-6559-2-git-send-email-baoyou.xie@linaro.org>
References: <1481091204-6559-1-git-send-email-baoyou.xie@linaro.org>
 <1481091204-6559-2-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20161207140847.GE2749@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 07, 2016 at 02:13:23PM +0800, Baoyou Xie wrote:
> This patch introduces the power domain driver of zx296718
> which belongs to zte's 2967 family.

The 'board' in subject is not appropriate, as zx296718 is a SoC, not
board.

> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

When you repost, tags like Reviewed-by, Acked-by, and Tested-by provided
by people on your patches should be added after your Signed-off-by line.
Specifically, the Reviewed-by from Jun Nie on v2 of the patch should be
added here.

> ---
>  drivers/soc/zte/Makefile              |   2 +-
>  drivers/soc/zte/zx296718_pm_domains.c | 194 ++++++++++++++++++++++++++++++++++
>  2 files changed, 195 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/soc/zte/zx296718_pm_domains.c
> 
> diff --git a/drivers/soc/zte/Makefile b/drivers/soc/zte/Makefile
> index 97ac8ea..2d2a2cc 100644
> --- a/drivers/soc/zte/Makefile
> +++ b/drivers/soc/zte/Makefile
> @@ -1,4 +1,4 @@
>  #
>  # zx SOC drivers
>  #
> -obj-$(CONFIG_ZX_PM_DOMAINS) += pm_domains.o
> +obj-$(CONFIG_ZX_PM_DOMAINS) += pm_domains.o zx296718_pm_domains.o

I would suggest to name it pm_domains_zx296718.o, so that power domain
files can alphabetically grouped.  Also, we may want to write the
Makefile like below, so that a target can be added or removed easily.

obj-$(CONFIG_ZX_PM_DOMAINS) += pm_domains.o
obj-$(CONFIG_ZX_PM_DOMAINS) += pm_domains_zx296718.o

> diff --git a/drivers/soc/zte/zx296718_pm_domains.c b/drivers/soc/zte/zx296718_pm_domains.c
> new file mode 100644
> index 0000000..5355b94
> --- /dev/null
> +++ b/drivers/soc/zte/zx296718_pm_domains.c
> @@ -0,0 +1,194 @@
> +/*
> + * Copyright (C) 2015 ZTE Ltd.
> + *
> + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> + * License terms: GNU General Public License (GPL) version 2
> + */
> +#include <dt-bindings/arm/zte_pm_domains.h>

The header is added by another patch.  You should include that patch
into the series, as there is dependency between patches.

> +#include "pm_domains.h"
> +
> +static u16 zx296718_offsets[REG_ARRAY_SIZE] = {
> +	[REG_CLKEN] = 0x18,
> +	[REG_ISOEN] = 0x1c,
> +	[REG_RSTEN] = 0x20,
> +	[REG_PWREN] = 0x24,
> +	[REG_ACK_SYNC] = 0x28,
> +};
> +
> +enum {
> +	PCU_DM_VOU = 0,
> +	PCU_DM_SAPPU,
> +	PCU_DM_VDE,
> +	PCU_DM_VCE,
> +	PCU_DM_HDE,
> +	PCU_DM_VIU,
> +	PCU_DM_USB20,
> +	PCU_DM_USB21,
> +	PCU_DM_USB30,
> +	PCU_DM_HSIC,
> +	PCU_DM_GMAC,
> +	PCU_DM_TS,
> +};
> +
> +static struct zx_pm_domain vou_domain = {
> +	.dm = {
> +		.name		= "vou_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_VOU,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};

Please have a newline between struct variables.

> +static struct zx_pm_domain sappu_domain = {
> +	.dm = {
> +		.name		= "sappu_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_SAPPU,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +static struct zx_pm_domain vde_domain = {
> +	.dm = {
> +		.name		= "vde_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_VDE,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +static struct zx_pm_domain vce_domain = {
> +	.dm = {
> +		.name		= "vce_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_VCE,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +static struct zx_pm_domain hde_domain = {
> +	.dm = {
> +		.name		= "hde_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_HDE,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx_pm_domain viu_domain = {
> +	.dm = {
> +		.name		= "viu_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_VIU,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +static struct zx_pm_domain usb20_domain = {
> +	.dm = {
> +		.name		= "usb20_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_USB20,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +static struct zx_pm_domain usb21_domain = {
> +	.dm = {
> +		.name		= "usb21_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_USB21,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +static struct zx_pm_domain usb30_domain = {
> +	.dm = {
> +		.name		= "usb30_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_USB30,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +static struct zx_pm_domain hsic_domain = {
> +	.dm = {
> +		.name		= "hsic_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_HSIC,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +static struct zx_pm_domain gmac_domain = {
> +	.dm = {
> +		.name		= "gmac_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,
> +	},
> +	.bit = PCU_DM_GMAC,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +static struct zx_pm_domain ts_domain = {
> +	.dm = {
> +		.name		= "ts_domain",
> +		.power_off	= zx_normal_power_off,
> +		.power_on	= zx_normal_power_on,

Can we assign these two function hooks in zx_pd_probe()?  If so, both
functions can be static ones in pm_domains.c.

> +	},
> +	.bit = PCU_DM_TS,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +struct generic_pm_domain *zx296718_pm_domains[] = {

static?

> +	[DM_ZX296718_SAPPU] = &sappu_domain.dm,
> +	[DM_ZX296718_VDE] = &vde_domain.dm,
> +	[DM_ZX296718_VCE] = &vce_domain.dm,
> +	[DM_ZX296718_HDE] = &hde_domain.dm,
> +	[DM_ZX296718_VIU] = &viu_domain.dm,
> +	[DM_ZX296718_USB20] = &usb20_domain.dm,
> +	[DM_ZX296718_USB21] = &usb21_domain.dm,
> +	[DM_ZX296718_USB30] = &usb30_domain.dm,
> +	[DM_ZX296718_HSIC] = &hsic_domain.dm,
> +	[DM_ZX296718_GMAC] = &gmac_domain.dm,
> +	[DM_ZX296718_TS] = &ts_domain.dm,
> +	[DM_ZX296718_VOU] = &vou_domain.dm,
> +};
> +
> +static int zx296718_pd_probe(struct platform_device *pdev)
> +{
> +	return zx_pd_probe(pdev,
> +			  zx296718_pm_domains,
> +			  ARRAY_SIZE(zx296718_pm_domains));
> +}
> +
> +static const struct of_device_id zx296718_pm_domain_matches[] = {
> +	{ .compatible = "zte,zx296718-pcu", },

Where is the patch documents the bindings?

Shawn

> +	{ },
> +};
> +
> +static struct platform_driver zx296718_pd_driver = {
> +	.driver = {
> +		.name = "zx-powerdomain",
> +		.owner = THIS_MODULE,
> +		.of_match_table = zx296718_pm_domain_matches,
> +	},
> +	.probe = zx296718_pd_probe,
> +};
> +
> +static int __init zx296718_pd_init(void)
> +{
> +	return platform_driver_register(&zx296718_pd_driver);
> +}
> +subsys_initcall(zx296718_pd_init);
> -- 
> 2.7.4
> 
