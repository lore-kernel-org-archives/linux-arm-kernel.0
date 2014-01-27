From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 27 Jan 2014 09:32:19 +0100
Subject: [PATCH 4/9] idle: move the cpuidle entry point to the generic
 idle loop
In-Reply-To: <1390802904-28399-5-git-send-email-nicolas.pitre@linaro.org>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-5-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <52E61993.2090705@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/27/2014 07:08 AM, Nicolas Pitre wrote:
> In order to integrate cpuidle with the scheduler, we must have a better
> proximity in the core code with what cpuidle is doing and not delegate
> such interaction to arch code.
>
> Architectures implementing arch_cpu_idle() should simply enter
> a cheap idle mode in the absence of a proper cpuidle driver.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>

This patch without the next ones will lead to an extra call to 
cpuidle_idle_call.

	cpuidle_idle_call
		arch_cpu_idle
			cpuidle_idle_call
				x86_idle

But I guess it is acceptable as it is fixed with the next patches of the 
serie.

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   kernel/cpu/idle.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/cpu/idle.c b/kernel/cpu/idle.c
> index 4e327e211b..a6f40ad9f8 100644
> --- a/kernel/cpu/idle.c
> +++ b/kernel/cpu/idle.c
> @@ -3,6 +3,7 @@
>    */
>   #include <linux/sched.h>
>   #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>   #include <linux/tick.h>
>   #include <linux/mm.h>
>   #include <linux/stackprotector.h>
> @@ -94,7 +95,8 @@ static void cpu_idle_loop(void)
>   				if (!current_clr_polling_and_test()) {
>   					stop_critical_timings();
>   					rcu_idle_enter();
> -					arch_cpu_idle();
> +					if (cpuidle_idle_call())
> +						arch_cpu_idle();
>   					WARN_ON_ONCE(irqs_disabled());
>   					rcu_idle_exit();
>   					start_critical_timings();
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
