From: dianders@chromium.org (Doug Anderson)
Date: Wed, 5 Aug 2015 18:54:06 -0700
Subject: [PATCH v3 2/3] ARM: rockchip: set correct stabilization
 thresholds in suspend
In-Reply-To: <1709899.JJDRtF09u7@diego>
References: <2128609.Kb18M8K28F@diego>
	<1709899.JJDRtF09u7@diego>
Message-ID: <CAD=FV=VWehNnr-NaZy=m7p-ciXi1ACpwb0Wr2nDLSrjvZT-oUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko,

On Tue, Aug 4, 2015 at 3:51 PM, Heiko St?bner <heiko@sntech.de> wrote:
> Currently the stabilization thresholds for the oscillator and external pmu
> are statically set to 30ms based on a 32kHz clock rate. This leaves out the
> case when we don't switch to the 32kHz clock when only entering the shallow
> suspend mode where the logic keeps running.
>
> So, set the correct threshold after we have determined if we switch to the
> 32kHz clock or stay with the 24MHz one. Also set the oscillator-
> stabilization to 0 if it is kept running during suspend, as it of course
> does not need to stabilize then.
>
> Reported-by: Chris Zhong <zyw@rock-chips.com>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
> changes since v2:
> - describe 32kHz vs 24MHz
> - don't wait for oscillator stabilization if it's still running,
>   as explained by Chris Zhong in v2
> changes since v1:
> - 24MHz oriented threshold is only needed in shallow suspend, the deep
>   suspend always switches to 32kHz and only leaves the 24MHz oscillator
>   running if needed for stuff like usb wakeup
>
>  arch/arm/mach-rockchip/pm.c | 22 +++++++++++++++++++---
>  arch/arm/mach-rockchip/pm.h |  4 ----
>  2 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm/mach-rockchip/pm.c b/arch/arm/mach-rockchip/pm.c
> index 2ca1170..c11a30b 100644
> --- a/arch/arm/mach-rockchip/pm.c
> +++ b/arch/arm/mach-rockchip/pm.c
> @@ -145,6 +145,19 @@ static void rk3288_slp_mode_set(int level)
>
>                 mode_set1 |= BIT(PMU_CLR_ALIVE) | BIT(PMU_CLR_BUS) |
>                              BIT(PMU_CLR_PERI) | BIT(PMU_CLR_DMA);
> +
> +               /*
> +                * In deep suspend we use PMU_PMU_USE_LF to let the rk3288
> +                * switch its main clock supply to the alternative 32kHz
> +                * source. Therefore set 30ms on a 32kHz clock for pmic
> +                * stabilization. Similar 30ms on 24MHz for the other
> +                * mode below.
> +                */
> +               regmap_write(pmu_regmap, RK3288_PMU_STABL_CNT, 32 * 30);

Took me a little while to parse the comment, but it looks right.
Basically we need 30ms for PMIC stabilization both here and in the
other mode.  That is programmed as 32 * 30 here and 2400 * 30 there.
...and we know we're on 32k clock because of PMU_PMU_USE_LF.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
