From: julien.grall@citrix.com (Julien Grall)
Date: Fri, 13 Nov 2015 13:56:55 +0000
Subject: [Xen-devel] [PATCH v4 6/7] xen/arm: set the system time in Xen
 via the XENPF_settime64 hypercall
In-Reply-To: <1447349448-22610-6-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511121726370.526@kaball.uk.xensource.com>
 <1447349448-22610-6-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <5645EC27.3000104@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/15 17:30, Stefano Stabellini wrote:
> +static int xen_pvclock_gtod_notify(struct notifier_block *nb,
> +				   unsigned long was_set, void *priv)
> +{
> +	/* Protected by the calling core code serialization */
> +	static struct timespec64 next_sync;
> +
> +	struct xen_platform_op op;
> +	struct timespec64 now, system_time;
> +	struct timekeeper *tk = priv;
> +
> +	now.tv_sec = tk->xtime_sec;
> +	now.tv_nsec = (long)(tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift);
> +	system_time = timespec64_add(now, tk->wall_to_monotonic);
> +
> +	/*
> +	 * We only take the expensive HV call when the clock was set
> +	 * or when the 11 minutes RTC synchronization time elapsed.
> +	 */
> +	if (!was_set && timespec64_compare(&now, &next_sync) < 0)
> +		return NOTIFY_OK;
> +
> +	op.interface_version = XENPF_INTERFACE_VERSION;
> +	op.cmd = XENPF_settime64;
> +	op.u.settime64.mbz = 0;
> +	op.u.settime64.secs = now.tv_sec;
> +	op.u.settime64.nsecs = now.tv_nsec;
> +	op.u.settime64.system_time = timespec64_to_ns(&system_time);
> +	printk("GTOD: Setting to %llu.%09u at %llu\n",
> +	       op.u.settime64.secs,
> +	       op.u.settime64.nsecs,
> +	       op.u.settime64.system_time);

Is this printk really useful?

> +	(void)HYPERVISOR_platform_op(&op);
> +
> +	/*
> +	 * Move the next drift compensation time 11 minutes
> +	 * ahead. That's emulating the sync_cmos_clock() update for
> +	 * the hardware RTC.
> +	 */
> +	next_sync = now;
> +	next_sync.tv_sec += 11 * 60;
> +
> +	return NOTIFY_OK;
> +}
> +
> +static struct notifier_block xen_pvclock_gtod_notifier = {
> +	.notifier_call = xen_pvclock_gtod_notify,
> +};
> +
>  static void xen_percpu_init(void)
>  {
>  	struct vcpu_register_vcpu_info info;
> @@ -313,7 +364,9 @@ static int __init xen_guest_init(void)
>  
>  	pv_time_ops.steal_clock = xen_stolen_accounting;
>  	static_key_slow_inc(&paravirt_steal_enabled);
> -
> +	if (xen_initial_domain())
> +		pvclock_gtod_register_notifier(&xen_pvclock_gtod_notifier);
> + 

I think, you've introduced a trailing whitespace.

>  	return 0;
>  }
>  early_initcall(xen_guest_init);
> 

Regards,


-- 
Julien Grall
