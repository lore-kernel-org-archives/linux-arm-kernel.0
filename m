From: toddpoynor@google.com (Todd Poynor)
Date: Sat, 13 Nov 2010 01:35:32 -0800
Subject: [PATCH] ARM: Stop irqsoff tracing if return to user with
	interrupts enabled
In-Reply-To: <20101113084802.GB10125@n2100.arm.linux.org.uk>
References: <1289619648-8690-1-git-send-email-toddpoynor@google.com>
	<20101113084802.GB10125@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinGuVmevYUgt279UfdF=xQ6D1xHUDK=kxprS1z-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 13, 2010 at 12:48 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Nov 12, 2010 at 07:40:48PM -0800, Todd Poynor wrote:
>> Signed-off-by: Todd Poynor <toddpoynor@google.com>
>
> NAK. ?Firstly, you're not explaining why. ?Secondly, we purposely leave
> IRQs off when returning to userspace to avoid race conditions. ?Thirdly,
> we purposely leave lockdep believing that IRQs are off while userspace
> is running, even though IRQs are not.

Apologies for the lack of explanation.  The change makes the irqsoff
tracer account for whether the return to userspace will or will not
enable interrupts; it will not override the kernel's decision on
interrupts being enabled or not, and I don't believe it will affect
lockdep's beliefs.

The reason why is to properly terminate an IRQs-disabled interval if
IRQs will in fact be enabled on return, so that the tracer does not
continue to measure the time spent in userspace as a continuation of
the IRQs-off sequence started by the call to disable_irq at
ret_slow_syscall or ret_fast_syscall.  The x86 architecture implements
macro TRACE_IRQS_IRET for the same purpose.

I'll continue to search the lists in case there's anything I've missed.

>
> I've explained why this is in the past - please search the mailing list.
>
>> ---
>> ?arch/arm/kernel/entry-common.S | ? 14 ++++++++++++++
>> ?1 files changed, 14 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
>> index 8bfa987..b81d270 100644
>> --- a/arch/arm/kernel/entry-common.S
>> +++ b/arch/arm/kernel/entry-common.S
>> @@ -29,6 +29,13 @@ ret_fast_syscall:
>> ? ? ? ldr ? ? r1, [tsk, #TI_FLAGS]
>> ? ? ? tst ? ? r1, #_TIF_WORK_MASK
>> ? ? ? bne ? ? fast_work_pending
>> +#if defined(CONFIG_TRACE_IRQFLAGS)
>> + ? ? ldr ? ? r1, [sp, #S_OFF + S_PSR] ? ? ? ?@ get calling cpsr
>> + ? ? tst ? ? r1, #PSR_I_BIT
>> + ? ? bne ? ? 1f
>> + ? ? asm_trace_hardirqs_on
>> +1:
>> +#endif
>>
>> ? ? ? /* perform architecture specific actions before user return */
>> ? ? ? arch_ret_to_user r1, lr
>> @@ -65,6 +72,13 @@ ret_slow_syscall:
>> ? ? ? tst ? ? r1, #_TIF_WORK_MASK
>> ? ? ? bne ? ? work_pending
>> ?no_work_pending:
>> +#if defined(CONFIG_TRACE_IRQFLAGS)
>> + ? ? ldr ? ? r1, [sp, #S_PSR] ? ? ? ? ? ? ? ?@ get calling cpsr
>> + ? ? tst ? ? r1, #PSR_I_BIT
>> + ? ? bne ? ? 2f
>> + ? ? asm_trace_hardirqs_on
>> +2:
>> +#endif
>> ? ? ? /* perform architecture specific actions before user return */
>> ? ? ? arch_ret_to_user r1, lr
>>
>> --
>> 1.7.3.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
