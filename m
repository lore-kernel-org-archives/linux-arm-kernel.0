From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Oct 2013 11:20:46 +0200
Subject: [PATCH v2 12/13] arm64: kernel: add CPU idle call
In-Reply-To: <1381748590-14279-13-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1381748590-14279-13-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <525FABEE.9070100@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/14/2013 01:03 PM, Lorenzo Pieralisi wrote:
> When CPU idle is enabled, the architectural idle call should go through
> the idle subsystem to allow CPUs to enter idle states defined
> by the platform CPU idle back-end operations.
>
> This patch, mirroring other archs behaviour, adds the CPU idle call to the
> architectural arch_cpu_idle implementation for arm64.
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   arch/arm64/kernel/process.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index de17c89..50491ec 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -33,6 +33,7 @@
>   #include <linux/kallsyms.h>
>   #include <linux/init.h>
>   #include <linux/cpu.h>
> +#include <linux/cpuidle.h>
>   #include <linux/elfcore.h>
>   #include <linux/pm.h>
>   #include <linux/tick.h>
> @@ -98,8 +99,10 @@ void arch_cpu_idle(void)
>   	 * This should do all the clock switching and wait for interrupt
>   	 * tricks
>   	 */
> -	cpu_do_idle();
> -	local_irq_enable();
> +	if (cpuidle_idle_call()) {
> +		cpu_do_idle();
> +		local_irq_enable();
> +	}
>   }
>
>   #ifdef CONFIG_HOTPLUG_CPU
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
