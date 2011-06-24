From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 24 Jun 2011 15:01:42 +0100
Subject: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
In-Reply-To: <1308923618-5333-1-git-send-email-premi@ti.com>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
Message-ID: <20110624140142.GM9449@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 07:23:38PM +0530, Sanjeev Premi wrote:
> @@ -97,12 +97,8 @@ static int omap_target(struct cpufreq_policy *policy,
>  		return ret;
> 
>  	/* Notify transitions */
> -	if (is_smp()) {
> -		for_each_cpu(i, policy->cpus) {
> -			freqs.cpu = i;
> -			cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> -		}
> -	} else {
> +	for_each_cpu(i, policy->cpus) {
> +		freqs.cpu = i;
>  		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>  	}
> 

Ok.

> @@ -114,13 +110,20 @@ static int omap_target(struct cpufreq_policy *policy,
> 
>  	freqs.new = omap_getspeed(policy->cpu);
> 
> +#ifdef CONFIG_SMP
> +	/* Adjust jiffies before transition */
> +	for_each_cpu(i, policy->cpus) {
> +		unsigned long lpj = per_cpu(cpu_data, i).loops_per_jiffy;
> +
> +		per_cpu(cpu_data, i).loops_per_jiffy = cpufreq_scale(lpj,
> +							freqs.old,
> +							freqs.new);
> +	}
> +#endif
> +

You didn't listen to what I told you.  It'll be quicker for me to write
this patch myself if you send me the *original* file.

>  	/* Notify transitions */
> -	if (is_smp()) {
> -		for_each_cpu(i, policy->cpus) {
> -			freqs.cpu = i;
> -			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> -		}
> -	} else {
> +	for_each_cpu(i, policy->cpus) {
> +		freqs.cpu = i;
>  		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>  	}

Ok.
