From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 27 Sep 2013 10:45:38 +0200
Subject: [PATCH 2/6] cpuidle: calxeda: add cpu_pm_enter/exit calls
In-Reply-To: <1380248694-13388-3-git-send-email-robherring2@gmail.com>
References: <1380248694-13388-1-git-send-email-robherring2@gmail.com>
 <1380248694-13388-3-git-send-email-robherring2@gmail.com>
Message-ID: <524545B2.7000608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 04:24 AM, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
>
> Wnen powergating the core, we need to call cpu pm notifiers to save VFP
> state (!SMP only) and resetting the breakpoint h/w.
>
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm at vger.kernel.org

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Shouldn't this patch be the first in the series ?

> ---
>   drivers/cpuidle/cpuidle-calxeda.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-calxeda.c b/drivers/cpuidle/cpuidle-calxeda.c
> index 01cfecf3..b04767a 100644
> --- a/drivers/cpuidle/cpuidle-calxeda.c
> +++ b/drivers/cpuidle/cpuidle-calxeda.c
> @@ -21,6 +21,7 @@
>    */
>
>   #include <linux/cpuidle.h>
> +#include <linux/cpu_pm.h>
>   #include <linux/init.h>
>   #include <linux/of.h>
>   #include <asm/cpuidle.h>
> @@ -39,7 +40,10 @@ static int calxeda_pwrdown_idle(struct cpuidle_device *dev,
>   				struct cpuidle_driver *drv,
>   				int index)
>   {
> +	cpu_pm_enter();
>   	cpu_suspend(0, calxeda_idle_finish);
> +	cpu_pm_exit();
> +
>   	return index;
>   }
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
