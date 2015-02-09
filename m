From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Mon, 9 Feb 2015 11:55:54 -0800
Subject: [PATCH] ARM: print cma-reserved pages from show_mem
In-Reply-To: <54D534FB.1090101@codeaurora.org>
References: <1423092164-9145-1-git-send-email-gregory.0xf0@gmail.com>
 <54D40DAF.4080609@codeaurora.org>
 <CADtm3G7ROX4CrxSKRvTKcjqCiX=uJQZ=Q5izH8pS61z4jfumLg@mail.gmail.com>
 <54D534FB.1090101@codeaurora.org>
Message-ID: <CADtm3G7CUYUUbmTrWiudQ5j-wX9hu86Ox8TkB+FnXwEvjb=xeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 6, 2015 at 1:41 PM, Laura Abbott <lauraa@codeaurora.org> wrote:
> On 2/6/2015 1:14 PM, Gregory Fong wrote:
>>
>> On Thu, Feb 5, 2015 at 4:41 PM, Laura Abbott <lauraa@codeaurora.org>
>> wrote:
>>>
>>> On 2/4/2015 3:22 PM, Gregory Fong wrote:
>>>>
>>>>
>>>> Add cma reserved information to the ARM-specific show_mem.  It was
>>>> added to the generic implementation by commit
>>>> 49abd8c28046adf77c5ce1949549aa64d7221881 "lib/show_mem.c: add cma
>>>> reserved information".
>>>>
>>>> Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
>>>> ---
>>>>    arch/arm/mm/init.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
>>>> index 2495c8c..da77507 100644
>>>> --- a/arch/arm/mm/init.c
>>>> +++ b/arch/arm/mm/init.c
>>>> @@ -22,6 +22,7 @@
>>>>    #include <linux/memblock.h>
>>>>    #include <linux/dma-contiguous.h>
>>>>    #include <linux/sizes.h>
>>>> +#include <linux/cma.h>
>>>>
>>>>    #include <asm/cp15.h>
>>>>    #include <asm/mach-types.h>
>>>> @@ -130,6 +131,9 @@ void show_mem(unsigned int filter)
>>>>          printk("%d pages of RAM\n", total);
>>>>          printk("%d free pages\n", free);
>>>>          printk("%d reserved pages\n", reserved);
>>>> +#ifdef CONFIG_CMA
>>>> +       printk("%lu cma reserved pages\n", totalcma_pages);
>>>> +#endif
>>>
>>>
>>>
>>> Nit: 'cma reserved pages' is a bit unclear. Are there some CMA
>>> pages that aren't reserved? Dropping the reserved might be
>>> clearer.
>>
>>
>> Sure, I was trying to replicate what's in lib/show_mem.c, but it
>> doesn't actually make much sense.  Maybe it would be better to change
>> to "cma pages" here and change the wording in that lib/show_mem.c too.
>>
>> I'll wait a bit for any other thoughts and send out a v2 with those
>> changes.
>>
>
> So it looks like the lib/show_mem.c does something different
> #ifdef CONFIG_CMA
>         printk("%lu pages reserved\n", (reserved - totalcma_pages));
>         printk("%lu pages cma reserved\n", totalcma_pages);
> #else
>         printk("%lu pages reserved\n", reserved);
> #endif
>
>
> No need to change the name, instead I'd say fix up arm to match what
> the generic showmem is doing.

The trouble is that lib/show_mem.c and ARM's show_mem use the
'reserved' variable to hold different info, which was not a problem I
was aiming to tackle here, and am not sure I understand what's going
on well enough to do so.  But let's give it a shot:

In lib/show_mem.c, reserved is calculated by iterating over all online
nodes, then increasing reserved by (zone->present_pages -
zone->managed_pages).  This count includes CMA pages and so when
reserved pages is printed it should be 'reserved' - totalcma_pages, as
it currently is.

In ARM's show_mem, reserved is counted by iterating over memblocks,
and within each one iterating over pfns, checking each page to see if
it's reserved, and increasing the counter accordingly.  Unlike the
generic one, this results in counting reserved pages differently than
CMA pages.

Unfortunately, I don't see a good way to do the calculation different
in the generic implementation that doesn't also count CMA pages in
'reserved'---unless I'm missing something, this isn't available at the
zone info level.

If this is correct, then I think the correct set of steps is still
what I was suggesting:

1. change generic implementation to say 'cma' rather than 'cma reserved'
2. do what I did in this patch except also remove the word 'reserved'
like in (1).

Does that seem sensible?

Thanks,
Gregory
