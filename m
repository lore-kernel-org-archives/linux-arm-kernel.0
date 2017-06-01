From: dvyukov@google.com (Dmitry Vyukov)
Date: Thu, 1 Jun 2017 18:45:32 +0200
Subject: [PATCH 3/4] arm64/kasan: don't allocate extra shadow memory
In-Reply-To: <20170601163442.GC17711@leverpostej>
References: <20170601162338.23540-1-aryabinin@virtuozzo.com>
 <20170601162338.23540-3-aryabinin@virtuozzo.com>
 <20170601163442.GC17711@leverpostej>
Message-ID: <CACT4Y+aCKDF95mK2-nuiV0+XineHha3y+6PCW0-EorOaY=TFng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 1, 2017 at 6:34 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> On Thu, Jun 01, 2017 at 07:23:37PM +0300, Andrey Ryabinin wrote:
>> We used to read several bytes of the shadow memory in advance.
>> Therefore additional shadow memory mapped to prevent crash if
>> speculative load would happen near the end of the mapped shadow memory.
>>
>> Now we don't have such speculative loads, so we no longer need to map
>> additional shadow memory.
>
> I see that patch 1 fixed up the Linux helpers for outline
> instrumentation.
>
> Just to check, is it also true that the inline instrumentation never
> performs unaligned accesses to the shadow memory?

Inline instrumentation generally accesses only a single byte.

> If so, this looks good to me; it also avoids a potential fencepost issue
> when memory exists right at the end of the linear map. Assuming that
> holds:
>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
>
> Thanks,
> Mark.
>
>>
>> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: linux-arm-kernel at lists.infradead.org
>> ---
>>  arch/arm64/mm/kasan_init.c | 8 +-------
>>  1 file changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
>> index 687a358a3733..81f03959a4ab 100644
>> --- a/arch/arm64/mm/kasan_init.c
>> +++ b/arch/arm64/mm/kasan_init.c
>> @@ -191,14 +191,8 @@ void __init kasan_init(void)
>>               if (start >= end)
>>                       break;
>>
>> -             /*
>> -              * end + 1 here is intentional. We check several shadow bytes in
>> -              * advance to slightly speed up fastpath. In some rare cases
>> -              * we could cross boundary of mapped shadow, so we just map
>> -              * some more here.
>> -              */
>>               vmemmap_populate((unsigned long)kasan_mem_to_shadow(start),
>> -                             (unsigned long)kasan_mem_to_shadow(end) + 1,
>> +                             (unsigned long)kasan_mem_to_shadow(end),
>>                               pfn_to_nid(virt_to_pfn(start)));
>>       }
>>
>> --
>> 2.13.0
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
