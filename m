From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Oct 2015 12:08:40 +0100
Subject: [PATCH v2 12/22] arm64: Delay cpu feature checks
In-Reply-To: <1444064531-25607-13-git-send-email-suzuki.poulose@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-13-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151008110840.GF17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 05, 2015 at 06:02:01PM +0100, Suzuki K. Poulose wrote:
> @@ -647,16 +648,119 @@ void check_cpu_capabilities(const struct arm64_cpu_capabilities *caps,
>  		cpus_set_cap(caps[i].capability);
>  	}
>  
> -	/* second pass allows enable() to consider interacting capabilities */
> -	for (i = 0; caps[i].desc; i++) {
> -		if (cpus_have_cap(caps[i].capability) && caps[i].enable)
> -			caps[i].enable();
> +	/*
> +	 * second pass allows enable() invoked on active each CPU
> +	 * to consider interacting capabilities.
> +	 */

This comment doesn't read properly.

> -void check_local_cpu_features(void)
> +/*
> + * Park the CPU which doesn't have the capability as advertised
> + * by the system.
> + */
> +static void fail_incapable_cpu(char *cap_type,
> +				 const struct arm64_cpu_capabilities *cap)
> +{
> +	/*XXX: Are we really safe to call printk here ? */
> +	pr_crit("FATAL: CPU%d is missing %s : %s \n",
> +			smp_processor_id(), cap_type, cap->desc);

I'm not sure it's safe either, basically we haven't fully brought the
CPU into the system.

> +	asm volatile(
> +			" 1:	wfe \n\t"
> +			"	b 1b\n"
> +		    );
> +}

We could add a wfi as well in the mix.

However, if we have PSCI, we should use it to park the CPUs back into
firmware (via cpu_operations.cpu_die), and only use the above loop if
that fails.

> +/*
> + * Run through the enabled system capabilities and enable() it on this CPU.

s/it/them/

-- 
Catalin
