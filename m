From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 24 Apr 2013 23:14:28 +0100
Subject: [PATCH v4 7/7] mach-virt: support Xen hypercalls for shutdown
 and reboot
In-Reply-To: <1366831695-13214-7-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1304242012590.4180@kaball.uk.xensource.com>
 <1366831695-13214-7-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <alpine.DEB.2.02.1304242301390.4180@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 24 Apr 2013, Stefano Stabellini wrote:
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> CC: Marc Zyngier <marc.zyngier@arm.com>
> CC: will.deacon at arm.com
> CC: arnd at arndb.de
> CC: rob.herring at calxeda.com

Thinking twice about this patch, a less intrusive alternative would be
to set arm_pm_restart and pm_power_off to two xen specific functions
later on from xen_guest_init.

>  arch/arm/mach-virt/virt.c |   32 ++++++++++++++++++++++++++++++++
>  1 files changed, 32 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-virt/virt.c b/arch/arm/mach-virt/virt.c
> index 528c05e..ba14321 100644
> --- a/arch/arm/mach-virt/virt.c
> +++ b/arch/arm/mach-virt/virt.c
> @@ -23,13 +23,44 @@
>  #include <linux/of_platform.h>
>  #include <linux/smp.h>
>  
> +#include <xen/xen.h>
> +#include <xen/interface/sched.h>
> +
>  #include <asm/arch_timer.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
> +#include <asm/xen/hypercall.h>
> +
> +static void virt_restart(char str, const char *cmd)
> +{
> +#ifdef CONFIG_XEN
> +	if (xen_domain()) {
> +		struct sched_shutdown r = { .reason = SHUTDOWN_reboot };
> +		int rc;
> +		rc = HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
> +		if (rc)
> +			BUG();
> +	}
> +#endif
> +}
> +
> +static void virt_power_off(void)
> +{
> +#ifdef CONFIG_XEN
> +	if (xen_domain()) {
> +		struct sched_shutdown r = { .reason = SHUTDOWN_poweroff };
> +		int rc;
> +		rc = HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
> +		if (rc)
> +			BUG();
> +	}
> +#endif
> +}
>  
>  static void __init virt_init(void)
>  {
>  	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	pm_power_off = virt_power_off;
>  }
>  
>  static void __init virt_timer_init(void)
> @@ -52,4 +83,5 @@ DT_MACHINE_START(VIRT, "Dummy Virtual Machine")
>  	.init_machine	= virt_init,
>  	.smp		= smp_ops(virt_smp_ops),
>  	.dt_compat	= virt_dt_match,
> +	.restart	= virt_restart,
>  MACHINE_END
> -- 
> 1.7.2.5
> 
