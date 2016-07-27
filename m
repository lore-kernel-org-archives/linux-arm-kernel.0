From: dave.long@linaro.org (David Long)
Date: Wed, 27 Jul 2016 18:13:37 -0400
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <22b277ba-6812-a0dd-9e8e-c29bdb3aa672@linaro.org>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
 <57924104.1080202@linaro.org>
 <20160725171350.GE2423@e104818-lin.cambridge.arm.com>
 <57969234.1070201@linaro.org>
 <22b277ba-6812-a0dd-9e8e-c29bdb3aa672@linaro.org>
Message-ID: <57993211.1040600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/27/2016 07:50 AM, Daniel Thompson wrote:
> On 25/07/16 23:27, David Long wrote:
>> On 07/25/2016 01:13 PM, Catalin Marinas wrote:
>>> On Fri, Jul 22, 2016 at 11:51:32AM -0400, David Long wrote:
>>>> On 07/22/2016 06:16 AM, Catalin Marinas wrote:
>>>>> On Thu, Jul 21, 2016 at 02:33:52PM -0400, David Long wrote:
>>>>>> On 07/21/2016 01:23 PM, Marc Zyngier wrote:
>>>>>>> On 21/07/16 17:33, David Long wrote:
>>>>>>>> On 07/20/2016 12:09 PM, Marc Zyngier wrote:
>>>>>>>>> On 08/07/16 17:35, David Long wrote:
>>>>>>>>>> +#define MAX_INSN_SIZE            1
>>>>>>>>>> +#define MAX_STACK_SIZE            128
>>>>>>>>>
>>>>>>>>> Where is that value coming from? Because even on my 6502, I have
>>>>>>>>> a 256
>>>>>>>>> byte stack.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Although I don't claim to know the original author's thoughts I
>>>>>>>> would
>>>>>>>> guess it is based on the seven other existing implementations for
>>>>>>>> kprobes on various architectures, all of which appear to use
>>>>>>>> either 64
>>>>>>>> or 128 for MAX_STACK_SIZE.  The code is not trying to duplicate the
>>>>>>>> whole stack.
>>>>> [...]
>>>>>>> My main worry is that whatever value you pick, it is always going
>>>>>>> to be
>>>>>>> wrong. This is used to preserve arguments that are passed on the
>>>>>>> stack,
>>>>>>> as opposed to passed by registers). We have no idea of what is
>>>>>>> getting
>>>>>>> passed there so saving nothing, 128 bytes or 2kB is about the
>>>>>>> same. It
>>>>>>> is always wrong.
>>>>>>>
>>>>>>> A much better solution would be to check the frame pointer, and
>>>>>>> copy the
>>>>>>> delta between FP and SP, assuming it fits inside the allocated
>>>>>>> buffer.
>>>>>>> If it doesn't, or if FP is invalid, we just skip the hook,
>>>>>>> because we
>>>>>>> can't reliably execute it.
>>>>>>
>>>>>> Well, this is the way it works literally everywhere else. It is a
>>>>>> documented
>>>>>> limitation (Documentation/kprobes.txt). Said documentation may need
>>>>>> to be
>>>>>> changed along with the suggested fix.
>>>>>
>>>>> The document states: "Up to MAX_STACK_SIZE bytes are copied". That
>>>>> means
>>>>> the arch code could always copy less but never more than
>>>>> MAX_STACK_SIZE.
>>>>> What we are proposing is that we should try to guess how much to copy
>>>>> based on the FP value (caller's frame) and, if larger than
>>>>> MAX_STACK_SIZE, skip the probe hook entirely. I don't think this goes
>>>>> against the kprobes.txt document but at least it (a) may improve the
>>>>> performance slightly by avoiding unnecessary copy and (b) it avoids
>>>>> undefined behaviour if we ever encounter a jprobe with arguments
>>>>> passed
>>>>> on the stack beyond MAX_STACK_SIZE.
>>>>
>>>> OK, it sounds like an improvement. I do worry a little about
>>>> unexpected side
>>>> effects.
>>>
>>> You get more unexpected side effects by not saving/restoring the whole
>>> stack. We looked into this on Friday and came to the conclusion that
>>> there is no safe way for kprobes to know which arguments passed on the
>>> stack should be preserved, at least not with the current API.
>>>
>>> Basically the AArch64 PCS states that for arguments passed on the stack
>>> (e.g. they can't fit in registers), the caller allocates memory for them
>>> (on its own stack) and passes the pointer to the callee. Unfortunately,
>>> the frame pointer seems to be decremented correspondingly to cover the
>>> arguments, so we don't really have a way to tell how much to copy.
>>> Copying just the caller's stack frame isn't safe either since a
>>> callee/caller receiving such argument on the stack may passed it down to
>>> a callee without copying (I couldn't find anything in the PCS stating
>>> that this isn't allowed).
>>
>> OK, so I think we're pretty much back to our starting point.
>>>
>>>> I'm just asking if we can accept the existing code as now complete
>>>> enough (in that I believe it matches the other implementations) and
>>>> make
>>>> this enhancement something for the next release cycle, allowing the
>>>> existing
>>>> code to be exercised by a wider audience and providing ample time to
>>>> test
>>>> the new modification? I'd hate to get stuck in a mode where this
>>>> patch gets
>>>> repeatedly delayed for changes that go above and beyond the original
>>>> design.
>>>
>>> The problem is that the original design was done on x86 for its PCS and
>>> it doesn't always fit other architectures. So we could either ignore the
>>> problem, hoping that no probed function requires argument passing on
>>> stack or we copy all the valid data on the kernel stack:
>>>
>>> diff --git a/arch/arm64/include/asm/kprobes.h
>>> b/arch/arm64/include/asm/kprobes.h
>>> index 61b49150dfa3..157fd0d0aa08 100644
>>> --- a/arch/arm64/include/asm/kprobes.h
>>> +++ b/arch/arm64/include/asm/kprobes.h
>>> @@ -22,7 +22,7 @@
>>>
>>>   #define __ARCH_WANT_KPROBES_INSN_SLOT
>>>   #define MAX_INSN_SIZE            1
>>> -#define MAX_STACK_SIZE            128
>>> +#define MAX_STACK_SIZE            THREAD_SIZE
>>>
>>>   #define flush_insn_slot(p)        do { } while (0)
>>>   #define kretprobe_blacklist_size    0
>>>
>>
>> I doubt the ARM PCS is unusual.  At any rate I'm certain there are other
>> architectures that pass aggregate parameters on the stack. I suspect
>> other RISC(-ish) architectures have similar PCS issues and I think this
>> is at least a big part of where this simple copy with a 64/128 limit
>> comes from, or at least why it continues to exist.  That said, I'm not
>> enthusiastic about researching that assertion in detail as it could be
>> time consuming.
>
> Given Mark shared a test program I *was* curious enough to take a look
> at this.
>
> The only architecture I can find that behaves like arm64 with the
> implicit pass-by-reference described by Catalin/Mark is sparc64.
>
> In contrast alpha, arm (32-bit), hppa64, mips64 and powerpc64 all use a
> hybrid approach where the first fragments of the structure are passed in
> registers and the remainder on the stack.
>

That's interesting.  It also looks like sparc64 does not copy any stack 
for jprobes. I guess that approach at least makes it clear what will and 
won't work.

>
>> I think this (unchecked) limitation for stack frames is something users
>> of jprobes understand, or at least should understand from the
>> documentation.  At any rate it doesn't sound like we have a way of
>> improving it, and I think that's OK.
>
> I don't think that this limitation could be inferred from the current
> jprobes documentation. Most architectures (include arm64 when handling
>  >8 parameters) place arguments at the top of the stack. For these
> architectures we need only consider the memory consumed by the (padded)
> arguments in the function signature to determine if the jprobe will be
> safe.
>
> On arm64 large structures/unions end up being allocated like normal
> local variables and need not be near the top of the stack. This gives
> the caller much greater flexibility and makes safety a property of the
> caller not the callee.
>

Yes, I had not fully appreciated how spread out the important parts of 
the stack frame could be, before now.

> So if it turns out to be too slow to store the whole of the stack then
> it should at the very least be mentioned in the list of architecture
> support that jprobes on functions that take structure/union arguments
>  >16 bytes are unsafe/unsupported.
>
>
> Daniel.

Thanks,
-dl
