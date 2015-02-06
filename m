From: freddy77@gmail.com (Frediano Ziglio)
Date: Fri, 6 Feb 2015 09:50:10 +0000
Subject: Kexec and KVM not working gracefully together
In-Reply-To: <54D43F52.7030606@linaro.org>
References: <CAHt6W4cuRi3bfj5mryFouhOLGAAWuNXKVvz4K-rAjQnwiegL-Q@mail.gmail.com>
 <54C7ADF0.8090102@arm.com> <54D30AE0.5050101@linaro.org>
 <20150205094317.43f8554a@arm.com> <54D34592.9010903@linaro.org>
 <CAHt6W4dS-fv0U+=ch1-=X36EpyE5FA89aY8LVqbFP0+R3GvLqw@mail.gmail.com>
 <54D37108.9020103@arm.com>
 <CAHt6W4cckuuK+=1ZHNUEEW5BuiyiGNc2CeuP9O7MaC0WpScZoA@mail.gmail.com>
 <CAHt6W4eQ3iC+sqWAn5LkkfC-XBgGWR0i6TXjWvzEsUqFh75fwQ@mail.gmail.com>
 <54D43F52.7030606@linaro.org>
Message-ID: <CAHt6W4eQ1q+JxmB2o4MigDF+Li98iYhBfg2KXTTq3wGcNSCKMw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-06 4:13 GMT+00:00 AKASHI Takahiro <takahiro.akashi@linaro.org>:
> Hi Frediano
> [add Geoff to cc]
>
> I still have to compare my code with yours, but please note that
> some files in arch/arm/kvm are shared with arm64, especially
> arm.c, mmu.c and related headers.
>

Didn't know.

