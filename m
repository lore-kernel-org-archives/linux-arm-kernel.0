From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 18 Nov 2017 15:25:06 +0000
Subject: [PATCH 00/18] arm64: Unmap the kernel whilst running in userspace
 (KAISER)
In-Reply-To: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
References: <1510942921-12564-1-git-send-email-will.deacon@arm.com>
Message-ID: <CAKv+Gu8YB_qXgWEbd0ZZ6UycxNLXxTZCno87vJ9HH7d6+dKeLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 November 2017 at 18:21, Will Deacon <will.deacon@arm.com> wrote:
> Hi all,
>
> This patch series implements something along the lines of KAISER for arm64:
>
>   https://gruss.cc/files/kaiser.pdf
>
> although I wrote this from scratch because the paper has some funny
> assumptions about how the architecture works. There is a patch series
> in review for x86, which follows a similar approach:
>
>   http://lkml.kernel.org/r/<20171110193058.BECA7D88@viggo.jf.intel.com>
>
> and the topic was recently covered by LWN (currently subscriber-only):
>
>   https://lwn.net/Articles/738975/
>
> The basic idea is that transitions to and from userspace are proxied
> through a trampoline page which is mapped into a separate page table and
> can switch the full kernel mapping in and out on exception entry and
> exit respectively. This is a valuable defence against various KASLR and
> timing attacks, particularly as the trampoline page is at a fixed virtual
> address and therefore the kernel text can be randomized independently.
>
> The major consequences of the trampoline are:
>
>   * We can no longer make use of global mappings for kernel space, so
>     each task is assigned two ASIDs: one for user mappings and one for
>     kernel mappings
>
>   * Our ASID moves into TTBR1 so that we can quickly switch between the
>     trampoline and kernel page tables
>
>   * Switching TTBR0 always requires use of the zero page, so we can
>     dispense with some of our errata workaround code.
>
>   * entry.S gets more complicated to read
>
> The performance hit from this series isn't as bad as I feared: things
> like cyclictest and kernbench seem to be largely unaffected, although
> syscall micro-benchmarks appear to show that syscall overhead is roughly
> doubled, and this has an impact on things like hackbench which exhibits
> a ~10% hit due to its heavy context-switching.
>
> Patches based on 4.14 and also pushed here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git kaiser
>
> Feedback welcome,
>
> Will
>

Very nice! I am quite pleased, because this makes KASLR much more
useful than it is now.

My main question is why we need a separate trampoline vector table: it
seems to me that with some minor surgery (as proposed below), we can
make the kernel_ventry macro instantiations tolerant for being loaded
somewhere in the fixmap (which I think is a better place for this than
at the base of the VMALLOC space), removing the need to change
vbar_el1 back and forth. The only downside is that exceptions taken
from EL1 will also use absolute addressing, but I don't think that is
a huge price to pay.

-------------->8------------------
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index f8ce4cdd3bb5..7f89ebc690b1 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -71,6 +71,20 @@

  .macro kernel_ventry, el, label, regsize = 64
  .align 7
+alternative_if_not ARM64_MAP_KERNEL_AT_EL0
+ .if \regsize == 64
+ msr tpidrro_el0, x30 // preserve x30
+ .endif
+ .if \el == 0
+ mrs x30, ttbr1_el1
+ sub x30, x30, #(SWAPPER_DIR_SIZE + RESERVED_TTBR0_SIZE)
+ bic x30, x30, #USER_ASID_FLAG
+ msr ttbr1_el1, x30
+ isb
+ .endif
+ ldr x30, =el\()\el\()_\label
+alternative_else_nop_endif
+
  sub sp, sp, #S_FRAME_SIZE
 #ifdef CONFIG_VMAP_STACK
  /*
@@ -82,7 +96,11 @@
  tbnz x0, #THREAD_SHIFT, 0f
  sub x0, sp, x0 // x0'' = sp' - x0' = (sp + x0) - sp = x0
  sub sp, sp, x0 // sp'' = sp' - x0 = (sp + x0) - x0 = sp
+alternative_if_not ARM64_MAP_KERNEL_AT_EL0
+ br x30
+alternative_else
  b el\()\el\()_\label
+alternative_endif

 0:
  /*
@@ -91,6 +109,10 @@
  * userspace, and can clobber EL0 registers to free up GPRs.
  */

+alternative_if_not ARM64_MAP_KERNEL_AT_EL0
+ mrs x30, tpidrro_el0 // restore x30
+alternative_else_nop_endif
+
  /* Stash the original SP (minus S_FRAME_SIZE) in tpidr_el0. */
  msr tpidr_el0, x0

@@ -98,8 +120,11 @@
  sub x0, sp, x0
  msr tpidrro_el0, x0

- /* Switch to the overflow stack */
- adr_this_cpu sp, overflow_stack + OVERFLOW_STACK_SIZE, x0
+ /* Switch to the overflow stack of this CPU */
+ ldr x0, =overflow_stack + OVERFLOW_STACK_SIZE
+ mov sp, x0
+ mrs x0, tpidr_el1
+ add sp, sp, x0

  /*
  * Check whether we were already on the overflow stack. This may happen
@@ -108,19 +133,30 @@
  mrs x0, tpidr_el0 // sp of interrupted context
  sub x0, sp, x0 // delta with top of overflow stack
  tst x0, #~(OVERFLOW_STACK_SIZE - 1) // within range?
- b.ne __bad_stack // no? -> bad stack pointer
+ b.eq 1f
+ ldr x0, =__bad_stack // no? -> bad stack pointer
+ br x0

  /* We were already on the overflow stack. Restore sp/x0 and carry on. */
- sub sp, sp, x0
+1: sub sp, sp, x0
  mrs x0, tpidrro_el0
 #endif
+alternative_if_not ARM64_MAP_KERNEL_AT_EL0
+ br x30
+alternative_else
  b el\()\el\()_\label
+alternative_endif
  .endm

- .macro kernel_entry, el, regsize = 64
+ .macro kernel_entry, el, regsize = 64, restore_x30 = 1
  .if \regsize == 32
  mov w0, w0 // zero upper 32 bits of x0
  .endif
+ .if \restore_x30
+alternative_if_not ARM64_MAP_KERNEL_AT_EL0
+ mrs x30, tpidrro_el0 // restore x30
+alternative_else_nop_endif
+ .endif
  stp x0, x1, [sp, #16 * 0]
  stp x2, x3, [sp, #16 * 1]
  stp x4, x5, [sp, #16 * 2]
@@ -363,7 +399,7 @@ tsk .req x28 // current thread_info
  */
  .pushsection ".entry.text", "ax"

- .align 11
+ .align PAGE_SHIFT
 ENTRY(vectors)
  kernel_ventry 1, sync_invalid // Synchronous EL1t
  kernel_ventry 1, irq_invalid // IRQ EL1t
@@ -391,6 +427,8 @@ ENTRY(vectors)
  kernel_ventry 0, fiq_invalid, 32 // FIQ 32-bit EL0
  kernel_ventry 0, error_invalid, 32 // Error 32-bit EL0
 #endif
+ .ltorg
+ .align PAGE_SHIFT
 END(vectors)

 #ifdef CONFIG_VMAP_STACK
@@ -408,7 +446,7 @@ __bad_stack:
  * S_FRAME_SIZE) was stashed in tpidr_el0 by kernel_ventry.
  */
  sub sp, sp, #S_FRAME_SIZE
- kernel_entry 1
+ kernel_entry 1, restore_x30=0
  mrs x0, tpidr_el0
  add x0, x0, #S_FRAME_SIZE
  str x0, [sp, #S_SP]
