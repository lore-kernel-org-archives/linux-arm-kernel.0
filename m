From: will.deacon@arm.com (Will Deacon)
Date: Mon, 19 Nov 2012 14:51:00 +0000
Subject: [PATCH v4 05/14] KVM: ARM: Hypervisor inititalization
In-Reply-To: <20121110154245.2836.17259.stgit@chazy-air>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154245.2836.17259.stgit@chazy-air>
Message-ID: <20121119145100.GX3205@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Typo in subject, use one of initiali[sz]ation instead.

On Sat, Nov 10, 2012 at 03:42:45PM +0000, Christoffer Dall wrote:
> Sets up KVM code to handle all exceptions taken to Hyp mode.
> 
> When the kernel is booted in Hyp mode, calling "hvc #0xff" with r0 pointing to
> the new vectors, the HVBAR is changed to the the vector pointers.  This allows
> subsystems (like KVM here) to execute code in Hyp-mode with the MMU disabled.
> 
> We initialize other Hyp-mode registers and enables the MMU for Hyp-mode from
> the id-mapped hyp initialization code. Afterwards, the HVBAR is changed to
> point to KVM Hyp vectors used to catch guest faults and to switch to Hyp mode
> to perform a world-switch into a KVM guest.
> 
> If the KVM module is unloaded we call "hvc #0xff" once more to disable the MMU
> in Hyp mode again and install a vector handler to change the HVBAR for a
> subsequent reload of KVM or another hypervisor.

0xff might be a bit too simple. I notice Xen use 0xEA1, which is
probably less likely to conflict with anything else. We should probably
also put these numbers in the same header file so that any conflicts
become immediately apparent.

> 
> Also provides memory mapping code to map required code pages, data structures,
> and I/O regions  accessed in Hyp mode at the same virtual address as the host
> kernel virtual addresses, but which conforms to the architectural requirements
> for translations in Hyp mode. This interface is added in arch/arm/kvm/arm_mmu.c
> and comprises:
>  - create_hyp_mappings(from, to);
>  - create_hyp_io_mappings(from, to, phys_addr);
>  - free_hyp_pmds();
> 
> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

[...]

> diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
> index c196a22..f6e8f6f 100644
> --- a/arch/arm/include/asm/kvm_arm.h
> +++ b/arch/arm/include/asm/kvm_arm.h
> @@ -21,4 +21,111 @@
> 
>  #include <asm/types.h>
> 
> +/* Hyp Configuration Register (HCR) bits */
> +#define HCR_TGE                (1 << 27)
> +#define HCR_TVM                (1 << 26)
> +#define HCR_TTLB       (1 << 25)
> +#define HCR_TPU                (1 << 24)
> +#define HCR_TPC                (1 << 23)
> +#define HCR_TSW                (1 << 22)
> +#define HCR_TAC                (1 << 21)
> +#define HCR_TIDCP      (1 << 20)
> +#define HCR_TSC                (1 << 19)
> +#define HCR_TID3       (1 << 18)
> +#define HCR_TID2       (1 << 17)
> +#define HCR_TID1       (1 << 16)
> +#define HCR_TID0       (1 << 15)
> +#define HCR_TWE                (1 << 14)
> +#define HCR_TWI                (1 << 13)
> +#define HCR_DC         (1 << 12)
> +#define HCR_BSU                (3 << 10)
> +#define HCR_BSU_IS     (1 << 10)
> +#define HCR_FB         (1 << 9)
> +#define HCR_VA         (1 << 8)
> +#define HCR_VI         (1 << 7)
> +#define HCR_VF         (1 << 6)
> +#define HCR_AMO                (1 << 5)
> +#define HCR_IMO                (1 << 4)
> +#define HCR_FMO                (1 << 3)
> +#define HCR_PTW                (1 << 2)
> +#define HCR_SWIO       (1 << 1)
> +#define HCR_VM         1
> +
> +/*
> + * The bits we set in HCR:
> + * TAC:                Trap ACTLR
> + * TSC:                Trap SMC
> + * TSW:                Trap cache operations by set/way
> + * TWI:                Trap WFI
> + * TIDCP:      Trap L2CTLR/L2ECTLR
> + * BSU_IS:     Upgrade barriers to the inner shareable domain
> + * FB:         Force broadcast of all maintainance operations
> + * AMO:                Override CPSR.A and enable signaling with VA
> + * IMO:                Override CPSR.I and enable signaling with VI
> + * FMO:                Override CPSR.F and enable signaling with VF
> + * SWIO:       Turn set/way invalidates into set/way clean+invalidate
> + */
> +#define HCR_GUEST_MASK (HCR_TSC | HCR_TSW | HCR_TWI | HCR_VM | HCR_BSU_IS | \
> +                       HCR_FB | HCR_TAC | HCR_AMO | HCR_IMO | HCR_FMO | \
> +                       HCR_SWIO | HCR_TIDCP)
> +
> +/* Hyp System Control Register (HSCTLR) bits */
> +#define HSCTLR_TE      (1 << 30)
> +#define HSCTLR_EE      (1 << 25)
> +#define HSCTLR_FI      (1 << 21)
> +#define HSCTLR_WXN     (1 << 19)
> +#define HSCTLR_I       (1 << 12)
> +#define HSCTLR_C       (1 << 2)
> +#define HSCTLR_A       (1 << 1)
> +#define HSCTLR_M       1
> +#define HSCTLR_MASK    (HSCTLR_M | HSCTLR_A | HSCTLR_C | HSCTLR_I | \
> +                        HSCTLR_WXN | HSCTLR_FI | HSCTLR_EE | HSCTLR_TE)
> +
> +/* TTBCR and HTCR Registers bits */
> +#define TTBCR_EAE      (1 << 31)
> +#define TTBCR_IMP      (1 << 30)
> +#define TTBCR_SH1      (3 << 28)
> +#define TTBCR_ORGN1    (3 << 26)
> +#define TTBCR_IRGN1    (3 << 24)
> +#define TTBCR_EPD1     (1 << 23)
> +#define TTBCR_A1       (1 << 22)
> +#define TTBCR_T1SZ     (3 << 16)
> +#define TTBCR_SH0      (3 << 12)
> +#define TTBCR_ORGN0    (3 << 10)
> +#define TTBCR_IRGN0    (3 << 8)
> +#define TTBCR_EPD0     (1 << 7)
> +#define TTBCR_T0SZ     3
> +#define HTCR_MASK      (TTBCR_T0SZ | TTBCR_IRGN0 | TTBCR_ORGN0 | TTBCR_SH0)
> +
> +/* Hyp Debug Configuration Register bits */
> +#define HDCR_TDRA      (1 << 11)
> +#define HDCR_TDOSA     (1 << 10)
> +#define HDCR_TDA       (1 << 9)
> +#define HDCR_TDE       (1 << 8)
> +#define HDCR_HPME      (1 << 7)
> +#define HDCR_TPM       (1 << 6)
> +#define HDCR_TPMCR     (1 << 5)
> +#define HDCR_HPMN_MASK (0x1F)
> +
> +/* Virtualization Translation Control Register (VTCR) bits */
> +#define VTCR_SH0       (3 << 12)
> +#define VTCR_ORGN0     (3 << 10)
> +#define VTCR_IRGN0     (3 << 8)
> +#define VTCR_SL0       (3 << 6)
> +#define VTCR_S         (1 << 4)
> +#define VTCR_T0SZ      3
> +#define VTCR_MASK      (VTCR_SH0 | VTCR_ORGN0 | VTCR_IRGN0 | VTCR_SL0 | \
> +                        VTCR_S | VTCR_T0SZ | VTCR_MASK)
> +#define VTCR_HTCR_SH   (VTCR_SH0 | VTCR_ORGN0 | VTCR_IRGN0)
> +#define VTCR_SL_L2     0               /* Starting-level: 2 */
> +#define VTCR_SL_L1     (1 << 6)        /* Starting-level: 1 */
> +#define VTCR_GUEST_SL  VTCR_SL_L1
> +#define VTCR_GUEST_T0SZ        0
> +#if VTCR_GUEST_SL == 0
> +#define VTTBR_X                (14 - VTCR_GUEST_T0SZ)
> +#else
> +#define VTTBR_X                (5 - VTCR_GUEST_T0SZ)
> +#endif

I'm fine with putting this here for now, but we need to keep an eye out
for any future hyp-related code which can re-use these architectural
definitions.

> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
> new file mode 100644
> index 0000000..741ab8f
> --- /dev/null
> +++ b/arch/arm/include/asm/kvm_mmu.h
> @@ -0,0 +1,39 @@
> +/*
> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License, version 2, as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
> + */
> +
> +#ifndef __ARM_KVM_MMU_H__
> +#define __ARM_KVM_MMU_H__
> +
> +/*
> + * The architecture supports 40-bit IPA as input to the 2nd stage translations
> + * and PTRS_PER_PGD2 could therefore be 1024.
> + *
> + * To save a bit of memory and to avoid alignment issues we assume 39-bit IPA
> + * for now, but remember that the level-1 table must be aligned to its size.
> + */
> +#define PTRS_PER_PGD2  512
> +#define PGD2_ORDER     get_order(PTRS_PER_PGD2 * sizeof(pgd_t))

