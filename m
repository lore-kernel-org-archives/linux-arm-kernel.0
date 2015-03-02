From: heiko@sntech.de (Heiko Stuebner)
Date: Mon, 02 Mar 2015 21:50:13 +0100
Subject: [PATCH 2/2] ARM: rockchip: disable watchdog during suspend
In-Reply-To: <1423487543-10593-2-git-send-email-zyw@rock-chips.com>
References: <1423487543-10593-1-git-send-email-zyw@rock-chips.com>
 <1423487543-10593-2-git-send-email-zyw@rock-chips.com>
Message-ID: <19262192.YHbflRWDXo@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

Am Montag, 9. Februar 2015, 21:12:23 schrieb Chris Zhong:
> The watchdog clock should be disable in dw_wdt_suspend, but we set a
> dummy clock to watchdog for rk3288. So the watchdog will continue to
> work during suspend. And we switch the system clock to 32khz from 24Mhz,
> during suspend, so the watchdog timer over count will increase to
> 755 times, about 12.5 hours, the original value is 60 seconds. So
> watchdog will reset the system over a night,  but voltage are all
> incorrect, then it hang on reset.
> 
> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Daniel Kurtz <djkurtz@google.com>

The SGRF is not writeable in all bootmodes (I've talked with Doug about this 
to verify I remembered this correctly), so handling the sgrf gate for the 
watchdog is not safe for all possible boards.

Why not simply turn off the watchdog in the driver during suspend?


Heiko

> 
> ---
> 
>  arch/arm/mach-rockchip/pm.c | 11 ++++++++---
>  arch/arm/mach-rockchip/pm.h |  2 ++
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
> index a3ab397..b07d886 100644
> --- a/arch/arm/mach-rockchip/pm.c
> +++ b/arch/arm/mach-rockchip/pm.c
> @@ -75,9 +75,13 @@ static void rk3288_slp_mode_set(int level)
>  	regmap_read(pmu_regmap, RK3288_PMU_PWRMODE_CON,
>  		    &rk3288_pmu_pwr_mode_con);
> 
> -	/* set bit 8 so that system will resume to FAST_BOOT_ADDR */
> +	/*
> +	 * SGRF_FAST_BOOT_EN - system to boot from FAST_BOOT_ADDR
> +	 * PCLK_WDT_GATE - disable WDT during suspend.
> +	 */
>  	regmap_write(sgrf_regmap, RK3288_SGRF_SOC_CON0,
> -		     SGRF_FAST_BOOT_EN | SGRF_FAST_BOOT_EN_WRITE);
> +		     SGRF_PCLK_WDT_GATE | SGRF_FAST_BOOT_EN
> +		     | SGRF_PCLK_WDT_GATE_WRITE | SGRF_FAST_BOOT_EN_WRITE);
> 
>  	/* booting address of resuming system is from this register value */
>  	regmap_write(sgrf_regmap, RK3288_SGRF_FAST_BOOT_ADDR,
> @@ -122,7 +126,8 @@ static void rk3288_slp_mode_set_resume(void)
>  		     rk3288_pmu_pwr_mode_con);
> 
>  	regmap_write(sgrf_regmap, RK3288_SGRF_SOC_CON0,
> -		     rk3288_sgrf_soc_con0 | SGRF_FAST_BOOT_EN_WRITE);
> +		     rk3288_sgrf_soc_con0 | SGRF_PCLK_WDT_GATE_WRITE
> +		     | SGRF_FAST_BOOT_EN_WRITE);
>  }
> 
>  static int rockchip_lpmode_enter(unsigned long arg)
> diff --git a/arch/arm/mach-rockchip/pm.h b/arch/arm/mach-rockchip/pm.h
> index 96beaa0..d463978 100644
> --- a/arch/arm/mach-rockchip/pm.h
> +++ b/arch/arm/mach-rockchip/pm.h
> @@ -44,6 +44,8 @@ void __init rockchip_suspend_init(void);
> 
>  #define RK3288_SGRF_SOC_CON0		(0x0000)
>  #define RK3288_SGRF_FAST_BOOT_ADDR	(0x0120)
> +#define SGRF_PCLK_WDT_GATE		BIT(6)
> +#define SGRF_PCLK_WDT_GATE_WRITE	BIT(22)
>  #define SGRF_FAST_BOOT_EN		BIT(8)
>  #define SGRF_FAST_BOOT_EN_WRITE		BIT(24)
