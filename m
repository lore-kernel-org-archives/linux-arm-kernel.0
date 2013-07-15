From: konrad.wilk@oracle.com (Konrad Rzeszutek Wilk)
Date: Mon, 15 Jul 2013 11:25:32 -0400
Subject: [Xen-devel] [PATCH] xen/arm: disable cpuidle when linux is
 running as dom0
In-Reply-To: <1373898101-15633-1-git-send-email-julien.grall@linaro.org>
References: <1373898101-15633-1-git-send-email-julien.grall@linaro.org>
Message-ID: <20130715152532.GC5774@phenom.dumpdata.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 15, 2013 at 03:21:41PM +0100, Julien Grall wrote:
> When linux is running as dom0, Xen doesn't show the physical cpu but a
> virtual CPU.
> On some ARM SOC (for instance the exynos 5250), linux registers callbacks
> for cpuidle. When these callbacks are called, they will modify
> directly the physical cpu not the virtual one. It can impact the whole board
> instead of dom0.

Should you also call disable_cpufreq() ?

> 
> Signed-off-by: Julien Grall <julien.grall@linaro.org>
> ---
>  arch/arm/xen/enlighten.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 49839d8..a98999f 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -24,6 +24,8 @@
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
> +#include <linux/cpuidle.h>
> +#include <linux/cpufreq.h>
>  
>  #include <linux/mm.h>
>  
> @@ -292,6 +294,11 @@ static int __init xen_pm_init(void)
>  {
>  	pm_power_off = xen_power_off;
>  	arm_pm_restart = xen_restart;
> +	/*
> +	 * Making sure board specific code will not set up ops for
> +	 * cpu idle.
> +	 */
> +	disable_cpuidle();
>  
>  	return 0;
>  }
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel at lists.xen.org
> http://lists.xen.org/xen-devel
