From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 26 Mar 2013 15:25:01 +0800
Subject: [PATCH 05/15] cpuidle: imx6: remove timer broadcast initialization
In-Reply-To: <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org>
 <1364234140-514-6-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <20130326072458.GA7141@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 25, 2013 at 06:55:30PM +0100, Daniel Lezcano wrote:
> The initialization is done from the cpuidle framework.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  arch/arm/mach-imx/cpuidle-imx6q.c |   15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
> index 5ae22f7..a783a63 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6q.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6q.c
> @@ -6,7 +6,6 @@
>   * published by the Free Software Foundation.
>   */
>  
> -#include <linux/clockchips.h>

Removing this causes the compile error below.

  CC      arch/arm/mach-imx/cpuidle-imx6q.o
arch/arm/mach-imx/cpuidle-imx6q.c: In function ?imx6q_enter_wait?:
arch/arm/mach-imx/cpuidle-imx6q.c:25:2: error: implicit declaration of function ?clockevents_notify? [-Werror=implicit-function-declaration]
arch/arm/mach-imx/cpuidle-imx6q.c:25:21: error: ?CLOCK_EVT_NOTIFY_BROADCAST_ENTER? undeclared (first use in this function)
arch/arm/mach-imx/cpuidle-imx6q.c:25:21: note: each undeclared identifier is reported only once for each function it appears in
arch/arm/mach-imx/cpuidle-imx6q.c:45:21: error: ?CLOCK_EVT_NOTIFY_BROADCAST_EXIT? undeclared (first use in this function)
cc1: some warnings being treated as errors
make[2]: *** [arch/arm/mach-imx/cpuidle-imx6q.o] Error 1

Shawn

>  #include <linux/cpuidle.h>
>  #include <linux/module.h>
>  #include <asm/cpuidle.h>
> @@ -43,17 +42,6 @@ done:
>  	return index;
>  }
>  
> -/*
> - * For each cpu, setup the broadcast timer because local timer
> - * stops for the states other than WFI.
> - */
> -static void imx6q_setup_broadcast_timer(void *arg)
> -{
> -	int cpu = smp_processor_id();
> -
> -	clockevents_notify(CLOCK_EVT_NOTIFY_BROADCAST_ON, &cpu);
> -}
> -
>  static struct cpuidle_driver imx6q_cpuidle_driver = {
>  	.name = "imx6q_cpuidle",
>  	.owner = THIS_MODULE,
> @@ -84,8 +72,5 @@ int __init imx6q_cpuidle_init(void)
>  	/* Set chicken bit to get a reliable WAIT mode support */
>  	imx6q_set_chicken_bit();
>  
> -	/* Configure the broadcast timer on each cpu */
> -	on_each_cpu(imx6q_setup_broadcast_timer, NULL, 1);
> -
>  	return imx_cpuidle_init(&imx6q_cpuidle_driver);
>  }
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
