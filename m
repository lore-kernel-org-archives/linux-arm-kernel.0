From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 15 May 2018 12:23:28 +0100
Subject: [RFC PATCH 01/10] devfreq: rockchip-dfi: Move GRF definitions to
 a common place.
In-Reply-To: <20180514211610.26618-2-enric.balletbo@collabora.com>
References: <20180514211610.26618-1-enric.balletbo@collabora.com>
 <20180514211610.26618-2-enric.balletbo@collabora.com>
Message-ID: <c217cf74-c5fe-4e4b-7b55-7672381b3eaf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Enric,

On 14/05/18 22:16, Enric Balletbo i Serra wrote:
> Some rk3399 GRF (Generic Register Files) definitions can be used for
> different drivers. Move these definitions to a common include so we
> don't need to duplicate these definitions.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>   drivers/devfreq/event/rockchip-dfi.c | 23 +++++++----------------
>   include/soc/rockchip/rk3399_grf.h    | 21 +++++++++++++++++++++
>   2 files changed, 28 insertions(+), 16 deletions(-)
>   create mode 100644 include/soc/rockchip/rk3399_grf.h
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 22b113363ffc..2fbbcbeb644f 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -26,6 +26,8 @@
>   #include <linux/list.h>
>   #include <linux/of.h>
>   
> +#include <soc/rockchip/rk3399_grf.h>
> +
>   #define RK3399_DMC_NUM_CH	2
>   
>   /* DDRMON_CTRL */
> @@ -43,18 +45,6 @@
>   #define DDRMON_CH1_COUNT_NUM		0x3c
>   #define DDRMON_CH1_DFI_ACCESS_NUM	0x40
>   
> -/* pmu grf */
> -#define PMUGRF_OS_REG2	0x308
> -#define DDRTYPE_SHIFT	13
> -#define DDRTYPE_MASK	7
> -
> -enum {
> -	DDR3 = 3,
> -	LPDDR3 = 6,
> -	LPDDR4 = 7,
> -	UNUSED = 0xFF
> -};
> -
>   struct dmc_usage {
>   	u32 access;
>   	u32 total;
> @@ -83,16 +73,17 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
>   	u32 ddr_type;
>   
>   	/* get ddr type */
> -	regmap_read(info->regmap_pmu, PMUGRF_OS_REG2, &val);
> -	ddr_type = (val >> DDRTYPE_SHIFT) & DDRTYPE_MASK;
> +	regmap_read(info->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
> +	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
> +		    RK3399_PMUGRF_DDRTYPE_MASK;
>   
>   	/* clear DDRMON_CTRL setting */
>   	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
>   
>   	/* set ddr type to dfi */
> -	if (ddr_type == LPDDR3)
> +	if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
>   		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
> -	else if (ddr_type == LPDDR4)
> +	else if (ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
>   		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
>   
>   	/* enable count, use software mode */
> diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
> new file mode 100644
> index 000000000000..0f94034e2e9a
> --- /dev/null
> +++ b/include/soc/rockchip/rk3399_grf.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Rockchip Generic Register Files definitions

Nit: s/Generic/General/

(that's what the TRMs say)

Robin.

> + *
> + * Copyright (c) 2018, Collabora Ltd.
> + * Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> + */
> +
> +#ifndef __SOC_RK3399_GRF_H
> +#define __SOC_RK3399_GRF_H
> +
> +/* PMU GRF Registers */
> +#define RK3399_PMUGRF_OS_REG2		0x308
> +#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
> +#define RK3399_PMUGRF_DDRTYPE_MASK	7
> +#define RK3399_PMUGRF_DDRTYPE_DDR3	3
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
> +#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
> +
> +#endif
> 
