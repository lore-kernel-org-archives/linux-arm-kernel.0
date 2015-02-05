From: freddy77@gmail.com (Frediano Ziglio)
Date: Thu, 5 Feb 2015 16:56:42 +0000
Subject: Kexec and KVM not working gracefully together
In-Reply-To: <CAHt6W4cckuuK+=1ZHNUEEW5BuiyiGNc2CeuP9O7MaC0WpScZoA@mail.gmail.com>
References: <CAHt6W4cuRi3bfj5mryFouhOLGAAWuNXKVvz4K-rAjQnwiegL-Q@mail.gmail.com>
 <54C7ADF0.8090102@arm.com> <54D30AE0.5050101@linaro.org>
 <20150205094317.43f8554a@arm.com> <54D34592.9010903@linaro.org>
 <CAHt6W4dS-fv0U+=ch1-=X36EpyE5FA89aY8LVqbFP0+R3GvLqw@mail.gmail.com>
 <54D37108.9020103@arm.com>
 <CAHt6W4cckuuK+=1ZHNUEEW5BuiyiGNc2CeuP9O7MaC0WpScZoA@mail.gmail.com>
Message-ID: <CAHt6W4eQ3iC+sqWAn5LkkfC-XBgGWR0i6TXjWvzEsUqFh75fwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-02-05 14:27 GMT+00:00 Frediano Ziglio <freddy77@gmail.com>:
> 2015-02-05 13:32 GMT+00:00 Marc Zyngier <marc.zyngier@arm.com>:
>> On 05/02/15 10:51, Frediano Ziglio wrote:
>>> 2015-02-05 10:27 GMT+00:00 AKASHI Takahiro <takahiro.akashi@linaro.org>:
>>>> On 02/05/2015 06:43 PM, Marc Zyngier wrote:
>>>>>
>>>>> On Thu, 5 Feb 2015 06:17:04 +0000
>>>>> AKASHI Takahiro <takahiro.akashi@linaro.org> wrote:
>>>>>
>>>>>> Frediano
>>>>>> Cc: Marc
>>>>>>
>>>>>> Are you going to fix this issue on arm?
>>>>>> As I'm now working on the same issue on arm64,
>>>>>> we should share the idea and some code.
>>>>>
>>>>>
>>>>> Just to be perfectly clear: KVM support for Kexec on arm and arm64
>>>>> should be exactly the same, with the exception of some (very
>>>>> limited) assembly code for the MMU teardown.
>>>>
>>>>
>>>> Yep, that's exactly what I meant.
>>>>
>>>>> And I'd like to see both architectures addressed at the same time,
>>>>> without statements such as "we'll do that as a next step". As such, I'd
>>>>> very much recommend that Frediano and you work together to address this
>>>>> problem.
>>>>
>>>>
>>>> I hope so.
>>>>
>>>> Thanks,
>>>> -Takahiro AKASHI
>>>>
>>>>> Thanks,
>>>>>
>>>>>          M.
>>>>>
>>>
>>>
>>>
>>> Well, let's code speak. I'm actually testing it with an ARM32 platform
>>> with a single CPU (platform have 16 cores but I'm using a no SMP
>>> kernel for my tests for different reason, I should be able to test SMP
>>> in a couple of days).
>>>
>>> The key point is the switch back code (arm.c, kvm_cpu_reset code). The idea:
>>> - at boot time I save HSCTLR value
>>
>> Why do you need this? The content of that register is known at any point
>> of the lifetime of the kernel, and so is its value at reboot time
>> (basically MMU and caches disabled, ARM mode).
>>
>> This should be part of your MMU teardown process.
>>
>
> I should have put a RFC in the subject. Probably I can just adjust the
> value without saving the boot one.
>
>>> - restore boot page tables and trampoline before cpu reset
>>> - call kvm_cpu_reset instead of cpu_reset (this will call cpu_reset if
>>> kvm is disabled)
>>> - set hvbar to trampoline (virtual memory)
>>> - set hvbar to physical trampoline and boot pages (with trampoline
>>> mapped at physical and virtual that is identity)
>>> - flush memory while disabling caching on hypervisor mode (not doing
>>> cause a lot of instability, now I rebooted more than 100 times in a
>>> row)
>>> - call hypervisor mode to do the reset cpu restoring the boot HSCTLR value
>>>
>>>
>>> Hope gmail does not screw my patch...
>>>
>>>
>>> diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
>>> index 3a67bec..71380a1 100644
>>> --- a/arch/arm/include/asm/kvm_asm.h
>>> +++ b/arch/arm/include/asm/kvm_asm.h
>>> @@ -97,7 +97,24 @@ extern char __kvm_hyp_code_end[];
>>>  extern void __kvm_flush_vm_context(void);
>>>  extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);
>>>
>>> +extern void __kvm_set_vectors(unsigned long phys_vector_base);
>>> +
>>>  extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
>>> +
>>> +#ifdef CONFIG_HAVE_KVM
>>
>> That doesn't seem right. Shouldn't that be #ifndef?
>>
>
> Well... I don't know where I got that define, the name is wrong too.
> However I think that the kernel should switch to hypervisor mode
> either if kvm is enabled or not. head.S test for CONFIG_ARM_VIRT_EXT
> so probably I should have the same test here. I should also try to
> compile with either KVM enabled or not just to check that kernel links
> correctly.
>
>>> +static void kvm_cpu_reset(void (*phys_reset)(void *), void *addr)
>>> +{
>>> +    phys_reset(addr);
>>> +}
>>> +static inline int kvm_mmu_reset_prepare(void)
>>> +{
>>> +    return 0;
>>> +}
>>> +#else
>>> +extern void kvm_cpu_reset(void (*phys_reset)(void *), void *addr);
>>> +extern int kvm_mmu_reset_prepare(void);
>>> +#endif
>>> +
>>>  #endif
>>>
>>>  #endif /* __ARM_KVM_ASM_H__ */
>>> diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
>>> index 04b4ea0..c0b6c20 100644
>>> --- a/arch/arm/include/asm/kvm_host.h
>>> +++ b/arch/arm/include/asm/kvm_host.h
>>> @@ -192,6 +192,8 @@ int kvm_arm_coproc_set_reg(struct kvm_vcpu *vcpu,
>>> const struct kvm_one_reg *);
>>>  int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
>>>          int exception_index);
>>>
>>> +extern unsigned kvm_saved_sctlr;
>>> +
>>>  static inline void __cpu_init_hyp_mode(phys_addr_t boot_pgd_ptr,
>>>                         phys_addr_t pgd_ptr,
>>>                         unsigned long hyp_stack_ptr,
>>> @@ -213,7 +215,7 @@ static inline void __cpu_init_hyp_mode(phys_addr_t
>>> boot_pgd_ptr,
>>>       * PCS!).
>>>       */
>>>
>>> -    kvm_call_hyp(NULL, 0, boot_pgd_ptr);
>>> +    kvm_saved_sctlr = (unsigned) kvm_call_hyp(NULL, 0, boot_pgd_ptr);
>>>
>>>      kvm_call_hyp((void*)hyp_stack_ptr, vector_ptr, pgd_ptr);
>>>  }
>>> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
>>> index fdfa3a7..026a1e4 100644
>>> --- a/arch/arm/kernel/process.c
>>> +++ b/arch/arm/kernel/process.c
>>> @@ -41,6 +41,7 @@
>>>  #include <asm/system_misc.h>
>>>  #include <asm/mach/time.h>
>>>  #include <asm/tls.h>
>>> +#include <asm/kvm_asm.h>
>>>
>>>  #ifdef CONFIG_CC_STACKPROTECTOR
>>>  #include <linux/stackprotector.h>
>>> @@ -60,7 +61,7 @@ static const char *isa_modes[] __maybe_unused = {
>>>  };
>>>
>>>  extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
>>> -typedef void (*phys_reset_t)(unsigned long);
>>> +typedef void (*phys_reset_t)(void *);
>>>
>>>  /*
>>>   * A temporary stack to use for CPU reset. This is static so that we
>>> @@ -89,7 +90,7 @@ static void __soft_restart(void *addr)
>>>
>>>      /* Switch to the identity mapping. */
>>>      phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
>>> -    phys_reset((unsigned long)addr);
>>> +    kvm_cpu_reset(phys_reset, addr);
>>>
>>>      /* Should never get here. */
>>>      BUG();
>>> @@ -107,6 +108,8 @@ void soft_restart(unsigned long addr)
>>>      if (num_online_cpus() == 1)
>>>          outer_disable();
>>>
>>> +    kvm_mmu_reset_prepare();
>>> +
>>>      /* Change to the new stack and continue with the reset. */
>>>      call_with_stack(__soft_restart, (void *)addr, (void *)stack);
>>>
>>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>>> index 0b0d58a..7727678 100644
>>> --- a/arch/arm/kvm/arm.c
>>> +++ b/arch/arm/kvm/arm.c
>>> @@ -63,6 +63,8 @@ static DEFINE_SPINLOCK(kvm_vmid_lock);
>>>
>>>  static bool vgic_present;
>>>
>>> +unsigned kvm_saved_sctlr;
>>> +
>>>  static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
>>>  {
>>>      BUG_ON(preemptible());
>>> @@ -1079,6 +1081,37 @@ out_err:
>>>      return err;
>>>  }
>>>
>>> +void kvm_cpu_reset(void (*phys_reset)(void *), void *addr)
>>> +{
>>> +    unsigned long vector;
>>> +
>>> +    if (!is_hyp_mode_available()) {
>>> +        phys_reset(addr);
>>> +        return;
>>> +    }
>>> +
>>> +    vector = (unsigned long) kvm_get_idmap_vector();
>>> +
>>> +    kvm_call_hyp(__kvm_flush_vm_context);
>>
>> What are you trying to achieve here? This only makes sense if you're
>> reassigning VMIDs. I would certainly hope that, by the time you're
>> tearing KVM down for reboot, no VM is up and running.
>>
>
> Too many try flushing the cache... I can remove this flush.
>
>>> +
>>> +    /* set vectors so we call initialization routines */
>>> +    /* trampoline is still on memory, physical ram is not mapped */
>>
>> Comment is incredibly misleading. Physical memory *IS* mapped. What you
>> have is a kernel mapping of that page.
>>
>
> Right, should be "trampoline is mapped at TRAMPOLINE_VA but not at its
> physical address so we don't have an identity map to be able to
> disable MMU".
>
>>> +    kvm_call_hyp(__kvm_set_vectors,(unsigned long) (TRAMPOLINE_VA +
>>> (vector & (PAGE_SIZE-1))));
>>
>> That really deserves a comment as to *why* you're doing that offsetting.
>>
>
> I think "Set exception vectors at trampoline at TRAMPOLINE_VA address
> which is mapped".
>
>>> +
>>> +    /* set HVBAR to physical, page table to identity to do the switch */
>>> +    kvm_call_hyp((void*) 0x100, (unsigned long) vector,
>>> kvm_mmu_get_boot_httbr());
>>
>> Where is that 0x100 (stack?) coming from?
>>
>
> Could be 0x4, it's a valid pointer stack, I don't use stack but I use
> to reuse second phase in the identity map.
>
>>> +    flush_cache_all();
>>
>> Why do you need a flush_all? Why can't you do it by VA?
>>> +
>>> +    /* Turn off caching on Hypervisor mode */
>>> +    kvm_call_hyp((void*) 1);
>>> +
>>> +    flush_cache_all();
>>
>> The fact that you have to do it twice is indicative of other problems.
>>
>
> It's the same code in __soft_restart. The first flush is to make sure
> that code after the cache are disabled see updated values, the second
> one is to make sure that code don't see old cached values after cache
> is enabled (this happen when second kernel enable it). Without these
> flushes you got memory corruption. Yes, probably I can do by VA but we
> are on a slow code path restarting the system with a single CPU, best
> safe then sorry.
>
>>> +    /* restore execution */
>>> +    kvm_call_hyp((void*) 3, kvm_saved_sctlr, addr);
>>
>> That seems useless to me (as mentioned above). The whole sequence can
>> probably be reduced to a couple of HYP calls, and made much more
>> straightforward.
>>
>
> Yes, could be. However it's better to call flush functions from
> supervisor mode as all kernel code is mainly though for that mode.
> This call beside restoring the saver HSCTLR also jump to the code that
> setup the new kernel so I would say it's quite useful.
>
>>> +}
>>> +
>>>  /* NOP: Compiling as a module not supported */
>>>  void kvm_arch_exit(void)
>>>  {
>>> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
>>> index 3988e72..79f435a 100644
>>> --- a/arch/arm/kvm/init.S
>>> +++ b/arch/arm/kvm/init.S
>>> @@ -68,12 +68,21 @@ __kvm_hyp_init:
>>>      W(b)    .
>>>
>>>  __do_hyp_init:
>>> +    @ check for special values, odd numbers can't be a stack pointer
>>> +    cmp    r0, #1
>>> +    beq    cpu_proc_fin
>>> +    cmp    r0, #3
>>> +    beq    restore
>>> +
>>>      cmp    r0, #0            @ We have a SP?
>>>      bne    phase2            @ Yes, second stage init
>>>
>>>      @ Set the HTTBR to point to the hypervisor PGD pointer passed
>>>      mcrr    p15, 4, rr_lo_hi(r2, r3), c2
>>>
>>> +    @ Save HSCR to be able to return it, save and restore
>>> +    mrc    p15, 4, r3, c1, c0, 0    @ HSCR
>>> +
>>>      @ Set the HTCR and VTCR to the same shareability and cacheability
>>>      @ settings as the non-secure TTBCR and with T0SZ == 0.
>>>      mrc    p15, 4, r0, c2, c0, 2    @ HTCR
>>> @@ -125,6 +134,9 @@ __do_hyp_init:
>>>      isb
>>>      mcr    p15, 4, r0, c1, c0, 0    @ HSCR
>>>
>>> +    @ Return initial HSCR register
>>> +    mov    r0, r3
>>> +
>>>      @ End of init phase-1
>>>      eret
>>>
>>> @@ -151,6 +163,29 @@ target:    @ We're now in the trampoline code,
>>> switch page tables
>>>
>>>      eret
>>>
>>> +cpu_proc_fin:
>>> +    mrc    p15, 4, r0, c1, c0, 0        @ ctrl register
>>> +    bic    r0, r0, #0x1000            @ ...i............
>>> +    bic    r0, r0, #0x0006            @ .............ca.
>>> +    mcr    p15, 4, r0, c1, c0, 0        @ disable caches
>>> +    eret
>>> +
>>> +restore:
>>> +    isb
>>> +    mcr    p15, 4, r1, c1, c0, 0    @ HSCR
>>> +    isb
>>> +    mcr    p15, 4, r0, c8, c7, 0    @ TLBIALLH
>>> +    isb
>>> +    dsb    ish
>>> +
>>> +    @ Disable MMU, caches and Thumb in SCTLR
>>> +    mrc    p15, 0, r1, c1, c0, 0   @ SCTLR
>>> +    ldr    r0, =0x40003807
>>> +    bic    r1, r1, r0
>>> +    mcr    p15, 0, r1, c1, c0, 0
>>> +
>>> +    bx    r2
>>> +
>>>      .ltorg
>>>
>>>      .globl __kvm_hyp_init_end
>>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>>> index 01dcb0e..449e7dd 100644
>>> --- a/arch/arm/kvm/interrupts.S
>>> +++ b/arch/arm/kvm/interrupts.S
>>> @@ -87,6 +87,18 @@ ENDPROC(__kvm_flush_vm_context)
>>>
>>>
>>>  /********************************************************************
>>> + * Set HVBAR
>>> + *
>>> + * void __kvm_set_vectors(unsigned long phys_vector_base);
>>> + */
>>> +ENTRY(__kvm_set_vectors)
>>> +    mcr    p15, 4, r0, c12, c0, 0    @ set HVBAR
>>> +    dsb    ish
>>> +    isb
>>> +    bx    lr
>>> +ENDPROC(__kvm_set_vectors)
>>> +
>>> +/********************************************************************
>>>   *  Hypervisor world-switch code
>>>   *
>>>   *
>>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>>> index 1366625..9149ae5 100644
>>> --- a/arch/arm/kvm/mmu.c
>>> +++ b/arch/arm/kvm/mmu.c
>>> @@ -46,6 +46,8 @@ static phys_addr_t hyp_idmap_vector;
>>>
>>>  #define kvm_pmd_huge(_x)    (pmd_huge(_x) || pmd_trans_huge(_x))
>>>
>>> +static int kvm_mmu_boot_init(void);
>>> +
>>>  static void kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
>>>  {
>>>      /*
>>> @@ -369,6 +371,11 @@ void free_boot_hyp_pgd(void)
>>>      free_page((unsigned long)init_bounce_page);
>>>      init_bounce_page = NULL;
>>>
>>> +    /* avoid to reuse possibly invalid values if bounce page is freed */
>>> +    hyp_idmap_start = 0;
>>> +    hyp_idmap_end = 0;
>>> +    hyp_idmap_vector = 0;
>>> +
>>
>> Well, in this case, why do we free the page? We'd better keep it around
>> if we have Kexec...
>>
>
> Well.. yes, only I though that people that freed that 16kb (should be)
> memory wants that 16kb memory :)
> Keeping the trampoline and boot PGD available is much more easier indeed.
>
>>>      mutex_unlock(&kvm_hyp_pgd_mutex);
>>>  }
>>>
>>> @@ -1252,7 +1259,28 @@ phys_addr_t kvm_get_idmap_vector(void)
>>>      return hyp_idmap_vector;
>>>  }
>>>
>>> -int kvm_mmu_init(void)
>>> +/* assure we have MMU setup correctly */
>>> +int kvm_mmu_reset_prepare(void)
>>> +{
>>> +    int err = 0;
>>> +
>>> +    if (boot_hyp_pgd)
>>> +        goto out;
>>> +
>>> +    err = kvm_mmu_boot_init();
>>> +    if (err)
>>> +        goto out;
>>> +
>>> +    err =     __create_hyp_mappings(hyp_pgd,
>>> +                      TRAMPOLINE_VA, TRAMPOLINE_VA + PAGE_SIZE,
>>> +                      __phys_to_pfn(hyp_idmap_start),
>>> +                      PAGE_HYP);
>>> +
>>> +out:
>>> +    return err;
>>> +}
>>> +
>>
>> ... and this code can then go away.
>>
>
> Ok, I'll remove
>
>>> +static int kvm_mmu_boot_init(void)
>>>  {
>>>      int err;
>>>
>>> @@ -1294,10 +1322,9 @@ int kvm_mmu_init(void)
>>>               (unsigned long)phys_base);
>>>      }
>>>
>>> -    hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>>> hyp_pgd_order);
>>>      boot_hyp_pgd = (pgd_t *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
>>> hyp_pgd_order);
>>>
>>> -    if (!hyp_pgd || !boot_hyp_pgd) {
>>> +    if (!boot_hyp_pgd) {
>>>          kvm_err("Hyp mode PGD not allocated\n");
>>>          err = -ENOMEM;
>>>          goto out;
>>> @@ -1326,6 +1353,27 @@ int kvm_mmu_init(void)
>>>          goto out;
>>>      }
>>>
>>> +    return 0;
>>> +out:
>>> +    free_boot_hyp_pgd();
>>> +    return err;
>>> +}
>>> +
>>> +int kvm_mmu_init(void)
>>> +{
>>> +    int err;
>>> +
>>> +    err = kvm_mmu_boot_init();
>>> +    if (err)
>>> +        goto out0;
>>> +
>>> +    hyp_pgd = kzalloc(PTRS_PER_PGD * sizeof(pgd_t), GFP_KERNEL);
>>> +    if (!hyp_pgd) {
>>> +        kvm_err("Hyp mode PGD not allocated\n");
>>> +        err = -ENOMEM;
>>> +        goto out;
>>> +    }
>>> +
>>>      /* Map the same page again into the runtime page tables */
>>>      err =     __create_hyp_mappings(hyp_pgd,
>>>                        TRAMPOLINE_VA, TRAMPOLINE_VA + PAGE_SIZE,
>>> @@ -1340,6 +1388,7 @@ int kvm_mmu_init(void)
>>>      return 0;
>>>  out:
>>>      free_hyp_pgds();
>>> +out0:
>>>      return err;
>>>  }
>>>
>>>
>>> Frediano
>>>
>>
>> Thanks for having a look into this, as you're the first one to actually
>> do something. That still requires a lot of work, and some careful
>> thoughts as to how to do this on arm64.
>>
>> Looking forward to your next patch,
>>
>>         M.
>
>
> So, my todo list:
> - removed saved value and test again
> - remove vm flush, useless
> - correct compile check on header
> - try KVM enabled and not, compile link and tests
> - rewrite comments, add more where necessary
> - remove code to free and allocate again boot PGD and related, keep in
> memory if KEXEC is enabled
> - try SMP
> Beside last step I probably could do something before next week.
>
> Frediano

New version. Changes:
- removed saved value and test again
- remove vm flush, useless
- correct compile check on header
- try KVM enabled and not, compile link and tests
- rewrite comments, add more where necessary
- remove code to free and allocate again boot PGD and related, keep in
memory if KEXEC is enabled

Still not trying SMP. Still to be considered RFC. I tried different
compile options (KEXEC and KVM turned on/off). I realized that I
should test if kernel is started with SVC mode code still works
correctly. ARM_VIRT_EXT is always turned on for V7 CPU.


diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index 3a67bec..985f0a3 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -97,7 +97,19 @@ extern char __kvm_hyp_code_end[];
 extern void __kvm_flush_vm_context(void);
 extern void __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa);

