From: dvyukov@google.com (Dmitry Vyukov)
Date: Wed, 9 Nov 2016 10:19:34 -0800
Subject: KASAN & the vmalloc area
In-Reply-To: <8abab822-4d93-a336-b00f-7aa9b1f47f8c@virtuozzo.com>
References: <20161108190302.GH15297@leverpostej>
 <8abab822-4d93-a336-b00f-7aa9b1f47f8c@virtuozzo.com>
Message-ID: <CACT4Y+YP0TUxXY+0PZ+oo6K8rZmzECEW_4qTt6kU=tHHgYFrKg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 9, 2016 at 8:53 AM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
> On 11/08/2016 10:03 PM, Mark Rutland wrote:
>> Hi,
>>
>> I see a while back [1] there was a discussion of what to do about KASAN
>> and vmapped stacks, but it doesn't look like that was solved, judging by
>> the vmapped stacks pull [2] for v4.9.
>>
>> I wondered whether anyone had looked at that since?
>>
>
> Sadly, but I didn't have much time for this yet, so it's in an initial state.
>
>> I have an additional reason to want to dynamically allocate the vmalloc
>> area shadow: it turns out that KASAN currently interacts rather poorly
>> with the arm64 ptdump code.
>>
>> When KASAN is selected, we allocate shadow for the whole vmalloc area,
>> using common zero pte, pmd, pud tables. Walking over these in the ptdump
>> code takes a *very* long time (I've seen up to 15 minutes with
>> KASAN_OUTLINE enabled). For DEBUG_WX [3], this means boot hangs for that
>> long, too.
>>
>
> I didn't look at any code, but we probably could can remember last visited pgd
> and skip next pgd if it's the same as previous.

Good idea.

> Alternatively - just skip kasan_zero_p*d in ptdump walker.

Mark have concern with the fact that we hide the mapping from the
walker this way. But your above idea with deduping pgd's during walk
both fast and doesn't hide anything from walker.



>> If I don't allocate vmalloc shadow (and remove the apparently pointlesss
>> shadow of the shadow area), and only allocate shadow for the image,
>> fixmap, vmemmap and so on, that delay gets cut to a few seconds, which
>> is tolerable for a debug configuration...
>>
>> ... however, things blow up when the kernel touches vmalloc'd memory for
>> the first time, as we don't install shadow for that dynamically.
>>
>> Thanks,
>> Mark.
>>
>> [1] https://lkml.kernel.org/r/CALCETrWucrYp+yq8RHSDqf93xtg793duByirurzJbLRhrz=tcA at mail.gmail.com
>> [2] https://lkml.kernel.org/r/20161003092940.GA691 at gmail.com
>> [3] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-October/464191.html
>>
