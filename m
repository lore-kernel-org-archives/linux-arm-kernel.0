From: srivatsa.bhat@linux.vnet.ibm.com (Srivatsa S. Bhat)
Date: Wed, 15 Feb 2012 14:48:36 +0530
Subject: [PATCH 2/12] arch/arm: remove references to cpu_*_map.
In-Reply-To: <1329281884.28702.rusty@rustcorp.com.au>
References: <1329281884.28702.rusty@rustcorp.com.au>
Message-ID: <4F3B786C.2080809@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/15/2012 10:28 AM, Rusty Russell wrote:

> From: Rusty Russell <rusty@rustcorp.com.au>
> 
> This has been obsolescent for a while; time for the final push.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> ---

[...]

> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -359,7 +359,7 @@ void __init smp_prepare_cpus(unsigned in
>  		 * re-initialize the map in platform_smp_prepare_cpus() if
>  		 * present != possible (e.g. physical hotplug).
>  		 */
> -		init_cpu_present(&cpu_possible_map);
> +		init_cpu_present(cpu_possible_mask);
>  
>  		/*
>  		 * Initialise the SCU if there are more than one CPU
> @@ -577,8 +577,9 @@ void smp_send_stop(void)
>  	unsigned long timeout;
>  
>  	if (num_online_cpus() > 1) {
> -		cpumask_t mask = cpu_online_map;
> -		cpu_clear(smp_processor_id(), mask);
> +		struct cpumask mask;
> +		cpumask_copy(&mask, cpu_online_mask);
> +		cpumask_clear_cpu(&mask, smp_processor_id());
>  


This should be the other way around:
		cpumask_clear_cpu(smp_processor_id(), &mask);

>  		smp_cross_call(&mask, IPI_CPU_STOP);
>  	}
> 


Regards,
Srivatsa S. Bhat
