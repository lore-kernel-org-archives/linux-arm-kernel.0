From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 3 Jun 2014 11:36:24 +0200
Subject: [PATCHv2 2/4] arm64: Treat handle_arch_irq as a function pointer
In-Reply-To: <20140603091314.GA1310@leverpostej>
References: <1401742658-11841-1-git-send-email-lauraa@codeaurora.org>
 <1401742658-11841-3-git-send-email-lauraa@codeaurora.org>
 <20140603091314.GA1310@leverpostej>
Message-ID: <CAKv+Gu9okaiQQpJ4URLEnAVyK64STbMLzVsMNcAow2pZhp4Piw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3 June 2014 11:13, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Laura,
>
> On Mon, Jun 02, 2014 at 09:57:36PM +0100, Laura Abbott wrote:
>>
>> handle_arch_irq isn't actually text, it's just a function
>> pointer. It doesn't need to be stored in the text section
>> and doing so causes problems if we ever want to make the
>> kernel text readonly. Move it to the data section.
>>
>> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
>> ---
>>  arch/arm64/kernel/entry.S | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
>> index 39ac630..7c8ea1f 100644
>> --- a/arch/arm64/kernel/entry.S
>> +++ b/arch/arm64/kernel/entry.S
>> @@ -139,7 +139,8 @@ tsk       .req    x28             // current thread_info
>>   * Interrupt handling.
>>   */
>>       .macro  irq_handler
>> -     ldr     x1, handle_arch_irq
>> +     ldr     x1, =handle_arch_irq
>> +     ldr     x1, [x1]
>>       mov     x0, sp
>>       blr     x1
>>       .endm
>> @@ -678,5 +679,8 @@ ENTRY(sys_rt_sigreturn_wrapper)
>>       b       sys_rt_sigreturn
>>  ENDPROC(sys_rt_sigreturn_wrapper)
>>
>> -ENTRY(handle_arch_irq)
>> +     .data
>> +     .globl handle_arch_irq
>> +     .align 4
>> +handle_arch_irq:
>>       .quad   0
>
> Rather than having to set the alignment and section manually, would
> something like the below work, moving the definition into kernel/irq.c?
>
> Cheers,
> Mark.
>
> ---->8----
> diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
> index e1f7ecd..1eebf5b 100644
> --- a/arch/arm64/include/asm/irq.h
> +++ b/arch/arm64/include/asm/irq.h
> @@ -3,7 +3,6 @@
>u
>  #include <asm-generic/irq.h>
>
> -extern void (*handle_arch_irq)(struct pt_regs *);
>  extern void migrate_irqs(void);
>  extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
>
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index 39ac630..d378fc0 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -139,7 +139,8 @@ tsk .req    x28             // current thread_info
>   * Interrupt handling.
>   */
>         .macro  irq_handler
> -       ldr     x1, handle_arch_irq
> +       ldr     x1, =handle_arch_irq
> +       ldr     x1, [x1]

How about using

adrp x1, handle_arch_irq
ldr x1, [x1, #:lo12:handle_arch_irq]

instead, and avoid the literal pool entry?

-- 
Ard.


>         mov     x0, sp
>         blr     x1
>         .endm
> @@ -677,6 +678,3 @@ ENTRY(sys_rt_sigreturn_wrapper)
>         mov     x0, sp
>         b       sys_rt_sigreturn
>  ENDPROC(sys_rt_sigreturn_wrapper)
> -
> -ENTRY(handle_arch_irq)
> -       .quad   0
> diff --git a/arch/arm64/kernel/irq.c b/arch/arm64/kernel/irq.c
> index 0f08dfd..e4fedbc 100644
> --- a/arch/arm64/kernel/irq.c
> +++ b/arch/arm64/kernel/irq.c
> @@ -67,6 +67,8 @@ void handle_IRQ(unsigned int irq, struct pt_regs *regs)
>         set_irq_regs(old_regs);
>  }
>
> +void (*handle_arch_irq)(struct pt_regs *) = NULL;
> +
>  void __init set_handle_irq(void (*handle_irq)(struct pt_regs *))
>  {
>         if (handle_arch_irq)
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
