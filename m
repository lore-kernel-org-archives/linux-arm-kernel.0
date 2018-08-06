From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 6 Aug 2018 17:20:08 +0200
Subject: [RFC/PoC PATCH 0/3] arm64: basic ROP mitigation
In-Reply-To: <CAKv+Gu9X1CDpy+XvrmbSdjBjMb45eBW7JVsvsK_JQdUt2Dbvgw@mail.gmail.com>
References: <20180802132133.23999-1-ard.biesheuvel@linaro.org>
 <7529eedf-af56-2e94-261e-bc5c86abadaa@arm.com>
 <CAKv+Gu9X1CDpy+XvrmbSdjBjMb45eBW7JVsvsK_JQdUt2Dbvgw@mail.gmail.com>
Message-ID: <CAKv+Gu8qT+2-m=2jGO-ppC7Ru4vX_FXnn+AL4WmBqyvFGv5ZTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2018 at 16:04, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> On 6 August 2018 at 15:55, Robin Murphy <robin.murphy@arm.com> wrote:
>> On 02/08/18 14:21, Ard Biesheuvel wrote:
>>>
>>> This is a proof of concept I cooked up, primarily to trigger a discussion
>>> about whether there is a point to doing anything like this, and if there
>>> is, what the pitfalls are. Also, while I am not aware of any similar
>>> implementations, the idea is so simple that I would be surprised if nobody
>>> else thought of the same thing way before I did.
>>
>>
>> So, "TTBR0 PAN: Pointer Auth edition"? :P
>>
>>> The idea is that we can significantly limit the kernel's attack surface
>>> for ROP based attacks by clearing the stack pointer's sign bit before
>>> returning from a function, and setting it again right after proceeding
>>> from the [expected] return address. This should make it much more
>>> difficult
>>> to return to arbitrary gadgets, given that they rely on being chained to
>>> the next via a return address popped off the stack, and this is difficult
>>> when the stack pointer is invalid.
>>>
>>> Of course, 4 additional instructions per function return is not exactly
>>> for free, but they are just movs and adds, and leaf functions are
>>> disregarded unless they allocate a stack frame (this comes for free
>>> because simple_return insns are disregarded by the plugin)
>>>
>>> Please shoot, preferably with better ideas ...
>>
>>
>> Actually, on the subject of PAN, shouldn't this at least have a very hard
>> dependency on that? AFAICS without PAN clearing bit 55 of SP is effectively
>> giving userspace direct control of the kernel stack (thanks to TBI). Ouch.
>>
>
> How's that? Bits 52 .. 54 will still be set, so SP will never contain
> a valid userland address in any case. Or am I missing something?
>
>> I wonder if there's a little  more mileage in using "{add,sub} sp, sp, #1"
>> sequences to rely on stack alignment exceptions instead, with the added
>> bonus that that's about as low as the instruction-level overhead can get.
>>
>
> Good point. I did consider that, but couldn't convince myself that it
> isn't easier to defeat: loads via x29 occur reasonably often, and you
> can simply offset your doctored stack frame by a single byte.
>

Also, the restore has to be idempotent: only functions that modify sp
set the bit, so it cannot be reset unconditionally. Also, when taking
an exception in the middle, we'll return with the bit set even if it
was clear when the exception was taken.
