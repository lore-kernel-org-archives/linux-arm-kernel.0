From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 14 Aug 2013 13:51:49 -0400 (EDT)
Subject: [PATCHv3 3/5] arm64: read enable-method for CPU0
In-Reply-To: <1376497228-20543-4-git-send-email-mark.rutland@arm.com>
References: <1376497228-20543-1-git-send-email-mark.rutland@arm.com>
 <1376497228-20543-4-git-send-email-mark.rutland@arm.com>
Message-ID: <alpine.LFD.2.03.1308141351330.14472@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 14 Aug 2013, Mark Rutland wrote:

> With the advent of CPU_HOTPLUG, the enable-method property for CPU0
> may tells us something useful (i.e. how to hotplug it back on), so
> we must read it along with all the enable-method for all the other CPUs.
> 
> This patch ensures that CPU0's enable-method property is read.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Nicolas Pitre <nico@linaro.org>

> ---
>  arch/arm64/kernel/smp.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 72c2823..f6ce2ae 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -254,6 +254,8 @@ void __init smp_init_cpus(void)
>  			}
>  		}
>  
> +		enable_method = of_get_property(dn, "enable-method", NULL);
> +
>  		/*
>  		 * The numbering scheme requires that the boot CPU
>  		 * must be assigned logical id 0. Record it so that
> @@ -269,11 +271,12 @@ void __init smp_init_cpus(void)
>  
>  			bootcpu_valid = true;
>  
> +			if (enable_method)
> +				smp_ops[0] = smp_get_ops(enable_method);
> +
>  			/*
> -			 * cpu_logical_map has already been
> -			 * initialized and the boot cpu doesn't need
> -			 * the enable-method so continue without
> -			 * incrementing cpu.
> +			 * cpu_logical_map has already been initialized so
> +			 * continue without incrementing cpu.
>  			 */
>  			continue;
>  		}
> @@ -281,10 +284,6 @@ void __init smp_init_cpus(void)
>  		if (cpu >= NR_CPUS)
>  			goto next;
>  
> -		/*
> -		 * We currently support only the "spin-table" enable-method.
> -		 */
> -		enable_method = of_get_property(dn, "enable-method", NULL);
>  		if (!enable_method) {
>  			pr_err("%s: missing enable-method property\n",
>  				dn->full_name);
> -- 
> 1.8.1.1
> 
