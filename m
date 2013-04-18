From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 18 Apr 2013 16:44:58 +0100
Subject: [PATCH] xen/arm: introduce xen_early_init, use PSCI on xen
In-Reply-To: <1366298167-12755-1-git-send-email-stefano.stabellini@eu.citrix.com>
References: <1366298167-12755-1-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <alpine.DEB.2.02.1304181644060.7254@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Apr 2013, Stefano Stabellini wrote:
> diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
> index b002822..3006de4 100644
> --- a/arch/arm/xen/enlighten.c
> +++ b/arch/arm/xen/enlighten.c
> @@ -176,11 +178,36 @@ static int __init xen_secondary_init(unsigned int cpu)
>  	return 0;
>  }
>  
> +static bool __init xen_smp_init(void)
> +{
> +#ifdef CONFIG_SMP
> +	/* If we are running on Xen, use PSCI if available.
> +	 * In any case do not try to use the native smp_ops. */
> +	if (psci_smp_available())
> +		smp_set_ops(&psci_smp_ops);
> +	return true;
> +#endif
> +}

Small mistake here: ifndef CONFIG_SMP, xen_smp_init won't have a return
value.
I'll fix and resend.