+extern void __kvm_set_vectors(unsigned long phys_vector_base);
+
 extern int __kvm_vcpu_run(struct kvm_vcpu *vcpu);
+
+#ifndef CONFIG_ARM_VIRT_EXT
+static void kvm_cpu_reset(void (*phys_reset)(void *), void *addr)
+{
+    phys_reset(addr);
+}
+#else
+extern void kvm_cpu_reset(void (*phys_reset)(void *), void *addr);
+#endif
+
 #endif

 #endif /* __ARM_KVM_ASM_H__ */
diff --git a/arch/arm/kernel/hyp-stub.S b/arch/arm/kernel/hyp-stub.S
index 2a55373..30339ad 100644
--- a/arch/arm/kernel/hyp-stub.S
+++ b/arch/arm/kernel/hyp-stub.S
@@ -164,13 +164,63 @@ ARM_BE8(orr    r7, r7, #(1 << 25))     @ HSCTLR.EE
     bx    lr            @ The boot CPU mode is left in r4.
 ENDPROC(__hyp_stub_install_secondary)

+#undef CPU_RESET
+#if defined(CONFIG_ARM_VIRT_EXT) && !defined(CONFIG_KVM) && !defined(ZIMAGE)
+#  define CPU_RESET 1
+#endif
+
 __hyp_stub_do_trap:
+#ifdef CPU_RESET
+    cmp    r0, #-2
+    bne    1f
+
+    mrc    p15, 4, r0, c1, c0, 0    @ HSCR
+    ldr    r2, =0x40003807
+    bic    r0, r0, r2
+    mcr    p15, 4, r0, c1, c0, 0    @ HSCR
+    isb
+
+    @ Disable MMU, caches and Thumb in SCTLR
+    mrc    p15, 0, r0, c1, c0, 0    @ SCTLR
+    bic    r0, r0, r2
+    mcr    p15, 0, r0, c1, c0, 0
+
+    bx    r1
+    .ltorg
+1:
+#endif
     cmp    r0, #-1
     mrceq    p15, 4, r0, c12, c0, 0    @ get HVBAR
     mcrne    p15, 4, r0, c12, c0, 0    @ set HVBAR
     __ERET
 ENDPROC(__hyp_stub_do_trap)

+#ifdef CPU_RESET
+/*
+ * r0 cpu_reset function
+ * r1 address to jump to
+ */
+ENTRY(kvm_cpu_reset)
+    mov    r2, r0
+
+    @ __boot_cpu_mode should be HYP_MODE
+    adr    r0, .L__boot_cpu_mode_offset
+    ldr    r3, [r0]
+    ldr    r0, [r0, r3]
+    cmp    r0, #HYP_MODE
+    beq    reset_to_hyp
+
+    @ Call SVC mode cpu_reset
+    mov    r0, r1
+THUMB(    orr    r2, r2, 1    )
+    bx    r2
+
+reset_to_hyp:
+    mov    r0, #-2
+    b    __hyp_set_vectors
+ENDPROC(kvm_cpu_reset)
+#endif
+
 /*
  * __hyp_set_vectors: Call this after boot to set the initial hypervisor
  * vectors as part of hypervisor installation.  On an SMP system, this should
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
index fdfa3a7..c018719 100644
--- a/arch/arm/kernel/process.c
+++ b/arch/arm/kernel/process.c
@@ -41,6 +41,7 @@
 #include <asm/system_misc.h>
 #include <asm/mach/time.h>
 #include <asm/tls.h>
+#include <asm/kvm_asm.h>

 #ifdef CONFIG_CC_STACKPROTECTOR
 #include <linux/stackprotector.h>
@@ -60,7 +61,7 @@ static const char *isa_modes[] __maybe_unused = {
 };

 extern void call_with_stack(void (*fn)(void *), void *arg, void *sp);
-typedef void (*phys_reset_t)(unsigned long);
+typedef void (*phys_reset_t)(void *);

 /*
  * A temporary stack to use for CPU reset. This is static so that we
@@ -89,7 +90,8 @@ static void __soft_restart(void *addr)

     /* Switch to the identity mapping. */
     phys_reset = (phys_reset_t)(unsigned long)virt_to_phys(cpu_reset);
-    phys_reset((unsigned long)addr);
+
+    kvm_cpu_reset(phys_reset, addr);

     /* Should never get here. */
     BUG();
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 0b0d58a..e4d4a2b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -1009,7 +1009,7 @@ static int init_hyp_mode(void)
     if (err)
         goto out_free_mappings;

-#ifndef CONFIG_HOTPLUG_CPU
+#if !defined(CONFIG_HOTPLUG_CPU) && !defined(CONFIG_KEXEC)
     free_boot_hyp_pgd();
 #endif

@@ -1079,6 +1079,53 @@ out_err:
     return err;
 }

