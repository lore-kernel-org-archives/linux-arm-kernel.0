From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 30 Nov 2017 10:45:18 -0700
Subject: [PATCH v2] arm64: kdump: Avoid to power off nonpanic CPUs
In-Reply-To: <5A1ED9F8.2040207@arm.com>
References: <1510996352-16684-1-git-send-email-leo.yan@linaro.org>
 <5A145890.4070206@arm.com>
 <CANLsYkyd96Dotgubuoug-3XLpUM_o4_gpFaOHiTF+17bJcmH_g@mail.gmail.com>
 <5A1ED9F8.2040207@arm.com>
Message-ID: <CANLsYkx7JHuRmm2eUwNyQdSDmVndNX6tOMzo6zH8Yi4+0fmgXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 November 2017 at 09:02, James Morse <james.morse@arm.com> wrote:
> Hi Mathieu,
>
> On 21/11/17 19:06, Mathieu Poirier wrote:
>> On 21 November 2017 at 09:47, James Morse <james.morse@arm.com> wrote:
>>> On 18/11/17 09:12, Leo Yan wrote:
>>>> The upper patch has no issue if enabled crash dump only; but if enabled
>>>> crash dump and Coresight debug module for panic dumping at the meantime,
>>>> nonpanic CPUs are powered off in crash dump flow, later this may
>>>> introduce conflicts with the Coresight debug module because Coresight
>>>> debug registers dumping requires the CPU must be powered on for some
>>>> platforms (e.g. Hi6220 on Hikey board).
>>>
>>> Is it just Hikey with this problem?
>>
>> Any board with the CoreSight debug registers being part of the core
>> power domain will exhibit that behaviour.
>
> When the external-debugger interface is internal?
> The problem is Linux can't know this is the case and that firmware isn't doing
> the right thing to work around it.

The approach that was taken in the coresight-debug driver is that we
care about firmware that does the right thing, i.e properly dealing
with the COREPURQ and CORENPDRQ lines.  Otherwise we can't do anything
and boards will simply crash.   That will force firmware to do the
right thing.

>
> If we were to take the line firmware must work around this SoC-specific
> integration issue, which boards break? Is it just Hikey? Will a user of this
> coresight kdump thing know how to update the firmware?
>
> I want to avoid fixing this in such a way that firmware never needs to do the
> right thing, as Linux always has to work round it... (but that ship may have
> sailed!)...

Same here.  Dealing with every board where firmware doesn't do the
right thing isn't realistic.

>
>
>>>> If we cannot keep the CPUs
>>>> powered on, we can see the hardware lockup issue when access Coresight
>>>> debug registers.
>>>
>>> By 'hardware lockup issue' do you mean you want to use the Coresight debug
>>> registers to inspect what caused the panic()=>kdump in the first place?
>>> You mention 'dumping requires the CPU [to] be powered on', I assume it loses
>>> state when powered off.
>>>
>>> ...or does the CPU hang if you use PSCI to power it off while the Coresight
>>> debug is running?
>>>
>>>
>>>> To fix this issue, this commit bypasses CPU hotplug operation in func
>>>> crash_smp_send_stop() when coresight CPU debug module has been enabled
>>>> and let CPUs to run into WFE/WFI states so CPUs can still be powered on
>>>> after crash dump. This finally is more safe for Coresight debug module
>>>> to dump registers and avoid hardware lockup.
>>>
>>> Ah, there is a hardware-lockup.
>>
>> Right, this is a classic case of accessing registers on a device that
>> isn't powered.
>
> Sounds fun.
> This wasn't particularly clear from this commit message.
>
>
>>> Wouldn't the same thing happen if I poke the sysfs cpu online/offline interface
>>> while this thing is running? (Not to mention cpu-idle)
>>>
>>> Shouldn't this be fixed in firmware? If EL3 can see the Coresight debug is running,
>>> it can hold the CPU in WFE instead of trying to actually power off. Firmware can
>>> know if the debug hardware and the CPU are powered together, (which I guess is
>>> why this is a problem on Hikey).
>>
>> I agree that firmware is the way to go and the driver is provisioning
>> for that already.  The problem is that the goal posts have moved a
>> little.
>>
>> When Leo first introduced the coresight-cpu-debug driver in June
>> crash_smp_send_stop() wasn't resolving to anything.
>
> (You were depending on a bug that broke kdump).

