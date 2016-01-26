From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 26 Jan 2016 17:07:47 +0900
Subject: [RFC] arm64: ftrace with regs for livepatch support
In-Reply-To: <56A5E346.8020406@huawei.com>
References: <564F0846.5000001@linaro.org> <567E5DA7.70904@huawei.com>
 <569DF394.4000105@linaro.org> <569EE216.6030000@huawei.com>
 <569EFB04.6070807@linaro.org> <56A5E346.8020406@huawei.com>
Message-ID: <56A72953.9030500@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2016 05:56 PM, Li Bin wrote:
>
>
> on 2016/1/20 11:12, AKASHI Takahiro wrote:
>> Li,
>>
>> On 01/20/2016 10:25 AM, Li Bin wrote:
>>> Hi Takahiro,
>>> Thanks for your reply firstly.
>>>
>>> on 2016/1/19 16:28, AKASHI Takahiro wrote:
>>>>>> 1) instruction sequence
>>>>>> Unlike x86, we have to preserve link register(x30) explicitly on arm64 since
>>>>>> a ftrace help function will be invoked before a function prologue. so we
>>>>>> need a few, not one, instructions here. Two possible ways:
>>>>>>
>>>>>>     (a) stp x29, x30, [sp, #-16]!
>>>>>>         mov x29, sp
>>>>>>         bl <mcount>
>>>>>>         ldp x29, x30, [sp], #16
>>>>>>         <function prologue>
>>>>>>         ...
>>>>>>
>>>>>>     (b) mov x9, x30
>>>>>>         bl <mcount>
>>>>>>         mov x30, x9
>>>>>>         <function prologue>
>>>>>>         ...
>>>>>>
>>>>>> (a) complies with a normal calling convention.
>>>>>> (b) is Li Bin's idea in his old patch. While (b) can save some memory
>>>>>> accesses by using a scratch register(x9 in this example), we have no way
>>>>>> to recover an actual value for this register.
>>>>>>
>>>>>>          Q#1. Which approach should we take here?
>>>>>>
>>>>>>
>>>>>> 2) replacing an instruction sequence
>>>>>>       (This issue is orthogonal to Q#1.)
>>>>>>
>>>>>> Replacing can happen anytime, so we have to do it (without any locking) in
>>>>>> such a safe way that any task either calls a helper or doesn't call it, but
>>>>>> never runs in any intermediate state.
>>>>>>
>>>>>> Again here, two possible ways:
>>>>>>
>>>>>>      (a) initialize the code in the shape of (A') at boot time,
>>>>>>                (B) -> (B') -> (A')
>>>>>>          then switching to (A) or (A')
>>>>>>      (b) take a few steps each time. For example,
>>>>>>          to enable tracing,
>>>>>>                (B) -> (B') -> (A') -> (A)
>>>>>>          to disable tracing,
>>>>>>                (A) -> (A') -> (B') -> (A)
>>>>>>          Obviously, we need cache flushing/invalidation and barriers between.
>>>>>>
>>>>>>        (A)                                (A')
>>>>>>            stp x29, x30, [sp, #-16]!           b 1f
>>>>>>            mov x29, sp                         mov x29, sp
>>>>>>            bl <_mcount>                        bl <_mcount>
>>>>>>            ldp x29, x30, [sp], #16             ld x29, x30, [sp], #16
>>>>>>                                             1:
>>>>>>            <function prologue>
>>>>>>            <function body>
>>>>>>            ...
>>>>>>
>>>>>>        (B)                                (B')
>>>>>>            nop                                 b 1f
>>>>>>            nop                                 nop
>>>>>>            nop                                 nop
>>>>>>            nop                                 nop
>>>>>>                                             1:
>>>>>>            <function prologue>
>>>>>>            <function body>
>>>>>>            ...
>>>>>>
>>>>>
>>>>> Hi takahiro,
>>>>> This method can not guarantee the correctness of replacing the multi instrucions
>>>>> from  (A') to (B') or from (B') to (A'), even if under kstop_machine especially for
>>>>> preemptable kernel or NMI context (which will be supported on arm64 in future).
>>>>> Right?
>>>>
>>>> You seem to be right.
>>>> I thought that we could use aarch64_insn_patch_text() here, but
>>>> it doesn't ensure any atomicity of replacement.
>>>> Switching from (A') to (A) or (A) to (A') can be used instead,
>>>> but the performance penalty will not be acceptable.
>>>>
>>>> Why does your livepatch with -mfentry work?
>>>>
>>>
>>> For my method with -mfentry, the instruction replacement for converting
>>> nops to ftrace calls or back is as following,
>>>
>>>       (A)    mov x9, x30                     (A')  mov x9, x30
>>>               nop           <-------------->     bl <__fentry__>
>>>               mov x30, x9                            mov x30, x9
>>>               <function prologue>            <function prologue>
>>>
>>> so it is compatible with the current recordmcount and ftrace logic, and the
>>> only effect is that introducing two extra low cost mov instruction.
>>
>> Last night I thought this issue and reached almost the same conclusion :)
>> The only other way would be to forcedly suppress gcc's instruction
>> scheduling in a function prologue and generate an always-the-same prologue.
>> But this will be unlikely.
>> (requiring pt_regs for livepatch is just too much.)
>>
>> Other than a performance impact (I'm still not sure about it),
>> we might have a problem *with -fprolog-add=N* when the kernel sets up this
>> multiple-instructions sequence in each traceable function at boot time because
>> we have no way to do so transparently. I will check the ftrace code.
>>
>
> So can we promote the gcc community to consider the -mfentry feature which
> follows x86/s390/mips/sh example to support this method?
> https://gcc.gnu.org/ml/gcc-patches/2015-10/msg02250.html

I think we can also initialize ftrace in case of -fprolog-add=N option.

First, ftrace_init() is called in start_kernel() so early that no other threads
are run. Then ftrace_init() calls ftrace_update_code() with local irq disabled.
This means that ftrace_make_call/nop() can be executed in a *safe* mode.
The problem is that we have to modify not only the second NOP, but also all the three
NOPs either to nop;nop;nop or mov; bl; mov at boot time.
Fortunately, the first and third instruction will never be modified later and so
we can do as follows:
ftrace_make_call/nop(...)
{
     if (1st instruction == NOP) --- (*)
         write 1st instruction.
         write 3rd instruction.

     write nop to 2nd.
}
(or we don't even need (*).)

It is a bit ugly, but works.

So now I don't super strongly advocate -fprolog-add=N, but if this option can also be
used to implement livepatch (precisely, FTRACE_WITH_REGS) on other archs or just for
other purposes,  I don't want to deny this approach yet.

Thanks,
-Takahiro AKASHI

> Thanks,
> Li Bin
>
>> Thanks,
>> -Takahiro AKASHI
>>
>>> Thanks,
>>> Li Bin
>>>
>>>> -Takahiro AKASHI
>>>>
>>>>> Thanks,
>>>>> Li Bin
>>>>>
>>>>>> (a) is much simpler, but (b) has less performance penalty(?) when tracing
>>>>>> is disabled. I'm afraid that I might simplify the issue too much.
>>>>>>
>>>>>>           Q#2. Which one is more preferable?
>>>>>>
>>>>>>
>>>>>> [1] https://gcc.gnu.org/ml/gcc/2015-05/msg00267.html, and
>>>>>>        https://gcc.gnu.org/ml/gcc/2015-10/msg00090.html
>>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> -Takahiro AKASHI
>>>>>>
>>>>>> .
>>>>>>
>>>
>>>
>>
>> .
>>
>