> So can you please
> - submit your new patch without including old e-mail threads.
>   (don't forget RFC or PATCH.)
> - break it up into two pieces, one for common, the other for arm
>

I'll do for next.

> and a few more comments below:
>
> On 02/06/2015 01:56 AM, Frediano Ziglio wrote:
>
> [snip]
>
>> New version. Changes:
>> - removed saved value and test again
>> - remove vm flush, useless
>> - correct compile check on header
>> - try KVM enabled and not, compile link and tests
>> - rewrite comments, add more where necessary
>> - remove code to free and allocate again boot PGD and related, keep in
>> memory if KEXEC is enabled
>>
>> Still not trying SMP. Still to be considered RFC. I tried different
>> compile options (KEXEC and KVM turned on/off). I realized that I
>> should test if kernel is started with SVC mode code still works
>> correctly. ARM_VIRT_EXT is always turned on for V7 CPU.
>>
>>
>> diff --git a/arch/arm/include/asm/kvm_asm.h
>> b/arch/arm/include/asm/kvm_asm.h
>> index 3a67bec..985f0a3 100644
>> --- a/arch/arm/include/asm/kvm_asm.h
>> +++ b/arch/arm/include/asm/kvm_asm.h
>> @@ -97,7 +97,19 @@ extern char __kvm_hyp_code_end[];
>>   extern void __kvm_flush_vm_context(void);
>>   extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
>>
>> +extern void __kvm_set_vectors(unsigned long phys_vector_base);
>> +
>>   extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
>> +
>> +#ifndef CONFIG_ARM_VIRT_EXT
>
>
> Arm64 doesn't have CONFIG_ARM_VIRT_EXT. Why don't use CONFIG_KVM?
> I'd rather put this conditional into the place where the function is
> actually called for flexible implementation. (See below)
>

In ARMv7 you can have ARM_VIRT_EXT but not KVM. ARM_VIRT_EXT means the
processor can support virtualization while KVM means you want to
compile kvm in the kernel. So code should be defined if either are
defined.

>
>> +static void kvm_cpu_reset(void (*phys_reset)(void *), void *addr)
>> +{
>> +    phys_reset(addr);
>> +}
>> +#else
>> +extern void kvm_cpu_reset(void (*phys_reset)(void *), void *addr);
>> +#endif
>> +
>>   #endif
>>
>>   #endif /* __ARM_KVM_ASM_H__ */
>> diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
>> index 2a55373..30339ad 100644
>> --- a/arch/arm/kernel/hyp-stub.S
>> +++ b/arch/arm/kernel/hyp-stub.S
>> @@ -164,13 +164,63 @@ ARM_BE8(orr    r7, r7, #(1 << 25))     @ HSCTLR.EE
>>       bx    lr            @ The boot CPU mode is left in r4.
>>   ENDPROC(__hyp_stub_install_secondary)
>>
>> +#undef CPU_RESET
>> +#if defined(CONFIG_ARM_VIRT_EXT) && !defined(CONFIG_KVM) &&
>> !defined(ZIMAGE)
>> +#  define CPU_RESET 1
>> +#endif
>> +
>>   __hyp_stub_do_trap:
>> +#ifdef CPU_RESET
>> +    cmp    r0, #-2
>> +    bne    1f
>> +
>> +    mrc    p15, 4, r0, c1, c0, 0    @ HSCR
>> +    ldr    r2, =0x40003807
>> +    bic    r0, r0, r2
>> +    mcr    p15, 4, r0, c1, c0, 0    @ HSCR
>> +    isb
>> +
>> +    @ Disable MMU, caches and Thumb in SCTLR
>> +    mrc    p15, 0, r0, c1, c0, 0    @ SCTLR
>> +    bic    r0, r0, r2
>> +    mcr    p15, 0, r0, c1, c0, 0
>> +
>> +    bx    r1
>> +    .ltorg
>> +1:
>> +#endif
>>       cmp    r0, #-1
>>       mrceq    p15, 4, r0, c12, c0, 0    @ get HVBAR
>>       mcrne    p15, 4, r0, c12, c0, 0    @ set HVBAR
>>       __ERET
>>   ENDPROC(__hyp_stub_do_trap)
>>
>> +#ifdef CPU_RESET
>> +/*
>> + * r0 cpu_reset function
>> + * r1 address to jump to
>> + */
>> +ENTRY(kvm_cpu_reset)
>> +    mov    r2, r0
>> +
>> +    @ __boot_cpu_mode should be HYP_MODE
>> +    adr    r0, .L__boot_cpu_mode_offset
>> +    ldr    r3, [r0]
>> +    ldr    r0, [r0, r3]
>> +    cmp    r0, #HYP_MODE
>> +    beq    reset_to_hyp
>> +
>> +    @ Call SVC mode cpu_reset
>> +    mov    r0, r1
>> +THUMB(    orr    r2, r2, 1    )
>> +    bx    r2
>> +
>> +reset_to_hyp:
>> +    mov    r0, #-2
>> +    b    __hyp_set_vectors
>> +ENDPROC(kvm_cpu_reset)
>> +#endif
>> +
>>   /*
>>    * __hyp_set_vectors: Call this after boot to set the initial hypervisor
>>    * vectors as part of hypervisor installation.  On an SMP system, this
>> should
>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>> index fdfa3a7..c018719 100644
>> --- a/arch/arm/kernel/process.c
>> +++ b/arch/arm/kernel/process.c
>> @@ -41,6 +41,7 @@
>>   #include <asm/system_misc.h>
>>   #include <asm/mach/time.h>
>>   #include <asm/tls.h>
>> +#include <asm/kvm_asm.h>
>>
>>   #ifdef CONFIG_CC_STACKPROTECTOR
>>   #include <linux/stackprotector.h>
>> @@ -60,7 +61,7 @@ static const char *isa_modes[] __maybe_unused = {
>>   };
>>
>>   extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
>> -typedef void (*phys_reset_t)(unsigned long);
>> +typedef void (*phys_reset_t)(void *);
>>
>>   /*
>>    * A temporary stack to use for CPU reset. This is static so that we
>> @@ -89,7 +90,8 @@ static void __soft_restart(void *addr)
>>
>>       /* Switch to the identity mapping. */
>>       phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
>> -    phys_reset((unsigned long)addr);
>> +
>> +    kvm_cpu_reset(phys_reset, addr);
>
>
> How about this?
> #ifdef CONFIG_KVM
>         kvm_cpu_reset(...);
> #endif
>         phys_reset(addr);
>
> It will clearify the purpose of kvm_cpu_reset().
> The name of kvm_cpu_reset() might better be cpu_*de*init_hyp_mode or similar
> given that the function would be called in hyp_init_cpu_notify()
> once kvm supports cpu hotplug in the future.
>

the purpose of kvm_cpu_reset is to reset state and jump to newer
kernel initialization code. Is a no return function like cpu_reset. So
perhaps code can be

#if defined(CONFIG_KVM) || defined(CONFIG_ARM_VIRT_EXT)
        kvm_cpu_reset(...);
#else
        phys_reset(addr);
#endif

>>       /* Should never get here. */
>>       BUG();
>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index 0b0d58a..e4d4a2b 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -1009,7 +1009,7 @@ static int init_hyp_mode(void)
>>       if (err)
>>           goto out_free_mappings;
>>
>> -#ifndef CONFIG_HOTPLUG_CPU
>> +#if !defined(CONFIG_HOTPLUG_CPU) && !defined(CONFIG_KEXEC)
>>       free_boot_hyp_pgd();
>>   #endif
>>
>> @@ -1079,6 +1079,53 @@ out_err:
>>       return err;
>>   }
>>
>> +void kvm_cpu_reset(void (*phys_reset)(void *), void *addr)
>
>
> I'm not sure, but it might be better to put this code into arm/kernel/init.S
> as it is a counterpart of _do_hyp_init from cpu_init_hyp_mode().
>

init.S is written in assembly, kvm_cpu_reset for kvm is written in C.
There is another version if kvm is disabled.

The kernel code is supposed (at least in ARMv7) to run in SVC mode,
not on HYP mode. One reason is that code that change SCTLR executed at
HYP instead of SVC would not change current mode system control
register. The function does not revert to HYP for this reason.

>
>> +{
>> +    unsigned long vector;
>> +
>> +    if (!is_hyp_mode_available()) {
>> +        phys_reset(addr);
>> +        return;
>> +    }
>> +
>> +    vector = (unsigned long) kvm_get_idmap_vector();
>> +
>> +    /*
>> +     * Set vectors so we call initialization routines.
>> +     * trampoline is mapped at TRAMPOLINE_VA but not at its physical
>> +     * address so we don't have an identity map to be able to
>> +     * disable MMU. We need to set exception vector at trampoline
>> +     * at TRAMPOLINE_VA address which is mapped.
>> +     */
>> +    kvm_call_hyp(__kvm_set_vectors,(unsigned long) (TRAMPOLINE_VA +
>> (vector & (PAGE_SIZE-1))));
>> +
>> +    /*
>> +     * Set HVBAR to physical address, page table to identity to do the
>> switch
>> +     */
>> +    kvm_call_hyp((void*) 4, (unsigned long) vector,
>> kvm_mmu_get_boot_httbr());
>> +
>> +    /*
>> +     * Flush to make sure code after the cache are disabled see updated
>> values
>> +     */
>> +    flush_cache_all();
>> +
>> +    /*
>> +     * Turn off caching on Hypervisor mode
>> +     */
>> +    kvm_call_hyp((void*) 1);
>> +
>> +    /*
>> +     * Flush to make sude code don't see old cached values after cache is
>> +     * enabled
>> +     */
>> +    flush_cache_all();
>> +
>> +    /*
>> +     * Restore execution
>> +     */
>> +    kvm_call_hyp((void*) 3, addr);
>> +}
>> +
>
>
> If you like kvm_call_hyp-like sequences, please specify what each
> kvm_call_hyp() should do.
> (we can do all in one kvm_call_hyp() though.)
>

kvm_call_hyp support a restricted number of arguments as they must be
on registers and I actually need more registers. I found quite
confusing that every vector table and HVC call have it's interface.
One for stub (-1 get HVBAR otherwise set), one for kvm (-1 get HVBAR
otherwise function pointer) and another for kvm initialization (0
first initialization, otherwise stack pointer, HVBAR and HTTBR).
Wouldn't be much nicer to pass a index for a function, something like
(in C pseudocode)

typedef unsigned (*hvc_func_t)(unsigned a1, unsigned a2, unsigned a3);

hvc_func_t hvc_funcs[MAX_HVC_FUNC];

#define HVC_FUNC_GET_HVBAR 0
#define HVC_FUNC_SET_HVBAR 1
#define HVC_FUNC_FLUSH_xxx 2
...

and in assembly we could just use these indexes ?? Of course some HVC
implementation should return not implemented.

I could disable cache on first call (the one I set just HVBAR) and
doing the flush than call second one with:
- vector in physical address (to jump to trampoline before disabling
MMU) with bit 0 set to distinguish from stack/0;
- address of newer kernel
- boot HTTBR (it takes 2 register as it's 64 bit)

I'll have a look at arm64 code.

Thank you,
   Frediano

> Thanks,
> -Takahiro AKASHI
>
>
>>   /* NOP: Compiling as a module not supported */
>>   void kvm_arch_exit(void)
>>   {
>> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
>> index 3988e72..c2f1d4d 100644
>> --- a/arch/arm/kvm/init.S
>> +++ b/arch/arm/kvm/init.S
>> @@ -68,6 +68,12 @@ __kvm_hyp_init:
>>       W(b)    .
>>
>>   __do_hyp_init:
>> +    @ check for special values, odd numbers can't be a stack pointer
>> +    cmp    r0, #1
>> +    beq    cpu_proc_fin
>> +    cmp    r0, #3
>> +    beq    restore
>> +
>>       cmp    r0, #0            @ We have a SP?
>>       bne    phase2            @ Yes, second stage init
>>
>> @@ -151,6 +157,33 @@ target:    @ We're now in the trampoline code,
>> switch page tables
>>
>>       eret
>>
>> +cpu_proc_fin:
>> +    mrc    p15, 4, r0, c1, c0, 0        @ ctrl register
>> +    bic    r0, r0, #0x1000            @ ...i............
>> +    bic    r0, r0, #0x0006            @ .............ca.
>> +    mcr    p15, 4, r0, c1, c0, 0        @ disable caches
>> +    eret
>> +
>> +restore:
>> +    @ Disable MMU, caches and Thumb in HSCTLR
>> +    mrc    p15, 4, r0, c1, c0, 0    @ HSCR
>> +    ldr    r2, =0x40003807
>> +    bic    r0, r0, r2
>> +    mcr    p15, 4, r0, c1, c0, 0    @ HSCR
>> +    isb
>> +
>> +    @ Invalidate old TLBs
>> +    mcr    p15, 4, r0, c8, c7, 0    @ TLBIALLH
>> +    isb
>> +    dsb    ish
>> +
>> +    @ Disable MMU, caches and Thumb in SCTLR
>> +    mrc    p15, 0, r0, c1, c0, 0   @ SCTLR
>> +    bic    r0, r0, r2
>> +    mcr    p15, 0, r0, c1, c0, 0
>> +
>> +    bx    r1
>> +
>>       .ltorg
>>
>>       .globl __kvm_hyp_init_end
>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index 01dcb0e..449e7dd 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
>> @@ -87,6 +87,18 @@ ENDPROC(__kvm_flush_vm_context)
>>
>>
>>   /********************************************************************
>> + * Set HVBAR
>> + *
>> + * void __kvm_set_vectors(unsigned long phys_vector_base);
>> + */
>> +ENTRY(__kvm_set_vectors)
>> +    mcr    p15, 4, r0, c12, c0, 0    @ set HVBAR
>> +    dsb    ish
>> +    isb
>> +    bx    lr
>> +ENDPROC(__kvm_set_vectors)
>> +
>> +/********************************************************************
>>    *  Hypervisor world-switch code
>>    *
>>    *
>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 1366625..f853858 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -369,6 +369,11 @@ void free_boot_hyp_pgd(void)
>>       free_page((unsigned long)init_bounce_page);
>>       init_bounce_page = NULL;
>>
>> +    /* avoid to reuse possibly invalid values if bounce page is freed */
>> +    hyp_idmap_start = 0;
>> +    hyp_idmap_end = 0;
>> +    hyp_idmap_vector = 0;
>> +
>>       mutex_unlock(&kvm_hyp_pgd_mutex);
>>   }
>>
>>
>> Frediano
>>
>
