From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Fri, 23 Mar 2012 13:22:32 +0100
Subject: [RFC][PATCH 3/9] ARM: OMAP3: cpuidle - set enable_off_mode as
 static
In-Reply-To: <1332494794-7810-3-git-send-email-daniel.lezcano@linaro.org>
References: <1332494794-7810-1-git-send-email-daniel.lezcano@linaro.org>
 <1332494794-7810-3-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAORVsuVBC2TgVyt-PFWV878mXpM1GqETQnzdVi0ZYH-2x8D4nQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 10:26 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> This variable is only used in the pm-debug.c file.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
> ?arch/arm/mach-omap2/pm-debug.c | ? ?2 +-
> ?arch/arm/mach-omap2/pm.h ? ? ? | ? 30 ++++++++++++------------------
> ?2 files changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 814bcd9..86aa398 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -38,7 +38,7 @@
> ?#include "prm2xxx_3xxx.h"
> ?#include "pm.h"
>
> -u32 enable_off_mode;
> +static u32 enable_off_mode;
It is stil needed in cpuidle34xx.c.

>
> ?#ifdef CONFIG_DEBUG_FS
> ?#include <linux/debugfs.h>
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index af73a86..f5c3072 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -25,6 +25,18 @@ extern int omap4_idle_init(void);
> ?extern int omap_pm_clkdms_setup(struct clockdomain *clkdm, void *unused);
> ?extern int (*omap_pm_suspend)(void);
>
> +/*
> + * cpuidle mach specific parameters
> + *
> + * The board code can override the default C-states definition using
> + * omap3_pm_init_cpuidle
> + */
> +struct cpuidle_params {
> + ? ? ? u32 exit_latency; ? ? ? /* exit_latency = sleep + wake-up latencies */
> + ? ? ? u32 target_residency;
> + ? ? ? u8 valid; ? ? ? ? ? ? ? /* validates the C-state */
> +};
> +
Is this move needed? This will be removed in a later patch.

> ?#if defined(CONFIG_PM_OPP)
> ?extern int omap3_opp_init(void);
> ?extern int omap4_opp_init(void);
> @@ -39,27 +51,9 @@ static inline int omap4_opp_init(void)
> ?}
> ?#endif
>
> -/*
> - * cpuidle mach specific parameters
> - *
> - * The board code can override the default C-states definition using
> - * omap3_pm_init_cpuidle
> - */
> -struct cpuidle_params {
> - ? ? ? u32 exit_latency; ? ? ? /* exit_latency = sleep + wake-up latencies */
> - ? ? ? u32 target_residency;
> - ? ? ? u8 valid; ? ? ? ? ? ? ? /* validates the C-state */
> -};
> -
> ?extern int omap3_pm_get_suspend_state(struct powerdomain *pwrdm);
> ?extern int omap3_pm_set_suspend_state(struct powerdomain *pwrdm, int state);
>
> -#ifdef CONFIG_PM_DEBUG
> -extern u32 enable_off_mode;
> -#else
> -#define enable_off_mode 0
> -#endif
> -
> ?#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> ?extern void pm_dbg_update_time(struct powerdomain *pwrdm, int prev);
> ?#else
> --
> 1.7.5.4
>

Jean
