From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 08 Jan 2016 09:25:46 +0100
Subject: [PATCH] soc: rockchip: power-domain: Modify power domain driver
 for rk3368
In-Reply-To: <1452269144-15389-1-git-send-email-zhangqing@rock-chips.com>
References: <1452269144-15389-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <3979294.oVXyhiFhfI@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Freitag, 8. Januar 2016, 08:05:44 schrieb zhangqing:
> This driver is modified to support RK3368 SoC.
> 
> Signed-off-by: zhangqing <zhangqing@rock-chips.com>
> ---
>  drivers/soc/rockchip/pm_domains.c        | 33
> ++++++++++++++++++++++++++++++++ include/dt-bindings/power/rk3368-power.h
> | 28 +++++++++++++++++++++++++++ 2 files changed, 61 insertions(+)
>  create mode 100644 include/dt-bindings/power/rk3368-power.h
> 
> diff --git a/drivers/soc/rockchip/pm_domains.c
> b/drivers/soc/rockchip/pm_domains.c index 534c589..6cdffb1 100644
> --- a/drivers/soc/rockchip/pm_domains.c
> +++ b/drivers/soc/rockchip/pm_domains.c
> @@ -18,6 +18,7 @@
>  #include <linux/regmap.h>
>  #include <linux/mfd/syscon.h>
>  #include <dt-bindings/power/rk3288-power.h>
> +#include <dt-bindings/power/rk3368-power.h>
> 
>  struct rockchip_domain_info {
>  	int pwr_mask;
> @@ -75,6 +76,9 @@ struct rockchip_pmu {
>  #define DOMAIN_RK3288(pwr, status, req)		\
>  	DOMAIN(pwr, status, req, req, (req) + 16)
> 
> +#define DOMAIN_RK3368(pwr, status, req)		\
> +	DOMAIN(pwr, status, req, (req) + 16, req)
> +
>  static bool rockchip_pmu_domain_is_idle(struct rockchip_pm_domain *pd)
>  {
>  	struct rockchip_pmu *pmu = pd->pmu;
> @@ -444,6 +448,14 @@ static const struct rockchip_domain_info
> rk3288_pm_domains[] = { [RK3288_PD_GPU]		= DOMAIN_RK3288(9, 9, 2),
>  };
> 
> +static const struct rockchip_domain_info rk3368_pm_domains[] = {
> +	[RK3368_PD_PERI]	= DOMAIN_RK3368(13, 12, 6),
> +	[RK3368_PD_VIO]		= DOMAIN_RK3368(15, 14, 8),
> +	[RK3368_PD_VIDEO]	= DOMAIN_RK3368(14, 13, 7),
> +	[RK3368_PD_GPU_0]	= DOMAIN_RK3368(16, 15, 2),
> +	[RK3368_PD_GPU_1]	= DOMAIN_RK3368(17, 16, 2),
> +};

The structure in the registers (and thus the macros you define above) is the 
same between rk3288 and rk3368, so there is no need to define that a second 
time. It is perfectly fine to re-use the DOMAIN_RK3288 macro here and saves 
double-definitions. [see our clock-drivers which already do this for the 
common parts].

> +
>  static const struct rockchip_pmu_info rk3288_pmu = {
>  	.pwr_offset = 0x08,
>  	.status_offset = 0x0c,
> @@ -461,11 +473,32 @@ static const struct rockchip_pmu_info rk3288_pmu = {
> .domain_info = rk3288_pm_domains,
>  };
> 
> +static const struct rockchip_pmu_info rk3368_pmu = {
> +	.pwr_offset = 0x0c,
> +	.status_offset = 0x10,
> +	.req_offset = 0x3c,
> +	.idle_offset = 0x40,
> +	.ack_offset = 0x40,
> +
> +	.core_pwrcnt_offset = 0x48,
> +	.gpu_pwrcnt_offset = 0x50,
> +
> +	.core_power_transition_time = 24,
> +	.gpu_power_transition_time = 24,
> +
> +	.num_domains = ARRAY_SIZE(rk3368_pm_domains),
> +	.domain_info = rk3368_pm_domains,
> +};
> +
>  static const struct of_device_id rockchip_pm_domain_dt_match[] = {
>  	{
>  		.compatible = "rockchip,rk3288-power-controller",
>  		.data = (void *)&rk3288_pmu,
>  	},
> +	{
> +		.compatible = "rockchip,rk3368-power-controller",
> +		.data = (void *)&rk3368_pmu,
> +	},
>  	{ /* sentinel */ },
>  };
> 
> diff --git a/include/dt-bindings/power/rk3368-power.h
> b/include/dt-bindings/power/rk3368-power.h new file mode 100644
> index 0000000..93633d5
> --- /dev/null
> +++ b/include/dt-bindings/power/rk3368-power.h

Please split the addition of the binding-header into a separate patch. We 
will need the header in both the soc-specific code as well as the devicetree 
side, which requires the header being in a shared branch.

Otherwise patch looks great.


Thanks
Heiko

> @@ -0,0 +1,28 @@
> +#ifndef __DT_BINDINGS_POWER_RK3368_POWER_H__
> +#define __DT_BINDINGS_POWER_RK3368_POWER_H__
> +
> +/* VD_CORE */
> +#define RK3368_PD_A53_L0	0
> +#define RK3368_PD_A53_L1	1
> +#define RK3368_PD_A53_L2	2
> +#define RK3368_PD_A53_L3	3
> +#define RK3368_PD_SCU_L		4
> +#define RK3368_PD_A53_B0	5
> +#define RK3368_PD_A53_B1	6
> +#define RK3368_PD_A53_B2	7
> +#define RK3368_PD_A53_B3	8
> +#define RK3368_PD_SCU_B		9
> +
> +/* VD_LOGIC */
> +#define RK3368_PD_BUS		10
> +#define RK3368_PD_PERI		11
> +#define RK3368_PD_VIO		12
> +#define RK3368_PD_ALIVE		13
> +#define RK3368_PD_VIDEO		14
> +#define RK3368_PD_GPU_0		15
> +#define RK3368_PD_GPU_1		16
> +
> +/* VD_PMU */
> +#define RK3368_PD_PMU		17
> +
> +#endif
