From: achandran@mvista.com (Arun Chandran)
Date: Mon, 25 Aug 2014 19:44:57 +0530
Subject: [PATCH] Arm64: convert soft_restart() to assembly code
In-Reply-To: <20140818160253.GB3302@leverpostej>
References: <1407847365-10873-1-git-send-email-achandran@mvista.com>
 <1408123221.22761.38.camel@smoke>
 <20140815182157.GD21908@leverpostej>
 <1408128799.22761.47.camel@smoke>
 <20140818160253.GB3302@leverpostej>
Message-ID: <CAFdej005x5rYpP+1PM2fDktmEKAO-me4+btYc37UxQxKUPMXoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 18, 2014 at 9:32 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi Geoff,
>
> On Fri, Aug 15, 2014 at 07:53:19PM +0100, Geoff Levand wrote:
>> Hi Mark,
>>
>> On Fri, 2014-08-15 at 19:21 +0100, Mark Rutland wrote:
>> > On Fri, Aug 15, 2014 at 06:20:21PM +0100, Geoff Levand wrote:
>> > > For the cpu-ops shutdown I'm working on I need a call to move the
>> > > secondary processors to an identity mapped spin loop after the identity
>> > > map is enabled.  I want to do this in C code, so it needs to happen
>> > > after the identity map is enabled, and before the dcache is disabled.
>> > >
>> > > I think to do this we can keep the existing soft_restart(addr) routine
>> > > with something like this:
>> > >
>> > > void soft_restart(unsigned long addr)
>> > > {
>> > >   setup_mm_for_reboot();
>> > >
>> > > #if defined(CONFIG_SMP)
>> > >   smp_secondary_shutdown();
>> > > #endif
>> > >
>> > >   cpu_soft_restart(addr);
>> > >
>> > >   /* Should never get here */
>> > >   BUG();
>> > > }
>> > >
>> >
>> > I don't follow why you need a hook in the middle of soft_restart. That
>> > sounds like a layering violation to me.
>> >
>> > I assume this is for implementing the spin-table cpu-return-addr idea?
>>
>> Yes.
>>
>> > If so, what's wrong with something like:
>>
>> > void spin_table_cpu_die(unsigned int cpu)
>> > {
>> >     unsigned long release_addr = per_cpu(return_addr, cpu);
>> >
>> >     /*
>> >      * We should have a local_disable(DBG|ASYNC|FIQ|IRQ) function or
>> >      * something similar as these are all context synchronising and
>> >      * therefore expensive.
>> >      */
>> >     local_dbg_disable();
>> >     local_async_disable();
>> >     local_fiq_disable();
>> >     arch_local_irq_disable();
>> >
>> >     soft_restart(release_addr);
>> > }
>>
>> OK, this is a much simpler way than what I was thinking, which
>> was to have the secondaries spin in the kernel until the main
>> cpu shutdown.  I'll switch over to this, thanks.
>
> I just realised that this is still missing the jump to EL2 that I
> mentioned a while back.
>
> I think what we need to do is:
>
> * Have KVM (if present) tears itself down prior to cpu_die, restoring
>   the __hyp_stub_vectors in VBAR_EL2 and disabling the MMU, and caches.
>
> * Add a mechanism to __hyp_stub_vectors to allow a hypercall to
>   call a function at EL2. We should be able to replace the current
>   hyp_stub el1_sync handler with that, and rework KVM to call a function
>   at EL2 to setup VBAR_EL2 appropriately at init time.
>
> * Depending on whether EL2 is available, go via soft_restart or the
>   hypercall to cpu_soft_restart (or something very close to it).
>
> How does that sound?

Hi Mark,

Please Ignore my previous mail. I think this version of sample
implementation is simple and better. Please give your comments.

###########
diff --git a/arch/arm64/include/asm/proc-fns.h
b/arch/arm64/include/asm/proc-fns.h
index ddbc3f5..40d3360 100644
--- a/arch/arm64/include/asm/proc-fns.h
+++ b/arch/arm64/include/asm/proc-fns.h
@@ -31,7 +31,7 @@ struct cpu_suspend_ctx;
 extern void cpu_cache_off(void);
 extern void cpu_do_idle(void);
 extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
-extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
+extern void cpu_reset(unsigned long addr, unsigned long boot_mode)
__attribute__((noreturn));
 extern void cpu_soft_restart(phys_addr_t cpu_reset, unsigned long
addr) __attribute__((noreturn));
 extern void cpu_do_suspend(struct cpu_suspend_ctx *ptr);
 extern u64 cpu_do_resume(phys_addr_t ptr, u64 idmap_ttbr);
diff --git a/arch/arm64/include/asm/virt.h b/arch/arm64/include/asm/virt.h
index 215ad46..3976737 100644
--- a/arch/arm64/include/asm/virt.h
+++ b/arch/arm64/include/asm/virt.h
@@ -34,6 +34,7 @@
  */
 extern u32 __boot_cpu_mode[2];

+void __hyp_func_call(phys_addr_t func, ...);
 void __hyp_set_vectors(phys_addr_t phys_vector_base);
 phys_addr_t __hyp_get_vectors(void);

diff --git a/arch/arm64/kernel/hyp-stub.S b/arch/arm64/kernel/hyp-stub.S
index a272f33..82c2b0d 100644
--- a/arch/arm64/kernel/hyp-stub.S
+++ b/arch/arm64/kernel/hyp-stub.S
@@ -53,14 +53,12 @@ ENDPROC(__hyp_stub_vectors)
        .align 11

 el1_sync:
-       mrs     x1, esr_el2
-       lsr     x1, x1, #26
-       cmp     x1, #0x16
+       mrs     x19, esr_el2
+       lsr     x19, x19, #26
+       cmp     x19, #0x16
        b.ne    2f                              // Not an HVC trap
-       cbz     x0, 1f
-       msr     vbar_el2, x0                    // Set vbar_el2
-       b       2f
-1:     mrs     x0, vbar_el2                    // Return vbar_el2
+
+1:     blr     x0                              // Jump to the function
 2:     eret
 ENDPROC(el1_sync)

@@ -101,10 +99,17 @@ ENDPROC(\label)
  */

 ENTRY(__hyp_get_vectors)
-       mov     x0, xzr
-       // fall through
-ENTRY(__hyp_set_vectors)
-       hvc     #0
+       mrs     x0, vbar_el2                    // Return vbar_el2
        ret
 ENDPROC(__hyp_get_vectors)
+
+ENTRY(__hyp_set_vectors)
+       msr     vbar_el2, x1
+       ret
 ENDPROC(__hyp_set_vectors)
+
+/* Call a function @x0 */
+ENTRY(__hyp_func_call)
+       hvc     #0
+       ret
+ENDPROC(__hyp_func_call)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 3cb6dec..e68f42e 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -25,6 +25,7 @@
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
+#include <asm/virt.h>

 #include "proc-macros.S"

@@ -69,19 +70,26 @@ ENDPROC(cpu_cache_off)
  */
        .align  5
 ENTRY(cpu_reset)
-       mrs     x1, sctlr_el1
-       bic     x1, x1, #1
-       msr     sctlr_el1, x1                   // disable the MMU
+       mrs     x2, sctlr_el1
+       bic     x2, x2, #1
+       msr     sctlr_el1, x2                   // disable the MMU
        isb
 #if defined(CONFIG_SMP)
 /*     bl      secondary_shutdown */
 #endif
+       sub     w1, w1, #BOOT_CPU_MODE_EL2
+       cbz     w1, __hyp_func_call
        ret     x0
 ENDPROC(cpu_reset)

 ENTRY(cpu_soft_restart)
+       ldr     x3, =__boot_cpu_mode
+       add     x3, x3, #4
+       ldr     w2, [x3]
+
        mov     x19, x0
        mov     x20, x1
+       mov     w21, w2

        /* Turn D-cache off */
        bl      cpu_cache_off
@@ -89,6 +97,7 @@ ENTRY(cpu_soft_restart)
        bl      flush_cache_all

        mov     x0, x20
+       mov     w1, w21
        ret     x19
 ENDPROC(cpu_soft_restart)
#########

I have implemented __hyp_func_call; other userscan
make use of it to call __hyp_set_vectors/__hyp_get_vectors

--Arun
