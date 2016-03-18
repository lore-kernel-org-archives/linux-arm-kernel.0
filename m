From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 18 Mar 2016 13:56:57 +0100
Subject: [PATCH] cpufreq: rockchip: add driver
In-Reply-To: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
Message-ID: <1787319.AFAWVqkdk0@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Feng,

Am Freitag, 18. M?rz 2016, 20:10:04 schrieb Feng Xiao:
> This driver will directly use cpufreq-dt driver as backend.
> 
> As there is not a generic devicetree board file(rockchip.c)
> on ARM64 architecture, so remove platform_device_register_simple
> in rockchip.c and add a new cpufreq driver to support for all
> Rockchip SoCs.
> 
> Signed-off-by: Feng Xiao <xf@rock-chips.com>

[...]

> diff --git a/drivers/cpufreq/rockchip-cpufreq.c
> b/drivers/cpufreq/rockchip-cpufreq.c new file mode 100644
> index 0000000..ecbadcd
> --- /dev/null
> +++ b/drivers/cpufreq/rockchip-cpufreq.c
> @@ -0,0 +1,36 @@
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
> +static int __init rockchip_cpufreq_driver_init(void)
> +{
> +	struct platform_device *pdev;
> +
> +	pdev = platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
> +	return PTR_ERR_OR_ZERO(pdev);

This would create that cpufreq-dt device on all non-Rockchip platforms 
compiled into the same kernel image as well - we definitly don't want that.

Also, on both the rk3368 as well as the rk3399, you probably want the cluster-
handling of arm-bL-cpufreq-dt.
Contrary to its name it is _not_ limited to switching between clusters, but 
can also control frequencies of multiple cpu-clusters running at the same 
time.


Implementation-wise, I guess doing it similar to the scpi-implementation might 
make more sense. Please take a look at drivers/clk/clk-scpi.c that registers 
the virtual cpufreq device there.

So we could do something similar, move the cpufreq from mach-rockchip to the 
clock drivers and register the appropriate cpufreq-driver for each soc.
cpufreq-dt for socs with a single cluster, the bL-thing for socs with multiple 
clusters.


Heiko
