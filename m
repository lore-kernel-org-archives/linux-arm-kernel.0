From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 19 Nov 2015 14:10:50 -0800
Subject: [PATCH RFC 13/27] ARM: cpuidle: Add runtime PM support for CPU
 idle
In-Reply-To: <1447799871-56374-14-git-send-email-lina.iyer@linaro.org> (Lina
 Iyer's message of "Tue, 17 Nov 2015 15:37:37 -0700")
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
 <1447799871-56374-14-git-send-email-lina.iyer@linaro.org>
Message-ID: <7hlh9ttzbp.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lina Iyer <lina.iyer@linaro.org> writes:

> Notify runtime PM when the CPU is going to be powered off in the idle
> state. This allows for runtime PM suspend/resume of the CPU as well as
> its PM domain.
>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/cpuidle/cpuidle-arm.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/cpuidle/cpuidle-arm.c b/drivers/cpuidle/cpuidle-arm.c
> index 545069d..8e72a23 100644
> --- a/drivers/cpuidle/cpuidle-arm.c
> +++ b/drivers/cpuidle/cpuidle-arm.c
> @@ -11,13 +11,16 @@
>  
>  #define pr_fmt(fmt) "CPUidle arm: " fmt
>  
> +#include <linux/cpu.h>
>  #include <linux/cpuidle.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> +#include <linux/rcupdate.h>
>  
>  #include <asm/cpuidle.h>
>  
> @@ -45,6 +48,10 @@ static int arm_enter_idle_state(struct cpuidle_device *dev,
>  
>  	ret = cpu_pm_enter();
>  	if (!ret) {
> +		struct device *cpu_dev = get_cpu_device(dev->cpu);
> +
> +		RCU_NONIDLE(pm_runtime_put_sync_suspend(cpu_dev));
> +

A comment in the changelog about the use of _put_sync_suspend() instead
of a normal _put_sync() would be helpful for this patch.

Kevin
