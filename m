From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu, 1 Jun 2017 19:59:20 +0300
Subject: [PATCH 3/4] arm64/kasan: don't allocate extra shadow memory
In-Reply-To: <20170601165205.GA8191@leverpostej>
References: <20170601162338.23540-1-aryabinin@virtuozzo.com>
 <20170601162338.23540-3-aryabinin@virtuozzo.com>
 <20170601163442.GC17711@leverpostej>
 <CACT4Y+aCKDF95mK2-nuiV0+XineHha3y+6PCW0-EorOaY=TFng@mail.gmail.com>
 <20170601165205.GA8191@leverpostej>
Message-ID: <75ea368f-9268-44fd-f3f6-2a48dc8d2fe8@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/01/2017 07:52 PM, Mark Rutland wrote:
> On Thu, Jun 01, 2017 at 06:45:32PM +0200, Dmitry Vyukov wrote:
>> On Thu, Jun 1, 2017 at 6:34 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>>> On Thu, Jun 01, 2017 at 07:23:37PM +0300, Andrey Ryabinin wrote:
>>>> We used to read several bytes of the shadow memory in advance.
>>>> Therefore additional shadow memory mapped to prevent crash if
>>>> speculative load would happen near the end of the mapped shadow memory.
>>>>
>>>> Now we don't have such speculative loads, so we no longer need to map
>>>> additional shadow memory.
>>>
>>> I see that patch 1 fixed up the Linux helpers for outline
>>> instrumentation.
>>>
>>> Just to check, is it also true that the inline instrumentation never
>>> performs unaligned accesses to the shadow memory?
>>

Correct, inline instrumentation assumes that all accesses are properly aligned as it
required by C standard. I knew that the kernel violates this rule in many places,
therefore I decided to add checks for unaligned accesses in outline case.


>> Inline instrumentation generally accesses only a single byte.
> 
> Sorry to be a little pedantic, but does that mean we'll never access the
> additional shadow, or does that mean it's very unlikely that we will?
> 
> I'm guessing/hoping it's the former!
> 

Outline will never access additional shadow byte: https://github.com/google/sanitizers/wiki/AddressSanitizerAlgorithm#unaligned-accesses

> Thanks,
> Mark.
> 
