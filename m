From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 12 May 2014 09:49:10 -0400
Subject: [PATCH v9 3/3] ARM: Check if a CPU has gone offline
In-Reply-To: <20140512101638.GD3006@e106331-lin.cambridge.arm.com>
References: <1399472847-14377-1-git-send-email-ashwin.chaugule@linaro.org>
 <1399472847-14377-4-git-send-email-ashwin.chaugule@linaro.org>
 <20140512101638.GD3006@e106331-lin.cambridge.arm.com>
Message-ID: <CAJ5Y-ebF6xt08PwjUH8o=MsROv2b8hAWh-=yuoT3VyDmyOM8_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2014 06:16, Mark Rutland <mark.rutland@arm.com> wrote:
>> +     for (i=0; i<10; i++) {
>
> Nit: please place spaces around the binary operators:
>
>         for (i = 0; i < 10; i++) {

Ok.

>
>> +             err = psci_ops.affinity_info(cpu_logical_map(cpu), 0);
>> +             if (err == PSCI_0_2_AFFINITY_LEVEL_OFF)
>> +                     return 1;
>> +
>> +             msleep(10);
>> +             pr_info("Retrying again to check for CPU kill\n");
>
> I don't think we need to print on each iteration -- that's going to spam
> the log if we race and/or slow things down.

I think its better than having a single print which could be easily
hidden by other dmesg noise. This shouldn't (hopefully) take all 10
iterations in practice and if it does then the bunch of printks should
be easy to identify and indicate that the CPU did not die. Come to
think of it, I should probably add a print when it does die, to make
it clear after a few (if any) retries.

>
>> +     }
>> +
>> +     pr_err("psci: Cannot kill CPU:%d, psci ret val: %d\n",
>> +                     cpu, err);
>
> This message might be a little confusing as we're testing that the CPU
> is dead rather than explicitly killing it. The "psci:" prefix is
> redundant thanks to pr_fmt and CPU:%d is a little odd.
>
> How about:
>
> pr_warn("CPU%d may not have shut down cleanly (AFFINITY_INFO reports %d)\n",
>         cpu, err);

Ok.

>
>> +     /* Make platform_cpu_kill() fail. */
>> +     return 0;
>> +}
>
> [...]
>
> Could you implement this for arm64 as well? We don't currently have a
> cpu_kill callback on cpu_operations, but the (compile-tested only) patch
> below should remedy that.
>
> Cheers,
> Mark.
>
> ---->8----
> From 8f81dc38a7a2b7b61165d350dff5cdcaa7248081 Mon Sep 17 00:00:00 2001
> From: Mark Rutland <mark.rutland@arm.com>
> Date: Mon, 12 May 2014 10:39:07 +0100
> Subject: [PATCH] arm64: cpu_ops: add cpu_kill callback
>
> Currently there is a window between a CPU announcing that it is dead and
> said CPU leaving the kernel. If data or instructions are clobbered (as
> happens on a kexec) within this window the CPU might begin doing
> arbitrary bad things.
>
> In some of these cases (e.g. on those platforms with PSCI 0.2) we can
> query the firmware to discover when the CPU has really left the kernel,
> closing the race.
>
> This patch adds a cpu_kill callback for use in those cases, which may
> bew used to synchronise with the dying CPU.
>
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/include/asm/cpu_ops.h |  2 ++
>  arch/arm64/kernel/smp.c          | 22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+)
>
> diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
> index 1524130..c7c7442 100644
> --- a/arch/arm64/include/asm/cpu_ops.h
> +++ b/arch/arm64/include/asm/cpu_ops.h
> @@ -39,6 +39,7 @@ struct device_node;
>   *             from the cpu to be killed.
>   * @cpu_die:   Makes a cpu leave the kernel. Must not fail. Called from the
>   *             cpu being killed.
> + * @cpu_kill:  Ensures a cpu has left the kernel. Called from another cpu.
>   * @cpu_suspend: Suspends a cpu and saves the required context. May fail owing
>   *               to wrong parameters or error conditions. Called from the
>   *               CPU being suspended. Must be called with IRQs disabled.
> @@ -52,6 +53,7 @@ struct cpu_operations {
>  #ifdef CONFIG_HOTPLUG_CPU
>         int             (*cpu_disable)(unsigned int cpu);
>         void            (*cpu_die)(unsigned int cpu);
> +       int             (*cpu_kill)(unsigned int cpu);
>  #endif
>  #ifdef CONFIG_ARM64_CPU_SUSPEND
>         int             (*cpu_suspend)(unsigned long);
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 7cfb92a..4844628 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -220,6 +220,19 @@ int __cpu_disable(void)
>         return 0;
>  }
>
> +static int op_cpu_kill(unsigned int cpu)
> +{
> +       /*
> +        * If we have no means of synchronising with the dying CPU, then assume
> +        * that it is really dead. We can only wait for an arbitrary length of
> +        * time and hope that it's dead, so let's skip the wait and just hope.
> +        */
> +       if (!cpu_ops[cpu]->cpu_kill)
> +               return 0;
> +
> +       return cpu_ops[cpu]->cpu_kill(cpu);
> +}
> +
>  static DECLARE_COMPLETION(cpu_died);
>
>  /*
> @@ -233,6 +246,15 @@ void __cpu_die(unsigned int cpu)
>                 return;
>         }
>         pr_notice("CPU%u: shutdown\n", cpu);
> +
> +       /*
> +        * Now that the dying CPU is beyond the point of no return w.r.t.
> +        * in-kernel synchronisation, try to get the firwmare to help us to
> +        * verify that it has really left the kernel before we consider
> +        * clobbering anything it might still be using.
> +        */
> +       if (op_cpu_kill(cpu))
> +               pr_warn("CPU%d may not have shut down cleanly\n", cpu);
>  }
>
>  /*
> --
> 1.8.1.1
>
Your patch looks good to me and I can fold it in with the ARM patch
with your signature. However, I dont have a way to test any of this
besides booting it up on the FVP. So, if you've got any way to run
this, that'd be great!
Thanks for the review!

Cheers,
Ashwin
