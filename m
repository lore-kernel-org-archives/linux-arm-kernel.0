From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 5 Aug 2015 17:46:03 -0700
Subject: [PATCH v3 15/31] arm64: SMP support
In-Reply-To: <1347035226-18649-16-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
 <1347035226-18649-16-git-send-email-catalin.marinas@arm.com>
Message-ID: <CAOZdJXVoDJM3y2mnKO+91yf2EHogKfMjumjhhi85REAfhcJM=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

I know this patch is three years old, but I have a question about it:

On Fri, Sep 7, 2012 at 9:26 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> +static void ipi_cpu_stop(unsigned int cpu)
> +{
> +       if (system_state == SYSTEM_BOOTING ||
> +           system_state == SYSTEM_RUNNING) {
> +               raw_spin_lock(&stop_lock);
> +               pr_crit("CPU%u: stopping\n", cpu);
> +               dump_stack();
> +               raw_spin_unlock(&stop_lock);
> +       }
> +
> +       set_cpu_online(cpu, false);
> +
> +       local_fiq_disable();
> +       local_irq_disable();
> +
> +       while (1)
> +               cpu_relax();
> +}

Why do you display a message and dump the stack when a CPU is stopped?
 I ask because emergency_restart() calls this function, and so
whenever I want to do an "emergency" reboot, it dumps the stack for
each core.  On an ARM64 system with lots of cores, this produces a ton
of output.  That makes emergency_restart() almost useless.

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
