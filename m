From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 10 Sep 2014 00:00:34 +0800
Subject: [PATCH v3 09/17] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <540E93A0.4040306@redhat.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-10-git-send-email-hanjun.guo@linaro.org>
 <540E80BD.20801@redhat.com> <540E88A2.1000606@linaro.org>
 <540E93A0.4040306@redhat.com>
Message-ID: <540F2422.90105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?09?09? 13:44, Jon Masters wrote:
> On 09/09/2014 12:57 AM, Hanjun Guo wrote:
>> Hi Jon,
>>
>> On 2014?09?09? 12:23, Jon Masters wrote:
>>> On 09/01/2014 10:57 AM, Hanjun Guo wrote:
>>>> MADT contains the information for MPIDR which is essential for
>>>> SMP initialization, parse the GIC cpu interface structures to
>>>> get the MPIDR value and map it to cpu_logical_map(), and add
>>>> enabled cpu with valid MPIDR into cpu_possible_map.
>>>>
>>>> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
>>>> Parking protocol, but the Parking protocol is only specified for
>>>> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
>>>> before some updates for the ACPI spec or the Parking protocol spec.
>>>> +	/* CPU 0 was already initialized */
>>>> +	if (cpu) {
>>>> +		if (cpu_ops[cpu]->cpu_init(NULL, cpu))
>>>> +			return -EOPNOTSUPP;
>>>> +
>>>> +		/* map the logical cpu id to cpu MPIDR */
>>>> +		cpu_logical_map(cpu) = mpidr;
>>> I'm not sure it's worth noting in a comment or just in the dialogue that
>>> none of these MPIDR values is literally the value in the MPIDR. Linux
>>> doesn't store that anyway (even in the cpu_logical_map), since it is
>>> pre-filtered against MPIDR_HWID_BITMASK to remove the non-affinity level
>>> bits. And since the ACPI5.1 specification requires that non-affinity
>>> bits be zero everything works. But it relies upon this assumption so it
>>> might be worth explicitly masking out the bits when making the call into:
>>>
>>>        acpi_map_gic_cpu_interface(processor->arm_mpidr,
>>>                processor->flags & ACPI_MADT_ENABLED);
>>>
>>> During the parsing of the processor object's MPIDR value.
>> Yes, I agree with you. When I tested this patch set on our
>> ARM64 platform, I found this problem too. some firmware
>> will just present the real MPIDR value to OS which some reserved
>> bit set to 1, and it will lead to some logic problem in this patch.
>> (actually firmware didn't obey with ACPI spec)
>>
>> I had updated the patch with:
>>
>> +	acpi_map_gic_cpu_interface(processor->arm_mpidr & MPIDR_HWID_BITMASK,
>> +		processor->flags & ACPI_MADT_ENABLED);
>>
>> and then the problem was gone :)
> Did I miss an updated patch posting then? It is possible...

No, you didn't miss it, I'm still working on the new version, sorry I didn't
clarify that in my previous email.

Thanks
Hanjun
