From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 2 Apr 2013 13:34:22 -0400 (EDT)
Subject: [PATCH v5 3/3] xen/arm: introduce xen_early_init, use PSCI on xen
In-Reply-To: <1364919374-7836-3-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1304021700380.5078@kaball.uk.xensource.com>
 <1364919374-7836-3-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <alpine.LFD.2.03.1304021325230.1171@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2 Apr 2013, Stefano Stabellini wrote:

> Split xen_guest_init in two functions, one of them (xen_early_init) is
> going to be called very early from setup_arch.
> 
> Change machine_desc->smp_init to xen_smp_init if Xen is present on the
> platform. xen_smp_init just sets smp_ops to psci_smp_ops.
> 
> Introduce a dependency for ARM_PSCI in XEN.

The Kconfig stuff should be more understandable to "normal" users 
configuring the kernel.  Hence it might make more sense for Xen to 
select PSCI rather than making it a prerequisite.

[...]
> @@ -176,27 +178,30 @@ static int __init xen_secondary_init(unsigned int cpu)
>  	return 0;
>  }
>  
> +static void __init xen_smp_init(void)
> +{
> +	if (psci_smp_available())
> +		smp_set_ops(&psci_smp_ops);
> +}
> +

I still don't understand why you need to do this.  Why can't you just 
rely on the next priority which is to set PSCI ops by default if 
available?  Using this hook for Xen doesn't look justified. As it is, 
you break MCPM.

As I explained to you, MCPM will end up using PSCI as well when 
available, which I think should be sufficient for your concern.


Nicolas