(perhaps but the end result is the same, Leo's implementation was working)

>
>
>> As part of the
>> panic notifier chain the driver was receiving a notification and
>> setting the COREPURQ and CORENPDRQ in register EDPCR for each CPU.
>
> From Documentation/trace/coresight-cpu-debug.txt, these bits inhibit power-off
> on 'sane' systems.

Correct, we have decided to not deal with 'insane' systems.

>
>
>> That was enough for the coresight-cpu-debug driver to do its work
>> before the CPUs got switched off by operations carried out after calls
>> to the notifier chain.
>
> Ugh, because smp_send_stop() doesn't bother trying to turn off the CPUs. (fixing
> this is on my todo list, glad to know what it'll break!)
>
>
>> Firmware in Juno had been implemented to
>> properly deal with the COREPURQ and CORENPDRQ signals.
>
> (Would coresight-cpu-debug.txt classify Juno as sane?)

Despite all the shortcomings, its firmware does the right thing.

>
> What do you expect firmware do to here? It looks like you are using CORENPDRQ as
> a flag for firmware on insane systems to not do the power-down.

Did you mean "sane" here?  If so that's exactly it.  On same systems
FW won't power down for as long as CORENPDRQ is set.

>
> Does this Juno firmware work with cpu-idle and coresight debug?
>
>
>> I see two ways to deal with this:
>>
>> 1) Set COREPURQ and CORENPDRQ when the crash collection capability is
>> enabled in the the coresight-cpu-debug driver (either at boot time or
>> from sysFS).
>
>> That is easy to do but prevent CPUs from being switched
>> off as soon as the feature is enabled.
>
> ...isn't that what you want?

It is, but that way of addressing things has a huge cost on power savings.

>
> From coresight-cpu-debug.txt, it looks like this wouldn't work on an insane
> system unless firmware is reading those bits. Can you spot these systems from
> the power-domains property in the DT?

You can't but again, we have decided to not care about system where
the firmware doesn't take the lines into account.

>
> Do you have any way of knowing whether firmware is working around this issue?

Not sure what you mean by "around this issue" - firmware either
handles the COREPURQ and CORENPDRQ lines or it doesn't. I may have
misunderstood your comment.

>
> I want to keep the current behaviour for systems not using coresight-cpu-debug
> and ideally for those where firmware is doing the right thing. i.e. linux
> powers-off CPUs when it isn't using them. This rules out this-patches
> compile-time approach, as it all needs to work with a single kernel image.

Correct, or nohlt can be used on the cmd line of broken systems.  But
that would need to be tested though.

>
>
> Fixing this in firmware means this thing would work over cpu-idle, and the user
> doesn't need to know about the SoCs power domains in order to craft a
> coresight-debug compatible cmdline.

Correct.

>
> (What are you using nohlt for?)

That's the work around for systems where firmware is broken.

Regards,
Mathieu

>
>
> Thanks,
>
> James
>
>>>> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
>>>> index 9f7195a..31dab1f 100644
>>>> --- a/arch/arm64/kernel/smp.c
>>>> +++ b/arch/arm64/kernel/smp.c
>>>> @@ -856,7 +856,7 @@ static void ipi_cpu_crash_stop(unsigned int cpu, struct pt_regs *regs)
>>>>
>>>>       local_irq_disable();
>>>>
>>>> -#ifdef CONFIG_HOTPLUG_CPU
>>>> +#if defined(CONFIG_HOTPLUG_CPU) && !defined(CONFIG_CORESIGHT_CPU_DEBUG)
>>>>       if (cpu_ops[cpu]->cpu_die)
>>>>               cpu_ops[cpu]->cpu_die(cpu);
>>>>  #endif
>>>>
>>>
>
