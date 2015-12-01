From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 1 Dec 2015 16:31:39 +0000
Subject: [PATCH v2 2/6] arm64: Move kill_cpu_early to smp.c
In-Reply-To: <565DC5DB.7070905@arm.com>
References: <1448982731-17182-1-git-send-email-suzuki.poulose@arm.com>
 <1448982731-17182-3-git-send-email-suzuki.poulose@arm.com>
 <20151201152826.GA28370@leverpostej> <565DC5DB.7070905@arm.com>
Message-ID: <20151201163138.GA29045@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>+#ifdef CONFIG_HOTPLUG_CPU
> >>+	/* Check if we can park ourselves */
> >>+	if (cpu_ops[cpu] && cpu_ops[cpu]->cpu_die)
> >>+		cpu_ops[cpu]->cpu_die(cpu);
> >>+#endif
> >
> >Is there no way we can synchronise against this from another CPU, to be
> >sure that this CPU is actually gone?
> 
> Unfortunately, no. It cannot be guaranteed whether the CPU died gracefully
> or is held up in the kernel. All the other CPU can find is whether the
> CPU successfully turned online or not (using a wait_for_completion_timeout).

That's true if we only consider the kernel, but the firmware can help
us.

For PSCI 0.2+ we can query AFFINITY_INFO to discover whether a CPU is
whether or not it is in the firmware (i.e. whether or not it is
potentially in the kernel), so we can certainly query this in some
cases.

We already do this in the usual hotplug-off case; see cpu_kill.

> >>+
> >>+	asm(
> >>+	"1:	wfe\n"
> >>+	"	wfi\n"
> >>+	"	b	1b");
> >>+}
> >
> >This can be:
> >
> >for (;;) {
> >	wfe();
> >	wfi();
> >}
> 
> Nice, I will change it.
> 
> >
> >Regardless of that, we now have a CPU stuck in the kernel, despite
> >beleiving it to be !present (and therefore !online).
> 
> Right, the CPU could be spinning in the kernel.
> 
> >
> >This is problematic for anything where we need to offline or stop
> >secondary CPUs. For instance, we need to inhibit kexec here (as we will
> >also need to in case CPUs were stuck in the spinning due to spin-table).
> 
> Correct, I didn't think about kexec. May be we could indicate the result
> back (that we are looping in kernel) in secondary_data and that could solve
> the synchronisation part ?

I think we need to have two flags, a cpu-must-die flag in secondary
data, and a global stuck-in-the-kernel flag.

The CPU wanting to die could set its cpu-must-die flag, signal the
completion, then cpu_die(). The CPU awaiting the completion would then
check cpu-must-die, and if so, cpu_kill() that CPU. If not set, we had a
successful onlining.

We need stuck-in-the-kernel flag to account for CPUs which didn't manage
to turn the MMU on (which are either in the spin-table, or failed when
they were individually onlined).

Thanks,
Mark.
