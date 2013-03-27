From: robherring2@gmail.com (Rob Herring)
Date: Wed, 27 Mar 2013 12:45:27 -0500
Subject: [PATCH v3] [RFC] arm: use PSCI if available
In-Reply-To: <alpine.DEB.2.02.1303271642340.4430@kaball.uk.xensource.com>
References: <1364388639-11210-1-git-send-email-stefano.stabellini@eu.citrix.com>
 <20130327133811.GE18429@mudshark.cambridge.arm.com>
 <alpine.DEB.2.02.1303271610430.4430@kaball.uk.xensource.com>
 <51531FE3.8010905@gmail.com>
 <alpine.DEB.2.02.1303271642340.4430@kaball.uk.xensource.com>
Message-ID: <51533037.5060004@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/27/2013 12:10 PM, Stefano Stabellini wrote:
> On Wed, 27 Mar 2013, Rob Herring wrote:
>> On 03/27/2013 11:23 AM, Stefano Stabellini wrote:
>>> Would you agree on a patch that moves virt_smp_ops out of mach-virt and
>>> renames them to psci_smp_ops (maybe to arch/arm/kernel/psci_smp_ops.c)?
>>>
>>> Would you agree on initializing psci from setup_arch, right after the
>>> call to arm_dt_init_cpu_maps()?
>>>
>>> Finally the most controversial point: would you agree on using
>>> psci_smp_ops by default if they are available?
>>> If not, would you at least agree on letting Xen overwrite the default
>>> machine smp_ops?
>>> We need one or the other for dom0 support.
>>
>> It should not be *always* use PSCI smp ops if available, but use them
>> only if the platform does not define its own smp ops.
> 
> Well, that is the one additional problem that we have on Xen.
> 
> On x86 Xen replaces a lot of core native function calls with its own
> implementations (see paravirt_ops).
> On ARM we only need *one* set of calls: the smp_ops calls.
> 
> So if we don't want to give priority to PSCI over the platform smp_ops,
> then we need a simple workaround just for Xen in common code like the
> one appended below.
> Not pretty, but at least small:
> 
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 3f6cbb2..08cf7e0 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c
> @@ -43,6 +43,8 @@
>  #include <asm/cacheflush.h>
>  #include <asm/cachetype.h>
>  #include <asm/tlbflush.h>
> +#include <xen/xen.h>
> +#include <asm/xen/hypervisor.h>
>  
>  #include <asm/prom.h>
>  #include <asm/mach/arch.h>
> @@ -766,9 +768,13 @@ void __init setup_arch(char **cmdline_p)
>  	unflatten_device_tree();
>  
>  	arm_dt_init_cpu_maps();
> +	xen_early_init();
>  #ifdef CONFIG_SMP
>  	if (is_smp()) {
> -		smp_set_ops(mdesc->smp);
> +		if (xen_domain())
> +			smp_set_ops(&xen_smp_ops);
> +		else
> +			smp_set_ops(mdesc->smp);

No, I was thinking in the case of Xen and mach-virt, you would not set
mdesc->smp. So you would have something like this:

if (mdesc->smp)
	smp_set_ops(mdesc->smp);
else
	smp_set_ops(&psci_smp_ops);


Rob
