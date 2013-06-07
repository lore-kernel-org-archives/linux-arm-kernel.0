From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Jun 2013 16:39:32 -0600
Subject: [PATCH] ARM: tegra: disable nonboot CPUs when reboot
In-Reply-To: <20130607221526.GC18614@n2100.arm.linux.org.uk>
References: <1370597810-1153-1-git-send-email-josephl@nvidia.com>
 <51B20DF1.3030207@wwwdotorg.org>
 <20130607181846.GL8111@mudshark.cambridge.arm.com>
 <51B22CDC.4080200@wwwdotorg.org> <51B25086.6020209@wwwdotorg.org>
 <20130607221526.GC18614@n2100.arm.linux.org.uk>
Message-ID: <51B26124.5060505@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 04:15 PM, Russell King - ARM Linux wrote:
> On Fri, Jun 07, 2013 at 03:28:38PM -0600, Stephen Warren wrote:
>> On 06/07/2013 12:56 PM, Stephen Warren wrote:
>> ...
>>> [1] Perhaps the issue is why ipi_send_stop() calls down into 
>>> tegra_cpu_kill() rather than tegra_cpu_die(), since die() is what
>>> should be run on the killed CPU, and kill() on the killing CPU?
>>
>> Scratch that; I don't think it's calling down to /either/; I was
>> confused. It seems like it /should/ call cpu_die() though, at least if
>> hotplug is enabled, right?
> 
> The problem is really complex.
> 
> CPU hotplug is done in paths where we're relatively confident that the
> system is working correctly.  So all the features such as scheduling
> are available, the timer ticks work and so forth.
> 
> However, reboot is a totally different environment.  This can happen
> from almost any context with the system in any state what so ever.  A
> CPU could be stuck.  A CPU could have oopsed.  The CPU which is in
> the reboot code could be the CPU which has oopsed.  It could be called
> from within an interrupt...
> 
> What that means is the usual CPU hotplug methods can't be used in the
> reboot path.  Well, they can, but it will be fragile.
> 
> For reboot, the real solution there is not to use software-based
> reboot, but bring the other cores to a halt (which is what
> ipi_send_stop is doing) and then issue a hardware reset to the whole
> system, including the other CPUs.

Ignoring the issues with oops in reboot, I think there's a bug in that
when hotplug is enabled, smp_kill_cpus() calls platform_cpu_kill(), but
nothing causes the failing CPU to ever execute smp_ops.cpu_die(). Hence,
if the implementation of smp_ops.cpu_kill() relies on the target CPU
having run smp_ops.cpu_die(), then smp_ops.cpu_kill() may not operate
correctly.

Or, must smp_ops.cpu_kill() not assume that smp_ops.cpu_die() will be
called on the target CPU? What are the semantics here? Will mentioned
that __cpu_die and cpu_die are a pair, but what about is the smp_ops are
used directly; are they also supposed to be a pair?

The change below solves the pairing issue, by making ipi_cpu_stop()
perform the low-level part of hotplug that matches what smp_kill_cpus()
call to platform_cpu_kill(). This certainly fixes the
hang-in-reboot-or-shutdown problem on Tegra.

> diff --git a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
> index 550d63c..541f667 100644
> --- a/arch/arm/kernel/smp.c
> +++ b/arch/arm/kernel/smp.c
> @@ -581,11 +581,20 @@ static void ipi_cpu_stop(unsigned int cpu)
>  
>         set_cpu_online(cpu, false);
>  
> +#ifdef CONFIG_HOTPLUG_CPU
> +#if 0
> +       arch_cpu_idle_dead();
> +#else
> +       /* The body of arch_cpu_idle_dead() - which is better? */
> +       cpu_die();
> +#endif
> +#else
>         local_fiq_disable();
>         local_irq_disable();
>  
>         while (1)
>                 cpu_relax();
> +#endif
>  }

Some things I'm not sure of here:

* cpu_die() calls idle_task_exit(). That's probably wrong if it's
triggered from an IPI; who knows what task it's executing. That said, if
migrate_to_reboot_cpu() did set_cpus_allowed_ptr(current,
cpumask_of(cpu)), perhaps that guarantees the CPU is running the idle
task since there's nothing else that could be running?

* ipi_cpu_stop() currently calls local_fiq_disable(), but cpu_die()
doesn't. Should both functions call both local_fiq_disable() and
local_irq_disable()?

* Perhaps smp_kill_cpus() should also be changed, to call cpu_die() not
platform_cpu_kill(), to keep the pairing correct at that level too.

Plus, I ignored any issues you raised for the oops case on reboot...