+void kvm_cpu_reset(void (*phys_reset)(void *), void *addr)
+{
+    unsigned long vector;
+
+    if (!is_hyp_mode_available()) {
+        phys_reset(addr);
+        return;
+    }
+
+    vector = (unsigned long) kvm_get_idmap_vector();
+
+    /*
+     * Set vectors so we call initialization routines.
+     * trampoline is mapped at TRAMPOLINE_VA but not at its physical
+     * address so we don't have an identity map to be able to
+     * disable MMU. We need to set exception vector at trampoline
+     * at TRAMPOLINE_VA address which is mapped.
+     */
+    kvm_call_hyp(__kvm_set_vectors,(unsigned long) (TRAMPOLINE_VA +
(vector & (PAGE_SIZE-1))));
+
+    /*
+     * Set HVBAR to physical address, page table to identity to do the switch
+     */
+    kvm_call_hyp((void*) 4, (unsigned long) vector, kvm_mmu_get_boot_httbr());
+
+    /*
+     * Flush to make sure code after the cache are disabled see updated values
+     */
+    flush_cache_all();
+
+    /*
+     * Turn off caching on Hypervisor mode
+     */
+    kvm_call_hyp((void*) 1);
+
+    /*
+     * Flush to make sude code don't see old cached values after cache is
+     * enabled
+     */
+    flush_cache_all();
+
+    /*
+     * Restore execution
+     */
+    kvm_call_hyp((void*) 3, addr);
+}
+
 /* NOP: Compiling as a module not supported */
 void kvm_arch_exit(void)
 {
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 3988e72..c2f1d4d 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -68,6 +68,12 @@ __kvm_hyp_init:
     W(b)    .

 __do_hyp_init:
+    @ check for special values, odd numbers can't be a stack pointer
+    cmp    r0, #1
+    beq    cpu_proc_fin
+    cmp    r0, #3
+    beq    restore
+
     cmp    r0, #0            @ We have a SP?
     bne    phase2            @ Yes, second stage init

@@ -151,6 +157,33 @@ target:    @ We're now in the trampoline code,
switch page tables

     eret

+cpu_proc_fin:
+    mrc    p15, 4, r0, c1, c0, 0        @ ctrl register
+    bic    r0, r0, #0x1000            @ ...i............
+    bic    r0, r0, #0x0006            @ .............ca.
+    mcr    p15, 4, r0, c1, c0, 0        @ disable caches
+    eret
+
+restore:
+    @ Disable MMU, caches and Thumb in HSCTLR
+    mrc    p15, 4, r0, c1, c0, 0    @ HSCR
+    ldr    r2, =0x40003807
+    bic    r0, r0, r2
+    mcr    p15, 4, r0, c1, c0, 0    @ HSCR
+    isb
+
+    @ Invalidate old TLBs
+    mcr    p15, 4, r0, c8, c7, 0    @ TLBIALLH
+    isb
+    dsb    ish
+
+    @ Disable MMU, caches and Thumb in SCTLR
+    mrc    p15, 0, r0, c1, c0, 0   @ SCTLR
+    bic    r0, r0, r2
+    mcr    p15, 0, r0, c1, c0, 0
+
+    bx    r1
+
     .ltorg

     .globl __kvm_hyp_init_end
diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 01dcb0e..449e7dd 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -87,6 +87,18 @@ ENDPROC(__kvm_flush_vm_context)


 /********************************************************************
+ * Set HVBAR
+ *
+ * void __kvm_set_vectors(unsigned long phys_vector_base);
+ */
+ENTRY(__kvm_set_vectors)
+    mcr    p15, 4, r0, c12, c0, 0    @ set HVBAR
+    dsb    ish
+    isb
+    bx    lr
+ENDPROC(__kvm_set_vectors)
+
+/********************************************************************
  *  Hypervisor world-switch code
  *
  *
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 1366625..f853858 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -369,6 +369,11 @@ void free_boot_hyp_pgd(void)
     free_page((unsigned long)init_bounce_page);
     init_bounce_page = NULL;

+    /* avoid to reuse possibly invalid values if bounce page is freed */
+    hyp_idmap_start = 0;
+    hyp_idmap_end = 0;
+    hyp_idmap_vector = 0;
+
     mutex_unlock(&kvm_hyp_pgd_mutex);
 }


Frediano