Can you follow the _S2_ style you used in the pgtable headers please?

> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
> index ead5a4e..8e1ea2b 100644
> --- a/arch/arm/kvm/arm.c
> +++ b/arch/arm/kvm/arm.c
> @@ -34,11 +34,21 @@
>  #include <asm/ptrace.h>
>  #include <asm/mman.h>
>  #include <asm/cputype.h>
> +#include <asm/tlbflush.h>
> +#include <asm/virt.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_asm.h>
> +#include <asm/kvm_mmu.h>
> 
>  #ifdef REQUIRES_VIRT
>  __asm__(".arch_extension       virt");
>  #endif
> 
> +static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
> +static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
> +static unsigned long hyp_default_vectors;
> +
> +
>  int kvm_arch_hardware_enable(void *garbage)
>  {
>         return 0;
> @@ -324,9 +334,171 @@ long kvm_arch_vm_ioctl(struct file *filp,
>         return -EINVAL;
>  }
> 
> +static void cpu_init_hyp_mode(void *vector)
> +{
> +       unsigned long pgd_ptr;
> +       unsigned long hyp_stack_ptr;
> +       unsigned long stack_page;
> +       unsigned long vector_ptr;
> +
> +       /* Switch from the HYP stub to our own HYP init vector */
> +       __hyp_set_vectors((unsigned long)vector);
> +
> +       pgd_ptr = kvm_mmu_get_httbr();
> +       stack_page = __get_cpu_var(kvm_arm_hyp_stack_page);
> +       hyp_stack_ptr = stack_page + PAGE_SIZE;
> +       vector_ptr = (unsigned long)__kvm_hyp_vector;
> +
> +       /*
> +        * Call initialization code, and switch to the full blown
> +        * HYP code. The init code corrupts r12, so set the clobber
> +        * list accordingly.
> +        */
> +       asm volatile (
> +               "mov    r0, %[pgd_ptr]\n\t"
> +               "mov    r1, %[hyp_stack_ptr]\n\t"
> +               "mov    r2, %[vector_ptr]\n\t"
> +               "hvc    #0\n\t" : :
> +               [pgd_ptr] "r" (pgd_ptr),
> +               [hyp_stack_ptr] "r" (hyp_stack_ptr),
> +               [vector_ptr] "r" (vector_ptr) :
> +               "r0", "r1", "r2", "r12");

This looks similar to the Xen PCS (at least, register-compatible). Could
we have a separate function for issuing a hvc call which is shared
between the two?

> +}
> +
> +/**
> + * Inits Hyp-mode on all online CPUs
> + */
> +static int init_hyp_mode(void)
> +{
> +       phys_addr_t init_phys_addr;
> +       int cpu;
> +       int err = 0;
> +
> +       /*
> +        * Allocate Hyp PGD and setup Hyp identity mapping
> +        */
> +       err = kvm_mmu_init();
> +       if (err)
> +               return err;
> +
> +       /*
> +        * It is probably enough to obtain the default on one
> +        * CPU. It's unlikely to be different on the others.
> +        */
> +       hyp_default_vectors = __hyp_get_vectors();
> +
> +       /*
> +        * Allocate stack pages for Hypervisor-mode
> +        */
> +       for_each_possible_cpu(cpu) {
> +               unsigned long stack_page;
> +
> +               stack_page = __get_free_page(GFP_KERNEL);
> +               if (!stack_page) {
> +                       err = -ENOMEM;
> +                       goto out_free_stack_pages;
> +               }
> +
> +               per_cpu(kvm_arm_hyp_stack_page, cpu) = stack_page;
> +       }
> +
> +       /*
> +        * Execute the init code on each CPU.
> +        *
> +        * Note: The stack is not mapped yet, so don't do anything else than
> +        * initializing the hypervisor mode on each CPU using a local stack
> +        * space for temporary storage.
> +        */
> +       init_phys_addr = virt_to_phys(__kvm_hyp_init);
> +       for_each_online_cpu(cpu) {
> +               smp_call_function_single(cpu, cpu_init_hyp_mode,
> +                                        (void *)(long)init_phys_addr, 1);
> +       }

Hmm, this will probably go wrong for platforms like keystone, where
everything is above 4GB in physical memory. Actually, I'm not sure on
the status of the patches so you could check with Cyril [CC'd].

> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
> index 1dc8926..3e0690b 100644
> --- a/arch/arm/kvm/init.S
> +++ b/arch/arm/kvm/init.S
> @@ -15,5 +15,112 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>   */
> +
> +#include <linux/linkage.h>
> +#include <asm/unified.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/kvm_asm.h>
> +#include <asm/kvm_arm.h>
> +
> +/********************************************************************
> + * Hypervisor initialization
> + *   - should be called with:
> + *       r0 = Hypervisor pgd pointer
> + *       r1 = top of Hyp stack (kernel VA)
> + *       r2 = pointer to hyp vectors
> + */
> +
> +       .text
> +       .pushsection    .hyp.idmap.text,"ax"
> +       .align 12
> +__kvm_hyp_init:
> +       .globl __kvm_hyp_init
> +
> +       @ Hyp-mode exception vector
> +       W(b)    .
> +       W(b)    .
> +       W(b)    .
> +       W(b)    .
> +       W(b)    .
> +       W(b)    __do_hyp_init
> +       W(b)    .
> +       W(b)    .
> +
> +__do_hyp_init:
> +       @ Set the sp to end of this page and push data for later use
> +ARM(   add     r12, pc, #(__kvm_init_sp - .)   )
> +ARM(   sub     r12, r12, #8                    )
> +THUMB( adr     r12, __kvm_init_sp              )
> +       mov     sp, r12
> +       push    {r1, r2}
> +
> +       @ Set the HTTBR to point to the hypervisor PGD pointer passed to
> +       @ function and set the upper bits equal to the kernel PGD.
> +       mrrc    p15, 1, r1, r2, c2
> +       mcrr    p15, 4, r0, r2, c2
> +
> +       @ Set the HTCR and VTCR to the same shareability and cacheability
> +       @ settings as the non-secure TTBCR and with T0SZ == 0.
> +       mrc     p15, 4, r0, c2, c0, 2   @ HTCR
> +       ldr     r12, =HTCR_MASK
> +       bic     r0, r0, r12
> +       mrc     p15, 0, r1, c2, c0, 2   @ TTBCR
> +       and     r1, r1, #(HTCR_MASK & ~TTBCR_T0SZ)
> +       orr     r0, r0, r1
> +       mcr     p15, 4, r0, c2, c0, 2   @ HTCR
> +
> +       mrc     p15, 4, r1, c2, c1, 2   @ VTCR
> +       bic     r1, r1, #(VTCR_HTCR_SH | VTCR_SL0)
> +       bic     r0, r0, #(~VTCR_HTCR_SH)
> +       orr     r1, r0, r1
> +       orr     r1, r1, #(VTCR_SL_L1 | VTCR_GUEST_T0SZ)
> +       mcr     p15, 4, r1, c2, c1, 2   @ VTCR
> +
> +       @ Use the same memory attributes for hyp. accesses as the kernel
> +       @ (copy MAIRx ro HMAIRx).
> +       mrc     p15, 0, r0, c10, c2, 0
> +       mcr     p15, 4, r0, c10, c2, 0
> +       mrc     p15, 0, r0, c10, c2, 1
> +       mcr     p15, 4, r0, c10, c2, 1
> +
> +       @ Set the HSCTLR to:
> +       @  - ARM/THUMB exceptions: Kernel config (Thumb-2 kernel)
> +       @  - Endianness: Kernel config
> +       @  - Fast Interrupt Features: Kernel config
> +       @  - Write permission implies XN: disabled
> +       @  - Instruction cache: enabled
> +       @  - Data/Unified cache: enabled
> +       @  - Memory alignment checks: enabled
> +       @  - MMU: enabled (this code must be run from an identity mapping)
> +       mrc     p15, 4, r0, c1, c0, 0   @ HSCR
> +       ldr     r12, =HSCTLR_MASK
> +       bic     r0, r0, r12
> +       mrc     p15, 0, r1, c1, c0, 0   @ SCTLR
> +       ldr     r12, =(HSCTLR_EE | HSCTLR_FI)
> +       and     r1, r1, r12
> + ARM(  ldr     r12, =(HSCTLR_M | HSCTLR_A | HSCTLR_I)                  )
> + THUMB(        ldr     r12, =(HSCTLR_M | HSCTLR_A | HSCTLR_I | HSCTLR_TE)      )
> +       orr     r1, r1, r12
> +       orr     r0, r0, r1
> +       isb
> +       mcr     p15, 4, r0, c1, c0, 0   @ HSCR
> +       isb
> +
> +       @ Set stack pointer and return to the kernel
> +       pop     {r1, r2}
> +       mov     sp, r1
> +
> +       @ Set HVBAR to point to the HYP vectors
> +       mcr     p15, 4, r2, c12, c0, 0  @ HVBAR
> +
> +       eret
> +
> +       .ltorg
> +
> +       .align 12

Do you *have* to page-align the start and end of this small piece of
code? What goes wrong if you end up including random other stuff in the
hyp pgd?

> +
> +       __kvm_init_sp:
> +       .globl __kvm_hyp_init_end
> +__kvm_hyp_init_end:
> +
> +       .popsection
> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
> index 1dc8926..98a67ca 100644
> --- a/arch/arm/kvm/interrupts.S
> +++ b/arch/arm/kvm/interrupts.S
> @@ -15,5 +15,53 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>   */
> +
> +#include <linux/linkage.h>
> +#include <linux/const.h>
> +#include <asm/unified.h>
> +#include <asm/page.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/kvm_asm.h>
> +#include <asm/kvm_arm.h>
> +
> +       .text
> +       .align  PAGE_SHIFT

I guess you could also use PAGE_SHIFT in the previous file if you do
have to keep the align directives. Why do you need the alignment here?

> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index 10ed464..17c2bf5 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -15,3 +15,213 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>   */
> +
> +#include <linux/mman.h>
> +#include <linux/kvm_host.h>
> +#include <linux/io.h>
> +#include <asm/idmap.h>
> +#include <asm/pgalloc.h>
> +#include <asm/kvm_arm.h>
> +#include <asm/kvm_mmu.h>
> +#include <asm/mach/map.h>
> +
> +static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
> +static pgd_t *hyp_pgd;
> +
> +static void free_ptes(pmd_t *pmd, unsigned long addr)
> +{
> +       pte_t *pte;
> +       unsigned int i;
> +
> +       for (i = 0; i < PTRS_PER_PMD; i++, addr += PMD_SIZE) {
> +               if (!pmd_none(*pmd) && pmd_table(*pmd)) {
> +                       pte = pte_offset_kernel(pmd, addr);
> +                       pte_free_kernel(NULL, pte);
> +               }
> +               pmd++;
> +       }
> +}
> +
> +/**
> + * free_hyp_pmds - free a Hyp-mode level-2 tables and child level-3 tables
> + *
> + * Assumes this is a page table used strictly in Hyp-mode and therefore contains
> + * only mappings in the kernel memory area, which is above PAGE_OFFSET.
> + */
> +void free_hyp_pmds(void)
> +{
> +       pgd_t *pgd;
> +       pud_t *pud;
> +       pmd_t *pmd;
> +       unsigned long addr;
> +
> +       mutex_lock(&kvm_hyp_pgd_mutex);
> +       for (addr = PAGE_OFFSET; addr != 0; addr += PGDIR_SIZE) {
> +               pgd = hyp_pgd + pgd_index(addr);
> +               pud = pud_offset(pgd, addr);
> +
> +               if (pud_none(*pud))
> +                       continue;
> +               BUG_ON(pud_bad(*pud));
> +
> +               pmd = pmd_offset(pud, addr);
> +               free_ptes(pmd, addr);
> +               pmd_free(NULL, pmd);
> +               pud_clear(pud);
> +       }
> +       mutex_unlock(&kvm_hyp_pgd_mutex);
> +}
> +
> +/*
> + * Create a HYP pte mapping.
> + *
> + * If pfn_base is NULL, we map kernel pages into HYP with the virtual
> + * address. Otherwise, this is considered an I/O mapping and we map
> + * the physical region starting at *pfn_base to [start, end[.
> + */

Seems fairly counter-intuitive to me. Why can't you have two separate
functions?

> diff --git a/mm/memory.c b/mm/memory.c
> index fb135ba..5ae0164 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -383,12 +383,14 @@ void pgd_clear_bad(pgd_t *pgd)
>         pgd_ERROR(*pgd);
>         pgd_clear(pgd);
>  }
> +EXPORT_SYMBOL_GPL(pgd_clear_bad);
> 
>  void pud_clear_bad(pud_t *pud)
>  {
>         pud_ERROR(*pud);
>         pud_clear(pud);
>  }
> +EXPORT_SYMBOL_GPL(pud_clear_bad);

Do we really need these? If so, they should be a separate patch which needs
sending to linux-mm with akpm on CC.

Will
