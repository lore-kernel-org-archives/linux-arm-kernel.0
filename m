From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 17 Oct 2014 08:35:05 +0900
Subject: [PATCH v2 2/2] ARM: EXYNOS: Call regulator core suspend prepare
 and finish functions
In-Reply-To: <1413454410-23396-3-git-send-email-javier.martinez@collabora.co.uk>
References: <1413454410-23396-1-git-send-email-javier.martinez@collabora.co.uk>
 <1413454410-23396-3-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <54405629.2090702@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On 10/16/2014 07:13 PM, Javier Martinez Canillas wrote:
> The regulator framework has a set of helpers functions to be used when
> the system is entering and leaving from suspend but these are not called
> on Exynos platforms. This means that the .set_suspend_* function handlers
> defined by regulator drivers are not called when the system is suspended.
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  arch/arm/mach-exynos/suspend.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
> index cc8d237..ee9a8e0 100644
> --- a/arch/arm/mach-exynos/suspend.c
> +++ b/arch/arm/mach-exynos/suspend.c
> @@ -20,6 +20,7 @@
>  #include <linux/io.h>
>  #include <linux/irqchip/arm-gic.h>
>  #include <linux/err.h>
> +#include <linux/regulator/machine.h>
>  
>  #include <asm/cacheflush.h>
>  #include <asm/hardware/cache-l2x0.h>
> @@ -443,6 +444,22 @@ static int exynos_suspend_enter(suspend_state_t state)
>  
>  static int exynos_suspend_prepare(void)
>  {
> +	int ret;
> +
> +	/*
> +	 * REVISIT: It would be better if struct platform_suspend_ops
> +	 * .prepare handler get the suspend_state_t as a parameter to
> +	 * avoid hard-coding the suspend to mem state. It's safe to do
> +	 * it now only because the suspend_valid_only_mem function is
> +	 * used as the .valid callback used to check if a given state
> +	 * is supported by the platform anyways.
> +	 */
> +	ret = regulator_suspend_prepare(PM_SUSPEND_MEM);
> +	if (ret) {
> +		pr_err("Failed to prepare regulators for system suspend\n");
> +		return ret;
> +	}
> +
>  	s3c_pm_check_prepare();
>  
>  	return 0;
> @@ -451,6 +468,7 @@ static int exynos_suspend_prepare(void)
>  static void exynos_suspend_finish(void)
>  {
>  	s3c_pm_check_cleanup();
> +	regulator_suspend_finish();
>  }
>  
>  static const struct platform_suspend_ops exynos_suspend_ops = {
> 

Looks good to me.

Reviewed-by: Chanwoo Choi<cw00.choi@samsung.com>

Thanks,
Chanwoo Choi
