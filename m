From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 25 Mar 2016 12:52:45 +0100
Subject: [PATCH 2/2] ARM: cpuidle: make arm_cpuidle_suspend() a bit more
 efficient
In-Reply-To: <1458796269-6158-3-git-send-email-jszhang@marvell.com>
References: <1458796269-6158-1-git-send-email-jszhang@marvell.com>
 <1458796269-6158-3-git-send-email-jszhang@marvell.com>
Message-ID: <56F5268D.70000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/24/2016 06:11 AM, Jisheng Zhang wrote:
> Currently, we check cpuidle_ops.suspend every time when entering a
> low-power idle state. But this check could be avoided in this hot path
> by moving it into arm_cpuidle_init() to reduce arm_cpuidle_suspend()
> overhead a bit.
>
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>   arch/arm/kernel/cpuidle.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> index f108d8f..bf68d49 100644
> --- a/arch/arm/kernel/cpuidle.c
> +++ b/arch/arm/kernel/cpuidle.c
> @@ -52,13 +52,9 @@ int arm_cpuidle_simple_enter(struct cpuidle_device *dev,
>    */
>   int arm_cpuidle_suspend(int index)
>   {
> -	int ret = -EOPNOTSUPP;
>   	int cpu = smp_processor_id();
>
> -	if (cpuidle_ops[cpu].suspend)
> -		ret = cpuidle_ops[cpu].suspend(index);
> -
> -	return ret;
> +	return cpuidle_ops[cpu].suspend(index);
>   }

I agree with the optimization but, same comment than the previous patch, 
it should be handled in arm_cpuidle_read_ops.

-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
