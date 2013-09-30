From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Mon, 30 Sep 2013 15:18:08 -0400 (EDT)
Subject: [PATCH 2/3] ARM: mcpm: Implement cpu_kill() to synchronise on
 powerdown
In-Reply-To: <1380567603-21367-3-git-send-email-Dave.Martin@arm.com>
References: <1380567603-21367-1-git-send-email-Dave.Martin@arm.com>
 <1380567603-21367-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <alpine.LFD.2.03.1309301507360.6331@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 30 Sep 2013, Dave Martin wrote:

> CPU hotplug and kexec rely on smp_ops.cpu_kill(), which is supposed
> to wait for the CPU to park or power down, and perform the last
> rites (such as disabling clocks etc., where the platform doesn't do
> this automatically).
> 
> kexec in particular is unsafe without performing this
> synchronisation to park secondaries.  Without it, the secondaries
> might not be parked when kexec trashes the kernel.
> 
> There is no generic way to do this synchronisation, so a new mcpm
> platform_ops method power_down_finish() is added by this patch.
> 
> The new method is mandatory.  A platform which provides no way to
> detect when CPUs are parked is likely broken.
> 
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>

There is still a problem with this patch.

> +int mcpm_cpu_power_down_finish(unsigned int cpu, unsigned int cluster)
> +{
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!platform_ops || !platform_ops->power_down_finish))
> +		return 0;
> +
> +	ret = platform_ops->power_down_finish(cpu, cluster);
> +	if (!ret)
> +		pr_warn("%s: cpu %u, cluster %u failed to power down\n",
> +			__func__, cpu, cluster);
> +
> +	return ret;
> +}

So 0 is the error case.

[...]
> + * mcpm_cpu_power_down_finish - wait for a specified CPU to halt, and
> + *	make sure it is powered off
[...]
> + * @return:
> + *	- zero if the CPU is in a safely parked state
> + *	- nonzero otherwise (e.g., timeout)

But you document it as being the opposite.

I'd suggest that the return value is either an int where 0 means success 
and negative error codes are returned otherwise, or it is a bool and 
true/false means success/failure.

I see that platform_cpu_kill() is a bit inconsistent in that regard, but 
we don't have to propagate this down.


Nicolas
