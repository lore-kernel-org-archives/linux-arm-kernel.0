From: rafael@kernel.org (Rafael J. Wysocki)
Date: Wed, 11 May 2016 22:45:56 +0200
Subject: [PATCH v4 2/5] ACPI / processor_idle: Add support for Low Power
 Idle(LPI) states
In-Reply-To: <57334A66.6070004@arm.com>
References: <1461069013-13292-1-git-send-email-sudeep.holla@arm.com>
 <1461069013-13292-3-git-send-email-sudeep.holla@arm.com>
 <1857618.TLitUhExSh@vostro.rjw.lan> <57334A66.6070004@arm.com>
Message-ID: <CAJZ5v0gbkQmgGuVBxficJjVrOudRTgKKFFp6tFRCG-Byud8Ozg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 11, 2016 at 5:06 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
>
> On 11/05/16 01:03, Rafael J. Wysocki wrote:
>>
>> On Tuesday, April 19, 2016 01:30:10 PM Sudeep Holla wrote:
>>>

[cut]

>>
>> My main concern about the flattening of _LPI is that at one point we'll
>> probably decide to unflatten it and that will change the behavior for
>> current users.  There needs to be a plan for that IMO.
>>
>
> Are you referring the OS co-ordinated mode ? If yes, I agree. If not,
> can you explain why would we not flatten the LPI states ?

If the platform doesn't autopromote core-level states into
package-level states, then having access to unflattened hierarchy may
be useful.  In some cases the exit latency of core states may be
acceptable, while the exit latency of package states may not be, for
example.

Also the scheduler may want to know which cores are in one package
(from the idle states perspective) at one point.

[cut]

>>> +
>>> +       for (i = 0; i < fl_scnt && i < CPUIDLE_STATE_MAX; i++) {
>>> +               lpi = &pr->power.lpi_states[i];
>>> +
>>> +               state = &drv->states[i];
>>> +               snprintf(state->name, CPUIDLE_NAME_LEN, "LPI-%d", i);
>>> +               strlcpy(state->desc, lpi->desc, CPUIDLE_DESC_LEN);
>>> +               state->exit_latency = lpi->wake_latency;
>>> +               state->target_residency = lpi->min_residency;
>>> +               if (lpi->arch_flags)
>>> +                       state->flags |= CPUIDLE_FLAG_TIMER_STOP;
>>> +               state->enter = acpi_idle_lpi_enter;
>>
>>
>> No ->enter_freeze ?
>>
>
> I don't have a system to test this. Also IIUC the cpuidle does support
> suspend-to-idle even when ->enter_freeze is not implemented right.
> Can we add it later once I find a way to test. Correctly no wakeup on my
> test platform :(

Fair enough.
