From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 10 Jan 2018 09:49:05 +0530
Subject: [PATCH 2/2] cpufreq: scpi: remove arm_big_little dependency
In-Reply-To: <1515516568-31359-3-git-send-email-sudeep.holla@arm.com>
References: <1515516568-31359-1-git-send-email-sudeep.holla@arm.com>
 <1515516568-31359-3-git-send-email-sudeep.holla@arm.com>
Message-ID: <20180110041905.GC3335@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09-01-18, 16:49, Sudeep Holla wrote:
> +static int
> +scpi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
>  {
> -	return scpi_ops->get_transition_latency(cpu_dev);
> +	int cpu, domain, tdomain;
> +	struct device *tcpu_dev;
> +
> +	domain = scpi_ops->device_domain_id(cpu_dev);
> +	if (domain < 0)
> +		return domain;
> +
> +	for_each_possible_cpu(cpu) {
> +		if (cpu == cpu_dev->id)
> +			continue;
> +
> +		tcpu_dev = get_cpu_device(cpu);
> +		if (!tcpu_dev)
> +			continue;
> +
> +		tdomain = scpi_ops->device_domain_id(tcpu_dev);
> +		if (tdomain == domain)
> +			cpumask_set_cpu(cpu, cpumask);
> +	}
> +
> +	return 0;
>  }

So this is the main thing you want to achieve ? i.e. get the
policy->cpus from scpi_ops, right ?

Why can't we update .init_opp_table() to include policy as a parameter
and let individual stub drivers update policy->cpus then ?

-- 
viresh
