From: jan.kiszka@siemens.com (Jan Kiszka)
Date: Thu, 1 Mar 2018 07:04:17 +0100
Subject: [PATCH] arm: Initialize hrtimer-based broadcast clockevent
In-Reply-To: <86a7e675-11bd-3b8b-22a0-8f440db96293@siemens.com>
References: <86a7e675-11bd-3b8b-22a0-8f440db96293@siemens.com>
Message-ID: <8f2fd3b9-416a-992e-5ca6-fc83aad5700d@siemens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-01-22 07:06, Jan Kiszka wrote:
> Analogously to 9358d755bd5c, this registers a broadcast clockevent in
> case no hardware broadcast timer is available and the per-CPU timers can
> be stopped in deep power states.
> 
> Partitions of the Jailhouse hypervisor fall in this category.
> Registering the workaround timer allows to enter high-resolution mode in
> that case.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  arch/arm/kernel/time.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
> index 629f8e9981f1..0a45d861ef8e 100644
> --- a/arch/arm/kernel/time.c
> +++ b/arch/arm/kernel/time.c
> @@ -12,6 +12,7 @@
>   *  reading the RTC at bootup, etc...
>   */
>  #include <linux/clk-provider.h>
> +#include <linux/clockchips.h>
>  #include <linux/clocksource.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> @@ -121,5 +122,7 @@ void __init time_init(void)
>  		of_clk_init(NULL);
>  #endif
>  		timer_probe();
> +
> +		tick_setup_hrtimer_broadcast();
>  	}
>  }
> 

Gentle ping, just to avoid that this falls through the cracks because
it's so small.

Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
