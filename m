From: trong@android.com (Tri Vo)
Date: Mon, 6 Aug 2018 14:54:32 -0700
Subject: [PATCH] arm64: build CONFIG_ARM64_LSE_ATOMICS without -ffixed-
 flags
In-Reply-To: <CAKv+Gu-oWw9qa-U=XB8YPhUtSGcGwtEddafpsOY7XW9L6aPNdQ@mail.gmail.com>
References: <20180802231753.86336-1-trong@android.com>
 <CAKv+Gu_QzzDSV74pzLQcPBsWHZK5hvMwa8PojSJmzTOMnY780Q@mail.gmail.com>
 <CAKwvOd=vYBoZazvvN=MHVZnYtekgr-fCktuOFePsV-eSvbFQyQ@mail.gmail.com>
 <CAKv+Gu8KeXFqqWu6yV4_rRpL-6NN5KQyLWKCuC_XnbotGtMu7w@mail.gmail.com>
 <CANA+-vD0U3_1r4xJuv0fq6J1qAwRDLuu1sH+GHhL4vMh8JJ3Gw@mail.gmail.com>
 <CAKv+Gu8MaDPHuDmqg14-98CwAznuP8R0oo7BNPsAKMU_vPmKMQ@mail.gmail.com>
 <CAKv+Gu-SgWCzbBH1iZnWKYbTj28TiL6Xd_x9OTm0CXSiBQCitw@mail.gmail.com>
 <CANA+-vDMckt3WN+7E59vd_EKnUS4r_iuPNgyp2cs6-uWiAg3qA@mail.gmail.com>
 <CAKv+Gu-oWw9qa-U=XB8YPhUtSGcGwtEddafpsOY7XW9L6aPNdQ@mail.gmail.com>
Message-ID: <CANA+-vB5v5JPnthjJ-1wqgEnNdcz6eiJ28NyeO37ggSvVtWEeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 4, 2018 at 12:21 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 4 August 2018 at 03:05, Tri Vo <trong@android.com> wrote:
>> On Fri, Aug 3, 2018 at 12:34 PM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> On 3 August 2018 at 21:13, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>>> On 3 August 2018 at 21:08, Tri Vo <trong@android.com> wrote:
>>>>> On Fri, Aug 3, 2018 at 10:27 AM, Ard Biesheuvel
>>>>> <ard.biesheuvel@linaro.org> wrote:
>>>>>> On 3 August 2018 at 19:17, Nick Desaulniers <ndesaulniers@google.com> wrote:
>>>>>>> On Fri, Aug 3, 2018 at 1:43 AM Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>>>>>>>>
>>>>>>>> On 3 August 2018 at 01:17, Tri Vo <trong@android.com> wrote:
>>>>>>>> > Remove -ffixed- compile flags as they are not required for correct
>>>>>>>> > behavior of out-of-line ll/sc implementations of atomic functions.
>>>>>>>> > Registers (except x0 which contains return value) only need to be
>>>>>>>> > callee-saved, not necessarily fixed.
>>>>>>>> >
>>>>>>>> > For readability purposes, represent "callee-saves-all-registers" calling
>>>>>>>> > convention with a combination of -fcall-used- and -fcall-saved- flags only.
>>>>>>>> >
>>>>>>>> > Signed-off-by: Tri Vo <trong@android.com>
>>>>>>>>
>>>>>>>> Wouldn't this permit the compiler to stack/unstack these registers in
>>>>>>>> the implementations of the out of line LL/SC fallbacks.
>>>>>
>>>>> Yes. However, the number of registers that get stacked/unstacked
>>>>> should remain the same since compiler should only preserve registers
>>>>> that are used by callee (assuming callee saves all).
>>>>>>>
>>>>>>> I'm curious to understand more about how this LSE patching works, and
>>>>>>> what the constraints exactly are.  Are there some docs I should read
>>>>>>> that you can point me to?  I see
>>>>>>> arch/arm64/include/asm/atomic_ll_sc.h, but are those are the in line
>>>>>>> implementations?  Does that make arch/arm64/include/asm/atomic.h the
>>>>>>> out of line definitions?  What are the restrictions around preventing
>>>>>>> the compiler to push/pop those registers?
>>>>>>>
>>>>>>
>>>>>> The idea is that LSE atomics can each be patched into a bl instruction
>>>>>> that calls the appropriate LL/SC fallback, but without the overhead of
>>>>>> an ordinary function call. (actually the bl is there by default, but
>>>>>> patched into LSE ops on h/w that supports it)
>>>>>>
>>>>>> So that is why the 'bl' is in an asm() block, and why x30 is used as a
>>>>>> temporary/clobber in the LSE sequences: the function call is
>>>>>> completely hidden from the compiler. Obviously, for performance, you
>>>>>> want to prevent these fallbacks from touching the stack.
>>>>>
>>>>> The function call is hidden from the compiler on the caller side
>>>>> using 'bl' in the asm block. I suspect that is done to make
>>>>> alternative instructions the same byte length (constraints of dynamic
>>>>> patching). However, on the callee side, LL/SC fallbacks
>>>>> (in atomic_ll_sc.h) are implemented as C functions. So the compiler
>>>>> still handles the function call details and register allocation
>>>>> within those functions.
>>>>>
>>>>> Since the caller doesn't save any registers, callee stacks/unstacks
>>>>> all the registers it uses. So, for example, LL/SC fallback
>>>>> implementation of atomic_add preserves 2 registers with or without
>>>>> this change.
>>>>>
>>>>
>>>> Did you look at the disassembly?
>>
>> Yes, I did.
>
> 0000000000000000 <__ll_sc_atomic_add>:
>    0: f9800031 prfm pstl1strm, [x1]
>    4: 885f7c31 ldxr w17, [x1]
>    8: 0b000231 add w17, w17, w0
>    c: 88107c31 stxr w16, w17, [x1]
>   10: 35ffffb0 cbnz w16, 4 <__ll_sc_atomic_add+0x4>
>   14: d65f03c0 ret
>
> Now where does it preserve 2 registers?

