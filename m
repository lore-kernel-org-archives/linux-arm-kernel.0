From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 21 Apr 2016 12:33:09 +0100
Subject: [PATCH v7 17/16] arm64: hibernate: Refuse to hibernate if the
 boot cpu is offline
In-Reply-To: <1460565110-26341-1-git-send-email-james.morse@arm.com>
References: <1459529620-22150-1-git-send-email-james.morse@arm.com>
 <1460565110-26341-1-git-send-email-james.morse@arm.com>
Message-ID: <20160421113309.GA7547@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 13, 2016 at 05:31:50PM +0100, James Morse wrote:
> It is important to hibernate/resume on the same CPU, otherwise we may
> change the cpu order or restore a big cpu's register state on a little
> cpu.

I think the problem is that we would end up having no context to
resume to altogether given how cpu_suspend() is implemented (or
context that is simply stale).

> We know cpu 0 is the cpu the firmware booted us on last time, refuse to
> hibernate if it has been hotplugged out. Follow x86's example by registering
> a pm notifier that is called before processes are frozen and devices are
> stopped.

"Hibernation represents a system state save/restore through
a system reboot; this implies that the logical cpus carrying
out hibernation/thawing must be the same, so that the context
saved in the snapshot image on hibernation is consistent with
the state of the system on resume. If resume from hibernation
is driven through kernel command line parameter, the cpu responsible
for thawing the system will be whatever CPU firmware boots the system
on upon cold-boot (ie logical cpu 0); this means that in order to
keep system context consistent between the hibernate snapshot image
and system state on kernel resume from hibernate, logical cpu 0 must
be online on hibernation and must be the logical cpu that creates
the snapshot image.

This patch adds a PM notifier that enforces logical cpu 0 is online
when the hibernation is started (and prevents hibernation if it is
not), which is sufficient to guarantee it will be the one creating
the snapshot image therefore providing the resume cpu a consistent
snapshot of the system to resume to."

A tad verbose, feel free to modify it as you deem fit.

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/arm64/kernel/hibernate.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/kernel/hibernate.c b/arch/arm64/kernel/hibernate.c
> index 486315249f2a..1ef4bf2207a5 100644
> --- a/arch/arm64/kernel/hibernate.c
> +++ b/arch/arm64/kernel/hibernate.c
> @@ -17,6 +17,7 @@
>  #define pr_fmt(x) "hibernate: " x
>  #include <linux/kvm_host.h>
>  #include <linux/mm.h>
> +#include <linux/notifier.h>
>  #include <linux/pm.h>
>  #include <linux/sched.h>
>  #include <linux/suspend.h>
> @@ -476,3 +477,28 @@ int swsusp_arch_resume(void)
>  out:
>  	return rc;
>  }
> +
> +static int check_boot_cpu_online_pm_callback(struct notifier_block *nb,
> +					     unsigned long action, void *ptr)
> +{
> +	if (action == PM_HIBERNATION_PREPARE &&
> +	     cpumask_first(cpu_online_mask) != 0) {
> +		pr_warn("CPU0 is offline.\n");
> +		return notifier_from_errno(-ENODEV);
> +	}
> +
> +	return NOTIFY_OK;
> +}
> +
> +static int __init check_boot_cpu_online_init(void)
> +{
> +	/*
> +	 * Set this pm_notifier callback with a lower priority than
> +	 * cpu_hotplug_pm_callback, so that cpu_hotplug_pm_callback will be
> +	 * called earlier to disable cpu hotplug before the cpu online check.
> +	 */
> +	pm_notifier(check_boot_cpu_online_pm_callback, -INT_MAX);
> +
> +	return 0;
> +}
> +core_initcall(check_boot_cpu_online_init);
