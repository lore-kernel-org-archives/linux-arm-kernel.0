From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 15:14:51 +0000
Subject: [PATCH v2 5/6] msm: hotplug: support cpu hotplug on msm
In-Reply-To: <1291782501-3909-6-git-send-email-johlstei@codeaurora.org>
References: <1291782501-3909-1-git-send-email-johlstei@codeaurora.org>
	<1291782501-3909-6-git-send-email-johlstei@codeaurora.org>
Message-ID: <20101208151451.GG9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 07, 2010 at 08:28:20PM -0800, Jeff Ohlstein wrote:
> +static DECLARE_COMPLETION(cpu_killed);

There's changes in my tree for 2.6.38 which gets rid of this completion
from platform code.

> +void platform_cpu_die(unsigned int cpu)
> +{
> +#ifdef DEBUG
> +	unsigned int this_cpu = hard_smp_processor_id();
> +
> +	if (cpu != this_cpu) {
> +		printk(KERN_CRIT "Eek! platform_cpu_die running on %u, should be %u\n",
> +			   this_cpu, cpu);
> +		BUG();
> +	}
> +#endif

This debug check can not possibly ever happen; it can be removed.

> +
> +	printk(KERN_NOTICE "CPU%u: shutdown\n", cpu);

This printk is not required with those changes I mentioned above.
