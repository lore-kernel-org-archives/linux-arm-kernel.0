From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 13 Dec 2011 11:23:15 +0100
Subject: [PATCH V2 7/7] arm/imx6q: add cpufreq support
In-Reply-To: <1323757530-19402-8-git-send-email-richard.zhao@linaro.org>
References: <1323757530-19402-1-git-send-email-richard.zhao@linaro.org>
 <1323757530-19402-8-git-send-email-richard.zhao@linaro.org>
Message-ID: <20111213102315.GJ27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 13, 2011 at 02:25:30PM +0800, Richard Zhao wrote:
> use cpu0 node property clock-frequency to check max frequency.
> 
> Signed-off-by: Richard Zhao <richard.zhao@linaro.org>
> ---
>  arch/arm/mach-imx/Kconfig        |    1 +
>  arch/arm/mach-imx/Makefile       |    2 +-
>  arch/arm/mach-imx/cpu_op-imx6q.c |   69 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 1 deletions(-)
>  create mode 100644 arch/arm/mach-imx/cpu_op-imx6q.c
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index fbd414b..21e472f 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -834,6 +834,7 @@ comment "i.MX6 family:"
>  
>  config SOC_IMX6Q
>  	bool "i.MX6 Quad support"
> +	select ARCH_HAS_CPUFREQ
>  	select ARM_GIC
>  	select CACHE_L2X0
>  	select CPU_V7
> diff --git a/arch/arm/mach-imx/Makefile b/arch/arm/mach-imx/Makefile
> index 9cf630a..2dfe4a7 100644
> --- a/arch/arm/mach-imx/Makefile
> +++ b/arch/arm/mach-imx/Makefile
> @@ -72,7 +72,7 @@ AFLAGS_head-v7.o :=-Wa,-march=armv7-a
>  obj-$(CONFIG_SMP) += platsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU) += hotplug.o
>  obj-$(CONFIG_LOCAL_TIMERS) += localtimer.o
> -obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o
> +obj-$(CONFIG_SOC_IMX6Q) += clock-imx6q.o mach-imx6q.o pm-imx6q.o cpu_op-imx6q.o
>  
>  # i.MX5 based machines
>  obj-$(CONFIG_MACH_MX51_BABBAGE) += mach-mx51_babbage.o
> diff --git a/arch/arm/mach-imx/cpu_op-imx6q.c b/arch/arm/mach-imx/cpu_op-imx6q.c
> new file mode 100644
> index 0000000..d24e081
> --- /dev/null
> +++ b/arch/arm/mach-imx/cpu_op-imx6q.c
> @@ -0,0 +1,69 @@
> +/*
> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
> + */
> +
> +/*
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +#include <linux/types.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/of.h>
> +#include <mach/hardware.h>
> +
> +static int arm_max_freq_idx;

This is only used in mx6q_get_cpu_op()

Also shouldn't this be initialized with 1? From what you
said 800MHz is safe for all boards whereas 1GHz is not.

Sascha

> +
> +/* operating point(op): 0 - 1GHz; 1 - 800MHz, 3 - 400MHz, 4  - 160MHz */
> +static struct cpu_op mx6q_cpu_op[] = {
> +	{
> +		.cpu_rate = 996000000,
> +		.cpu_voltage = 1225000,
> +	},
> +	{
> +		.cpu_rate = 792000000,
> +		.cpu_voltage = 1100000,
> +	},
> +	{
> +		.cpu_rate = 396000000,
> +		.cpu_voltage = 950000,
> +	},
> +	{
> +		.cpu_rate = 198000000,
> +		.cpu_voltage = 850000,
> +	},
> +};
> +
> +struct cpu_op *mx6q_get_cpu_op(int *op)
> +{
> +	struct device_node *cpu0;
> +	u32 val;
> +	int i;
> +
> +	cpu0 = of_find_node_by_path("/cpus/cpu at 0");
> +	if (cpu0 && !of_property_read_u32(cpu0, "clock-frequency", &val)) {
> +		for (i = 0; i < ARRAY_SIZE(mx6q_cpu_op); i++) {
> +			if (val >= mx6q_cpu_op[i].cpu_rate) {
> +				arm_max_freq_idx = i;
> +				break;
> +			}
> +		}
> +	}
> +	if (cpu0)
> +		of_node_put(cpu0);
> +	*op = ARRAY_SIZE(mx6q_cpu_op) - arm_max_freq_idx;
> +	return mx6q_cpu_op + arm_max_freq_idx;
> +}
> +
> +static int __init mx6q_cpu_op_init(void)
> +{
> +	get_cpu_op = mx6q_get_cpu_op;
> +	return 0;
> +}
> +
> +core_initcall(mx6q_cpu_op_init);
> -- 
> 1.7.5.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
