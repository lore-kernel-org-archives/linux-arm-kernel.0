From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 28 Mar 2017 16:38:41 +0100
Subject: [PATCH v2 06/18] arm64: arch_timer: Add infrastructure for
 multiple erratum detection methods
In-Reply-To: <20170328145524.GD2123@mai>
References: <20170322154114.GE30499@mai>
 <a922484a-1bb0-cfd0-1996-fab026a4feae@arm.com> <20170323173030.GA24630@mai>
 <5e8faa45-bb1b-fd9b-f34f-93ce5babb0a3@arm.com> <20170327075628.GE24630@mai>
 <e0e0a3d7-2252-5fd6-3247-c128208fd9b9@arm.com> <20170328133438.GB2123@mai>
 <ec5e673c-6d02-fc88-9913-b0f9261da05e@arm.com> <20170328143633.GC2123@mai>
 <ee4b5b59-e6ef-6f55-792c-6aa39d354adb@arm.com> <20170328145524.GD2123@mai>
Message-ID: <645ab4be-2730-3197-9d70-4e44692ea693@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/03/17 15:55, Daniel Lezcano wrote:
> On Tue, Mar 28, 2017 at 03:48:23PM +0100, Marc Zyngier wrote:
>> On 28/03/17 15:36, Daniel Lezcano wrote:
>>> On Tue, Mar 28, 2017 at 03:07:52PM +0100, Marc Zyngier wrote:
>>>
>>> [ ... ]
>>>
>>>>>>> -bool arch_timer_check_global_cap_erratum(const struct arch_timer_erratum_workaround *wa,
>>>>>>> -					 const void *arg)
>>>>>>> +bool arch_timer_check_cap_erratum(const struct arch_timer_erratum_workaround *wa,
>>>>>>> +				  const void *arg)
>>>>>>>  {
>>>>>>> -	return cpus_have_cap((uintptr_t)wa->id);
>>>>>>> +	return cpus_have_cap((uintptr_t)wa->id) | this_cpu_has_cap((uintptr_t)wa->id);
>>>>>>
>>>>>> Not quite. Here, you're making all capability-based errata to be be
>>>>>> global (if a single CPU in the system has a capability, then by
>>>>>> transitivity cpus_have_cap returns true). If that's a big-little system,
>>>>>> you end-up applying the workaround to all CPUs, including those unaffected.
>>>>>>
>>>>>> I'd rather drop cpus_have_cap altogether and rely on individual CPU
>>>>>> matching (since we don't have a need for a global capability erratum
>>>>>> handling yet).
>>>>>
>>>>> Ok, thanks.
>>>>
>>>> Quick update. I've just implemented this, and found out that getting rid
>>>> of local/global has an unfortunate effect:
>>>>
>>>> Since we only probe the global errata (using ACPI for example) on the
>>>> boot CPU path, we lose propagation of the erratum across the secondary
>>>> CPUs. One way of solving this is to convert the secondary boot path to
>>>> be aware of DT vs ACPI vs detection method of the month. Which isn't
>>>> easy, since by the time we boot secondary CPUs, we don't have the
>>>> pointers to the various ACPI tables anymore. Also, assuming we were
>>>> careful and saved the pointers, the tables may have been unmapped. Fun.
>>>
>>> My proposal was supposed to prevent that. The detecion is done in the
>>> subsystems, ACPI detects ACPI errata, DT detects DT errata and CPU detects CPU
>>> errata. The drivers get the errata and enable the workaround. The id
>>> association <-> errata self contains errata types (void *, char *, int). So
>>> everything can be done in a CPU basis without local / global dance.
>>
>> I'm sorry, but it feels like a Jumbo-Jet sized hammer to try and squash
>> a fly (I'm staying away from the frozen shark metaphor here). You're
>> willing to add a whole list of things with private ids that need
>> matching to kill a flag? I don't think this buys us anything but extra
>> complexity and another maintenance headache.
> 
> Well, it is like your approach except it is split in two steps.
> 
> Can you explain where is the extra complexity ? May be I am missing the point.

This is how I understand your approach:

- Boot the first CPU
- Build a list of errata discovered at that time
- Apply erratum on the boot CPU if required, using a yet-to-be-invented
private id matching mechanism,
- Boot a secondary CPU
- Apply erratum if required, parsing the list
- Realise that you don't have the full list (this CPU comes with an
erratum that was not in the initial list)
- Add more to the list
- Apply erratum, using the same matching mechanism

This is mine:

- Boot the first CPU
- Apply global erratum to all CPUs
- Apply local erratum
- Boot a secondary CPU
- Apply local erratum

In my case, everything is static, and I don't need to rematch each CPU
against the list of globally applicable errata.

If my understanding is flawed, let me know.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
