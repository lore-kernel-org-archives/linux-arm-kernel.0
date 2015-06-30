From: wcohen@redhat.com (William Cohen)
Date: Tue, 30 Jun 2015 09:41:33 -0400
Subject: [PATCH v7 5/7] arm64: Add trampoline code for kretprobes
In-Reply-To: <CAPvkgC1zL9V1Oab+YnG8wOGymt_T-chPJ5irRa9sBg6Ri=UL=g@mail.gmail.com>
References: <1434395229-6654-1-git-send-email-dave.long@linaro.org>
 <1434395229-6654-6-git-send-email-dave.long@linaro.org>
 <CAPvkgC1hSRrzp_pR98qwnKvBspg1WizCm_Pzt0c1=dPWci1pjg@mail.gmail.com>
 <55918B68.7030900@redhat.com>
 <CAPvkgC1zL9V1Oab+YnG8wOGymt_T-chPJ5irRa9sBg6Ri=UL=g@mail.gmail.com>
Message-ID: <55929C8D.307@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2015 07:04 AM, Steve Capper wrote:
> On 29 June 2015 at 19:16, William Cohen <wcohen@redhat.com> wrote:
>> On 06/29/2015 01:25 PM, Steve Capper wrote:
>>> On 15 June 2015 at 20:07, David Long <dave.long@linaro.org> wrote:
>>>> From: William Cohen <wcohen@redhat.com>
>>>>
>>>> The trampoline code is used by kretprobes to capture a return from a probed
>>>> function.  This is done by saving the registers, calling the handler, and
>>>> restoring the registers.  The code then returns to the roginal saved caller
>>>> return address.  It is necessary to do this directly instead of using a
>>>> software breakpoint because the code used in processing that breakpoint
>>>> could itself be kprobe'd and cause a problematic reentry into the debug
>>>> exception handler.
>>>>
>>>> Signed-off-by: William Cohen <wcohen@redhat.com>
>>>> Signed-off-by: David A. Long <dave.long@linaro.org>
>>>> ---
>>>>  arch/arm64/include/asm/kprobes.h  |  1 +
>>>>  arch/arm64/kernel/kprobes-arm64.h | 41 +++++++++++++++++++++++++++++++++++++++
>>>>  arch/arm64/kernel/kprobes.c       | 26 +++++++++++++++++++++++++
>>>>  3 files changed, 68 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/include/asm/kprobes.h b/arch/arm64/include/asm/kprobes.h
>>>> index af31c4d..d081f49 100644
>>>> --- a/arch/arm64/include/asm/kprobes.h
>>>> +++ b/arch/arm64/include/asm/kprobes.h
>>>> @@ -58,5 +58,6 @@ int kprobe_exceptions_notify(struct notifier_block *self,
>>>>                              unsigned long val, void *data);
>>>>  int kprobe_breakpoint_handler(struct pt_regs *regs, unsigned int esr);
>>>>  int kprobe_single_step_handler(struct pt_regs *regs, unsigned int esr);
>>>> +void kretprobe_trampoline(void);
>>>>
>>>>  #endif /* _ARM_KPROBES_H */
>>>> diff --git a/arch/arm64/kernel/kprobes-arm64.h b/arch/arm64/kernel/kprobes-arm64.h
>>>> index ff8a55f..bdcfa62 100644
>>>> --- a/arch/arm64/kernel/kprobes-arm64.h
>>>> +++ b/arch/arm64/kernel/kprobes-arm64.h
>>>> @@ -27,4 +27,45 @@ extern kprobes_pstate_check_t * const kprobe_condition_checks[16];
>>>>  enum kprobe_insn __kprobes
>>>>  arm_kprobe_decode_insn(kprobe_opcode_t insn, struct arch_specific_insn *asi);
>>>>
>>>> +#define SAVE_REGS_STRING\
>>>> +       "       stp x0, x1, [sp, #16 * 0]\n"    \
>>>> +       "       stp x2, x3, [sp, #16 * 1]\n"    \
>>>> +       "       stp x4, x5, [sp, #16 * 2]\n"    \
>>>> +       "       stp x6, x7, [sp, #16 * 3]\n"    \
>>>> +       "       stp x8, x9, [sp, #16 * 4]\n"    \
>>>> +       "       stp x10, x11, [sp, #16 * 5]\n"  \
>>>> +       "       stp x12, x13, [sp, #16 * 6]\n"  \
>>>> +       "       stp x14, x15, [sp, #16 * 7]\n"  \
>>>> +       "       stp x16, x17, [sp, #16 * 8]\n"  \
>>>> +       "       stp x18, x19, [sp, #16 * 9]\n"  \
>>>> +       "       stp x20, x21, [sp, #16 * 10]\n" \
>>>> +       "       stp x22, x23, [sp, #16 * 11]\n" \
>>>> +       "       stp x24, x25, [sp, #16 * 12]\n" \
>>>> +       "       stp x26, x27, [sp, #16 * 13]\n" \
>>>> +       "       stp x28, x29, [sp, #16 * 14]\n" \
>>>> +       "       str x30,   [sp, #16 * 15]\n"    \
>>>> +       "       mrs x0, nzcv\n"                 \
>>>> +       "       str x0, [sp, #8 * 33]\n"
>>>> +
>>>> +
>>>> +#define RESTORE_REGS_STRING\
>>>> +       "       ldr x0, [sp, #8 * 33]\n"        \
>>>> +       "       msr nzcv, x0\n"                 \
>>>> +       "       ldp x0, x1, [sp, #16 * 0]\n"    \
>>>> +       "       ldp x2, x3, [sp, #16 * 1]\n"    \
>>>> +       "       ldp x4, x5, [sp, #16 * 2]\n"    \
>>>> +       "       ldp x6, x7, [sp, #16 * 3]\n"    \
>>>> +       "       ldp x8, x9, [sp, #16 * 4]\n"    \
>>>> +       "       ldp x10, x11, [sp, #16 * 5]\n"  \
>>>> +       "       ldp x12, x13, [sp, #16 * 6]\n"  \
>>>> +       "       ldp x14, x15, [sp, #16 * 7]\n"  \
>>>> +       "       ldp x16, x17, [sp, #16 * 8]\n"  \
>>>> +       "       ldp x18, x19, [sp, #16 * 9]\n"  \
>>>> +       "       ldp x20, x21, [sp, #16 * 10]\n" \
>>>> +       "       ldp x22, x23, [sp, #16 * 11]\n" \
>>>> +       "       ldp x24, x25, [sp, #16 * 12]\n" \
>>>> +       "       ldp x26, x27, [sp, #16 * 13]\n" \
>>>> +       "       ldp x28, x29, [sp, #16 * 14]\n" \
>>>> +       "       ldr x30,   [sp, #16 * 15]\n"
>>>
>>> Do we need to restore x19..x28 as they are callee-saved?
>>
>> Hi Steve,
>>
>> The goal was to make the trampoline not affect the values in any of the registers, so if the calling conventions ever change the code will still work. Figured it was safer and clearer just to save everything rather than assuming that the compiler's code generated for trampoline_probe_handler is going to save certain registers.
>>
>>>
>>> Okay this all matches up with the definitions of the pt_regs struct.
>>> So regs->regs[xn] are all set as is regs->pstate.
>>>
>>> The hard coded constant offsets make me nervous though, as does the
>>> uncertain state of the other elements of the pt_regs struct.
>>
>> The macros in this patch are modelled after the kernel_entry and kernel_exit macros in arch/arm64/kernel/entry.S.  What other elements of the pt_regs struct are of concern? The sp value will be unchanged and the pc value is going to be overwritten in the handler.  Concerned about some portion of the pstate (#8 *33) not be saved/restored?
> 
> pstate looks good to me. I was just worried that sp, pc orig_x0 and
> syscallno may have uncertain values as their containing structure is
> hosted on the stack. It's probably me just being overly paranoid
> though.

Hi Steve,

Actually I am quite happy you are being paranoid about this.  This kretprobe trampoline is operating completely as normal kernel code, but sections of the kprobe code are operating in exceptions, single step mode, or other unusual states, so one needs to check the assumptions about what values are valid and need to be restored.  Things have gone wrong in the kprobes code in the past because of not being careful (for example not properly setting the interrupt/debug masks before doing an instruction single step).

Thanks for the review.

-Will
> 
>>
>>>
>>>> +
>>>>  #endif /* _ARM_KERNEL_KPROBES_ARM64_H */
>>>> diff --git a/arch/arm64/kernel/kprobes.c b/arch/arm64/kernel/kprobes.c
>>>> index 6255814..570218c 100644
>>>> --- a/arch/arm64/kernel/kprobes.c
>>>> +++ b/arch/arm64/kernel/kprobes.c
>>>> @@ -560,6 +560,32 @@ int __kprobes longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
>>>>         return 0;
>>>>  }
>>>>
>>>> +/*
>>>> + * When a retprobed function returns, this code saves registers and
>>>> + * calls trampoline_handler() runs, which calls the kretprobe's handler.
>>>> + */
>>>> +static void __used __kprobes kretprobe_trampoline_holder(void)
>>>> +{
>>>> +       asm volatile (".global kretprobe_trampoline\n"
>>>> +                       "kretprobe_trampoline:\n"
>>>> +                       "sub sp, sp, %0\n"
>>>> +                       SAVE_REGS_STRING
>>>> +                       "mov x0, sp\n"
>>>> +                       "bl trampoline_probe_handler\n"
>>>> +                       /* Replace trampoline address in lr with actual
>>>> +                          orig_ret_addr return address. */
>>>> +                       "str x0, [sp, #16 * 15]\n"
>>>> +                       RESTORE_REGS_STRING
>>>> +                       "add sp, sp, %0\n"
>>>> +                       "ret\n"
>>>> +                     : : "I"(sizeof(struct pt_regs)) : "memory");
>>>
>>> I would consider placing something like:
>>> BUILD_BUG_ON(offsetof(struct pt_regs, regs) != 0);
>>> BUILD_BUG_ON(offsetof(struct pt_regs, pstate) != 264);
>>>
>>> here to catch changes in pt_regs.
>>>
>>> Or...
>>>
>>> Perhaps it makes sense to pull kretprobe_trampoline out into its own .S file?
>>> That way you could pull in asm-offsets.h and make use of:
>>> S_X0, S_PSTATE and S_FRAME_SIZE.
>>>
>>> Or something else :-).
>>>
>>
>> The asm-offsets.h would make the register save and restore clearer with the symbolic names.  asm-offsets.h only defines S_X0-S_X7. Other defines would be needed for the rest of the general purpose registers.
>>
>> -Will
>>>> +}
>>>> +
>>>> +static void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs)
>>>> +{
>>>> +       return (void *) 0;
>>>> +}
>>>> +
>>>>  int __init arch_init_kprobes(void)
>>>>  {
>>>>         return 0;
>>>> --
>>>> 1.8.1.2
>>>>
>>
