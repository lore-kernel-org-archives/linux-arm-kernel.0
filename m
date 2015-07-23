From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 23 Jul 2015 08:53:53 +0800
Subject: [PATCH 1/2] ARM: rockchip: set correct stabilization thresholds
 in suspend
In-Reply-To: <3856665.6DP3Y23l8S@diego>
References: <3856665.6DP3Y23l8S@diego>
Message-ID: <55B03B21.1070801@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko

On 07/22/2015 11:27 PM, Heiko St?bner wrote:
> Currently the stabilization thresholds for the oscillator and external pmu
> are statically set to 30ms based on a 32kHz clock rate. This leaves out the
> case when we don't switch to the 32kHz clock if either usb wakeup is
> enabled or we only enter the shallow suspend mode where the logic keeps
> running.
>
> So, set the correct threshold after we have determined if we switch to the
> 32kHz clock or stay with the 24MHz one.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   arch/arm/mach-rockchip/pm.c | 16 ++++++++++++----
>   arch/arm/mach-rockchip/pm.h |  4 ----
>   2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
> index 892bace..4539f51 100644
> --- a/arch/arm/mach-rockchip/pm.c
> +++ b/arch/arm/mach-rockchip/pm.c
> @@ -96,7 +96,8 @@ static bool rk3288_slp_disable_osc(void)
>   static void rk3288_slp_mode_set(int level)
>   {
>   	u32 mode_set, mode_set1;
> -	bool osc_switch_to_32k = rk3288_slp_disable_osc();
> +	bool osc_switch_to_32k;
> +	int cnt_thres;
>   
>   	regmap_read(sgrf_regmap, RK3288_SGRF_CPU_CON0, &rk3288_sgrf_cpu_con0);
>   	regmap_read(sgrf_regmap, RK3288_SGRF_SOC_CON0, &rk3288_sgrf_soc_con0);
> @@ -135,6 +136,8 @@ static void rk3288_slp_mode_set(int level)
>   	mode_set1 = BIT(PMU_CLR_CORE) | BIT(PMU_CLR_CPUP);
>   
>   	if (level == ROCKCHIP_ARM_OFF_LOGIC_DEEP) {
> +		osc_switch_to_32k = rk3288_slp_disable_osc();
> +
>   		/* arm off, logic deep sleep */
>   		mode_set |= BIT(PMU_BUS_PD_EN) | BIT(PMU_PMU_USE_LF) |
>   			    BIT(PMU_DDR1IO_RET_EN) | BIT(PMU_DDR0IO_RET_EN) |
> @@ -145,7 +148,10 @@ static void rk3288_slp_mode_set(int level)
>   
>   		mode_set1 |= BIT(PMU_CLR_ALIVE) | BIT(PMU_CLR_BUS) |
>   			     BIT(PMU_CLR_PERI) | BIT(PMU_CLR_DMA);
> +
>   	} else {
> +		osc_switch_to_32k = false;
> +
>   		/*
>   		 * arm off, logic normal
>   		 * if pmu_clk_core_src_gate_en is not set,
> @@ -154,6 +160,11 @@ static void rk3288_slp_mode_set(int level)
>   		mode_set |= BIT(PMU_CLK_CORE_SRC_GATE_EN);
>   	}
>   
> +	/* set correct stabilization threshold */
> +	cnt_thres = (osc_switch_to_32k) ? 32 : 24000;

We have switch to 32khz in ROCKCHIP_ARM_OFF_LOGIC_DEEP mode,
although the 24Mhz osc is still working when osc_switch_to_32k = false.
So I think cnt_thres must always be 32 for ROCKCHIP_ARM_OFF_LOGIC_DEEP mode

> +	regmap_write(pmu_regmap, RK3288_PMU_OSC_CNT, cnt_thres * 30);
> +	regmap_write(pmu_regmap, RK3288_PMU_STABL_CNT, cnt_thres * 30);
> +
>   	regmap_write(pmu_regmap, RK3288_PMU_PWRMODE_CON, mode_set);
>   	regmap_write(pmu_regmap, RK3288_PMU_PWRMODE_CON1, mode_set1);
>   }
> @@ -262,9 +273,6 @@ static int rk3288_suspend_init(struct device_node *np)
>   	memcpy(rk3288_bootram_base, rockchip_slp_cpu_resume,
>   	       rk3288_bootram_sz);
>   
> -	regmap_write(pmu_regmap, RK3288_PMU_OSC_CNT, OSC_STABL_CNT_THRESH);
> -	regmap_write(pmu_regmap, RK3288_PMU_STABL_CNT, PMU_STABL_CNT_THRESH);
> -
>   	return 0;
>   }
>   
> diff --git a/arch/arm/mach-rockchip/pm.h b/arch/arm/mach-rockchip/pm.h
> index b6494c2..8a55ee2 100644
> --- a/arch/arm/mach-rockchip/pm.h
> +++ b/arch/arm/mach-rockchip/pm.h
> @@ -62,10 +62,6 @@ static inline void rockchip_suspend_init(void)
>   /* PMU_WAKEUP_CFG1 bits */
>   #define PMU_ARMINT_WAKEUP_EN		BIT(0)
>   
> -/* wait 30ms for OSC stable and 30ms for pmic stable */
> -#define OSC_STABL_CNT_THRESH	(32 * 30)
> -#define PMU_STABL_CNT_THRESH	(32 * 30)
> -
>   enum rk3288_pwr_mode_con {
>   	PMU_PWR_MODE_EN = 0,
>   	PMU_CLK_CORE_SRC_GATE_EN,
