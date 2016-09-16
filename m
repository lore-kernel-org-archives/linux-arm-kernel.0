From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 16 Sep 2016 11:32:02 -0500
Subject: [PATCH v9 08/10] arm64: pmu: Detect and enable multiple PMUs in
 an ACPI system
In-Reply-To: <87y42st1e3.fsf@e105922-lin.cambridge.arm.com>
References: <1473892358-22574-1-git-send-email-jeremy.linton@arm.com>
 <1473892358-22574-9-git-send-email-jeremy.linton@arm.com>
 <87y42st1e3.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <6e0b08db-2e13-be49-5208-c396bf51fe68@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09/16/2016 08:33 AM, Punit Agrawal wrote:
> Jeremy Linton <jeremy.linton@arm.com> writes:
>
>> Its possible that an ACPI system has multiple CPU types in it
>> with differing PMU counters. Iterate the CPU's and make a determination
>> about how many of each type exist in the system. Then take and create
>> a PMU platform device for each type, and assign it the interrupts parsed
>> from the MADT. Creating a platform device is necessary because the PMUs
>> are not described as devices in the DSDT table.
>>
>> This code is loosely based on earlier work by Mark Salter.

(trimming)

>> +
>> +	list_for_each_entry_safe(pmu, safe_temp, &pmus, list) {
>> +		if (unused_madt_entries)
>> +			pmu->cpu_count = num_possible_cpus();
>
> So if there is any unbooted cpu ...
>
>> +
>> +		res = kcalloc(pmu->cpu_count,
>> +				  sizeof(struct resource), GFP_KERNEL);
>
> ... we allocate potentially large number (num_possible_cpus()) of
> resources for each PMU.
>
> This is needlessly wasteful. Under what conditions have you found
> reg_midr to be 0?

Unused MADT entries, in place for potentially unbooted/hotplug CPUs. In 
those cases you don't know for sure which PMU the CPU belongs to until 
it comes online and the MIDR can be read. I'm open to suggestions on how 
to deal with this, outside of pushing my luck and further breaking the 
platform device encapsulation by trying to reallocate the resource 
structure while its active. Besides its only wasteful for 
ACPI+big.little, which at the moment only applies to a development platform.
