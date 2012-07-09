From: tony@atomide.com (Tony Lindgren)
Date: Mon, 9 Jul 2012 06:15:49 -0700
Subject: [PATCH 2/2] ARM: OMAP4: Add local timer support for Device Tree
In-Reply-To: <1341839470-5586-3-git-send-email-santosh.shilimkar@ti.com>
References: <1341839470-5586-1-git-send-email-santosh.shilimkar@ti.com>
 <1341839470-5586-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20120709131549.GI1122@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120709 06:16]:
> Add cortex-a9 local timer  support for all OMAP4 based
> SOCs using DT.
...

> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -36,6 +36,7 @@
>  #include <linux/clocksource.h>
>  #include <linux/clockchips.h>
>  #include <linux/slab.h>
> +#include <linux/of.h>
>  
>  #include <asm/mach/time.h>
>  #include <plat/dmtimer.h>
> @@ -384,9 +385,13 @@ static void __init omap4_timer_init(void)
>  	if (omap_rev() != OMAP4430_REV_ES1_0) {
>  		int err;
>  
> -		err = twd_local_timer_register(&twd_local_timer);
> -		if (err)
> -			pr_err("twd_local_timer_register failed %d\n", err);
> +		if (of_have_populated_dt()) {
> +			twd_local_timer_of_register();
> +		} else {
> +			err = twd_local_timer_register(&twd_local_timer);
> +			if (err)
> +				pr_err("twd_local_timer_register failed %d\n", err);
> +		}
>  	}
>  #endif
>  }

How about just return after twd_local_timer_of_register() instead?
That avoids nesting the code further.

Tony
