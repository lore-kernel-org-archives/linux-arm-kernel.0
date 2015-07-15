From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 15 Jul 2015 11:20:27 +0100
Subject: [PATCH v2 3/3] drivers: firmware: psci: add system suspend support
In-Reply-To: <20150715103408.07523347@xhacker>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>	<1434638494-514-1-git-send-email-sudeep.holla@arm.com>	<1434638494-514-4-git-send-email-sudeep.holla@arm.com>	<20150714141703.0d77242c@xhacker>	<55A4D2F1.5070702@arm.com>	<20150714175011.31c3d714@xhacker>	<55A4EC37.7030900@arm.com>	<20150714194038.47ccf2e5@xhacker>	<55A50C12.60901@arm.com>
 <20150715103408.07523347@xhacker>
Message-ID: <55A633EB.2000609@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jisheng,

On 15/07/15 03:34, Jisheng Zhang wrote:
> Dear Sudeep,
>
> On Tue, 14 Jul 2015 14:18:10 +0100
> Sudeep Holla wrote:

[...]

>>
>> OK, though similar semantics may be used else where, we need to define
>> the state similar to the way ACPI does it for x86 systems.
>>
>>> Here is an example:
>>>
>>> S3 is the state where All devices are suspended and power down,  memory is
>>> placed in self-refresh mode. Usually this is the suspend to ram state.
>>>
>>
>> Agreed.
>>
>>> S2 is the state where devices except cpus are suspended and put in a
>>> low-power state(not power off), if the deivce doesn't support lower power mode,
>>> the device is left on. memory is placed in self-refresh mode. secondary CPUs
>>> are powered off via. PSCI_CPU_OFF, boot cpu is put into WFI state and runs at
>>> low freq.
>>>
>>
>> Is this a standard state or custom tailored for some power optimization
>> on particular system ? Anyway I am not sure if I quite understand the
>
> This is customized state.
>

OK, but I do have concern as you mention that you leave certain device
on, what if that device initiate some DMA operation which might not be
possible when DDR is in self-refresh mode. IMO this is highly customized
state.

>> exact definition of this state. When and how often do you use this
>> use this state ?
>
> Very often. When we want s2ram similar state but low-latency back transition,
> we want to use this state.
>

I don't understand this. You want secondaries hot-plugged out which is
quite expensive yet you mention this is low-latency. That could be
possible as you leave last CPU in WFI but again highly customized state.

>>
>> Have you looked at PM_SUSPEND_FREEZE state implemented in Linux ?
>> For me this S2 you explained sounds similar to PM_SUSPEND_FREEZE state.
>> In short, PM_SUSPEND_FREEZE = all the processes are frozen + all the
>> devices are suspended + all the processors enter deepest idle state
>> possible.
>
> The S2 in my example is a bit different with freeze. It's looks more like
> the S1 or standby in Documentation/power/states.txt. The biggest difference
> with freeze is whether putting memory in self-refresh state or not.
>

OK I am still struggling to map these(S1/S2) to ARM systems as they
designed and map well for x86 systems. Since the idle states on include
state where CPU power is lost, I wonder if the state you are explaining
provides any more power save compared to system freeze.

>>
>> Though I don't understand why you need to power-off secondary cpus
>> and stay in WFI on boot cpu as that would have increased latency
>
> we want save more power, the increased latency is affordable.
>

Which clearly contradicts what you said above.

>> defeating the purpose of S2 state. Also why you are mixing DVFS here ?
>> PSCI deals with just low power states and has nothing to do with DVFS.
>
> It's not DVFS related, but to put the boot cpu in a low power state while
> still keeping its power.
>

If there's nothing for CPU to do, some CPUFreq governors(e.g.
interactive) will ensure lowest OPP is chosen so you need not do
anything extra I believe.

>>
>> Further IMO we can also achieve a low power state almost close to
>> PM_SUSPEND_FREEZE having run-time PM for all the devices and cpuidle.
>
> we want one more sleep state which saves more power than freeze.
>

Do you have any power/latency number that indicates freeze is not that
power efficient ? Also I imagine you S2 state has higher latency as you
are doing CPU hot-plug.

> Or let's change the question: how to implement "standby" or "s1" in
> Documentation/power/states.txt with the help of PSCI? Seems the PSCI spec
> expects "operating systems use only one suspend to RAM state", but this
> is a limitation in the long run.
>

OK, this one I leave it for you to take up discussion in PSCI forum with
justification(power/latency numbers to prove an extra system state is
really worthy)

Regards,
Sudeep