I tested the change on a Hikey 4.9 kernel. The disassembly there
looks like this:
0000000000000000 <__ll_sc_atomic_add>:
       0: a9be7bfd stp x29, x30, [sp, #-32]!
       4: 910003fd mov x29, sp
       8: a90127e8 stp x8, x9, [sp, #16]
       c: 2a0003e9 mov w9, w0
      10: aa0103e8 mov x8, x1
      14: aa1e03e0 mov x0, x30
      18: 94000000 bl 0 <_mcount>
      1c: f9800111 prfm pstl1strm, [x8]
      20: 885f7d00 ldxr w0, [x8]
      24: 0b090000 add w0, w0, w9
      28: 88107d00 stxr w16, w0, [x8]
      2c: 35ffffb0 cbnz w16, 20 <__ll_sc_atomic_add+0x20>
      30: a94127e8 ldp x8, x9, [sp, #16]
      34: a8c27bfd ldp x29, x30, [sp], #32
      38: d65f03c0 ret
      3c: d503201f nop

Excluding FP, SP, there are 2 registers x8, x9 preserved.
>
>>>
>>> Actually, I only just spotted that you only modify x1 .. x7 and that
>>> the other registers already use -fcall-saved-xNN
>>>
>>> Will should comment on why the distinction exists in the first place.
>>> Note that a strict reading of the GCC man page suggests that using
>>> -fcall-saved-x8 is a bad idea, given that it is the indirect return
>>> register. However, given the limited scope of the option here, that
>>> probably does not matter in practice.
>>>
>>> So I guess you need this patch for Clang? Would be better to mention
>>> that in the commit log if this is the case.
>>
>> Yes, I am planning to fold whatever compiler support is needed for LSE
>> atomics into "callee-saves-all-registers" calling convention (without
>> ffixed flags). I'll then implement that calling convention in Clang.
>> I'll mention that in the commit message.
>
> Not *all* registers. x16 and x17 are excluded in this case, and I am
> not sure whether you would to encode that in an option.
>
> What is wrong with using -ffixed or -fcall-saved?

Looking at your disassembly snippet, usage of -ffixed flags makes
sense to me now. They prevent argument registers from being
unnecessarily stacked/unstacked if compiler uses x16, x17 (which
don't need to be saved) for allocation.

This patch will indeed cause a performance regression, although not
on all build environments. Sorry for the confusion.
