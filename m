From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 02 Mar 2015 21:47:39 +0100
Subject: [PATCH 1/2] ARM: rockchip: decrease the wait time for resume
In-Reply-To: <1423487543-10593-1-git-send-email-zyw@rock-chips.com>
References: <1423487543-10593-1-git-send-email-zyw@rock-chips.com>
Message-ID: <30327138.BhvlayfjZW@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 9. Februar 2015, 21:12:22 schrieb Chris Zhong:
> The delay time for wait the 24MHz OSC stabilization is 750ms, and the
> delay time for wait the external PMU stabilization is 750ms too, let's
> decrease them to 30ms.

just to understand whats happening here:

The default delay time for wait the 24MHz OSC and PMU stabilization is 750ms, 
= reset value in the register and your patch is decreasing this to 30ms.

Are the new 30ms for each of the two long enough in all cases?


Heiko


> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> ---
> 
>  arch/arm/mach-rockchip/pm.c | 3 +++
>  arch/arm/mach-rockchip/pm.h | 4 ++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
> index 50cb781..a3ab397 100644
> --- a/arch/arm/mach-rockchip/pm.c
> +++ b/arch/arm/mach-rockchip/pm.c
> @@ -209,6 +209,9 @@ static int rk3288_suspend_init(struct device_node *np)
>  	memcpy(rk3288_bootram_base, rockchip_slp_cpu_resume,
>  	       rk3288_bootram_sz);
> 
> +	regmap_write(pmu_regmap, RK3288_PMU_OSC_CNT, OSC_STABL_CNT_THRESH);
> +	regmap_write(pmu_regmap, RK3288_PMU_STABL_CNT, PMU_STABL_CNT_THRESH);
> +
>  	return 0;
>  }
> 
> diff --git a/arch/arm/mach-rockchip/pm.h b/arch/arm/mach-rockchip/pm.h
> index 7d752ff..96beaa0 100644
> --- a/arch/arm/mach-rockchip/pm.h
> +++ b/arch/arm/mach-rockchip/pm.h
> @@ -57,6 +57,10 @@ void __init rockchip_suspend_init(void);
>  /* PMU_WAKEUP_CFG1 bits */
>  #define PMU_ARMINT_WAKEUP_EN		BIT(0)
> 
> +/* wait 30ms for OSC stable and 30ms for pmic stable */
> +#define OSC_STABL_CNT_THRESH	(32 * 30)
> +#define PMU_STABL_CNT_THRESH	(32 * 30)
> +
>  enum rk3288_pwr_mode_con {
>  	PMU_PWR_MODE_EN = 0,
>  	PMU_CLK_CORE_SRC_GATE_EN,
