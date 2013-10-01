From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 1 Oct 2013 11:10:43 -0400 (EDT)
Subject: [PATCH v2 2/3] ARM: mcpm: Implement cpu_kill() to synchronise
 on powerdown
In-Reply-To: <1380621302-5655-3-git-send-email-Dave.Martin@arm.com>
References: <1380621302-5655-1-git-send-email-Dave.Martin@arm.com>
 <1380621302-5655-3-git-send-email-Dave.Martin@arm.com>
Message-ID: <alpine.LFD.2.03.1310011108530.21228@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 1 Oct 2013, Dave Martin wrote:

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

We're getting there.  ;-)

[...]
> +int mcpm_cpu_power_down_finish(unsigned int cpu, unsigned int cluster)
> +{
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!platform_ops || !platform_ops->power_down_finish))
> +		return 0;

You'd have to return a non-zero value here to be consistent.


Nicolas
