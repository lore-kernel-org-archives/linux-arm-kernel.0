From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Dec 2015 15:28:26 +0000
Subject: [PATCH v2 2/6] arm64: Move kill_cpu_early to smp.c
In-Reply-To: <1448982731-17182-3-git-send-email-suzuki.poulose@arm.com>
References: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
 <1448982731-17182-3-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151201152826.GA28370@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Suzuki,

On Tue, Dec 01, 2015 at 03:12:07PM +0000, Suzuki K. Poulose wrote:
> This patch moves kill_cpu_early to smp.c, where it fits better.
> No functional changes, except for adding the necessary checks
> for CONFIG_HOTPLUG_CPU.

This is mostly a code move, and the comments below were true for the
original, too.

> +/*
> + * Kill the calling secondary CPU, early in bringup before it is turned
> + * online.
> + */
> +void kill_cpu_early(void)
> +{
> +	int cpu = smp_processor_id();
> +
> +	pr_crit("CPU%d: will not boot\n", cpu);
> +
> +	/* Mark this CPU absent */
> +	set_cpu_present(cpu, 0);
> +
> +#ifdef CONFIG_HOTPLUG_CPU
> +	/* Check if we can park ourselves */
> +	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
> +		cpu_ops[cpu]->cpu_die(cpu);
> +#endif

Is there no way we can synchronise against this from another CPU, to be
sure that this CPU is actually gone?

> +
> +	asm(
> +	"1:	wfe\n"
> +	"	wfi\n"
> +	"	b	1b");
> +}

This can be:

for (;;) {
	wfe();
	wfi();
}

Regardless of that, we now have a CPU stuck in the kernel, despite
beleiving it to be !present (and therefore !online).

This is problematic for anything where we need to offline or stop
secondary CPUs. For instance, we need to inhibit kexec here (as we will
also need to in case CPUs were stuck in the spinning due to spin-table).

Thanks,
Mark.
