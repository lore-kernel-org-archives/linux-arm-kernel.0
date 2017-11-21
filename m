From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 21 Nov 2017 12:06:23 -0700
Subject: [PATCH v2] arm64: kdump: Avoid to power off nonpanic CPUs
In-Reply-To: <5A145890.4070206@arm.com>
References: <1510996352-16684-1-git-send-email-leo.yan@linaro.org>
 <5A145890.4070206@arm.com>
Message-ID: <CANLsYkyd96Dotgubuoug-3XLpUM_o4_gpFaOHiTF+17bJcmH_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey James,

On 21 November 2017 at 09:47, James Morse <james.morse@arm.com> wrote:
> Hi Leo Yan,
>
> On 18/11/17 09:12, Leo Yan wrote:
>> commit a88ce63b642c ("arm64: kexec: have own crash_smp_send_stop() for
>> crash dump for nonpanic cores") introduces ARM64 architecture function
>
> (This commit fixed a bug where the core-code version was used, this didn't save
> the CPU registers, which made kdump useless.)
>
>
>> crash_smp_send_stop() to replace the weak function, this results in
>> the nonpanic CPUs to be hot-plugged out and CPUs are placed into low
>> power state on ARM64 platforms with the flow:
>>
>>   Panic CPU:
>>     machine_crash_shutdown()
>>       crash_smp_send_stop()
>>       smp_cross_call(&mask, IPI_CPU_CRASH_STOP)
>>
>>   Nonpanic CPUs:
>>     handle_IPI()
>>       ipi_cpu_crash_stop()
>>         cpu_ops[cpu]->cpu_die()
>>
>> The upper patch has no issue if enabled crash dump only; but if enabled
>> crash dump and Coresight debug module for panic dumping at the meantime,
>> nonpanic CPUs are powered off in crash dump flow, later this may
>> introduce conflicts with the Coresight debug module because Coresight
>> debug registers dumping requires the CPU must be powered on for some
>> platforms (e.g. Hi6220 on Hikey board).
>
> Is it just Hikey with this problem?

Any board with the CoreSight debug registers being part of the core
power domain will exhibit that behaviour.

>
>
>> If we cannot keep the CPUs
>> powered on, we can see the hardware lockup issue when access Coresight
>> debug registers.
>
> By 'hardware lockup issue' do you mean you want to use the Coresight debug
> registers to inspect what caused the panic()=>kdump in the first place?
> You mention 'dumping requires the CPU [to] be powered on', I assume it loses
> state when powered off.
>
> ...or does the CPU hang if you use PSCI to power it off while the Coresight
> debug is running?
>
>
>> To fix this issue, this commit bypasses CPU hotplug operation in func
>> crash_smp_send_stop() when coresight CPU debug module has been enabled
>> and let CPUs to run into WFE/WFI states so CPUs can still be powered on
>> after crash dump. This finally is more safe for Coresight debug module
>> to dump registers and avoid hardware lockup.
>
> Ah, there is a hardware-lockup.

Right, this is a classic case of accessing registers on a device that
isn't powered.

>
> Wouldn't the same thing happen if I poke the sysfs cpu online/offline interface
> while this thing is running? (Not to mention cpu-idle)
>
> Shouldn't this be fixed in firmware? If EL3 can see the Coresight debug is running,
> it can hold the CPU in WFE instead of trying to actually power off. Firmware can
> know if the debug hardware and the CPU are powered together, (which I guess is
> why this is a problem on Hikey).

I agree that firmware is the way to go and the driver is provisioning
for that already.  The problem is that the goal posts have moved a
little.

When Leo first introduced the coresight-cpu-debug driver in June
crash_smp_send_stop() wasn't resolving to anything.  As part of the
panic notifier chain the driver was receiving a notification and
setting the COREPURQ and CORENPDRQ in register EDPCR for each CPU.
That was enough for the coresight-cpu-debug driver to do its work
before the CPUs got switched off by operations carried out after calls
to the notifier chain.  Firmware in Juno had been implemented to
properly deal with the COREPURQ and CORENPDRQ signals.

I see two ways to deal with this:

1) Set COREPURQ and CORENPDRQ when the crash collection capability is
enabled in the the coresight-cpu-debug driver (either at boot time or
from sysFS).  That is easy to do but prevent CPUs from being switched
off as soon as the feature is enabled.

2) Somehow add a mechanism in crash_smp_send_stop() to properly deal
with COREPURQ and CORENPDRQ before the IPIs are sent out.  That would
be optimal but the implementation isn't clear to me.  Adding something
like coresight_cpu_powerup_rq(mask)  before smp_cross_call(...) seems
hackish to me.  On the flip side CoreSigh is found on pretty much all
implementation so my opinion is debatable.

Regards,
Mathieu

>
>
> Thanks,
>
> James
>
>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 9f7195a..31dab1f 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -856,7 +856,7 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>>
>>       local_irq_disable();
>>
>> -#ifdef CONFIG_HOTPLUG_CPU
>> +#if defined(CONFIG_HOTPLUG_CPU) && !defined(CONFIG_CORESIGHT_CPU_DEBUG)
>>       if (cpu_ops[cpu]->cpu_die)
>>               cpu_ops[cpu]->cpu_die(cpu);
>>  #endif
>>
>
