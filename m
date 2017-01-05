From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 5 Jan 2017 15:38:48 +0800
Subject: [PATCH v6 5/5] soc: zte: pm_domains: Add support for zx296718
In-Reply-To: <1483530494-14177-5-git-send-email-baoyou.xie@linaro.org>
References: <1483530494-14177-1-git-send-email-baoyou.xie@linaro.org>
 <1483530494-14177-5-git-send-email-baoyou.xie@linaro.org>
Message-ID: <20170105073846.GD4667@x250>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 04, 2017 at 07:48:14PM +0800, Baoyou Xie wrote:
> This patch introduces the power domain driver of zx296718
> which belongs to zte's zx2967 family.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> Reviewed-by: Jun Nie <jun.nie@linaro.org>
> ---
>  drivers/soc/zte/Makefile              |   1 +
>  drivers/soc/zte/zx296718_pm_domains.c | 181 ++++++++++++++++++++++++++++++++++
>  2 files changed, 182 insertions(+)
>  create mode 100644 drivers/soc/zte/zx296718_pm_domains.c
> 
> diff --git a/drivers/soc/zte/Makefile b/drivers/soc/zte/Makefile
> index 8a37f2f..96b7cd4 100644
> --- a/drivers/soc/zte/Makefile
> +++ b/drivers/soc/zte/Makefile
> @@ -2,3 +2,4 @@
>  # ZTE SOC drivers
>  #
>  obj-$(CONFIG_ZX2967_PM_DOMAINS) += zx2967_pm_domains.o
> +obj-$(CONFIG_ZX2967_PM_DOMAINS) += zx296718_pm_domains.o
> diff --git a/drivers/soc/zte/zx296718_pm_domains.c b/drivers/soc/zte/zx296718_pm_domains.c
> new file mode 100644
> index 0000000..52003ee
> --- /dev/null
> +++ b/drivers/soc/zte/zx296718_pm_domains.c
> @@ -0,0 +1,181 @@
> +/*
> + * Copyright (C) 2017 ZTE Ltd.
> + *
> + * Author: Baoyou Xie <baoyou.xie@linaro.org>
> + * License terms: GNU General Public License (GPL) version 2
> + */

Please have a newline between licence declaration and headers to improve
the readability.  Same for zx2967_pm_domains.c.

> +#include <dt-bindings/soc/zte,pm_domains.h>
> +#include "zx2967_pm_domains.h"
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

I think we can save this enum completely by defining those
DM_ZX296718_xxx constants in zte,pm_domains.h in the same order of this
enum (hardware bit position order), so that DM_ZX296718_xxx can directly
be used as .bit field of struct zx2967_pm_domain.

#define DM_ZX296718_VOU 	0
#define DM_ZX296718_SAPPU	1
#define DM_ZX296718_VDE		2  /* g1v6 */
#define DM_ZX296718_VCE		3  /* h1v6 */
#define DM_ZX296718_HDE		4  /* g2v2 */
#define DM_ZX296718_VIU		5
#define DM_ZX296718_USB20	6
#define DM_ZX296718_USB21	7
#define DM_ZX296718_USB30	8
#define DM_ZX296718_HSIC	9
#define DM_ZX296718_GMAC	10
#define DM_ZX296718_TS		11

> +
> +static struct zx2967_pm_domain vou_domain = {
> +	.dm = {
> +		.name		= "vou_domain",
> +	},
> +	.bit = PCU_DM_VOU,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain sappu_domain = {
> +	.dm = {
> +		.name		= "sappu_domain",
> +	},
> +	.bit = PCU_DM_SAPPU,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain vde_domain = {
> +	.dm = {
> +		.name		= "vde_domain",
> +	},
> +	.bit = PCU_DM_VDE,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain vce_domain = {
> +	.dm = {
> +		.name		= "vce_domain",
> +	},
> +	.bit = PCU_DM_VCE,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain hde_domain = {
> +	.dm = {
> +		.name		= "hde_domain",
> +	},
> +	.bit = PCU_DM_HDE,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain viu_domain = {
> +	.dm = {
> +		.name		= "viu_domain",
> +	},
> +	.bit = PCU_DM_VIU,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain usb20_domain = {
> +	.dm = {
> +		.name		= "usb20_domain",
> +	},
> +	.bit = PCU_DM_USB20,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain usb21_domain = {
> +	.dm = {
> +		.name		= "usb21_domain",
> +	},
> +	.bit = PCU_DM_USB21,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain usb30_domain = {
> +	.dm = {
> +		.name		= "usb30_domain",
> +	},
> +	.bit = PCU_DM_USB30,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain hsic_domain = {
> +	.dm = {
> +		.name		= "hsic_domain",
> +	},
> +	.bit = PCU_DM_HSIC,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain gmac_domain = {
> +	.dm = {
> +		.name		= "gmac_domain",
> +	},
> +	.bit = PCU_DM_GMAC,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct zx2967_pm_domain ts_domain = {
> +	.dm = {
> +		.name		= "ts_domain",
> +	},
> +	.bit = PCU_DM_TS,
> +	.polarity = PWREN,
> +	.reg_offset = zx296718_offsets,
> +};
> +
> +static struct generic_pm_domain *zx296718_pm_domains[] = {
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

If you update the order of DM_ZX296718_xxx in zte,pm_domains.h, it would
be nice to update this list accordingly as well.

> +};
> +
> +static int zx296718_pd_probe(struct platform_device *pdev)
> +{
> +	return zx2967_pd_probe(pdev,
> +			  zx296718_pm_domains,
> +			  ARRAY_SIZE(zx296718_pm_domains));
> +}
> +
> +static const struct of_device_id zx296718_pm_domain_matches[] = {
> +	{ .compatible = "zte,zx296718-pcu", },
> +	{ },
> +};
> +
> +static struct platform_driver zx296718_pd_driver = {
> +	.driver = {
> +		.name = "zx-powerdomain",

This is a zx296718 specific driver.  So zx296718-powerdomain should
be a better name?

Shawn

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
