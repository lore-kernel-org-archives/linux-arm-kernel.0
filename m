From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 08 Nov 2010 17:13:38 +0000
Subject: Using non-Global mappings for kernel address space
In-Reply-To: <AANLkTi=f+s4GAKLSESK=WSjxmUDCCvog21z1XxW73nU3@mail.gmail.com>
References: <AANLkTi=f+s4GAKLSESK=WSjxmUDCCvog21z1XxW73nU3@mail.gmail.com>
Message-ID: <1289236418.3541.117.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2010-11-01 at 14:23 +0000, Christoffer Dall wrote:
> For the purpose of performance evaluation of our KVM for ARM port, I
> am interested in avoiding having to flush the TLB every time I switch
> from the guest kernel to the host kernel and vice-versa. 

I'm not familiar with the KVM implementation for ARMv6(so it has been on
my list to look at for some time). Does the guest OS use a full 4GB
virtual address space? Does it only run in user mode or both
user/kernel?

Do you target SMP? That may get even trickier with the ASIDs because of
the roll-over event being broadcast via IPI.

> The only way
> to accomplish this on ARMv6 would be to have non-Global mappings of
> the host kernel address space using a separate ASID from that of the
> guest kernel.
> 
> My general approach is outlined as follows:
>  - Mark all pages and sections (except interrupt vector page) with
> addr > TASK_SIZE as non-global
>  - Set a special kernel reserved ASID at the same time of
> paging_init()

Why do you need a different ASID for the kernel? Can you not use the
same ASID for both user and kernel (while in the same context) and avoid
switching the ASID when entering/exiting the kernel? This way you could
even move the switch_mm() function to the vectors page (global), though
it may not be a problem.

As I said, this may not apply as I'm not familiar with the ARM KVM
implementation.

>  - Defer setting the CP15 context id register until return from kernel
> to userspace in ret_fast_syscall and ret_slow_syscall (ret_to_user)
>  - Set the kernel reserved ASID as part of the vector_stub (and add a
> little vector_stub code for the SWI handler for this purpose)
>  - Modify the tlbflush.h functions so they  invalidate the requested
> parts of the TLB matching the changes above. (Actually for testing
> purposes, make all functions invalidate the entire TLB).

There is local_flush_tlb_mm() that uses the ASID as well.

> The problem is that with the above changes, the kernel seems to boot
> just fine, but when it starts running user space processes, the system
> eventually crashes with the messages:

I think there is fundamental problem with your approach. Basically the
kernel always runs with ASID 0 no matter which thread is the active one.
If it gets a TLB entry for a user page (either because of explicit
get_user etc. or just speculative access), the TLB will have ASID 0
associated with a user space address. When you switch tasks, even if
user space has a new ASID, the kernel would still use ASID 0 when
accessing the new user space address. If it hits a previously loaded
TLB, that would have the wrong translation.

So the kernel must use the same ASID as the user space application, or
at least have a different one for each application rather than the
common 0 value.

In Linux we use ASID 0 but only for brief periods of time when switching
the context or at roll-over but there is no active user space access
with ASID 0.

Some more comments on the patch below:
 
> --- a/arch/arm/kernel/entry-armv.S
> +++ b/arch/arm/kernel/entry-armv.S
> @@ -998,6 +998,12 @@ vector_\name:
>         mrs     lr, spsr
>         str     lr, [sp, #8]            @ save spsr
>  
> +       @ 
> +       @ Set kernel reserved ASID
> +       @
> +       mov     r0, #0
> +       mcr     p15, 0, r0, c13, c0, 1

You probably need an ISB after this (at least on ARMv7, not sure whether
it would work without on ARMv6).

> @@ -1147,6 +1153,12 @@ vector_addrexcptn:
>   * for CPUs with separate I & D caches.
>   */
>         .align  5
> +__pre_branch_swi_vector:
> +       sub     sp, sp, #S_FRAME_SIZE
> +       stmia   sp, {r0 - r12}                  @ Calling r0 - r12
> +       mov     r8, #0
> +       mcr     p15, 0, r8, c13, c0, 1
> +       ldr     pc, __branch_swi_vector

ISB after the ASID setting?

> diff --git a/arch/arm/kernel/entry-common.S b/arch/arm/kernel/entry-common.S
> index 159d041..2a5472b 100644
> --- a/arch/arm/kernel/entry-common.S
> +++ b/arch/arm/kernel/entry-common.S
> @@ -14,6 +14,12 @@
>  
>  #include "entry-header.S"
>  
> +.macro set_context_id reg
> +       ldr     \reg, [tsk, #TSK_ACTIVE_MM]
> +       cmp     \reg, #0
> +       ldrne   \reg, [\reg, #MM_CONTEXT_ID]
> +       mcrne   p15, 0, \reg, c13, c0, 1
> +.endm

ISB.

> --- a/arch/arm/mm/context.c
> +++ b/arch/arm/mm/context.c
> @@ -31,7 +31,6 @@ void __init_new_context(struct task_struct *tsk, struct mm_struct *mm)
>  static void flush_context(void)
>  {
>         /* set the reserved ASID before flushing the TLB */
> -       asm("mcr        p15, 0, %0, c13, c0, 1\n" : : "r" (0));
>         isb();
>         local_flush_tlb_all();
>         if (icache_is_vivt_asid_tagged()) {
> @@ -122,10 +121,6 @@ unsigned int __new_asid(void)
>          */
>         if (unlikely((asid & ~ASID_MASK) == 0)) {
>                 asid = ++cpu_last_asid;
> -               /* set the reserved ASID before flushing the TLB */
> -               asm("mcr        p15, 0, %0, c13, c0, 1  @ set reserved context ID\n"
> -                   :
> -                   : "r" (0));
>                 isb();
>                 flush_tlb_all();
>                 if (icache_is_vivt_asid_tagged()) {

How do you handle the ASID roll-over since you removed this?

> +void __init kernel_asid_init(void)
> +{
> +       /* Set the kernel reserved ASID (= 0) */
> +       asm("mcr        p15, 0, %0, c13, c0, 1  @ set reserved context ID\n"
> +           :
> +           : "r" (0));

isb();

BTW, Cortex-A15 has full hardware virtualisation available, so this way
you could avoid many of the above problems.

Catalin
