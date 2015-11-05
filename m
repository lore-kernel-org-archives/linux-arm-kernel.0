From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 05 Nov 2015 19:58:32 +0100
Subject: [PATCH 3/3] xen/arm: set the system time in Xen via the
 XENPF_settime hypercall
In-Reply-To: <1446743385-12848-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1511051706560.13541@kaball.uk.xensource.com>
 <1446743385-12848-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <6188457.uvvdcZaVNM@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 November 2015 17:09:45 Stefano Stabellini wrote:
> If Linux is running as dom0, call XENPF_settime to update the system
> time in Xen on pvclock_gtod notifications.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Signed-off-by: Ian Campbell <ian.campbell@citrix.com>
> ---
>  arch/arm/xen/enlighten.c |   52 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 51 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index b6aea9c..0176db0 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -28,6 +28,7 @@
>  #include <linux/cpufreq.h>
>  #include <linux/cpu.h>
>  #include <linux/console.h>
> +#include <linux/pvclock_gtod.h>
>  #include <linux/timekeeping.h>
>  #include <clocksource/arm_arch_timer.h>
>  
> @@ -123,6 +124,50 @@ static void xen_read_wallclock(struct timespec *ts)
>  	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
>  }
>  
> +static int xen_pvclock_gtod_notify(struct notifier_block *nb,
> +				   unsigned long was_set, void *priv)
> +{
> +	/* Protected by the calling core code serialization */
> +	static struct timespec next_sync;
> +
> +	struct xen_platform_op op;
> +	struct timespec now;

Again, use timespec64

> +	now = __current_kernel_time();

We don't have __current_kernel_time64() yet, but it is trivial
to add, just follow the example of
current_kernel_time()/current_kernel_time64() and convert the
existing __current_kernel_time() function into a static
inline wrapper for the new __current_kernel_time64().

> +	/*
> +	 * We only take the expensive HV call when the clock was set
> +	 * or when the 11 minutes RTC synchronization time elapsed.
> +	 */
> +	if (!was_set && timespec_compare(&now, &next_sync) < 0)
> +		return NOTIFY_OK;
> +
> +	op.interface_version = XENPF_INTERFACE_VERSION;
> +	op.cmd = XENPF_settime;
> +	op.u.settime.secs = now.tv_sec;
> +	op.u.settime.nsecs = now.tv_nsec;
> +	op.u.settime.system_time = arch_timer_read_counter();
> +	printk("GTOD: Setting to %ld.%ld at %lld\n",
> +	       (long)op.u.settime.secs,
> +	       (long)op.u.settime.nsecs,
> +	       (long long)op.u.settime.system_time);
> +	(void)HYPERVISOR_dom0_op(&op);

I guess we will also need a XENPF_settime64 interface, but at
least we can get away with implementing only that one on ARM,
while x86 will have to support both the 32-bit and 64-bit
based variant.

	Arnd
