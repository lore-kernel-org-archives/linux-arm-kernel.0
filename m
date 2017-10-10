From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Tue, 10 Oct 2017 13:51:33 -0600
Subject: [PATCH] arm64: kdump: Avoid to power off nonpanic CPUs
In-Reply-To: <20171008153540.GB1694@remoulade>
References: <1507471966-15367-1-git-send-email-leo.yan@linaro.org>
 <20171008153540.GB1694@remoulade>
Message-ID: <CANLsYkzwKM3tKFy8kaAKsifZjB9L4Jop2TCbC_iXL-EK2R2tSw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 October 2017 at 09:35, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Leo,
>
> On Sun, Oct 08, 2017 at 10:12:46PM +0800, Leo Yan wrote:
>> commit a88ce63b642c ("arm64: kexec: have own crash_smp_send_stop() for
>> crash dump for nonpanic cores") introduces ARM64 architecture function
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
>> nonpanic CPUs are powered off in crash dump flow,
>
> We want to turn secondary CPUs off if at all possible, since we want to prevent
> issues resulting from asynchronous behaviour (e.g. TLB/cache fetches) that
> could result in subsequent problems (e.g. if bad page tables resulted in page
> table walks to MMIO devices).
>
> So we *really* want this behaviour in the general case.
>
>> later this may introduce conflicts with the Coresight debug module because
>> Coresight debug registers dumping requires the CPU must be powered on for
>> some platforms (e.g. Hi6220 on Hikey board). If we cannot keep the CPUs
>> powered on, we can see the hardware lockup issue when access Coresight debug
>> registers.
>
> Just to check I understand, the coresight debug module is being invoked as a
> panic notifier in the current kernel, right?
>
>> To fix this issue, this commit removes CPU hotplug operation in func
>> crash_smp_send_stop() and let CPUs to run into WFE/WFI states so CPUs
>> can still be powered on after crash dump. This finally is more safe
>> for Coresight debug module to dump registers and avoid hardware lockup.
>>
>> Cc: James Morse <james.morse@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Leo Yan <leo.yan@linaro.org>
>> ---
>>  arch/arm64/kernel/smp.c | 6 ------
>>  1 file changed, 6 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>> index 9f7195a..a65e68b 100644
>> --- a/arch/arm64/kernel/smp.c
>> +++ b/arch/arm64/kernel/smp.c
>> @@ -856,12 +856,6 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>>
>>       local_irq_disable();
>>
>> -#ifdef CONFIG_HOTPLUG_CPU
>> -     if (cpu_ops[cpu]->cpu_die)
>> -             cpu_ops[cpu]->cpu_die(cpu);
>> -#endif
>> -
>
> If it's really necessary to keep secondary CPUs online, please limit that to
> the case where the coresight debug module is being used.
>
> IIRC there were similar interactions with cpuidle, and I don't see why hotplug
> should be any different.

Can you point to where it was fixed for CPUidle?  We should try to do
the same for coresight_debug so that things are done the same way.
I'm also thinking that we could call ->cpu_die(cpu) in a #ifdef
CONFIG_HOTPLUG_CPU clause in debug_notifier_call().  That way the
behaviour remains the same, just enacted a little later - please
advise on what option you prefer.

Regards,
Mathieu

>
> Thanks,
> Mark.
