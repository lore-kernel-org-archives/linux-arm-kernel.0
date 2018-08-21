From: james.morse@arm.com (James Morse)
Date: Tue, 21 Aug 2018 17:48:05 +0100
Subject: [PATCH v4 1/5] arm64: export memblock_reserve()d regions via
 /proc/iomem
In-Reply-To: <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
References: <20180723015732.24252-1-takahiro.akashi@linaro.org>
 <20180723015732.24252-2-takahiro.akashi@linaro.org>
 <CALAqxLU3+tu09M5=D-6xCqweKenfXtZuBGy6tqEP2DoGAs-LNA@mail.gmail.com>
 <38e0224a-46f8-85c3-abe2-5e89d16810ea@arm.com>
Message-ID: <55a21245-7bc2-a700-20ce-1103fbadf72b@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/21/2018 11:22 AM, James Morse wrote:
> On 08/21/2018 05:39 AM, John Stultz wrote:
>> On Sun, Jul 22, 2018 at 6:57 PM, AKASHI Takahiro
>> <takahiro.akashi@linaro.org> wrote:
>>> From: James Morse <james.morse@arm.com>
>>>
>>> There has been some confusion around what is necessary to prevent kexec
>>> overwriting important memory regions. memblock: reserve, or nomap?
>>> Only memblock nomap regions are reported via /proc/iomem, kexec's
>>> user-space doesn't know about memblock_reserve()d regions.
>>>
>>> Until commit f56ab9a5b73ca ("efi/arm: Don't mark ACPI reclaim memory
>>> as MEMBLOCK_NOMAP") the ACPI tables were nomap, now they are reserved
>>> and thus possible for kexec to overwrite with the new kernel or initrd.
>>> But this was always broken, as the UEFI memory map is also reserved
>>> and not marked as nomap.
>>>
>>> Exporting both nomap and reserved memblock types is a nuisance as
>>> they live in different memblock structures which we can't walk at
>>> the same time.
>>>
>>> Take a second walk over memblock.reserved and add new 'reserved'
>>> subnodes for the memblock_reserved() regions that aren't already
>>> described by the existing code. (e.g. Kernel Code)
>>>
>>> We use reserve_region_with_split() to find the gaps in existing named
>>> regions. This handles the gap between 'kernel code' and 'kernel data'
>>> which is memblock_reserve()d, but already partially described by
>>> request_standard_resources(). e.g.:
>>> | 80000000-dfffffff : System RAM
>>> |?? 80080000-80ffffff : Kernel code
>>> |?? 81000000-8158ffff : reserved
>>> |?? 81590000-8237efff : Kernel data
>>> |?? a0000000-dfffffff : Crash kernel
>>> | e00f0000-f949ffff : System RAM
>>>
>>> reserve_region_with_split needs kzalloc() which isn't available when
>>> request_standard_resources() is called, use an initcall.
> 
>>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>>> index 30ad2f085d1f..5b4fac434c84 100644
>>> --- a/arch/arm64/kernel/setup.c
>>> +++ b/arch/arm64/kernel/setup.c
>>> @@ -241,6 +241,44 @@ static void __init request_standard_resources(void)
> 
>>> +static int __init reserve_memblock_reserved_regions(void)
> 
>>> +?????? for_each_reserved_mem_region(i, &start, &end) {
>>> +?????????????? if (end <= roundup_end)
>>> +?????????????????????? continue; /* done already */
>>> +
>>> +?????????????? start = __pfn_to_phys(PFN_DOWN(start));
>>> +?????????????? end = __pfn_to_phys(PFN_UP(end)) - 1;
>>> +?????????????? roundup_end = end;
>>> +
>>> +?????????????? res = kzalloc(sizeof(*res), GFP_ATOMIC);
>>> +?????????????? if (WARN_ON(!res))
>>> +?????????????????????? return -ENOMEM;
>>> +?????????????? res->start = start;
>>> +?????????????? res->end = end;
>>> +?????????????? res->name? = "reserved";
>>> +?????????????? res->flags = IORESOURCE_MEM;
>>> +
>>> +?????????????? mem = request_resource_conflict(&iomem_resource, res);
>>> +?????????????? /*
>>> +??????????????? * We expected memblock_reserve() regions to conflict with
>>> +??????????????? * memory created by request_standard_resources().
>>> +??????????????? */
>>> +?????????????? if (WARN_ON_ONCE(!mem))


>> Since this patch landed, on the HiKey board at bootup I'm seeing:
>>
>> [??? 0.451884] WARNING: CPU: 1 PID: 1 at arch/arm64/kernel/setup.c:271
>> reserve_memblock_reserved_regions+0xd4/0x13c

>> ?From skimming the patch, it seems this is maybe expected? Or should
>> this warning raise eyebrows? I can't quite figure it out.
> 
> Ugh, sorry for the noise! This is warning that there is something wrong
> with our assumptions about what types of memory exist.
> 
> 
>> It seems to trigger on the pstore memory at 0x21f00000-0x21ffffff.
> 
> ... pmem ...


> So, this is a memblock_reserved() range that isn't actually memory.
> 
> This happens because your DT has carved these regions out of the memory
> node, but added a named 'reserved-memory' region for them, just in case?
> I'm not sure what it means if 'reserved-memory' is not also described as
> memory....
> 
> You do need the carve-out, otherwise this gets covered by the linear
> map, and when you throw in that 'unbuffered' property you get both a
> cacheable and uncacheable mapping of the same page.


Hmm, looks like its (even) more complicated than I thought, of_reserved_mem.c's 
definition of 'nomap' is memblock_remove(), not memblock_mark_nomap().

This might be more common to all users of DTs memreserve.


Thanks,

James
