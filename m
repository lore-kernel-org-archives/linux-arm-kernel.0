From: khilman@ti.com (Kevin Hilman)
Date: Wed, 04 May 2011 13:09:08 -0700
Subject: [PATCH 2/5] OMAP3: clean-up mach specific cpuidle data structures
In-Reply-To: <1304069186-3086-3-git-send-email-j-pihet@ti.com> (jean pihet's
	message of "Fri, 29 Apr 2011 11:26:23 +0200")
References: <1304069186-3086-1-git-send-email-j-pihet@ti.com>
	<1304069186-3086-3-git-send-email-j-pihet@ti.com>
Message-ID: <8762pqrzx7.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

jean.pihet at newoldbits.com writes:

> From: Jean Pihet <j-pihet@ti.com>
>
> - sleep_latency and wake_latency are not used, replace them by
>   exit_latency which is used by cpuidle. exit_latency simply is
>   the sum of sleep_latency and wake_latency,
> - replace threshold by target_residency,
> - changed the OMAP3 specific cpuidle code accordingly,
> - changed the OMAP3 board code accordingly.
>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>

One minor comment...

> ---
>  arch/arm/mach-omap2/board-rx51.c  |   15 +++---
>  arch/arm/mach-omap2/cpuidle34xx.c |  103 +++++++++++++++---------------------
>  arch/arm/mach-omap2/pm.h          |   13 +++--
>  3 files changed, 60 insertions(+), 71 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-rx51.c b/arch/arm/mach-omap2/board-rx51.c
> index f8ba20a..44656e8 100644
> --- a/arch/arm/mach-omap2/board-rx51.c
> +++ b/arch/arm/mach-omap2/board-rx51.c
> @@ -58,21 +58,22 @@ static struct platform_device leds_gpio = {
>  	},
>  };
>  
> +/* cpuidle C-states definition override from the default values */

Please add a line here describing the sum in the table entries
(e.g. it's sleep + wakeup latency.)

>  static struct cpuidle_params rx51_cpuidle_params[] = {
>  	/* C1 */
> -	{1, 110, 162, 5},
> +	{110 + 162, 5 , 1},
>  	/* C2 */
> -	{1, 106, 180, 309},
> +	{106 + 180, 309, 1},
>  	/* C3 */
> -	{0, 107, 410, 46057},
> +	{107 + 410, 46057, 0},
>  	/* C4 */
> -	{0, 121, 3374, 46057},
> +	{121 + 3374, 46057, 0},
>  	/* C5 */
> -	{1, 855, 1146, 46057},
> +	{855 + 1146, 46057, 1},
>  	/* C6 */
> -	{0, 7580, 4134, 484329},
> +	{7580 + 4134, 484329, 0},
>  	/* C7 */
> -	{1, 7505, 15274, 484329},
> +	{7505 + 15274, 484329, 1},
>  };

Kevin
