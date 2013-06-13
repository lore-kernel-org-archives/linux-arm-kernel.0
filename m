From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Jun 2013 08:59:40 -0600
Subject: [PATCH V2 2/2] ARM: decouple CPU offlining from reboot/shutdown
In-Reply-To: <20130613074551.GA7769@mudshark.cambridge.arm.com>
References: <1371067281-655-1-git-send-email-swarren@wwwdotorg.org>
 <1371067281-655-2-git-send-email-swarren@wwwdotorg.org>
 <20130613074551.GA7769@mudshark.cambridge.arm.com>
Message-ID: <51B9DE5C.9030904@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2013 01:45 AM, Will Deacon wrote:
> Hi Stephen,
> 
> On Wed, Jun 12, 2013 at 09:01:21PM +0100, Stephen Warren wrote:
>> From: Stephen Warren <swarren@nvidia.com>
>>
>> Add comments to machine_shutdown()/halt()/power_off()/restart() that
>> describe their purpose and/or requirements re: CPUs being active/not.
>>
>> In machine_shutdown(), replace the call to smp_send_stop() with a call to
>> disable_nonboot_cpus(). This completely disables all but one CPU, thus
>> satisfying the requirement that only a single CPU be active for kexec.
>> Adjust Kconfig dependencies for this change.
>>
>> In machine_halt()/power_off()/restart(), call smp_send_stop() directly,
>> rather than via machine_shutdown(); these functions don't need to
>> completely de-activate all CPUs using hotplug, but rather just quiesce
>> them.
>>
>> Remove smp_kill_cpus(), and its call from smp_send_stop().
>> smp_kill_cpus() was indirectly calling smp_ops.cpu_kill() without calling
>> smp_ops.cpu_die() on the target CPUs first. At least some implementations
>> of smp_ops had issues with this; it caused cpu_kill() to hang on Tegra,
>> for example. Since smp_send_stop() is only used for shutdown, halt, and
>> power-off, there is no need to attempt any kind of CPU hotplug here.
>>
>> Adjust Kconfig to reflect that machine_shutdown() (and hence kexec)
>> relies upon disable_nonboot_cpus(). However, this alone doesn't guarantee
>> that hotplug will work, or even that hotplug is implemented for a
>> particular piece of HW that a multi-platform zImage runs on. Hence, add
>> error-checking to machine_kexec() to determine whether it did work.

>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c

>> +/*
>> + * Called by kexec, immediately prior to machine_kexec().
>> + *
>> + * This must completely disable all secondary CPUs; simply causing those CPUs
>> + * to execute e.g. a RAM-based pin loop is not sufficient. This allows the
>> + * kexec'd kernel to use any and all RAM as it sees fit, without having to
>> + * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
>> + * functionality embodied in disable_nonboot_cpus() to achieve this.
>> + */
>>  void machine_shutdown(void)
>>  {
>> -#ifdef CONFIG_SMP
>> -	smp_send_stop();
>> -#endif
>> +	disable_nonboot_cpus();
>>  }
> 
> Any reason not to move this into machine_kexec and leave machine_shutdown
> as a nop?

Well, the function needs to exist to link the kernel, so I figured it
may as well do something:-)

Judging by the function names, it seems like machine_shutdown() should
put the machine into a state where kexec can work, and machine_kexec()
should do the final "jump". That matches doing disable_nonboot_cpus() in
here. I don't know much about KEXEC_JUMP, but if it were ever
implemented for ARM, I'm not sure we'd want to do the
disable_nonboot_cpus() in that case(?), and machine_shutdown() is called
if !KEXEC_JUMP, but machine_kexec() is called for both.

It also means I get to put that comment right there, which is next to
the equivalent commands for machine_halt/power_off/restart, rather than
in some completely different place in machine_kexec.c.

> Anyway, I'm on holiday without internet until Tuesday, so for these two
> patches:
> 
>   Acked-by: Will Deacon <will.deacon@arm.com>

Thanks!

Russell, does this look good to you? I assume I should put this into the
ARM patch tracker.
