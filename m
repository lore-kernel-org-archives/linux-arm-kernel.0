From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Sun, 21 Jul 2013 15:09:13 +0100
Subject: [PATCH v2] xen/arm: disable cpuidle and cpufreq when linux is
 running as dom0
In-Reply-To: <1374233220-13770-1-git-send-email-julien.grall@linaro.org>
References: <1374233220-13770-1-git-send-email-julien.grall@linaro.org>
Message-ID: <alpine.DEB.2.02.1307211508520.4893@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Jul 2013, Julien Grall wrote:
> When linux is running as dom0, Xen doesn't show the physical cpu but a
> virtual CPU.
> On some ARM SOC (for instance the exynos 5250), linux registers callbacks
> for cpuidle and cpufreq. When these callbacks are called, they will modify
> directly the physical cpu not the virtual one. It can impact the whole board
> instead of only dom0.
> 
> Signed-off-by: Julien Grall <julien.grall@linaro.org>
> 

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>     Changes in v2:
>         - Disable cpufreq
> ---
>  arch/arm/xen/enlighten.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 49839d8..af82792 100644
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
> @@ -292,6 +294,12 @@ static int __init xen_pm_init(void)
>  {
>  	pm_power_off = xen_power_off;
>  	arm_pm_restart = xen_restart;
> +	/*
> +	 * Making sure board specific code will not set up ops for
> +	 * cpu idle and cpu freq.
> +	 */
> +	disable_cpuidle();
> +	disable_cpufreq();
>  
>  	return 0;
>  }
> -- 
> 1.7.10.4
> 
