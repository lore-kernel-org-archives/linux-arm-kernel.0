From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 16 Sep 2015 15:47:38 +0100
Subject: [PATCH] arm64: add cpu_idle tracepoints to arch_cpu_idle
In-Reply-To: <1442413401-2955-1-git-send-email-jszhang@marvell.com>
References: <1442413401-2955-1-git-send-email-jszhang@marvell.com>
Message-ID: <20150916144738.GA23245@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 03:23:21PM +0100, Jisheng Zhang wrote:
> Currently, if cpuidle is disabled or not supported, powertop reports
> zero wakeups and zero events. This is due to the cpu_idle tracepoints
> are missing.
> 
> This patch is to make cpu_idle tracepoints always available even if
> cpuidle is disabled or not supported.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Is there a reason why this code cannot be moved to the generic idle loop ?

Thanks,
Lorenzo

> ---
>  arch/arm64/kernel/process.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 223b093..f75b540 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -44,6 +44,7 @@
>  #include <linux/hw_breakpoint.h>
>  #include <linux/personality.h>
>  #include <linux/notifier.h>
> +#include <trace/events/power.h>
>  
>  #include <asm/compat.h>
>  #include <asm/cacheflush.h>
> @@ -75,8 +76,10 @@ void arch_cpu_idle(void)
>  	 * This should do all the clock switching and wait for interrupt
>  	 * tricks
>  	 */
> +	trace_cpu_idle_rcuidle(1, smp_processor_id());
>  	cpu_do_idle();
>  	local_irq_enable();
> +	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -- 
> 2.5.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
