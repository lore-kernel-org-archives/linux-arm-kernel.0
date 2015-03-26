From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 27 Mar 2015 07:01:10 +0800
Subject: [patch v11 12/23] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <20150326211239.GA23660@arm.com>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-13-git-send-email-hanjun.guo@linaro.org>
 <20150325171735.GI14585@localhost> <20150326151510.GI2805@arm.com>
 <551462A2.4070308@linaro.org> <20150326211239.GA23660@arm.com>
Message-ID: <55148FB6.1030106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?03?27? 05:12, Will Deacon wrote:
> On Thu, Mar 26, 2015 at 07:48:50PM +0000, Hanjun Guo wrote:
>> On 2015?03?26? 23:15, Will Deacon wrote:
>>> commit 8ef320319592693f4a6286d80df210fd47b3e356
>>> Author: Will Deacon <will.deacon@arm.com>
>>> Date:   Thu Mar 26 15:09:20 2015 +0000
>>>
>>>       ARM64 / ACPI: fix usage of acpi_map_gic_cpu_interface
>>>
>>>       acpi_parse_gic_cpu_interface calls acpi_map_gic_cpu_interface by both
>>>       passing a 32-bit value in the u8 enabled parameter and then subsequently
>>>       ignoring its return value.
>>>
>>>       Sort it out.
>>>
>>>       Reported-by: Catalin Marinas <catalin.marinas@arm.com>
>>>       Signed-off-by: Will Deacon <will.deacon@arm.com>
>>>
>>> diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
>>> index cd60329da8c4..07649e413244 100644
>>> --- a/arch/arm64/kernel/acpi.c
>>> +++ b/arch/arm64/kernel/acpi.c
>>> @@ -103,9 +103,12 @@ void __init __acpi_unmap_table(char *map, unsigned long size)
>>>     *
>>>     * Returns the logical cpu number which maps to MPIDR
>>>     */
>>> -static int __init acpi_map_gic_cpu_interface(u64 mpidr, u8 enabled)
>>> +static int __init
>>> +acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
>>
>> How about just replace u8 with u32? This function has its purpose to
>> be lived, on x86/ia64, ACPI core will get the physcal cpu ID via
>> ACPI handle, then pass it to the arch specific mapping function
>> to map the physcal cpu ID with logical cpu ID for the new added
>> CPU, so when ACPI based CPU hot-plug is introduced on ARM64, we
>> need to go back to that solution.
>
> If/when that happens, we can change things then. Right now, this is a static
> function with one caller. One step at a time, please.
>
>>>    {
>>>    	int i;
>>> +	u64 mpidr = processor->arm_mpidr & MPIDR_HWID_BITMASK;
>>> +	bool enabled = !!(processor->flags & ACPI_MADT_ENABLED);
>>>
>>>    	if (mpidr == INVALID_HWID) {
>>>    		pr_info("Skip MADT cpu entry with invalid MPIDR\n");
>>> @@ -178,11 +181,7 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
>>>    		return -EINVAL;
>>>
>>>    	acpi_table_print_madt_entry(header);
>>> -
>>> -	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMASK,
>>> -		processor->flags & ACPI_MADT_ENABLED);
>>> -
>>> -	return 0;
>>> +	return acpi_map_gic_cpu_interface(processor);
>>
>> I don't think we need to return the error value here, in ACPI
>> core, it will stop the MADT scanning once it returned the error
>> value, but actually we can skip some disabled GICC (cpu) entries
>> and find all the enabled ones in MADT, for example,
>>
>> cpu0 entry, with flag enabled
>> cpu1 entry, disabled  - if we return the error value, table scanning
>>                           will stop
>> cpu2 entry, enabled   - and this cpu will be ignored
>
> Then send me a patch making acpi_map_gic_cpu_interface have a void return
> type. Ignoring the return type is usually a good way to introduce subtle
> bugs.

OK, I will, and I will cleanup the comments for this function too.

Need some sleep first...

Thanks
Hanjun
