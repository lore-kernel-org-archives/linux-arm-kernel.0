From: sstabellini@kernel.org (Stefano Stabellini)
Date: Wed, 13 Jul 2016 19:21:51 +0100 (BST)
Subject: [patch V2 49/67] arm/xen: Convert to hotplug state machine
In-Reply-To: <20160713153336.971559670@linutronix.de>
References: <20160713153219.128052238@linutronix.de>
 <20160713153336.971559670@linutronix.de>
Message-ID: <alpine.DEB.2.10.1607131921350.26575@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 13 Jul 2016, Anna-Maria Gleixner wrote:
> From: Richard Cochran <rcochran@linutronix.de>
> 
> Install the callbacks via the state machine and let the core invoke
> the callbacks on the already online CPUs.
> 
> The get_cpu() in xen_starting_cpu() boils down to preempt_disable() since
> we already know the CPU we run on. Disabling preemption shouldn't be required
> here from what I see since it we don't switch CPUs while invoking the function.
> 
> Signed-off-by: Richard Cochran <rcochran@linutronix.de>
> Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: xen-devel at lists.xenproject.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


>  arch/arm/xen/enlighten.c   | 41 +++++++++++------------------------------
>  include/linux/cpuhotplug.h |  1 +
>  2 files changed, 12 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 75cd734..d822e23 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -161,12 +161,11 @@ static struct notifier_block xen_pvclock_gtod_notifier = {
>  	.notifier_call = xen_pvclock_gtod_notify,
>  };
>  
> -static void xen_percpu_init(void)
> +static int xen_starting_cpu(unsigned int cpu)
>  {
>  	struct vcpu_register_vcpu_info info;
>  	struct vcpu_info *vcpup;
>  	int err;
> -	int cpu = get_cpu();
>  
>  	/* 
>  	 * VCPUOP_register_vcpu_info cannot be called twice for the same
> @@ -190,7 +189,13 @@ static void xen_percpu_init(void)
>  
>  after_register_vcpu_info:
>  	enable_percpu_irq(xen_events_irq, 0);
> -	put_cpu();
> +	return 0;
> +}
> +
> +static int xen_dying_cpu(unsigned int cpu)
> +{
> +	disable_percpu_irq(xen_events_irq);
> +	return 0;
>  }
>  
>  static void xen_restart(enum reboot_mode reboot_mode, const char *cmd)
> @@ -209,28 +214,6 @@ static void xen_power_off(void)
>  	BUG_ON(rc);
>  }
>  
> -static int xen_cpu_notification(struct notifier_block *self,
> -				unsigned long action,
> -				void *hcpu)
> -{
> -	switch (action) {
> -	case CPU_STARTING:
> -		xen_percpu_init();
> -		break;
> -	case CPU_DYING:
> -		disable_percpu_irq(xen_events_irq);
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return NOTIFY_OK;
> -}
> -
> -static struct notifier_block xen_cpu_notifier = {
> -	.notifier_call = xen_cpu_notification,
> -};
> -
>  static irqreturn_t xen_arm_callback(int irq, void *arg)
>  {
>  	xen_hvm_evtchn_do_upcall();
> @@ -351,16 +334,14 @@ static int __init xen_guest_init(void)
>  		return -EINVAL;
>  	}
>  
> -	xen_percpu_init();
> -
> -	register_cpu_notifier(&xen_cpu_notifier);
> -
>  	pv_time_ops.steal_clock = xen_stolen_accounting;
>  	static_key_slow_inc(&paravirt_steal_enabled);
>  	if (xen_initial_domain())
>  		pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
>  
> -	return 0;
> +	return cpuhp_setup_state(CPUHP_AP_ARM_XEN_STARTING,
> +				 "AP_ARM_XEN_STARTING", xen_starting_cpu,
> +				 xen_dying_cpu);
>  }
>  early_initcall(xen_guest_init);
>  
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 86ac982..f986963 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -48,6 +48,7 @@ enum cpuhp_state {
>  	CPUHP_AP_KVM_STARTING,
>  	CPUHP_AP_KVM_ARM_VGIC_STARTING,
>  	CPUHP_AP_KVM_ARM_TIMER_STARTING,
> +	CPUHP_AP_ARM_XEN_STARTING,
>  	CPUHP_AP_LEDTRIG_STARTING,
>  	CPUHP_AP_NOTIFY_STARTING,
>  	CPUHP_AP_ONLINE,
> -- 
> 2.8.1
> 
> 
> 
