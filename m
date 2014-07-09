From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Wed, 9 Jul 2014 11:49:19 +0100
Subject: [PATCH] xen/arm: use BUG_ON
In-Reply-To: <20140708222634.GA11976@himangi-Dell>
References: <20140708222634.GA11976@himangi-Dell>
Message-ID: <alpine.DEB.2.02.1407091148530.27641@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 Jul 2014, Himangi Saraogi wrote:
> Use BUG_ON(x) rather than if(x) BUG();
> 
> The semantic patch that fixes this problem is as follows:
> 
> // <smpl>
> @@ identifier x; @@
> -if (x) BUG();
> +BUG_ON(x);
> // </smpl>
> 
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  arch/arm/xen/enlighten.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 1e63243..98544c5 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -181,8 +181,7 @@ static void xen_restart(enum reboot_mode reboot_mode, const char *cmd)
>  	struct sched_shutdown r = { .reason = SHUTDOWN_reboot };
>  	int rc;
>  	rc = HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
> -	if (rc)
> -		BUG();
> +	BUG_ON(rc);
>  }
>  
>  static void xen_power_off(void)
> @@ -190,8 +189,7 @@ static void xen_power_off(void)
>  	struct sched_shutdown r = { .reason = SHUTDOWN_poweroff };
>  	int rc;
>  	rc = HYPERVISOR_sched_op(SCHEDOP_shutdown, &r);
> -	if (rc)
> -		BUG();
> +	BUG_ON(rc);
>  }
>  
>  static int xen_cpu_notification(struct notifier_block *self,
> -- 
> 1.9.1
> 
