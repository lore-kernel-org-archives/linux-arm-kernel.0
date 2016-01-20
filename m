From: huawei.libin@huawei.com (Li Bin)
Date: Wed, 20 Jan 2016 09:25:42 +0800
Subject: [RFC] arm64: ftrace with regs for livepatch support
In-Reply-To: <569DF394.4000105@linaro.org>
References: <564F0846.5000001@linaro.org> <567E5DA7.70904@huawei.com>
 <569DF394.4000105@linaro.org>
Message-ID: <569EE216.6030000@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Takahiro,
Thanks for your reply firstly.

on 2016/1/19 16:28, AKASHI Takahiro wrote:
>>> 1) instruction sequence
>>> Unlike x86, we have to preserve link register(x30) explicitly on arm64 since
>>> a ftrace help function will be invoked before a function prologue. so we
>>> need a few, not one, instructions here. Two possible ways:
>>>
>>>   (a) stp x29, x30, [sp, #-16]!
>>>       mov x29, sp
>>>       bl <mcount>
>>>       ldp x29, x30, [sp], #16
>>>       <function prologue>
>>>       ...
>>>
>>>   (b) mov x9, x30
>>>       bl <mcount>
>>>       mov x30, x9
>>>       <function prologue>
>>>       ...
>>>
>>> (a) complies with a normal calling convention.
>>> (b) is Li Bin's idea in his old patch. While (b) can save some memory
>>> accesses by using a scratch register(x9 in this example), we have no way
>>> to recover an actual value for this register.
>>>
>>>        Q#1. Which approach should we take here?
>>>
>>>
>>> 2) replacing an instruction sequence
>>>     (This issue is orthogonal to Q#1.)
>>>
>>> Replacing can happen anytime, so we have to do it (without any locking) in
>>> such a safe way that any task either calls a helper or doesn't call it, but
>>> never runs in any intermediate state.
>>>
>>> Again here, two possible ways:
>>>
>>>    (a) initialize the code in the shape of (A') at boot time,
>>>              (B) -> (B') -> (A')
>>>        then switching to (A) or (A')
>>>    (b) take a few steps each time. For example,
>>>        to enable tracing,
>>>              (B) -> (B') -> (A') -> (A)
>>>        to disable tracing,
>>>              (A) -> (A') -> (B') -> (A)
>>>        Obviously, we need cache flushing/invalidation and barriers between.
>>>
>>>      (A)                                (A')
>>>          stp x29, x30, [sp, #-16]!           b 1f
>>>          mov x29, sp                         mov x29, sp
>>>          bl <_mcount>                        bl <_mcount>
>>>          ldp x29, x30, [sp], #16             ld x29, x30, [sp], #16
>>>                                           1:
>>>          <function prologue>
>>>          <function body>
>>>          ...
>>>
>>>      (B)                                (B')
>>>          nop                                 b 1f
>>>          nop                                 nop
>>>          nop                                 nop
>>>          nop                                 nop
>>>                                           1:
>>>          <function prologue>
>>>          <function body>
>>>          ...
>>>
>>
>> Hi takahiro,
>> This method can not guarantee the correctness of replacing the multi instrucions
>> from  (A') to (B') or from (B') to (A'), even if under kstop_machine especially for
>> preemptable kernel or NMI context (which will be supported on arm64 in future).
>> Right?
>
> You seem to be right.
> I thought that we could use aarch64_insn_patch_text() here, but
> it doesn't ensure any atomicity of replacement.
> Switching from (A') to (A) or (A) to (A') can be used instead,
> but the performance penalty will not be acceptable.
>
> Why does your livepatch with -mfentry work?
>

For my method with -mfentry, the instruction replacement for converting
nops to ftrace calls or back is as following,

    (A)    mov x9, x30                     (A')  mov x9, x30
            nop           <-------------->     bl <__fentry__>
            mov x30, x9                            mov x30, x9
            <function prologue>            <function prologue>

so it is compatible with the current recordmcount and ftrace logic, and the
only effect is that introducing two extra low cost mov instruction.

Thanks,
Li Bin

> -Takahiro AKASHI
>
>> Thanks,
>> Li Bin
>>
>>> (a) is much simpler, but (b) has less performance penalty(?) when tracing
>>> is disabled. I'm afraid that I might simplify the issue too much.
>>>
>>>         Q#2. Which one is more preferable?
>>>
>>>
>>> [1] https://gcc.gnu.org/ml/gcc/2015-05/msg00267.html, and
>>>      https://gcc.gnu.org/ml/gcc/2015-10/msg00090.html
>>>
>>>
>>> Thanks,
>>> -Takahiro AKASHI
>>>
>>> .
>>>
