From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 20 Oct 2015 12:17:59 -0700
Subject: vmalloc_reserve with no highmem
In-Reply-To: <56268D82.7030504@redhat.com>
References: <56257AA5.1030800@gmail.com> <56268D82.7030504@redhat.com>
Message-ID: <56269367.2000304@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/10/15 11:52, Laura Abbott wrote:
> On 10/19/2015 04:20 PM, Florian Fainelli wrote:
>> Hi Russell, Laura,
>>
>> Setting vmalloc= on the kernel command-line to define the amount of
>> vmalloc_reserve is not quite working when you have no highmem, as is the
>> case of one my boards which has 512MB or 256M populated on a first bank
>> at PA 0x0.
>>
>> What happens in that case is that, despite setting vmalloc_reserve,
>> therefore bumping up vmalloc_min to a higher address than high_memory,
>> which is assigned __va(arm_lowmem_limit), we end-up with VMALLOC_START
>> at high_memory + VMALLOC_OFFSET, which yields the amount of physical
>> memory (start at PA 0x0 in my case) - VMALLOC_OFFSET.
>>
>> The maths look like this for this particular board (512MB)
>>
>> high_memory = 0x20000000 + PAGE_OFFSET = 0x20000000 + 0xC0000000 =
>> 0xE0000000
>> vmalloc_min = 0xFF00000 - (248 * 1024 * 1024) = 0xEF800000
>>
>> so we end-up with VMALLOC_START = high_memory + VMALLOC_OFFSET =
>> 0xE0000000 + 8 * 1024* 1024 = 0xE0800000
>>
>> in sanity_check_meminfo(), high_memory is unconditionally assigned with
>> arm_lowmem_limit's VA.
>>
>> The following quick and dirty patch seems to do it for me, but I am not
>> confident this is remotely the correct approach here:
>>
>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>> index 14428d2..e196ea4 100644
>> --- a/arch/arm/mm/mmu.c
>> +++ b/arch/arm/mm/mmu.c
>> @@ -1196,7 +1211,14 @@ void __init sanity_check_meminfo(void)
>>          }
>>   #endif
>>          meminfo.nr_banks = j;
>> -       high_memory = __va(arm_lowmem_limit - 1) + 1;
>> +
>> +       if (vmalloc_limit > arm_lowmem_limit)
>> +               high_memory = vmalloc_min - VMALLOC_OFFSET;
>> +       else
>> +               high_memory = __va(arm_lowmem_limit - 1) + 1;
>> +
>> +       pr_info("%s: high_memory: 0x%p, arm_lowmem_limit: 0x%llx\n",
>> +               __func__, high_memory, arm_lowmem_limit);
>>
>> BTW, even when there is highmem available, setting vmalloc= on the
>> command-line is off by VMALLOC_OFFSET, the way early_vmalloc() computes
>> things, is that intended?
>>
>> Thanks!
>>
> 
> Which baseline are you testing off of? Meminfo was removed
> a while ago so I'm not sure where the meminfo.nr_banks context is
> coming from.

This is 3.14, but I can forward port and test the change on 4.3-rcX as
well where this is still relevant.

> 
> This is how arm currently defines VMALLOC ranges
> 
> #define VMALLOC_OFFSET          (8*1024*1024)
> #define VMALLOC_START           (((unsigned long)high_memory +
> VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
> #define VMALLOC_END             0xff000000UL
> 
> VMALLOC_START is based off of the value of high_memory. high_memory
> is supposed to be the limit of the kernel direct mapped ram region so
> setting it to something above that is asking for trouble.

You're right, that does not seem right.

> It seems like this is
> working as intended. You'd have to decouple VMALLOC_START and
> high_memory to make this work properly.

That does not sound that trivial, but I can probably tinker with
something locally which is not keyed of high_memory for now.

> 
> Having a vmalloc_start be greater than the end of direct mapped RAM seems a
> little unusual. This would be leaving a hole in the virtual space. Is this
> what you are intending or is there another use case for adjusting the
> vmalloc space as you described?

The intended use case is something like you have 512MB of physical
memory, you want to give 248MB of this for vmalloc and no more, and the
remainder to a statically carved out region, used for non Linux-managed
allocations.

Do we agree though, that if you are setting vmalloc on the command-line
we should be reserving the amount that is being indicated?
-- 
Florian
