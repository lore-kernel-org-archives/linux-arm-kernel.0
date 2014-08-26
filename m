From: achandran@mvista.com (Arun Chandran)
Date: Tue, 26 Aug 2014 21:44:31 +0530
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <20140826152204.GC4078@leverpostej>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
 <1408128799.22761.47.camel@smoke>
 <20140818160253.GB3302@leverpostej>
 <CAFdej005x5rYpP+1PM2fDktmEKAO-me4+btYc37UxQxKUPMXoA@mail.gmail.com>
 <20140826152204.GC4078@leverpostej>
Message-ID: <CAFdej02w5JxsNW+5xV23-mR5GLBG9CvktJtwU3cYnZJ7Tr9GJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, Aug 26, 2014 at 8:52 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> Hi Mark,
>
> Hi Arun,
>
>> Please Ignore my previous mail. I think this version of sample
>> implementation is simple and better. Please give your comments.
>
> If you wish to have this reviewed in any depth, please:
>
>  - Base your patches on mainline, or at the very least provide a pointer
>    to the branch the patch is based upon.
>
>  - Test that this functions with and without CONFIG_KVM.
>
>  - Post this as an RFC PATCH, complete with a rationale (as previously
>    discussed).
>
>  - For later revisions, please label the patches with a version and give
>    adequate delay between postings to allow for review.
>

Yes I will put a RFC patch soon.

> I've given some comments below, but please post proper patches in
> future.
>

My Intention was to do the same(RFC patch); but I did not wanted
to drift a lot from your idea that is why I sent it like below.

>> ###########
>> diff --git a/arch/arm64/include/asm/proc-fns.h
>> b/arch/arm64/include/asm/proc-fns.h
>> index ddbc3f5..40d3360 100644
>> --- a/arch/arm64/include/asm/proc-fns.h
>> +++ b/arch/arm64/include/asm/proc-fns.h
>> @@ -31,7 +31,7 @@ struct cpu_suspend_ctx;
>>  extern void cpu_cache_off(void);
>>  extern void cpu_do_idle(void);
>>  extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
>> -extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
>> +extern void cpu_reset(unsigned long addr, unsigned long boot_mode)
>> __attribute__((noreturn));
>>  extern void cpu_soft_restart(phys_addr_t cpu_reset, unsigned long
>> addr) __attribute__((noreturn));
>>  extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
>>  extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
>> diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
>> index 215ad46..3976737 100644
>> --- a/arch/arm64/include/asm/virt.h
>> +++ b/arch/arm64/include/asm/virt.h
>> @@ -34,6 +34,7 @@
>>   */
>>  extern u32 __boot_cpu_mode[2];
>>
>> +void __hyp_func_call(phys_addr_t func, ...);
>>  void __hyp_set_vectors(phys_addr_t phys_vector_base);
>>  phys_addr_t __hyp_get_vectors(void);
>>
>> diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
>> index a272f33..82c2b0d 100644
>> --- a/arch/arm64/kernel/hyp-stub.S
>> +++ b/arch/arm64/kernel/hyp-stub.S
>> @@ -53,14 +53,12 @@ ENDPROC(__hyp_stub_vectors)
>>         .align 11
>>
>>  el1_sync:
>> -       mrs     x1, esr_el2
>> -       lsr     x1, x1, #26
>> -       cmp     x1, #0x16
>> +       mrs     x19, esr_el2
>> +       lsr     x19, x19, #26
>> +       cmp     x19, #0x16
>>         b.ne    2f                              // Not an HVC trap
>> -       cbz     x0, 1f
>> -       msr     vbar_el2, x0                    // Set vbar_el2
>> -       b       2f
>> -1:     mrs     x0, vbar_el2                    // Return vbar_el2
>> +
>> +1:     blr     x0                              // Jump to the function
>
> You need to stash the orignal lr, or we can't return from
> __hyp_call_func.

Ok.
>
>>  2:     eret
>>  ENDPROC(el1_sync)
>>
>> @@ -101,10 +99,17 @@ ENDPROC(\label)
>>   */
>>
>>  ENTRY(__hyp_get_vectors)
>> -       mov     x0, xzr
>> -       // fall through
>> -ENTRY(__hyp_set_vectors)
>> -       hvc     #0
>> +       mrs     x0, vbar_el2                    // Return vbar_el2
>>         ret
>>  ENDPROC(__hyp_get_vectors)
>> +
>> +ENTRY(__hyp_set_vectors)
>> +       msr     vbar_el2, x1
>> +       ret
>>  ENDPROC(__hyp_set_vectors)
>> +
>> +/* Call a function @x0 */
>> +ENTRY(__hyp_func_call)
>> +       hvc     #0
>> +       ret
>> +ENDPROC(__hyp_func_call)
>
> These will be called at EL1, so this breaks KVM.
>
>> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
>> index 3cb6dec..e68f42e 100644
>> --- a/arch/arm64/mm/proc.S
>> +++ b/arch/arm64/mm/proc.S
>> @@ -25,6 +25,7 @@
>>  #include <asm/hwcap.h>
>>  #include <asm/pgtable-hwdef.h>
>>  #include <asm/pgtable.h>
>> +#include <asm/virt.h>
>>
>>  #include "proc-macros.S"
>>
>> @@ -69,19 +70,26 @@ ENDPROC(cpu_cache_off)
>>   */
>>         .align  5
>>  ENTRY(cpu_reset)
>> -       mrs     x1, sctlr_el1
>> -       bic     x1, x1, #1
>> -       msr     sctlr_el1, x1                   // disable the MMU
>> +       mrs     x2, sctlr_el1
>> +       bic     x2, x2, #1
>> +       msr     sctlr_el1, x2                   // disable the MMU
>>         isb
>>  #if defined(CONFIG_SMP)
>>  /*     bl      secondary_shutdown */
>>  #endif
>> +       sub     w1, w1, #BOOT_CPU_MODE_EL2
>> +       cbz     w1, __hyp_func_call
>>         ret     x0
>>  ENDPROC(cpu_reset)
>
> Please base your patches on mainline (or if you need the fixed-up
> soft_restart, the arm64 devel branch).
>
> I thought we'd shot down the idea of the secondary_shutdown call.
>
Yes. Please see it is commented.

>>  ENTRY(cpu_soft_restart)
>> +       ldr     x3, =__boot_cpu_mode
>> +       add     x3, x3, #4
>> +       ldr     w2, [x3]
>> +
>>         mov     x19, x0
>>         mov     x20, x1
>> +       mov     w21, w2
>>
>>         /* Turn D-cache off */
>>         bl      cpu_cache_off
>> @@ -89,6 +97,7 @@ ENTRY(cpu_soft_restart)
>>         bl      flush_cache_all
>>
>>         mov     x0, x20
>> +       mov     w1, w21
>>         ret     x19
>>  ENDPROC(cpu_soft_restart)
>> #########
>>
>> I have implemented __hyp_func_call; other userscan
>> make use of it to call __hyp_set_vectors/__hyp_get_vectors
>
> The callers of those functions _must_ be updated in this patch to use
> the new hypercall mechanism.

Ok.

--Arun
