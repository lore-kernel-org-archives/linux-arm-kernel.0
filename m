From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 21 May 2015 08:45:45 +0800
Subject: [PATCH] ARM: rockchip: restore dapswjdp after suspend
In-Reply-To: <1432154048-19126-1-git-send-email-dianders@chromium.org>
References: <1432154048-19126-1-git-send-email-dianders@chromium.org>
Message-ID: <555D2AB9.1020903@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug

Thank you for pointing out.

Reviewed-by: Chris Zhong <zyw@rock-chips.com>

On 05/21/2015 04:34 AM, Doug Anderson wrote:
> In the commit (0ea001d ARM: rockchip: disable dapswjdp during suspend)
> we made the assumption that we didn't need to restore dapswjdp after
> suspend because "the MASKROM will enable it back".
>
> It turns out that's not a safe assumption.  In some cases (pending
> interrupts) it's possible that the WFI might act as a no-op and the
> MaskROM will never run.  Since we're changing the bit, we should
> restore it ourselves.
>
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> ---
>   arch/arm/mach-rockchip/pm.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
> index b0dcbe2..a7be465 100644
> --- a/arch/arm/mach-rockchip/pm.c
> +++ b/arch/arm/mach-rockchip/pm.c
> @@ -48,6 +48,7 @@ static struct regmap *sgrf_regmap;
>   
>   static u32 rk3288_pmu_pwr_mode_con;
>   static u32 rk3288_sgrf_soc_con0;
> +static u32 rk3288_sgrf_cpu_con0;
>   
>   static inline u32 rk3288_l2_config(void)
>   {
> @@ -70,6 +71,7 @@ static void rk3288_slp_mode_set(int level)
>   {
>   	u32 mode_set, mode_set1;
>   
> +	regmap_read(sgrf_regmap, RK3288_SGRF_CPU_CON0, &rk3288_sgrf_cpu_con0);
>   	regmap_read(sgrf_regmap, RK3288_SGRF_SOC_CON0, &rk3288_sgrf_soc_con0);
>   
>   	regmap_read(pmu_regmap, RK3288_PMU_PWRMODE_CON,
> @@ -129,6 +131,9 @@ static void rk3288_slp_mode_set(int level)
>   
>   static void rk3288_slp_mode_set_resume(void)
>   {
> +	regmap_write(sgrf_regmap, RK3288_SGRF_CPU_CON0,
> +		     rk3288_sgrf_cpu_con0 | SGRF_DAPDEVICEEN_WRITE);
> +
>   	regmap_write(pmu_regmap, RK3288_PMU_PWRMODE_CON,
>   		     rk3288_pmu_pwr_mode_con);
>   
