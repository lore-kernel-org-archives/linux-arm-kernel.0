From: dave.long@linaro.org (David Long)
Date: Wed, 26 Nov 2014 01:46:12 -0500
Subject: [PATCH v3 1/5] arm64: Kprobes with single stepping support
In-Reply-To: <546CAF5A.4060901@linaro.org>
References: <1416292375-29560-1-git-send-email-dave.long@linaro.org>
 <1416292375-29560-2-git-send-email-dave.long@linaro.org>
 <20141118145643.GO18842@arm.com>
 <CA+b37P337jcTCPTg4Ydxh6TKwqmyMngt-eEowzfsTNBDZ7-NEg@mail.gmail.com>
 <20141119112553.GC15985@arm.com> <546CAF5A.4060901@linaro.org>
Message-ID: <54757734.4060301@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/19/14 09:55, David Long wrote:
> On 11/19/14 06:25, Will Deacon wrote:
>> On Wed, Nov 19, 2014 at 11:21:24AM +0000, Sandeepa Prabhu wrote:
>>> On 18 November 2014 20:26, Will Deacon <will.deacon@arm.com> wrote:
>>>
>>>> One thing I noticed looking through this patch is that we're
>>>> effectively
>>>> reinventing a bunch of the instruction decoding logic that we
>>>> already have
>>>> in the kernel (introduced since Sandeepa last sent his patch).
>>>>
>>>> Could you take a look at include/asm/insn.h and kernel/insn.c
>>>> please, and
>>>> see if you can at least consolidate some of this? Some of it should
>>>> be easy
>>>> (i.e. reusing masks, using existing #defines to construct BRK
>>>> encodings),
>>>> but I appreciate there may be places where kprobes needs to add
>>>> extra bits,
>>>> in which case I'd really like to keep this all together if at all
>>>> possible.
>>>>
>>>> We're currently in a position where the module loader, BPF jit,
>>>> ftrace and
>>>> the proposed alternative patching scheme are all using the same
>>>> instruction
>>>> manipulation functions, so we should try to continue that trend if
>>>> we can.
>>> Will,
>>>
>>> kernel/insn.c support generating instruction encodings(forming opcodes
>>> with given specifications), so for kprobes, only BRK encoding can use
>>> this mechanism.
>>> For instruction simulation, the instruction behavior should be
>>> simulated on saved pt_regs, which is not supported on insn.c routines,
>>> so still need probes-simulate-insn.c. Please point me if I am missing
>>> something here.
>>
>> I was thinking of the magic hex numbers in the kprobes decode tables,
>> which
>> seem to correspond directly to the instruction classes described in
>> insn.c
>>
>> Keeping the actual emulation code separate makes sense.
>>
>> Will
>
> Of course that follows the model of the much more complex arm32
> kprobes/uprobes decoding.  I can have a go at replacing it with insn.c
> calls.
>
> -dl
>

While the existing aarch64_get_insn_class() function in insn.c is 
somewhat useful here what is really needed is a function that identifies 
if an instruction uses the pc (branch, load literal, load address). 
Such instructions cannot be arbitrarily moved around in isolation, and 
do not fall neatly into the existing "class"es.  I've written a simple 
aarch64_insn_uses_pc() function to add to insn.c but I'd like to hear 
agreement that this is a good approach before sending out the patch. 
Thoughts?

-dl
