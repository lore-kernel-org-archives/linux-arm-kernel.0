From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 7 Dec 2010 22:22:18 +0100
Subject: [PATCH] OMAP2+: PM/serial: fix console semaphore acquire during
	suspend
In-Reply-To: <1291755056-23860-1-git-send-email-khilman@deeprootsystems.com>
References: <1291755056-23860-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <AANLkTinTT0LmMRvZbhnS2-9VTUy0yBDZ_gR=nN+nskKm@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 7, 2010 at 9:50 PM, Kevin Hilman
<khilman@deeprootsystems.com> wrote:
> commit 0d8e2d0dad98a693bad88aea6876ac8b94ad95c6 (OMAP2+: PM/serial:
> hold console semaphore while OMAP UARTs are disabled) added use of the
> console semaphore to protect UARTs from being accessed after disabled
> during idle, but this causes problems in suspend.
>
> During suspend, the console semaphore is already held by the time we reach
> the OMAP suspend path, so the try_acquire_console_sem() will always fail and
> suspend will be aborted.
>
> To fix, introduce a check so the console semaphore is only attempted
> during idle, and not during suspend.
>
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Tested OK on Beagleboard with suspend and idle with RET and OFF modes

Tested-by: Jean Pihet <j-pihet@ti.com>

Thanks,
Jean

> ---
> Applies to Tony's omap-fixes branch.
>
> ?arch/arm/mach-omap2/pm34xx.c | ? 24 ++++++++++++++++++------
> ?1 files changed, 18 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 0ec8a04..122ef3c 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -50,6 +50,19 @@
> ?#include "sdrc.h"
> ?#include "control.h"
>
> +#ifdef CONFIG_SUSPEND
> +static suspend_state_t suspend_state = PM_SUSPEND_ON;
> +static inline bool is_suspending(void)
> +{
> + ? ? ? return (suspend_state != PM_SUSPEND_ON);
> +}
> +#else
> +static inline bool is_suspending(void)
> +{
> + ? ? ? return false;
> +}
> +#endif
> +
> ?/* Scratchpad offsets */
> ?#define OMAP343X_TABLE_ADDRESS_OFFSET ? ? 0xc4
> ?#define OMAP343X_TABLE_VALUE_OFFSET ? ? ? 0xc0
> @@ -387,10 +400,11 @@ void omap_sram_idle(void)
> ? ? ? ?}
>
> ? ? ? ?/* Block console output in case it is on one of the OMAP UARTs */
> - ? ? ? if (per_next_state < PWRDM_POWER_ON ||
> - ? ? ? ? ? core_next_state < PWRDM_POWER_ON)
> - ? ? ? ? ? ? ? if (try_acquire_console_sem())
> - ? ? ? ? ? ? ? ? ? ? ? goto console_still_active;
> + ? ? ? if (!is_suspending())
> + ? ? ? ? ? ? ? if (per_next_state < PWRDM_POWER_ON ||
> + ? ? ? ? ? ? ? ? ? core_next_state < PWRDM_POWER_ON)
> + ? ? ? ? ? ? ? ? ? ? ? if (try_acquire_console_sem())
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? goto console_still_active;
>
> ? ? ? ?/* PER */
> ? ? ? ?if (per_next_state < PWRDM_POWER_ON) {
> @@ -514,8 +528,6 @@ out:
> ?}
>
> ?#ifdef CONFIG_SUSPEND
> -static suspend_state_t suspend_state;
> -
> ?static int omap3_pm_prepare(void)
> ?{
> ? ? ? ?disable_hlt();
> --
> 1.7.2.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
