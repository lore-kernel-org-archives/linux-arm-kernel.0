From: dave.kleikamp@oracle.com (Dave Kleikamp)
Date: Tue, 3 Jul 2018 11:12:23 -0500
Subject: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via
 /proc/iomem
In-Reply-To: <20180703064726.GU23681@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-2-takahiro.akashi@linaro.org>
 <72307608-90e0-4842-edc1-d3b284782940@oracle.com>
 <ca9e5d9d-e090-f9e0-bc10-3297c9e3b7e1@arm.com>
 <891c3e5a-9760-1353-4a2c-0900082dd245@oracle.com>
 <20180703064726.GU23681@linaro.org>
Message-ID: <a9c38b0d-db67-2f5b-ea0e-ec6e45d2c4c9@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/03/2018 01:47 AM, AKASHI Takahiro wrote:
> On Tue, Jun 19, 2018 at 10:22:46AM -0500, Dave Kleikamp wrote:
>> On 06/19/2018 10:00 AM, James Morse wrote:
>>> Hi Dave,
>>>
>>> On 19/06/18 14:37, Dave Kleikamp wrote:
>>>> On 06/19/2018 01:44 AM, AKASHI Takahiro wrote:
>>>>> +static int __init reserve_memblock_reserved_regions(void)
>>>>> +{
>>>>> +	phys_addr_t start, end, roundup_end = 0;
>>>>> +	struct resource *mem, *res;
>>>>> +	u64 i;
>>>>> +
>>>>> +	for_each_reserved_mem_region(i, &start, &end) {
>>>>> +		if (end <= roundup_end)
>>>>> +			continue; /* done already */
>>>>> +
>>>>> +		start = __pfn_to_phys(PFN_DOWN(start));
>>>>> +		end = __pfn_to_phys(PFN_UP(end)) - 1;
>>>>> +		roundup_end = end;
>>>>> +
>>>>> +		res = kzalloc(sizeof(*res), GFP_ATOMIC);
>>>>> +		if (WARN_ON(!res))
>>>>> +			return -ENOMEM;
>>>>> +		res->start = start;
>>>>> +		res->end = end;
>>>>> +		res->name  = "reserved";
>>>>> +		res->flags = IORESOURCE_MEM;
>>>>> +
>>>>> +		mem = request_resource_conflict(&iomem_resource, res);
>>>>> +		/*
>>>>> +		 * We expected memblock_reserve() regions to conflict with
>>>>> +		 * memory created by request_standard_resources().
>>>>> +		 */
>>>>> +		if (WARN_ON_ONCE(!mem))
>>>>> +			continue;
>>>>> +		kfree(res);
>>>>
>>>> Why is kfree() after the conditional continue? This is a memory leak.
>>>
>>> request_resource_conflict() inserts res into the iomem_resource tree, or returns
>>> the conflict if there is already something at this address.
>>>
>>> We expect something at this address: a 'System RAM' section added by
>>> request_resource(). This code wants the conflicting 'System RAM' entry so that
>>> reserve_region_with_split() can fill in the gaps below it with 'reserved'. See
>>> the commit-message for an example.
>>>
>>> If there was no conflict, it means the memory map doesn't look like we expect,
>>> we can't pass NULL to reserve_region_with_split(), and we just inserted the
>>> 'reserved' at the top level. Freeing res at this point would be a use-after-free
>>> hanging from /proc/iomem.
>>> This code generates a WARN_ON_ONCE() and leaves the 'reserved' description where
>>> it is.
>>
>> Okay. I get it.
>>
>>> Trying to cleanup here is pointless, we can remove the resource entry and free
>>> it ... but we still want to report it as reserved, which is what just happened,
>>> just not quite how we we wanted it.
>>>
>>> If you ever see this warning, it means some RAM stopped being nomap between
>>> request_resources() and reserve_memblock_reserved_regions(). I can't find any
>>> case where that ever happens.
>>>
>>>
>>> If all that makes sense: how can I improve the comment above the WARN_ON_ONCE()
>>> to make it clearer?
>>
>> I guess something like you described above.
>>
>> /*
>>  * We expect a 'System RAM' section at this address. In the unexpected
>>  * case where one is not found, request_resource_conflict() will insert
>>  * res into the iomem_resource tree.
>>  */
>>
>> Do you think this is clearer?
> 
> If this is the only change needed in my patchset, I'd like the maintainers
> to take care of it instead of my posting another version.

Agreed. The sooner this gets fixed, the better.

Thanks,
Dave

> 
> Thanks,
> -Takahiro AKASHI
> 
>>>
>>>
>>> Thanks,
>>>
>>> James
>>>
>>>
>>>>> +
>>>>> +		reserve_region_with_split(mem, start, end, "reserved");
>>>>> +	}
>>>>> +
>>>>> +	return 0;
>>>>> +}
>>>>> +arch_initcall(reserve_memblock_reserved_regions);
>>>>> +
>>>>>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>>>>>  
>>>>>  void __init setup_arch(char **cmdline_p)
>>>>>
>>>
