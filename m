From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 17 Sep 2015 16:44:24 +0800
Subject: [PATCH v2] arm: add cpu_idle tracepoints to arch_cpu_idle
In-Reply-To: <20150917160744.52400e0e@xhacker>
References: <1442424760-4104-1-git-send-email-jszhang@marvell.com>
 <20150917160744.52400e0e@xhacker>
Message-ID: <20150917164424.513801a6@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Steven,

On Thu, 17 Sep 2015 16:07:44 +0800
Jisheng Zhang <jszhang@marvell.com> wrote:

> Dear all,
> 
> On Thu, 17 Sep 2015 01:32:40 +0800
> Jisheng Zhang <jszhang@marvell.com> wrote:
> 
> > Currently, if cpuidle is disabled or not supported, powertop reports
> > zero wakeups and zero events. This is due to the cpu_idle tracepoints
> > are missing.
> > 
> > This patch is to make cpu_idle tracepoints always available even if
> > cpuidle is disabled or not supported.
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
> > ---
> >  Since v1:
> >    - ignore arm_pm_idle.
> 
> Something related: let's have a look at arch/arm/mach-omap2/pm34xx.c
> the omap3_pm_idle(void) function, it uses trace_cpu_idle(), should we
> use the _rcuidle version as below:

484546509ce5 ("x86/tracing: Denote the power and cpuidle tracepoints as
_rcuidle()") make me think we need to fix omap3_pm_idle, right?

Thanks,
Jisheng

> 
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 87b98bf9..b3bc972 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -301,11 +301,11 @@ static void omap3_pm_idle(void)
>  	if (omap_irq_pending())
>  		return;
>  
> -	trace_cpu_idle(1, smp_processor_id());
> +	trace_cpu_rcuidle(1, smp_processor_id());
>  
>  	omap_sram_idle();
>  
> -	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
> +	trace_cpu_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
>  }
>  
>  #ifdef CONFIG_SUSPEND
> 
> 
> 
> >  arch/arm/kernel/process.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> > index 7a7c4ce..83d2dc5 100644
> > --- a/arch/arm/kernel/process.c
> > +++ b/arch/arm/kernel/process.c
> > @@ -28,6 +28,7 @@
> >  #include <linux/random.h>
> >  #include <linux/hw_breakpoint.h>
> >  #include <linux/leds.h>
> > +#include <trace/events/power.h>
> >  
> >  #include <asm/processor.h>
> >  #include <asm/thread_notify.h>
> > @@ -66,11 +67,15 @@ void (*arm_pm_idle)(void);
> >  
> >  void arch_cpu_idle(void)
> >  {
> > -	if (arm_pm_idle)
> > +	if (arm_pm_idle) {
> >  		arm_pm_idle();
> > -	else
> > +		local_irq_enable();
> > +	} else {
> > +		trace_cpu_idle_rcuidle(1, smp_processor_id());
> >  		cpu_do_idle();
> > -	local_irq_enable();
> > +		local_irq_enable();
> > +		trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
> > +	}
> >  }
> >  
> >  void arch_cpu_idle_prepare(void)
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
