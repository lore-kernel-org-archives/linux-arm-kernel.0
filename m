From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 15 Jul 2015 10:34:08 +0800
Subject: [PATCH v2 3/3] drivers: firmware: psci: add system suspend support
In-Reply-To: <55A50C12.60901@arm.com>
References: <1434462640-19613-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-1-git-send-email-sudeep.holla@arm.com>
 <1434638494-514-4-git-send-email-sudeep.holla@arm.com>
 <20150714141703.0d77242c@xhacker>	<55A4D2F1.5070702@arm.com>
 <20150714175011.31c3d714@xhacker>	<55A4EC37.7030900@arm.com>
 <20150714194038.47ccf2e5@xhacker>	<55A50C12.60901@arm.com>
Message-ID: <20150715103408.07523347@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sudeep,

On Tue, 14 Jul 2015 14:18:10 +0100
Sudeep Holla wrote:

> >>>>>> +
> >>>>>> +static void __init psci_init_system_suspend(void)
> >>>>>> +{
> >>>>>> +	if (!IS_ENABLED(CONFIG_SUSPEND))
> >>>>>> +		return;
> >>>>>> +
> >>>>>> +	if (psci_features(PSCI_FN_NATIVE(1_0, SYSTEM_SUSPEND)))
> >>>>>> +		return;
> >>>>>
> >>>>> So this requires the firmware implements SYSTEM_SUSPEND which doesn't exist
> >>>>> until PSCI 1.0,
> >>>>
> >>>> Correct, if you need System to RAM in Linux on a platform with PSCI
> >>>> firmware, firmware *must implement* SYSTEM_SUSPEND.
> >>>>
> >>>>> and even in PSCI 1.0 SYSTEM_SUSPEND is optional,
> >>>>
> >>>> Optional here means, that you may chose to implement or not in the
> >>>> firmware. It doesn't mean we can implement S2R in Linux using other
> >>>> PSCI methods. SYSTEM_SUSPEND was added mainly to avoid since workarounds
> >>>> in the kernel.
> >>>>
> >>>>> we also want
> >>>>> suspend to ram feature on PSCI 0.2 or PSCI 1.0 w/o SYSTEM_SUSPEND,
> >>>>
> >>>> Why do you choose to have PSCIv1.0 w/o SYSTEM_SUSPEND when you need that
> >>>> feature in Linux. Is it just because we can manage with workarounds ?
> >>>> Sorry, that's not an option.
> >>>
> >>> The problem is the PSCI 1.0 SYSTEM_SUSPEND definition: we can't pass something
> >>> like stateid as in CPU_SUSPEND to firmware. The stateid is used to tell
> >>> firmware to go to different Sleep state, for example S2 or S3.
> >>>
> >>
> >> Can you elaborate on S2 here with an example ? You are using ACPI
> >> Sleep State definitions here which should not be mixed with PSCI.
> >
> > Yes, it's ACPI concept. Here "S2" can be the "S2" mentioned in PSCI 1.0 spec.
> >
> > PSCI 1.0 SPEC says:
> >
> > "While ACPI distinguishes between two system level suspend to RAM states,
> > S2 and S3, PSCI provides a single API. In practice, operating systems use
> > only one suspend to RAM state, so this is not seen as a limitation. Note
> > that this specification is using the state definitions of S2 and S3 provided
> > by ACPI, but does not limit use of this PSCI function to ACPI based systems.
> > Semantics such as those described for sleep states S2 and S3 are used in
> > non-ACPI based systems."
> >
> 
> OK, though similar semantics may be used else where, we need to define
> the state similar to the way ACPI does it for x86 systems.
> 
> > Here is an example:
> >
> > S3 is the state where All devices are suspended and power down,  memory is
> > placed in self-refresh mode. Usually this is the suspend to ram state.
> >
> 
> Agreed.
> 
> > S2 is the state where devices except cpus are suspended and put in a
> > low-power state(not power off), if the deivce doesn't support lower power mode,
> > the device is left on. memory is placed in self-refresh mode. secondary CPUs
> > are powered off via. PSCI_CPU_OFF, boot cpu is put into WFI state and runs at
> > low freq.
> >
> 
> Is this a standard state or custom tailored for some power optimization
> on particular system ? Anyway I am not sure if I quite understand the

This is customized state.

> exact definition of this state. When and how often do you use this
> use this state ?

Very often. When we want s2ram similar state but low-latency back transition,
we want to use this state.

> 
> Have you looked at PM_SUSPEND_FREEZE state implemented in Linux ?
> For me this S2 you explained sounds similar to PM_SUSPEND_FREEZE state.
> In short, PM_SUSPEND_FREEZE = all the processes are frozen + all the
> devices are suspended + all the processors enter deepest idle state
> possible.

The S2 in my example is a bit different with freeze. It's looks more like
the S1 or standby in Documentation/power/states.txt. The biggest difference
with freeze is whether putting memory in self-refresh state or not.

> 
> Though I don't understand why you need to power-off secondary cpus
> and stay in WFI on boot cpu as that would have increased latency

we want save more power, the increased latency is affordable.

> defeating the purpose of S2 state. Also why you are mixing DVFS here ?
> PSCI deals with just low power states and has nothing to do with DVFS.

It's not DVFS related, but to put the boot cpu in a low power state while
still keeping its power.

> 
> Further IMO we can also achieve a low power state almost close to
> PM_SUSPEND_FREEZE having run-time PM for all the devices and cpuidle.

we want one more sleep state which saves more power than freeze.

Or let's change the question: how to implement "standby" or "s1" in
Documentation/power/states.txt with the help of PSCI? Seems the PSCI spec
expects "operating systems use only one suspend to RAM state", but this
is a limitation in the long run.

Thanks,
Jisheng
