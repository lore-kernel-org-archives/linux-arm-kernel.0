From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 16 Sep 2015 17:28:18 +0100
Subject: [PATCH] arm: add cpu_idle tracepoints to arch_cpu_idle
In-Reply-To: <1442414220-7204-1-git-send-email-jszhang@marvell.com>
References: <1442414220-7204-1-git-send-email-jszhang@marvell.com>
Message-ID: <20150916162817.GC21084@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 10:37:00PM +0800, Jisheng Zhang wrote:
> Currently, if cpuidle is disabled or not supported, powertop reports
> zero wakeups and zero events. This is due to the cpu_idle tracepoints
> are missing.
> 
> This patch is to make cpu_idle tracepoints always available even if
> cpuidle is disabled or not supported.

This seems like a hack to me.  These are cpu_idle tracepoints which
tell people when something happens in cpuidle.  If cpuidle is disabled,
then surely the tracepoints shouldn't fire.

However, I'll leave it to the tracing people to have the final word on
whether this is the right thing to do as I've very little experience
with the tracing design.

> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> ---
>  arch/arm/kernel/process.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index f192a2a..aa78e09 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -28,6 +28,7 @@
>  #include <linux/random.h>
>  #include <linux/hw_breakpoint.h>
>  #include <linux/leds.h>
> +#include <trace/events/power.h>
>  
>  #include <asm/processor.h>
>  #include <asm/thread_notify.h>
> @@ -66,11 +67,13 @@ void (*arm_pm_idle)(void);
>  
>  void arch_cpu_idle(void)
>  {
> +	trace_cpu_idle_rcuidle(1, smp_processor_id());
>  	if (arm_pm_idle)
>  		arm_pm_idle();
>  	else
>  		cpu_do_idle();
>  	local_irq_enable();
> +	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
>  }
>  
>  void arch_cpu_idle_prepare(void)
> -- 
> 2.5.1
> 

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
