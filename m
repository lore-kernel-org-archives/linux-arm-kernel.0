From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Tue, 7 May 2013 10:17:50 +0100
Subject: [Xen-devel] [PATCH RFC v2 4/4] xen/arm: account for stolen ticks
In-Reply-To: <1367851878-21629-4-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1305061532310.4756@kaball.uk.xensource.com>
 <1367851878-21629-4-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1367918270.26321.39.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2013-05-06 at 15:51 +0100, Stefano Stabellini wrote:
> Register the runstate_memory_area with the hypervisor.
> Use pv_time_ops.steal_clock to account for stolen ticks.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> ---
>  arch/arm/xen/enlighten.c |   23 +++++++++++++++++++++++
>  1 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index ee86bfa..2a5cc82 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -14,7 +14,10 @@
>  #include <xen/xen-ops.h>
>  #include <asm/xen/hypervisor.h>
>  #include <asm/xen/hypercall.h>
> +#include <asm/arch_timer.h>
>  #include <asm/system_misc.h>
> +#include <asm/paravirt.h>
> +#include <linux/jump_label.h>
>  #include <linux/interrupt.h>
>  #include <linux/irqreturn.h>
>  #include <linux/module.h>
> @@ -152,6 +155,20 @@ int xen_unmap_domain_mfn_range(struct vm_area_struct *vma,
>  }
>  EXPORT_SYMBOL_GPL(xen_unmap_domain_mfn_range);
>  
> +unsigned long long xen_stolen_accounting(int cpu)
> +{
> +	struct vcpu_runstate_info state;
> +
> +	if (cpu != get_cpu())

get_cpu disables preempt, so you need a matching put_cpu.

But actually I think you just want smp_processor_id and you probably
want the BUG_ON form to get unlikely etc.

That said, you don't use cpu for anything else, so why not drop it
entirely?

> +		BUG();
> +
> +	xen_get_runstate_snapshot(&state);
> +
> +	WARN_ON(state.state != RUNSTATE_running);
> +
> +	return state.time[RUNSTATE_runnable] + state.time[RUNSTATE_offline];
> +}
> +
>  static void __init xen_percpu_init(void *unused)
>  {
>  	struct vcpu_register_vcpu_info info;
> @@ -170,6 +187,8 @@ static void __init xen_percpu_init(void *unused)
>  		BUG();
>  	per_cpu(xen_vcpu, cpu) = vcpup;
>  
> +	xen_setup_runstate_info(cpu);
> +
>  	enable_percpu_irq(xen_events_irq, 0);
>  }
>  
> @@ -301,6 +320,10 @@ static int __init xen_init_events(void)
>  
>  	on_each_cpu(xen_percpu_init, NULL, 0);
>  
> +	pv_time_ops.steal_clock = xen_stolen_accounting;
> +	static_key_slow_inc(&paravirt_steal_enabled);
> +	static_key_slow_inc(&paravirt_steal_rq_enabled);

We don't seem to do this on x86 -- is that a bug on x86 on Xen?

> +
>  	return 0;
>  }
>  postcore_initcall(xen_init_events);
