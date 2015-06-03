From: tony@atomide.com (Tony Lindgren)
Date: Wed, 3 Jun 2015 15:26:20 -0700
Subject: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
In-Reply-To: <1433363565-17725-1-git-send-email-balbi@ti.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
Message-ID: <20150603222619.GY30984@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150603 13:36]:
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -655,20 +655,18 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
>  static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
>  void __init omap4_local_timer_init(void)
>  {
> +	int err;
> +
>  	omap4_sync32k_timer_init();
>  	/* Local timers are not supprted on OMAP4430 ES1.0 */
> -	if (omap_rev() != OMAP4430_REV_ES1_0) {
> -		int err;
> -
> -		if (of_have_populated_dt()) {
> -			clocksource_of_init();
> -			return;
> -		}
> -
> -		err = twd_local_timer_register(&twd_local_timer);
> -		if (err)
> -			pr_err("twd_local_timer_register failed %d\n", err);
> +	if (of_have_populated_dt()) {
> +		clocksource_of_init();
> +		return;
>  	}
> +
> +	err = twd_local_timer_register(&twd_local_timer);
> +	if (err)
> +		pr_err("twd_local_timer_register failed %d\n", err);
>  }
>  #else
>  void __init omap4_local_timer_init(void)

Looks like can get rid of even more code here, see the patch below.

Regards,

Tony

8< ------------------------
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 3 Jun 2015 14:40:40 -0700
Subject: [PATCH] ARM: OMAP2+: Clean up omap4_local_timer_init

Inspired by a patch from Felipe Balbi <balbi@ti.com>, we can
now get rid of most the code in omap4_local_timer_init.

Omap4 is now device tree only.. And we have not properly supported
omap4 ES1.0 revision for a really long time AFAIK.

Let's just remove all that code to simplify things. This assumes
we have arm,cortex-a9-twd-timer entry in the omap4.dtsi file, which
we do.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -649,23 +649,10 @@ static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 
 #ifdef CONFIG_ARCH_OMAP4
 #ifdef CONFIG_HAVE_ARM_TWD
-static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, OMAP44XX_LOCAL_TWD_BASE, 29);
 void __init omap4_local_timer_init(void)
 {
 	omap4_sync32k_timer_init();
-	/* Local timers are not supprted on OMAP4430 ES1.0 */
-	if (omap_rev() != OMAP4430_REV_ES1_0) {
-		int err;
-
-		if (of_have_populated_dt()) {
-			clocksource_of_init();
-			return;
-		}
-
-		err = twd_local_timer_register(&twd_local_timer);
-		if (err)
-			pr_err("twd_local_timer_register failed %d\n", err);
-	}
+	clocksource_of_init();
 }
 #else
 void __init omap4_local_timer_init(void)
