From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 22 Mar 2016 17:07:36 +0100
Subject: [PATCH v1] cpufreq: rockchip: add driver
In-Reply-To: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
 <1458647848-48999-1-git-send-email-xf@rock-chips.com>
Message-ID: <1758347.rheI35MbRd@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Dienstag, 22. M?rz 2016, 19:57:28 schrieb Feng Xiao:
> This driver will directly use cpufreq-dt driver as backend.
> 
> As there is not a generic devicetree board file(rockchip.c)
> on ARM64 architecture, so remove platform_device_register_simple
> in rockchip.c and add a new cpufreq driver to support Rockchip
> SoCs.
> 
> Signed-off-by: Feng Xiao <xf@rock-chips.com>

some hints regarding the soc-selection below, otherwise this looks nice.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

[includes an Ack for the mach-rockchip change ;-) ]

[...]

> diff --git a/drivers/cpufreq/rockchip-cpufreq.c
> b/drivers/cpufreq/rockchip-cpufreq.c new file mode 100644
> index 0000000..65c1de9
> --- /dev/null
> +++ b/drivers/cpufreq/rockchip-cpufreq.c
> @@ -0,0 +1,55 @@
> +/*
> + * Rockchip Platforms CPUFreq Support
> + *
> + * Copyright (C) 2016 Fuzhou Rockchip Electronics Co., Ltd
> + *
> + * Feng Xiao <xf@rock-chips.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +static const char * const rockchip_compat[] = {
> +	"rockchip,rk2928",

+	"rockchip,rk3036",

> +	"rockchip,rk3066a",
> +	"rockchip,rk3066b",
> +	"rockchip,rk3188",

+	"rockchip,rk3228",

> +	"rockchip,rk3288",
> +	"rockchip,rk3366",
> +	"rockchip,rk3368",
> +	"rockchip,rk3399",
> +};
> +
> +static int __init rockchip_cpufreq_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(rockchip_compat); i++) {
> +		if (of_machine_is_compatible(rockchip_compat[i])) {
> +			pdev = platform_device_register_simple("cpufreq-dt",
> +							       -1, NULL, 0);
> +			return PTR_ERR_OR_ZERO(pdev);
> +		}
> +	}
> +
> +	return -ENODEV;
> +}
> +module_init(rockchip_cpufreq_driver_init);
> +
> +MODULE_AUTHOR("Feng Xiao <xf@rock-chips.com>");
> +MODULE_DESCRIPTION("Rockchip cpufreq driver");
> +MODULE_LICENSE("GPL v2");
