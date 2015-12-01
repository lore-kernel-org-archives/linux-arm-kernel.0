From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Tue, 1 Dec 2015 16:07:55 +0000
Subject: [PATCH v2 2/6] arm64: Move kill_cpu_early to smp.c
In-Reply-To: <20151201152826.GA28370@leverpostej>
References: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
 <1448982731-17182-3-git-send-email-suzuki.poulose@arm.com>
 <20151201152826.GA28370@leverpostej>
Message-ID: <565DC5DB.7070905@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/12/15 15:28, Mark Rutland wrote:
> Hi Suzuki,

>> This patch moves kill_cpu_early to smp.c, where it fits better.
>> No functional changes, except for adding the necessary checks
>> for CONFIG_HOTPLUG_CPU.
>
> This is mostly a code move, and the comments below were true for the
> original, too.

Right, just that there was a dependency on struct arm64_cpu_capabilities
earlier, which was removed in the previous patch in the series.

>> +
>> +#ifdef CONFIG_HOTPLUG_CPU
>> +	/* Check if we can park ourselves */
>> +	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
>> +		cpu_ops[cpu]->cpu_die(cpu);
>> +#endif
>
> Is there no way we can synchronise against this from another CPU, to be
> sure that this CPU is actually gone?

Unfortunately, no. It cannot be guaranteed whether the CPU died gracefully
or is held up in the kernel. All the other CPU can find is whether the
CPU successfully turned online or not (using a wait_for_completion_timeout).

>> +
>> +	asm(
>> +	"1:	wfe\n"
>> +	"	wfi\n"
>> +	"	b	1b");
>> +}
>
> This can be:
>
> for (;;) {
> 	wfe();
> 	wfi();
> }

Nice, I will change it.

>
> Regardless of that, we now have a CPU stuck in the kernel, despite
> beleiving it to be !present (and therefore !online).

Right, the CPU could be spinning in the kernel.

>
> This is problematic for anything where we need to offline or stop
> secondary CPUs. For instance, we need to inhibit kexec here (as we will
> also need to in case CPUs were stuck in the spinning due to spin-table).

Correct, I didn't think about kexec. May be we could indicate the result
back (that we are looping in kernel) in secondary_data and that could solve
the synchronisation part ?


Suzuki
