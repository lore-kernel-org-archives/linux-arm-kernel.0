From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 20 Sep 2016 17:11:24 +0100
Subject: [PATCH v9 08/10] arm64: pmu: Detect and enable multiple PMUs in
 an ACPI system
In-Reply-To: <b8b27aa5-e80e-f7cc-3410-4b2ac44c69e5@arm.com> (Jeremy Linton's
 message of "Fri, 16 Sep 2016 12:57:20 -0500")
References: <1473892358-22574-1-git-send-email-jeremy.linton@arm.com>
 <1473892358-22574-9-git-send-email-jeremy.linton@arm.com>
 <87y42st1e3.fsf@e105922-lin.cambridge.arm.com>
 <6e0b08db-2e13-be49-5208-c396bf51fe68@arm.com>
 <87bmznu61q.fsf@e105922-lin.cambridge.arm.com>
 <b8b27aa5-e80e-f7cc-3410-4b2ac44c69e5@arm.com>
Message-ID: <87y42msg9f.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeremy Linton <jeremy.linton@arm.com> writes:

> On 09/16/2016 12:07 PM, Punit Agrawal wrote:
>> Jeremy Linton <jeremy.linton@arm.com> writes:
>>
>>> Hi,
>>>
>>> On 09/16/2016 08:33 AM, Punit Agrawal wrote:
>>>> Jeremy Linton <jeremy.linton@arm.com> writes:
>>>>
>>>>> Its possible that an ACPI system has multiple CPU types in it
>>>>> with differing PMU counters. Iterate the CPU's and make a determination
>>>>> about how many of each type exist in the system. Then take and create
>>>>> a PMU platform device for each type, and assign it the interrupts parsed
>>>>> from the MADT. Creating a platform device is necessary because the PMUs
>>>>> are not described as devices in the DSDT table.
>>>>>
>>>>> This code is loosely based on earlier work by Mark Salter.
>>>
>>> (trimming)
>>>
>>>>> +
>>>>> +	list_for_each_entry_safe(pmu, safe_temp, &pmus, list) {
>>>>> +		if (unused_madt_entries)
>>>>> +			pmu->cpu_count = num_possible_cpus();
>>>>
>>>> So if there is any unbooted cpu ...
>>>>
>>>>> +
>>>>> +		res = kcalloc(pmu->cpu_count,
>>>>> +				  sizeof(struct resource), GFP_KERNEL);
>>>>
>>>> ... we allocate potentially large number (num_possible_cpus()) of
>>>> resources for each PMU.
>>>>
>>>> This is needlessly wasteful. Under what conditions have you found
>>>> reg_midr to be 0?
>>>
>>> Unused MADT entries, in place for potentially unbooted/hotplug
>>> CPUs.
>>
>> Is linux able to deal with booting secondaries that have unused MADT
>> entries?
>
> Uh, yah I think so, that is how i've been testing it, maybe we are
> saying different things. When i'm talking about "unused" I mean MADT
> entries that don't have started/running cpus. Obviously they stop
> being unused when a cpu is booted.
>
>>
>>> In those cases you don't know for sure which PMU the CPU belongs
>>> to until it comes online and the MIDR can be read. I'm open to
>>> suggestions on how to deal with this, outside of pushing my luck and
>>> further breaking the platform device encapsulation by trying to
>>> reallocate the resource structure while its active. Besides its only
>>> wasteful for ACPI+big.little, which at the moment only applies to a
>>> development platform.
>>
>> I don't have any ideas to solve this problem, but in the interest of
>> helping review, please move all the changes arising from hotplug/unused
>> MADT entries in this patch to the next one.
>
> Which is sort of the opposite of the last 3 months, of complaints
> about how hard it was to review this module with multiple patches
> adding features to the code...

My suggestion to move functionality that has concerns and needs rework
to later patch is aimed at helping get stuff that everybody agrees upon
merged. But it's only a suggestion...

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
