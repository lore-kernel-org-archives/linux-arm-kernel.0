From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 26 Aug 2014 15:08:23 +0100
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <CAFdej01NQoVVB6QhZ=jSO5OACZ4293xKPJR9sDboZOOX5DMeig@mail.gmail.com>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
 <CAFdej01kDMSTpzdGiRmX8g=E4mZU2_5oiiKzyQ_z7z1jxeCF-A@mail.gmail.com>
 <20140820105408.GG21174@leverpostej>
 <CAFdej00s9ZYXnE4AfU0vUqTb4dmUg4U=fOhc3KS1_JK+0=+mdw@mail.gmail.com>
 <20140820141623.GF21734@leverpostej>
 <CAFdej023ABj=xstTS_vddr2PMoqE4Fe1qBN9Gr0P69hW+u=YBA@mail.gmail.com>
 <20140821143155.GN21734@leverpostej>
 <CAFdej01NQoVVB6QhZ=jSO5OACZ4293xKPJR9sDboZOOX5DMeig@mail.gmail.com>
Message-ID: <20140826140823.GB4078@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arun,

Please start a new thread if you have new things to say; this thread has
drifted far from its original purpose (the titular patch is now in the
arm64 devel branch [1]).

[...]

> > Ok. So we need to do what I have suggested elsewhere w.r.t. jumping back
> > up to EL2. As you point out below we need to synchronise with the CPUs
> > on their way out too we can add a spin-table cpu_kill with a slightly
> > dodgy delay to ensure that, given we have no other mechanism for
> > synchronising.
> >
> 
> I was able to remove the delay by pushing "set_cpu_online(cpu, false);"
> further down.
> 
> ############
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 3fb64cb..200e49e 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -543,8 +543,6 @@ static void ipi_cpu_stop(unsigned int cpu)
>                 raw_spin_unlock(&stop_lock);
>         }
> 
> -       set_cpu_online(cpu, false);
> -
>         local_irq_disable();
> 

If we don't set the cpu offline here, we'll call
clear_tasks_mm_cpumask(cpu) and migrate IRQs while the CPU is marked
online, wait a bit, then mark the CPU offline. 

I suspect this is broken, though I could be wrong.

>         /* If we have the cpu ops use them. */
> @@ -554,6 +552,8 @@ static void ipi_cpu_stop(unsigned int cpu)
>                 && !cpu_ops[cpu]->cpu_disable(cpu))
>                 cpu_ops[cpu]->cpu_die(cpu);
> 
> +
> +       set_cpu_online(cpu, false);
>         /* Otherwise spin here. */
> 
>         while (1)
> diff --git a/arch/arm64/kernel/smp_spin_table.c
> b/arch/arm64/kernel/smp_spin_table.c
> index e7275b3..8dcca88 100644
> --- a/arch/arm64/kernel/smp_spin_table.c
> +++ b/arch/arm64/kernel/smp_spin_table.c
> @@ -149,6 +149,7 @@ static void smp_spin_table_cpu_die(unsigned int cpu)
>         *release_addr = 0;
>         __flush_dcache_area(release_addr, 8);
> 
> +       set_cpu_online(cpu, false);
>         mb();
> 
>         soft_restart(0);
> ##############
> 
> This will
> 
> a) Make the waiting loop inside smp_send_stop() more meaningful

I don't follow how this is any more meaningful. We still have no
guarantee that the CPU is actually dead.

> b) Make sure that at least cpu-release-addr is invalidated.

There is still a period between the call to set_cpu_online(cpu, false)
and the CPU jumping to the return-address where it is still in the
kernel, so all this does is shorten the window for the race.

For PSCI 0.2+ we can poll to determine when the CPU is in the firmware.
For PSCI prior to 0.2 we can't, but the window is very short (as the
firmware performs the cache maintenance) and we seem to have gotten away
with it so far.

For spin-table we might have a large race window because the kernel must
flush the caches at EL2, incurring a relatively large delay. If we are
encountering a race there I'd rather this were fixed with a cpu_kill
callback for spin-table.

Cheers,
Mark.

[1] https://git.kernel.org/cgit/linux/kernel/git/arm64/linux.git/commit/?h=devel&id=6c80fe35fe9edf9147e3db9c8ff1a7761c49c4cc
