From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 09 May 2015 16:06:34 +0200
Subject: Memory size unaligned to section boundary
In-Reply-To: <20150509135458.GQ2067@n2100.arm.linux.org.uk>
References: <a865bd68d706f8c4c9e82a374ff6adc4@agner.ch>
 <20150506101104.GD2067@n2100.arm.linux.org.uk>
 <20150506105102.GB5382@e104818-lin.cambridge.arm.com>
 <20150506113503.GT2067@n2100.arm.linux.org.uk> <554E0DC8.4060401@redhat.com>
 <20150509134818.GP2067@n2100.arm.linux.org.uk> <554E1178.5030409@redhat.com>
 <20150509135458.GQ2067@n2100.arm.linux.org.uk>
Message-ID: <554E146A.9060207@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 09-05-15 15:54, Russell King - ARM Linux wrote:
> On Sat, May 09, 2015 at 03:54:00PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 09-05-15 15:48, Russell King - ARM Linux wrote:
>>> On Sat, May 09, 2015 at 03:38:16PM +0200, Hans de Goede wrote:
>>>> Ok, so does that mean that Mark's original patch:
>>>>
>>>> ---->8----
>>>> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
>>>> index 4e6ef89..2ea13f0 100644
>>>> --- a/arch/arm/mm/mmu.c
>>>> +++ b/arch/arm/mm/mmu.c
>>>> @@ -1125,9 +1125,9 @@ void __init sanity_check_meminfo(void)
>>>>                           * occurs before any free memory is mapped.
>>>>                           */
>>>>                          if (!memblock_limit) {
>>>> -                               if (!IS_ALIGNED(block_start, SECTION_SIZE))
>>>> +                               if (!IS_ALIGNED(block_start, PMD_SIZE))
>>>>                                          memblock_limit = block_start;
>>>> -                               else if (!IS_ALIGNED(block_end, SECTION_SIZE))
>>>> +                               else if (!IS_ALIGNED(block_end, PMD_SIZE))
>>>>                                          memblock_limit = arm_lowmem_limit;
>>>>                          }
>>>>
>>>> @@ -1142,7 +1142,7 @@ void __init sanity_check_meminfo(void)
>>>>           * last full section, which should be mapped.
>>>>           */
>>>>          if (memblock_limit)
>>>> -               memblock_limit = round_down(memblock_limit, SECTION_SIZE);
>>>> +               memblock_limit = round_down(memblock_limit, PMD_SIZE);
>>>>          if (!memblock_limit)
>>>>                  memblock_limit = arm_lowmem_limit;
>>>>
>>>>
>>>> Is good, or do we only need to have the last chunk of this patch ?
>>>
>>> That should do it, thanks.
>>
>> "that should do it" means the entire patch or only the last chunk?
>
> Entire patch.

Ok, I'll try to give this a test run on an affected system soonish.

Regards,

Hans
