From: dave.long@linaro.org (David Long)
Date: Fri, 22 Jul 2016 11:51:32 -0400
Subject: [PATCH v15 04/10] arm64: Kprobes with single stepping support
In-Reply-To: <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
References: <1467995754-32508-1-git-send-email-dave.long@linaro.org>
 <1467995754-32508-5-git-send-email-dave.long@linaro.org>
 <578FA238.3050206@arm.com> <5790F960.5050007@linaro.org>
 <57910528.7070902@arm.com> <57911590.50305@linaro.org>
 <20160722101617.GA17821@e104818-lin.cambridge.arm.com>
Message-ID: <57924104.1080202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2016 06:16 AM, Catalin Marinas wrote:
> On Thu, Jul 21, 2016 at 02:33:52PM -0400, David Long wrote:
>> On 07/21/2016 01:23 PM, Marc Zyngier wrote:
>>> On 21/07/16 17:33, David Long wrote:
>>>> On 07/20/2016 12:09 PM, Marc Zyngier wrote:
>>>>> On 08/07/16 17:35, David Long wrote:
>>>>>> +#define MAX_INSN_SIZE			1
>>>>>> +#define MAX_STACK_SIZE			128
>>>>>
>>>>> Where is that value coming from? Because even on my 6502, I have a 256
>>>>> byte stack.
>>>>>
>>>>
>>>> Although I don't claim to know the original author's thoughts I would
>>>> guess it is based on the seven other existing implementations for
>>>> kprobes on various architectures, all of which appear to use either 64
>>>> or 128 for MAX_STACK_SIZE.  The code is not trying to duplicate the
>>>> whole stack.
> [...]
>>> My main worry is that whatever value you pick, it is always going to be
>>> wrong. This is used to preserve arguments that are passed on the stack,
>>> as opposed to passed by registers). We have no idea of what is getting
>>> passed there so saving nothing, 128 bytes or 2kB is about the same. It
>>> is always wrong.
>>>
>>> A much better solution would be to check the frame pointer, and copy the
>>> delta between FP and SP, assuming it fits inside the allocated buffer.
>>> If it doesn't, or if FP is invalid, we just skip the hook, because we
>>> can't reliably execute it.
>>
>> Well, this is the way it works literally everywhere else. It is a documented
>> limitation (Documentation/kprobes.txt). Said documentation may need to be
>> changed along with the suggested fix.
>
> The document states: "Up to MAX_STACK_SIZE bytes are copied". That means
> the arch code could always copy less but never more than MAX_STACK_SIZE.
> What we are proposing is that we should try to guess how much to copy
> based on the FP value (caller's frame) and, if larger than
> MAX_STACK_SIZE, skip the probe hook entirely. I don't think this goes
> against the kprobes.txt document but at least it (a) may improve the
> performance slightly by avoiding unnecessary copy and (b) it avoids
> undefined behaviour if we ever encounter a jprobe with arguments passed
> on the stack beyond MAX_STACK_SIZE.
>

OK, it sounds like an improvement. I do worry a little about unexpected 
side effects.  I'm just asking if we can accept the existing code as now 
complete enough (in that I believe it matches the other implementations) 
and make this enhancement something for the next release cycle, allowing 
the existing code to be exercised by a wider audience and providing 
ample time to test the new modification? I'd hate to get stuck in a mode 
where this patch gets repeatedly delayed for changes that go above and 
beyond the original design.

Thanks,
-dl
