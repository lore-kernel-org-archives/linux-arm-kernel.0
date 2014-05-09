From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 May 2014 09:44:16 +0100
Subject: [PATCH 1/8] arm64: Use cpu_ops for smp_stop
In-Reply-To: <dfed1c27146457caec8f3c228a499f5e44678fd2.1399594544.git.geoff@infradead.org>
References: <cover.1399594544.git.geoff@infradead.org>
 <dfed1c27146457caec8f3c228a499f5e44678fd2.1399594544.git.geoff@infradead.org>
Message-ID: <20140509084416.GD4757@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 01:48:17AM +0100, Geoff Levand wrote:
> The current implementation of ipi_cpu_stop() is just a tight infinite loop
> around cpu_relax().  Add a check for a valid cpu_die method of the appropriate
> cpu_operations structure, and if a valid method is found, transfer control to
> that method.
> 
> The core kexec code calls the arch specific machine_shutdown() routine to
> shutdown any SMP secondary CPUs.  The current implementation of the arm64
> machine_shutdown() uses smp_send_stop(), which ultimately runs ipi_cpu_stop()
> on the secondary CPUs.  The infinite loop implementation of the current
> ipi_cpu_stop() does not have any mechanism to get the CPU into a state
> compatable with a kexec re-boot.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/kernel/smp.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index f0a141d..020bbd5 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -508,6 +508,14 @@ static void ipi_cpu_stop(unsigned int cpu)
>  
>  	local_irq_disable();
>  
> +	/* If we have the cup_ops use them. */
> +
> +	if (cpu_ops[cpu]->cpu_disable && cpu_ops[cpu]->cpu_die
> +		&& !cpu_ops[cpu]->cpu_disable(cpu))
> +		cpu_ops[cpu]->cpu_die(cpu);

For PSCI 0.2 support, we're going to need a cpu_kill callback which we
can't call from the dying CPU. Specifically, we'll need to poll
CPU_AFFINITY_INFO to ensure that secondaries have _actually_ left the
kernel and aren't going to be adversely affected by the kernel text
getting clobbered.

As we're going to wire that up to the cpu hotplug infrastructure it
would be nice to perform the hotplug for kexec by reusing the generic
hotplug infrastructure rather than calling portions of the arm64
implementation directly.

> +
> +	/* Spin here if the cup_ops fail. */
> +
>  	while (1)
>  		cpu_relax();

This seems very dodgy to me. If a CPU doesn't actually die it's going to
be spinning in some memory that we may later clobber. At that point the
CPU will do arbitrarily bad things when it begins executing whatever its
currently executing instructions (or vectors) were replaced by, and you
will waste hours trying to figure out what went wrong (See 8121cf312a19
"ARM: 7766/1: versatile: don't mark pen as __INIT" for a similar mess).

If we fail to hotplug a CPU we at minimum need some acknowledgement that
we failed. I would rather we failed to kexec entirely in that case.

Cheers,
Mark.
