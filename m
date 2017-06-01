From: dvyukov@google.com (Dmitry Vyukov)
Date: Thu, 1 Jun 2017 19:38:56 +0200
Subject: [PATCH 3/4] arm64/kasan: don't allocate extra shadow memory
In-Reply-To: <CACT4Y+Z02Un5DEjmhow4bSLOBygoC2mg7t_KKGn64WnWXQw0qw@mail.gmail.com>
References: <20170601162338.23540-1-aryabinin@virtuozzo.com>
 <20170601162338.23540-3-aryabinin@virtuozzo.com>
 <20170601163442.GC17711@leverpostej>
 <CACT4Y+aCKDF95mK2-nuiV0+XineHha3y+6PCW0-EorOaY=TFng@mail.gmail.com>
 <20170601165205.GA8191@leverpostej>
 <75ea368f-9268-44fd-f3f6-2a48dc8d2fe8@virtuozzo.com>
 <31a41822-35e1-1b4a-09f7-0a99571ee89a@virtuozzo.com>
 <CACT4Y+Z02Un5DEjmhow4bSLOBygoC2mg7t_KKGn64WnWXQw0qw@mail.gmail.com>
Message-ID: <CACT4Y+a7BE25V=dyPCaaO3Tg2kwD04Fq2=U8qgFWDuQGvo_kcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 1, 2017 at 7:05 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>>>>>>> We used to read several bytes of the shadow memory in advance.
>>>>>>> Therefore additional shadow memory mapped to prevent crash if
>>>>>>> speculative load would happen near the end of the mapped shadow memory.
>>>>>>>
>>>>>>> Now we don't have such speculative loads, so we no longer need to map
>>>>>>> additional shadow memory.
>>>>>>
>>>>>> I see that patch 1 fixed up the Linux helpers for outline
>>>>>> instrumentation.
>>>>>>
>>>>>> Just to check, is it also true that the inline instrumentation never
>>>>>> performs unaligned accesses to the shadow memory?
>>>>>
>>>
>>> Correct, inline instrumentation assumes that all accesses are properly aligned as it
>>> required by C standard. I knew that the kernel violates this rule in many places,
>>> therefore I decided to add checks for unaligned accesses in outline case.
>>>
>>>
>>>>> Inline instrumentation generally accesses only a single byte.
>>>>
>>>> Sorry to be a little pedantic, but does that mean we'll never access the
>>>> additional shadow, or does that mean it's very unlikely that we will?
>>>>
>>>> I'm guessing/hoping it's the former!
>>>>
>>>
>>> Outline will never access additional shadow byte: https://github.com/google/sanitizers/wiki/AddressSanitizerAlgorithm#unaligned-accesses
>>
>> s/Outline/inline  of course.
>
>
> I suspect that actual implementations have diverged from that
> description. Trying to follow asan_expand_check_ifn in:
> https://gcc.gnu.org/viewcvs/gcc/trunk/gcc/asan.c?revision=246703&view=markup
> but it's not trivial.
>
> +Yuri, maybe you know off the top of your head if asan instrumentation
> in gcc ever accesses off-by-one shadow byte (i.e. 1 byte after actual
> object end)?

Thinking of this more. There is at least 1 case in user-space asan
where off-by-one shadow access would lead to similar crashes: for
mmap-ed regions we don't have redzones and map shadow only for the
region itself, so any off-by-one access would lead to crashes. So I
guess we are safe here. Or at least any crash would be gcc bug.
