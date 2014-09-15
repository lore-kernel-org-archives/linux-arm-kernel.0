From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 15 Sep 2014 20:06:17 +0100
Subject: [PATCH 08/13] arm64: Use cpu_ops for smp_stop
In-Reply-To: <36ad9302497338a34cc7174a72a2ac99ceb16fdb.1410302383.git.geoff@infradead.org>
References: <cover.1410302383.git.geoff@infradead.org>
 <36ad9302497338a34cc7174a72a2ac99ceb16fdb.1410302383.git.geoff@infradead.org>
Message-ID: <20140915190616.GC14191@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Tue, Sep 09, 2014 at 11:49:05PM +0100, Geoff Levand wrote:
> The current implementation of ipi_cpu_stop() is just a tight infinite loop
> around cpu_relax().  This infinite loop implementation is OK if the machine
> will soon do a poweroff, but it doesn't have any mechanism to allow a CPU
> to be brought back on-line, nor is it compatible with kexec re-boot.

I don't see why we should use this when we have disable_nonboot_cpus.

If the kernel is alive and well, disable_nonboot_cpus will correctly
shut down all but one CPU, returning an error if that fails, whereupon
we can respect the error code and halt the kexec.

If the kernel is not alive and well, we have no idea what CPUs are
executing anyway, so all we can expect to do is to boot a (UP) crash
kernel in some previously reserved memory. Trying to actually kill the
CPUs is nice, but possibly not necessary.

> Add a check for a valid cpu_die method of the appropriate cpu_ops structure,
> and if a valid method is found, transfer control to that method.  It is
> expected that the cpu_die method puts the CPU into a state such that they can
> be brought back on-line or progress through a kexec re-boot.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/kernel/smp.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4743397..002aa8a 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -555,6 +555,15 @@ static void ipi_cpu_stop(unsigned int cpu)
>  
>  	local_irq_disable();
>  
> +	/* If we have the cpu ops use them. */
> +
> +	if (cpu_ops[cpu]->cpu_disable &&
> +	    cpu_ops[cpu]->cpu_die &&
> +	    !cpu_ops[cpu]->cpu_disable(cpu))
> +		cpu_ops[cpu]->cpu_die(cpu);

I don't think kexec should handle this. The hotplug code already does
this, better (calling cpu_kill and returning an error code), and having
two callers of these functions is only going to lead to hard-to-debug
drift between the two.

>  	while (1)
>  		cpu_relax();

Any CPUs left here are a major problem.

We absolutely must fail kexec if a CPU is still in the kernel (in the
pen or in the kernel proper), or they can do arbitrarily bad things when
the kernel image gets clobbered. SO this is insufficient.

As I mention above, a crash kernel might be an exception to that rule,
but we shouldn't treat that as the usual case.

Thanks,
Mark.
