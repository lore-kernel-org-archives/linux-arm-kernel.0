From: julien.grall@citrix.com (Julien Grall)
Date: Mon, 19 Oct 2015 18:01:47 +0100
Subject: [PATCH v3 3/3] xen/arm: don't try to re-register vcpu_info on
 cpu_hotplug.
In-Reply-To: <1445273735-15758-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1510191754000.27957@kaball.uk.xensource.com>
 <1445273735-15758-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <562521FB.10301@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On 19/10/15 17:55, Stefano Stabellini wrote:
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index 6c09cc4..074b1a2 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -93,6 +93,17 @@ static void xen_percpu_init(void)
>  	int err;
>  	int cpu = get_cpu();
>  
> +	/* 
> +	 * VCPUOP_register_vcpu_info cannot be called twice for the same
> +	 * vcpu, so if vcpu_info is already registered, just get out. This
> +	 * can happen with cpu-hotplug.
> +	 */
> +	if (per_cpu(xen_vcpu, cpu) != NULL) {
> +		enable_percpu_irq(xen_events_irq, 0);
> +		put_cpu();
> +		return;

I might be too picky, but this function can be reworked to avoid
duplicating the code. Something like:

if (per_cpu(xen_vcpu, cpu) != NULL)
  goto skip_register_vcpu;

> +	}
> +
>  	pr_info("Xen: initializing cpu%d\n", cpu);
>  	vcpup = per_cpu_ptr(xen_vcpu_info, cpu);
>  
> @@ -131,6 +142,9 @@ static int xen_cpu_notification(struct notifier_block *self,
>  	case CPU_STARTING:
>  		xen_percpu_init();
>  		break;
> +	case CPU_DYING:
> +		disable_percpu_irq(xen_events_irq);
> +		break;
>  	default:
>  		break;
>  	}
> 


-- 
Julien Grall
