From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sat, 13 Apr 2013 22:13:58 +0200
Subject: [PATCH V2] cpufreq: ARM big LITTLE: Add generic cpufreq driver
 and its DT glue
In-Reply-To: <1f864ec505cae7c5daea3810a3c26e0f5cda38ea.1364290815.git.viresh.kumar@linaro.org>
References: <1f864ec505cae7c5daea3810a3c26e0f5cda38ea.1364290815.git.viresh.kumar@linaro.org>
Message-ID: <5169BC86.7010905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/26/2013 10:51 AM, Viresh Kumar wrote:
> big LITTLE is ARM's new Architecture focussing power/performance needs of modern
> world. More information about big LITTLE can be found here:
> 
> http://www.arm.com/products/processors/technologies/biglittleprocessing.php
> http://lwn.net/Articles/481055/
> 
> In order to keep cpufreq support for all big LITTLE platforms simple/generic,
> this patch tries to add a generic cpufreq driver layer for all big LITTLE
> platforms.
> 
> The driver is divided into two parts:
> - Core driver: Generic and shared across all big LITTLE SoC's
> - Glue drivers: Per platform drivers providing ops to the core driver
> 
> This patch adds in a generic glue driver which would extract information from
> Device Tree.
> 
> Future SoC's can either reuse the DT glue or write their own depending on the
> need.
> 
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
[...]
> diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
> new file mode 100644
> index 0000000..452ff46
> --- /dev/null
> +++ b/drivers/cpufreq/arm_big_little_dt.c
> @@ -0,0 +1,92 @@
> +/*
> + * Generic big.LITTLE CPUFreq Interface driver
> + *
> + * It provides necessary ops to arm_big_little cpufreq driver and gets
> + * Frequency information from Device Tree. Freq table in DT must be in KHz.
> + *
> + * Copyright (C) 2013 Linaro.
> + * Viresh Kumar <viresh.kumar@linaro.org>
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
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/cpufreq.h>
> +#include <linux/device.h>
> +#include <linux/export.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/opp.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +#include "arm_big_little.h"
> +
> +static int dt_init_opp_table(struct device *cpu_dev)
> +{
> +	struct device_node *np = NULL;
> +	int count = 0, ret;
> +
> +	for_each_child_of_node(of_find_node_by_path("/cpus"), np) {

If of_find_node_by_path() returns NULL, there will be a NULL pointer
dereference.

> +		if (count++ != cpu_dev->id)
> +			continue;
> +		if (!of_get_property(np, "operating-points", NULL))
> +			return -ENODATA;
> +
> +		cpu_dev->of_node = np;
> +
> +		ret = of_init_opp_table(cpu_dev);
> +		if (ret)
> +			return ret;
> +
> +		return 0;

of_node_put() should be called on np before returning.
Also, the reference count of the parent node should be decremented as well.

These comments apply to the below function dt_get_transition_latency() too.

> +	}
> +
> +	return -ENODEV;
> +}
> +
> +static int dt_get_transition_latency(struct device *cpu_dev)
> +{
> +	struct device_node *np = NULL;
> +	u32 transition_latency = CPUFREQ_ETERNAL;
> +	int count = 0;
> +
> +	for_each_child_of_node(of_find_node_by_path("/cpus"), np) {
> +		if (count++ != cpu_dev->id)
> +			continue;
> +
> +		of_property_read_u32(np, "clock-latency", &transition_latency);
> +		return 0;
> +	}
> +
> +	return -ENODEV;
> +}

--
Francesco
