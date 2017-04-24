From: sstabellini@kernel.org (Stefano Stabellini)
Date: Mon, 24 Apr 2017 12:30:50 -0700 (PDT)
Subject: [PATCH 2/3 v2] arm/xen: Consolidate calls to shutdown hypercall
 in a single helper
In-Reply-To: <20170424175839.5262-3-julien.grall@arm.com>
References: <20170424175839.5262-1-julien.grall@arm.com>
 <20170424175839.5262-3-julien.grall@arm.com>
Message-ID: <alpine.DEB.2.10.1704241230090.16723@sstabellini-ThinkPad-X260>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Apr 2017, Julien Grall wrote:
> Signed-off-by: Julien Grall <julien.grall@arm.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>     Changes in v2:
>         - Patch added
> ---
>  arch/arm/xen/enlighten.c | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 81e3217b12d3..ba7f4c8f5c3e 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -191,20 +191,24 @@ static int xen_dying_cpu(unsigned int cpu)
>  	return 0;
>  }
>  
> -static void xen_restart(enum reboot_mode reboot_mode, const char *cmd)
> +void xen_reboot(int reason)
>  {
> -	struct sched_shutdown r = { .reason = SHUTDOWN_reboot };
> +	struct sched_shutdown r = { .reason = reason };
>  	int rc;
> +
>  	rc = HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
>  	BUG_ON(rc);
>  }
>  
> +static void xen_restart(enum reboot_mode reboot_mode, const char *cmd)
> +{
> +	xen_reboot(SHUTDOWN_reboot);
> +}
> +
> +
>  static void xen_power_off(void)
>  {
> -	struct sched_shutdown r = { .reason = SHUTDOWN_poweroff };
> -	int rc;
> -	rc = HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
> -	BUG_ON(rc);
> +	xen_reboot(SHUTDOWN_poweroff);
>  }
>  
>  static irqreturn_t xen_arm_callback(int irq, void *arg)
> -- 
> 2.11.0
> 
