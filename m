From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 20 Nov 2013 22:24:33 -0800
Subject: [PATCH v4] ARM: signal: fix armv7-m build issue in
 sigreturn_codes.S
In-Reply-To: <20131120112059.GA2582@e103592.cambridge.arm.com>
References: <1384932072-8103-1-git-send-email-victor.kamensky@linaro.org>
 <1384932072-8103-2-git-send-email-victor.kamensky@linaro.org>
 <20131120112059.GA2582@e103592.cambridge.arm.com>
Message-ID: <CAA3XUr0iwT_TYYMDt0w_+4_zW7hTDbFdngFDwv2zpR9WmY_fLg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 November 2013 03:21, Dave Martin <Dave.Martin@arm.com> wrote:
> On Tue, Nov 19, 2013 at 11:21:12PM -0800, Victor Kamensky wrote:
>> After "ARM: signal: sigreturn_codes should be endian neutral to
>> work in BE8" commit, thumb only platforms, like armv7m, fails to
>> compile sigreturn_codes.S. The reason is that for such arch
>> values '.arm' directive and arm opcodes are not allowed.
>>
>> Fix conditionally enables arm opcodes only if no CONFIG_CPU_THUMBONLY
>> defined and it uses .org instructions to keep sigreturn_codes
>> layout.
>>
>> Suggested-by: Dave Martin <Dave.Martin@arm.com>
>> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
>> Tested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
> I believe this looks correct now:
>
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>

It is posted to Russell's patch system now.

Dave, thank you very much for help and guidance.
Uwe, thank you for reporting, testing.

Thanks,
Victor

> Cheers
> ---Dave
>
>> ---
>>  arch/arm/kernel/sigreturn_codes.S | 40 ++++++++++++++++++++++++++++++---------
>>  1 file changed, 31 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/arm/kernel/sigreturn_codes.S b/arch/arm/kernel/sigreturn_codes.S
>> index 3c5d0f2..b84d0cb 100644
>> --- a/arch/arm/kernel/sigreturn_codes.S
>> +++ b/arch/arm/kernel/sigreturn_codes.S
>> @@ -30,6 +30,27 @@
>>   * snippets.
>>   */
>>
>> +/*
>> + * In CPU_THUMBONLY case kernel arm opcodes are not allowed.
>> + * Note in this case codes skips those instructions but it uses .org
>> + * directive to keep correct layout of sigreturn_codes array.
>> + */
>> +#ifndef CONFIG_CPU_THUMBONLY
>> +#define ARM_OK(code...)      code
>> +#else
>> +#define ARM_OK(code...)
>> +#endif
>> +
>> +     .macro arm_slot n
>> +     .org    sigreturn_codes + 12 * (\n)
>> +ARM_OK(      .arm    )
>> +     .endm
>> +
>> +     .macro thumb_slot n
>> +     .org    sigreturn_codes + 12 * (\n) + 8
>> +     .thumb
>> +     .endm
>> +
>>  #if __LINUX_ARM_ARCH__ <= 4
>>       /*
>>        * Note we manually set minimally required arch that supports
>> @@ -45,26 +66,27 @@
>>       .global sigreturn_codes
>>       .type   sigreturn_codes, #object
>>
>> -     .arm
>> +     .align
>>
>>  sigreturn_codes:
>>
>>       /* ARM sigreturn syscall code snippet */
>> -     mov     r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
>> -     swi     #(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE)
>> +     arm_slot 0
>> +ARM_OK(      mov     r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)       )
>> +ARM_OK(      swi     #(__NR_sigreturn)|(__NR_OABI_SYSCALL_BASE)      )
>>
>>       /* Thumb sigreturn syscall code snippet */
>> -     .thumb
>> +     thumb_slot 0
>>       movs    r7, #(__NR_sigreturn - __NR_SYSCALL_BASE)
>>       swi     #0
>>
>>       /* ARM sigreturn_rt syscall code snippet */
>> -     .arm
>> -     mov     r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
>> -     swi     #(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)
>> +     arm_slot 1
>> +ARM_OK(      mov     r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)    )
>> +ARM_OK(      swi     #(__NR_rt_sigreturn)|(__NR_OABI_SYSCALL_BASE)   )
>>
>>       /* Thumb sigreturn_rt syscall code snippet */
>> -     .thumb
>> +     thumb_slot 1
>>       movs    r7, #(__NR_rt_sigreturn - __NR_SYSCALL_BASE)
>>       swi     #0
>>
>> @@ -74,7 +96,7 @@ sigreturn_codes:
>>        * it is thumb case or not, so we need additional
>>        * word after real last entry.
>>        */
>> -     .arm
>> +     arm_slot 2
>>       .space  4
>>
>>       .size   sigreturn_codes, . - sigreturn_codes
>> --
>> 1.8.1.4
>>
>>
>> _______________________________________________
>> linaro-kernel mailing list
>> linaro-kernel at lists.linaro.org
>> http://lists.linaro.org/mailman/listinfo/linaro-kernel
