From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 30 Oct 2014 16:27:36 +0800
Subject: [PATCH v5 12/18] ACPI / processor: Make it possible to get CPU
 hardware ID via GICC
In-Reply-To: <20141029104321.GA8896@e102568-lin.cambridge.arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-13-git-send-email-hanjun.guo@linaro.org>
 <20141024173920.GB8303@red-moon> <544E1732.5090902@linaro.org>
 <20141029104321.GA8896@e102568-lin.cambridge.arm.com>
Message-ID: <5451F678.5090900@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-10-29 18:43, Lorenzo Pieralisi wrote:
> On Mon, Oct 27, 2014 at 09:58:10AM +0000, Hanjun Guo wrote:
> 
> [...]
> 
>>>> +static int map_gicc_mpidr(struct acpi_subtable_header *entry,
>>>> +		int device_declaration, u32 acpi_id, int *mpidr)
>>>> +{
>>>> +	struct acpi_madt_generic_interrupt *gicc =
>>>> +	    container_of(entry, struct acpi_madt_generic_interrupt, header);
>>>> +
>>>> +	if (!(gicc->flags & ACPI_MADT_ENABLED))
>>>> +		return -ENODEV;
>>>> +
>>>> +	/* In the GIC interrupt model, logical processors are
>>>> +	 * required to have a Processor Device object in the DSDT,
>>>> +	 * so we should check device_declaration here
>>>> +	 */
>>>> +	if (device_declaration && (gicc->uid == acpi_id)) {
>>>> +		/*
>>>> +		 * Only bits [0:7] Aff0, bits [8:15] Aff1, bits [16:23] Aff2
>>>> +		 * and bits [32:39] Aff3 are meaningful, so pack the Affx
>>>> +		 * fields into a single 32 bit identifier to accommodate the
>>>> +		 * acpi processor drivers.
>>>> +		 */
>>>> +		*mpidr = ((gicc->arm_mpidr & 0xff00000000) >> 8)
>>>> +			 | gicc->arm_mpidr;
>>>
>>> The simple fact that you define a function to pack the mpidr value and
>>> you can't use it here because this is *generic* code is telling, and
>>> a very bad omen. At the cost of sounding like a broken record, I do not
>>> like this mpidr->apic->logical_cpu song and dance at all.
>>> ACPI is peppered with code (eg hotplug is another example, CPUidle driver
>>> even worse) that is supposed to be generic but contains x86 code to carry
>>> out this cpuid conversion, I really think that in order to start an ARM64
>>> ACPI port properly we should at least try to factor out this physical to
>>> logical cpu id conversion, and it is not the first time that I mention this
>>> on the lists.
>>
>> I know, thanks for pointing this out. As I replied in previous version
>> of this patch set, apic_id is x86/ia64 specific, but the meaning behind
>> it is not. It means the CPU hardware id to identify itself in the system,
>> it just like MPIDR on ARM.
> 
> Yes, except that it is called apic_id.
> 
>> I will send out a patch for RFC to convert apic_id to physid which
>> is generic for all platforms.
> 
> That seems a good idea to sound out if I am the only one having an issue
> with the current approach.
> 
>>> I will also talk to Rafael about this at the earliest opportunity, I
>>> guess that x86 code relies on apic-id because some ACPI versions could
>>> not rely on the acpi-id or some other reasons I have to investigate.
>>
>> As ACPI spec (section 8.4, Declaring Processors) said, Each processor
>> in the system must be declared in the ACPI namespace, so each cpu will
>> have acpi_id in all ACPI versions, and in theory we can map acpi_id to
>> logical cpu id if we want to.
>>
>> But things are complicated, apic_id is connected to many
>> tables, MADT for smp init, DSDT for device driver, and SRAT for NUMA (there
>> is no acpi_id in it, ONLY has apic_id in the table for x86/ia64), so if we
>> want to factor the code to map acpi_id to logical cpu id, we need to modify:
>>
>>  - ACPI drivers;
>>  - SMP init for x86 and ia64
>>  - the mappings for NUMA init for x86 and ia64
>> that will be lots of work I think.
>>
>> I'm willing to discuss this further and come out a solution, please
>> comment on what I said and share your ideas :)
> 
> Factoring out apic_id to a common cpu_physical_id is ok to me, because
> basically that's what you are doing except for the naming. I do not
> have any particular preference for the acpi_id, I mentioned that only
> as a means to implement a generic cpu_physical_id, arch agnostic.
> 
> Drop the RFC you mentioned above please on the list, we will restart debating
> from there.

Ok, will send out the patch soon.

Thanks
Hanjun
