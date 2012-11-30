From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Fri, 30 Nov 2012 00:41:22 -0500
Subject: [PATCH v4 05/14] KVM: ARM: Hypervisor inititalization
In-Reply-To: <20121119145100.GX3205@mudshark.cambridge.arm.com>
References: <20121110154203.2836.46686.stgit@chazy-air>
 <20121110154245.2836.17259.stgit@chazy-air>
 <20121119145100.GX3205@mudshark.cambridge.arm.com>
Message-ID: <CANM98qJ-rQvAK7LCiC1rrHere3pVBhHe0yoBgvy_J85UA-75gg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 9:51 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> Typo in subject, use one of initiali[sz]ation instead.
>
> On Sat, Nov 10, 2012 at 03:42:45PM +0000, Christoffer Dall wrote:
>> Sets up KVM code to handle all exceptions taken to Hyp mode.
>>
>> When the kernel is booted in Hyp mode, calling "hvc #0xff" with r0 pointing to
>> the new vectors, the HVBAR is changed to the the vector pointers.  This allows
>> subsystems (like KVM here) to execute code in Hyp-mode with the MMU disabled.
>>
>> We initialize other Hyp-mode registers and enables the MMU for Hyp-mode from
>> the id-mapped hyp initialization code. Afterwards, the HVBAR is changed to
>> point to KVM Hyp vectors used to catch guest faults and to switch to Hyp mode
>> to perform a world-switch into a KVM guest.
>>
>> If the KVM module is unloaded we call "hvc #0xff" once more to disable the MMU
>> in Hyp mode again and install a vector handler to change the HVBAR for a
>> subsequent reload of KVM or another hypervisor.
>
> 0xff might be a bit too simple. I notice Xen use 0xEA1, which is
> probably less likely to conflict with anything else. We should probably
> also put these numbers in the same header file so that any conflicts
> become immediately apparent.
>

actually we don't even do this anymore, the commit text is dated, so
this is a non issue.

>>
>> Also provides memory mapping code to map required code pages, data structures,
>> and I/O regions  accessed in Hyp mode at the same virtual address as the host
>> kernel virtual addresses, but which conforms to the architectural requirements
>> for translations in Hyp mode. This interface is added in arch/arm/kvm/arm_mmu.c
>> and comprises:
>>  - create_hyp_mappings(from, to);
>>  - create_hyp_io_mappings(from, to, phys_addr);
>>  - free_hyp_pmds();
>>
>> Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
>
> [...]
>
>> diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
>> index c196a22..f6e8f6f 100644
>> --- a/arch/arm/include/asm/kvm_arm.h
>> +++ b/arch/arm/include/asm/kvm_arm.h
>> @@ -21,4 +21,111 @@
>>
>>  #include <asm/types.h>
>>
>> +/* Hyp Configuration Register (HCR) bits */
>> +#define HCR_TGE                (1 << 27)
>> +#define HCR_TVM                (1 << 26)
>> +#define HCR_TTLB       (1 << 25)
>> +#define HCR_TPU                (1 << 24)
>> +#define HCR_TPC                (1 << 23)
>> +#define HCR_TSW                (1 << 22)
>> +#define HCR_TAC                (1 << 21)
>> +#define HCR_TIDCP      (1 << 20)
>> +#define HCR_TSC                (1 << 19)
>> +#define HCR_TID3       (1 << 18)
>> +#define HCR_TID2       (1 << 17)
>> +#define HCR_TID1       (1 << 16)
>> +#define HCR_TID0       (1 << 15)
>> +#define HCR_TWE                (1 << 14)
>> +#define HCR_TWI                (1 << 13)
>> +#define HCR_DC         (1 << 12)
>> +#define HCR_BSU                (3 << 10)
>> +#define HCR_BSU_IS     (1 << 10)
>> +#define HCR_FB         (1 << 9)
>> +#define HCR_VA         (1 << 8)
>> +#define HCR_VI         (1 << 7)
>> +#define HCR_VF         (1 << 6)
>> +#define HCR_AMO                (1 << 5)
>> +#define HCR_IMO                (1 << 4)
>> +#define HCR_FMO                (1 << 3)
>> +#define HCR_PTW                (1 << 2)
>> +#define HCR_SWIO       (1 << 1)
>> +#define HCR_VM         1
>> +
>> +/*
>> + * The bits we set in HCR:
>> + * TAC:                Trap ACTLR
>> + * TSC:                Trap SMC
>> + * TSW:                Trap cache operations by set/way
>> + * TWI:                Trap WFI
>> + * TIDCP:      Trap L2CTLR/L2ECTLR
>> + * BSU_IS:     Upgrade barriers to the inner shareable domain
>> + * FB:         Force broadcast of all maintainance operations
>> + * AMO:                Override CPSR.A and enable signaling with VA
>> + * IMO:                Override CPSR.I and enable signaling with VI
>> + * FMO:                Override CPSR.F and enable signaling with VF
>> + * SWIO:       Turn set/way invalidates into set/way clean+invalidate
>> + */
>> +#define HCR_GUEST_MASK (HCR_TSC | HCR_TSW | HCR_TWI | HCR_VM | HCR_BSU_IS | \
>> +                       HCR_FB | HCR_TAC | HCR_AMO | HCR_IMO | HCR_FMO | \
>> +                       HCR_SWIO | HCR_TIDCP)
>> +
>> +/* Hyp System Control Register (HSCTLR) bits */
>> +#define HSCTLR_TE      (1 << 30)
>> +#define HSCTLR_EE      (1 << 25)
>> +#define HSCTLR_FI      (1 << 21)
>> +#define HSCTLR_WXN     (1 << 19)
>> +#define HSCTLR_I       (1 << 12)
>> +#define HSCTLR_C       (1 << 2)
>> +#define HSCTLR_A       (1 << 1)
>> +#define HSCTLR_M       1
>> +#define HSCTLR_MASK    (HSCTLR_M | HSCTLR_A | HSCTLR_C | HSCTLR_I | \
>> +                        HSCTLR_WXN | HSCTLR_FI | HSCTLR_EE | HSCTLR_TE)
>> +
>> +/* TTBCR and HTCR Registers bits */
>> +#define TTBCR_EAE      (1 << 31)
>> +#define TTBCR_IMP      (1 << 30)
>> +#define TTBCR_SH1      (3 << 28)
>> +#define TTBCR_ORGN1    (3 << 26)
>> +#define TTBCR_IRGN1    (3 << 24)
>> +#define TTBCR_EPD1     (1 << 23)
>> +#define TTBCR_A1       (1 << 22)
>> +#define TTBCR_T1SZ     (3 << 16)
>> +#define TTBCR_SH0      (3 << 12)
>> +#define TTBCR_ORGN0    (3 << 10)
>> +#define TTBCR_IRGN0    (3 << 8)
>> +#define TTBCR_EPD0     (1 << 7)
>> +#define TTBCR_T0SZ     3
>> +#define HTCR_MASK      (TTBCR_T0SZ | TTBCR_IRGN0 | TTBCR_ORGN0 | TTBCR_SH0)
>> +
>> +/* Hyp Debug Configuration Register bits */
>> +#define HDCR_TDRA      (1 << 11)
>> +#define HDCR_TDOSA     (1 << 10)
>> +#define HDCR_TDA       (1 << 9)
>> +#define HDCR_TDE       (1 << 8)
>> +#define HDCR_HPME      (1 << 7)
>> +#define HDCR_TPM       (1 << 6)
>> +#define HDCR_TPMCR     (1 << 5)
>> +#define HDCR_HPMN_MASK (0x1F)
>> +
>> +/* Virtualization Translation Control Register (VTCR) bits */
>> +#define VTCR_SH0       (3 << 12)
>> +#define VTCR_ORGN0     (3 << 10)
>> +#define VTCR_IRGN0     (3 << 8)
>> +#define VTCR_SL0       (3 << 6)
>> +#define VTCR_S         (1 << 4)
>> +#define VTCR_T0SZ      3
>> +#define VTCR_MASK      (VTCR_SH0 | VTCR_ORGN0 | VTCR_IRGN0 | VTCR_SL0 | \
>> +                        VTCR_S | VTCR_T0SZ | VTCR_MASK)
>> +#define VTCR_HTCR_SH   (VTCR_SH0 | VTCR_ORGN0 | VTCR_IRGN0)
>> +#define VTCR_SL_L2     0               /* Starting-level: 2 */
>> +#define VTCR_SL_L1     (1 << 6)        /* Starting-level: 1 */
>> +#define VTCR_GUEST_SL  VTCR_SL_L1
>> +#define VTCR_GUEST_T0SZ        0
>> +#if VTCR_GUEST_SL == 0
>> +#define VTTBR_X                (14 - VTCR_GUEST_T0SZ)
>> +#else
>> +#define VTTBR_X                (5 - VTCR_GUEST_T0SZ)
>> +#endif
>
> I'm fine with putting this here for now, but we need to keep an eye out
> for any future hyp-related code which can re-use these architectural
> definitions.
>
>> diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
>> new file mode 100644
>> index 0000000..741ab8f
>> --- /dev/null
>> +++ b/arch/arm/include/asm/kvm_mmu.h
>> @@ -0,0 +1,39 @@
>> +/*
>> + * Copyright (C) 2012 - Virtual Open Systems and Columbia University
>> + * Author: Christoffer Dall <c.dall@virtualopensystems.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License, version 2, as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>> + */
>> +
>> +#ifndef __ARM_KVM_MMU_H__
>> +#define __ARM_KVM_MMU_H__
>> +
>> +/*
>> + * The architecture supports 40-bit IPA as input to the 2nd stage translations
>> + * and PTRS_PER_PGD2 could therefore be 1024.
>> + *
>> + * To save a bit of memory and to avoid alignment issues we assume 39-bit IPA
>> + * for now, but remember that the level-1 table must be aligned to its size.
>> + */
>> +#define PTRS_PER_PGD2  512
>> +#define PGD2_ORDER     get_order(PTRS_PER_PGD2 * sizeof(pgd_t))
>
> Can you follow the _S2_ style you used in the pgtable headers please?
>

yes

>> diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
>> index ead5a4e..8e1ea2b 100644
>> --- a/arch/arm/kvm/arm.c
>> +++ b/arch/arm/kvm/arm.c
>> @@ -34,11 +34,21 @@
>>  #include <asm/ptrace.h>
>>  #include <asm/mman.h>
>>  #include <asm/cputype.h>
>> +#include <asm/tlbflush.h>
>> +#include <asm/virt.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_asm.h>
>> +#include <asm/kvm_mmu.h>
>>
>>  #ifdef REQUIRES_VIRT
>>  __asm__(".arch_extension       virt");
>>  #endif
>>
>> +static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
>> +static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
>> +static unsigned long hyp_default_vectors;
>> +
>> +
>>  int kvm_arch_hardware_enable(void *garbage)
>>  {
>>         return 0;
>> @@ -324,9 +334,171 @@ long kvm_arch_vm_ioctl(struct file *filp,
>>         return -EINVAL;
>>  }
>>
>> +static void cpu_init_hyp_mode(void *vector)
>> +{
>> +       unsigned long pgd_ptr;
>> +       unsigned long hyp_stack_ptr;
>> +       unsigned long stack_page;
>> +       unsigned long vector_ptr;
>> +
>> +       /* Switch from the HYP stub to our own HYP init vector */
>> +       __hyp_set_vectors((unsigned long)vector);
>> +
>> +       pgd_ptr = kvm_mmu_get_httbr();
>> +       stack_page = __get_cpu_var(kvm_arm_hyp_stack_page);
>> +       hyp_stack_ptr = stack_page + PAGE_SIZE;
>> +       vector_ptr = (unsigned long)__kvm_hyp_vector;
>> +
>> +       /*
>> +        * Call initialization code, and switch to the full blown
>> +        * HYP code. The init code corrupts r12, so set the clobber
>> +        * list accordingly.
>> +        */
>> +       asm volatile (
>> +               "mov    r0, %[pgd_ptr]\n\t"
>> +               "mov    r1, %[hyp_stack_ptr]\n\t"
>> +               "mov    r2, %[vector_ptr]\n\t"
>> +               "hvc    #0\n\t" : :
>> +               [pgd_ptr] "r" (pgd_ptr),
>> +               [hyp_stack_ptr] "r" (hyp_stack_ptr),
>> +               [vector_ptr] "r" (vector_ptr) :
>> +               "r0", "r1", "r2", "r12");
>
> This looks similar to the Xen PCS (at least, register-compatible). Could
> we have a separate function for issuing a hvc call which is shared
> between the two?
>

I don't think there's any guarantee that these will remain the same,
necessarily. Also, since the immediate value of the hvc can't really
be set at runtime, it's not really pretty, it would look something
like this (let me know):

>From cf9a0f1c2ffa04911cf4e98cebe46f1bc6907f6b Mon Sep 17 00:00:00 2001
From: Christoffer Dall <c.dall@virtualopensystems.com>
Date: Fri, 30 Nov 2012 00:42:14 -0500
Subject: [PATCH] KVM: ARM: Add generic hypercall function

Add a generic hypercall wrapper that can be used to call the KVM init
code, and could also be leveraged by otherusers such as Xen.

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/hvc.h |   23 ++++++++++++++++
 arch/arm/kernel/Makefile   |    2 +-
 arch/arm/kernel/hvc.S      |   63 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/arm.c         |   18 +++----------
 4 files changed, 90 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm/include/asm/hvc.h
 create mode 100644 arch/arm/kernel/hvc.S

diff --git a/arch/arm/include/asm/hvc.h b/arch/arm/include/asm/hvc.h
new file mode 100644
index 0000000..55f9d52
--- /dev/null
+++ b/arch/arm/include/asm/hvc.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+
+extern int hvc_call(unsigned num, unsigned long arg0,
+		    unsigned long arg1, unsigned long arg2,
+		    unsigned long arg3, unsigned long arg4);
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 5bbec7b..3dab040 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -81,6 +81,6 @@ head-y			:= head$(MMUEXT).o
 obj-$(CONFIG_DEBUG_LL)	+= debug.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o

-obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
+obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o hvc.o

 extra-y := $(head-y) vmlinux.lds
diff --git a/arch/arm/kernel/hvc.S b/arch/arm/kernel/hvc.S
new file mode 100644
index 0000000..aa6c784
--- /dev/null
+++ b/arch/arm/kernel/hvc.S
@@ -0,0 +1,63 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Author: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, write to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#include <linux/linkage.h>
+#include <linux/const.h>
+#include <asm/assembler.h>
+#include <asm/virt.h>
+#include <asm/opcodes-virt.h>
+
+.text
+
+/*
+ * int hvc_call(unsigned num, void *arg0, void *arg1,
+ * 		void *arg2, void *arg3, void *arg4)
+ *
+ * @num:  hypercall number passed in r12
+ * @arg0: The first argument
+ * @arg1: The second argument
+ * @arg2: The third argument
+ * @arg3: The fourth argument
+ * @arg4: The fifth argument
+ *
+ * Perform an HVC (hyper call) according to the following procedure call
+ * starndard:
+ *
+ * The arguments are passed in r0-r4
+ * The hypercall number is passed in r12 (if applicable)
+ * The return value is in r0 (if applicable)
+ */
+#define HVC_CALL(iss)						\
+	stmdb	sp!, {r4, lr};					\
+	mov	r12, r0;					\
+	mov	r0, r1;						\
+	mov	r1, r2;						\
+	mov	r2, r3;						\
+	ldr	r3, [sp, #12];					\
+	ldr	r4, [sp, #8];					\
+	__HVC(iss);						\
+	ldmia	sp!, {r4, lr};					\
+	bx	lr
+
+/*
+ * Perform a generic HVC call with hvc #0
+ */
+ENTRY(hvc_call)
+	HVC_CALL(0)
+ENDPROC(hvc_call)
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9827a3d..042692b 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -44,10 +44,7 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
 #include <asm/opcodes.h>
-
-#ifdef REQUIRES_VIRT
-__asm__(".arch_extension	virt");
-#endif
+#include <asm/hvc.h>

 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 static struct vfp_hard_struct __percpu *kvm_host_vfp_state;
@@ -943,18 +940,9 @@ static void cpu_init_hyp_mode(void *vector)

 	/*
 	 * Call initialization code, and switch to the full blown
-	 * HYP code. The init code corrupts r12, so set the clobber
-	 * list accordingly.
+	 * HYP code.
 	 */
-	asm volatile (
-		"mov	r0, %[pgd_ptr]\n\t"
-		"mov	r1, %[hyp_stack_ptr]\n\t"
-		"mov	r2, %[vector_ptr]\n\t"
-		"hvc	#0\n\t" : :
-		[pgd_ptr] "r" (pgd_ptr),
-		[hyp_stack_ptr] "r" (hyp_stack_ptr),
-		[vector_ptr] "r" (vector_ptr) :
-		"r0", "r1", "r2", "r12");
+	hvc_call(0, pgd_ptr, hyp_stack_ptr, vector_ptr, 0, 0);
 }

 /**
-- 
1.7.9.5



>> +}
>> +
>> +/**
>> + * Inits Hyp-mode on all online CPUs
>> + */
>> +static int init_hyp_mode(void)
>> +{
>> +       phys_addr_t init_phys_addr;
>> +       int cpu;
>> +       int err = 0;
>> +
>> +       /*
>> +        * Allocate Hyp PGD and setup Hyp identity mapping
>> +        */
>> +       err = kvm_mmu_init();
>> +       if (err)
>> +               return err;
>> +
>> +       /*
>> +        * It is probably enough to obtain the default on one
>> +        * CPU. It's unlikely to be different on the others.
>> +        */
>> +       hyp_default_vectors = __hyp_get_vectors();
>> +
>> +       /*
>> +        * Allocate stack pages for Hypervisor-mode
>> +        */
>> +       for_each_possible_cpu(cpu) {
>> +               unsigned long stack_page;
>> +
>> +               stack_page = __get_free_page(GFP_KERNEL);
>> +               if (!stack_page) {
>> +                       err = -ENOMEM;
>> +                       goto out_free_stack_pages;
>> +               }
>> +
>> +               per_cpu(kvm_arm_hyp_stack_page, cpu) = stack_page;
>> +       }
>> +
>> +       /*
>> +        * Execute the init code on each CPU.
>> +        *
>> +        * Note: The stack is not mapped yet, so don't do anything else than
>> +        * initializing the hypervisor mode on each CPU using a local stack
>> +        * space for temporary storage.
>> +        */
>> +       init_phys_addr = virt_to_phys(__kvm_hyp_init);
>> +       for_each_online_cpu(cpu) {
>> +               smp_call_function_single(cpu, cpu_init_hyp_mode,
>> +                                        (void *)(long)init_phys_addr, 1);
>> +       }
>
> Hmm, this will probably go wrong for platforms like keystone, where
> everything is above 4GB in physical memory. Actually, I'm not sure on
> the status of the patches so you could check with Cyril [CC'd].
>

first, this made me realize that the httbr actually accepts a 40-bit
value, and the init code becomes a lot nicer as a result of that, so
I've attached a patch to address that.

However, I don't understand how we at all support Hyp mode on a
platform where all ram is above 4GB, because the HVBAR only takes a
32-bit value and Hyp mode is entered with the MMU disabled (from
__hyp_stub_install). On such a platform monitor mode must setup the
HTTBR and the HVBAR to even get to Hyp mode, but we clear the MMU
enable flag for Hyp mode during Hyp boot, so entering it again, will,
eh, be bad? Me confused...

Can we cross this bridge when we get there?

>> diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
>> index 1dc8926..3e0690b 100644
>> --- a/arch/arm/kvm/init.S
>> +++ b/arch/arm/kvm/init.S
>> @@ -15,5 +15,112 @@
>>   * along with this program; if not, write to the Free Software
>>   * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>>   */
>> +
>> +#include <linux/linkage.h>
>> +#include <asm/unified.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/kvm_asm.h>
>> +#include <asm/kvm_arm.h>
>> +
>> +/********************************************************************
>> + * Hypervisor initialization
>> + *   - should be called with:
>> + *       r0 = Hypervisor pgd pointer
>> + *       r1 = top of Hyp stack (kernel VA)
>> + *       r2 = pointer to hyp vectors
>> + */
>> +
>> +       .text
>> +       .pushsection    .hyp.idmap.text,"ax"
>> +       .align 12
>> +__kvm_hyp_init:
>> +       .globl __kvm_hyp_init
>> +
>> +       @ Hyp-mode exception vector
>> +       W(b)    .
>> +       W(b)    .
>> +       W(b)    .
>> +       W(b)    .
>> +       W(b)    .
>> +       W(b)    __do_hyp_init
>> +       W(b)    .
>> +       W(b)    .
>> +
>> +__do_hyp_init:
>> +       @ Set the sp to end of this page and push data for later use
>> +ARM(   add     r12, pc, #(__kvm_init_sp - .)   )
>> +ARM(   sub     r12, r12, #8                    )
>> +THUMB( adr     r12, __kvm_init_sp              )
>> +       mov     sp, r12
>> +       push    {r1, r2}
>> +
>> +       @ Set the HTTBR to point to the hypervisor PGD pointer passed to
>> +       @ function and set the upper bits equal to the kernel PGD.
>> +       mrrc    p15, 1, r1, r2, c2
>> +       mcrr    p15, 4, r0, r2, c2
>> +
>> +       @ Set the HTCR and VTCR to the same shareability and cacheability
>> +       @ settings as the non-secure TTBCR and with T0SZ == 0.
>> +       mrc     p15, 4, r0, c2, c0, 2   @ HTCR
>> +       ldr     r12, =HTCR_MASK
>> +       bic     r0, r0, r12
>> +       mrc     p15, 0, r1, c2, c0, 2   @ TTBCR
>> +       and     r1, r1, #(HTCR_MASK & ~TTBCR_T0SZ)
>> +       orr     r0, r0, r1
>> +       mcr     p15, 4, r0, c2, c0, 2   @ HTCR
>> +
>> +       mrc     p15, 4, r1, c2, c1, 2   @ VTCR
>> +       bic     r1, r1, #(VTCR_HTCR_SH | VTCR_SL0)
>> +       bic     r0, r0, #(~VTCR_HTCR_SH)
>> +       orr     r1, r0, r1
>> +       orr     r1, r1, #(VTCR_SL_L1 | VTCR_GUEST_T0SZ)
>> +       mcr     p15, 4, r1, c2, c1, 2   @ VTCR
>> +
>> +       @ Use the same memory attributes for hyp. accesses as the kernel
>> +       @ (copy MAIRx ro HMAIRx).
>> +       mrc     p15, 0, r0, c10, c2, 0
>> +       mcr     p15, 4, r0, c10, c2, 0
>> +       mrc     p15, 0, r0, c10, c2, 1
>> +       mcr     p15, 4, r0, c10, c2, 1
>> +
>> +       @ Set the HSCTLR to:
>> +       @  - ARM/THUMB exceptions: Kernel config (Thumb-2 kernel)
>> +       @  - Endianness: Kernel config
>> +       @  - Fast Interrupt Features: Kernel config
>> +       @  - Write permission implies XN: disabled
>> +       @  - Instruction cache: enabled
>> +       @  - Data/Unified cache: enabled
>> +       @  - Memory alignment checks: enabled
>> +       @  - MMU: enabled (this code must be run from an identity mapping)
>> +       mrc     p15, 4, r0, c1, c0, 0   @ HSCR
>> +       ldr     r12, =HSCTLR_MASK
>> +       bic     r0, r0, r12
>> +       mrc     p15, 0, r1, c1, c0, 0   @ SCTLR
>> +       ldr     r12, =(HSCTLR_EE | HSCTLR_FI)
>> +       and     r1, r1, r12
>> + ARM(  ldr     r12, =(HSCTLR_M | HSCTLR_A | HSCTLR_I)                  )
>> + THUMB(        ldr     r12, =(HSCTLR_M | HSCTLR_A | HSCTLR_I | HSCTLR_TE)      )
>> +       orr     r1, r1, r12
>> +       orr     r0, r0, r1
>> +       isb
>> +       mcr     p15, 4, r0, c1, c0, 0   @ HSCR
>> +       isb
>> +
>> +       @ Set stack pointer and return to the kernel
>> +       pop     {r1, r2}
>> +       mov     sp, r1
>> +
>> +       @ Set HVBAR to point to the HYP vectors
>> +       mcr     p15, 4, r2, c12, c0, 0  @ HVBAR
>> +
>> +       eret
>> +
>> +       .ltorg
>> +
>> +       .align 12
>
> Do you *have* to page-align the start and end of this small piece of
> code? What goes wrong if you end up including random other stuff in the
> hyp pgd?
>

we did this to have stack space at the end of the page, but I got rid
of all this, see the patch at the end of this mail.

>> +
>> +       __kvm_init_sp:
>> +       .globl __kvm_hyp_init_end
>> +__kvm_hyp_init_end:
>> +
>> +       .popsection
>> diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
>> index 1dc8926..98a67ca 100644
>> --- a/arch/arm/kvm/interrupts.S
>> +++ b/arch/arm/kvm/interrupts.S
>> @@ -15,5 +15,53 @@
>>   * along with this program; if not, write to the Free Software
>>   * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>>   */
>> +
>> +#include <linux/linkage.h>
>> +#include <linux/const.h>
>> +#include <asm/unified.h>
>> +#include <asm/page.h>
>>  #include <asm/asm-offsets.h>
>>  #include <asm/kvm_asm.h>
>> +#include <asm/kvm_arm.h>
>> +
>> +       .text
>> +       .align  PAGE_SHIFT
>
> I guess you could also use PAGE_SHIFT in the previous file if you do
> have to keep the align directives. Why do you need the alignment here?
>

eh, we don't. Historical reasons. (except trying to keep this all in
one page might be good for performance to use only a single TLB
entry).

>> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
>> index 10ed464..17c2bf5 100644
>> --- a/arch/arm/kvm/mmu.c
>> +++ b/arch/arm/kvm/mmu.c
>> @@ -15,3 +15,213 @@
>>   * along with this program; if not, write to the Free Software
>>   * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>>   */
>> +
>> +#include <linux/mman.h>
>> +#include <linux/kvm_host.h>
>> +#include <linux/io.h>
>> +#include <asm/idmap.h>
>> +#include <asm/pgalloc.h>
>> +#include <asm/kvm_arm.h>
>> +#include <asm/kvm_mmu.h>
>> +#include <asm/mach/map.h>
>> +
>> +static DEFINE_MUTEX(kvm_hyp_pgd_mutex);
>> +static pgd_t *hyp_pgd;
>> +
>> +static void free_ptes(pmd_t *pmd, unsigned long addr)
>> +{
>> +       pte_t *pte;
>> +       unsigned int i;
>> +
>> +       for (i = 0; i < PTRS_PER_PMD; i++, addr += PMD_SIZE) {
>> +               if (!pmd_none(*pmd) && pmd_table(*pmd)) {
>> +                       pte = pte_offset_kernel(pmd, addr);
>> +                       pte_free_kernel(NULL, pte);
>> +               }
>> +               pmd++;
>> +       }
>> +}
>> +
>> +/**
>> + * free_hyp_pmds - free a Hyp-mode level-2 tables and child level-3 tables
>> + *
>> + * Assumes this is a page table used strictly in Hyp-mode and therefore contains
>> + * only mappings in the kernel memory area, which is above PAGE_OFFSET.
>> + */
>> +void free_hyp_pmds(void)
>> +{
>> +       pgd_t *pgd;
>> +       pud_t *pud;
>> +       pmd_t *pmd;
>> +       unsigned long addr;
>> +
>> +       mutex_lock(&kvm_hyp_pgd_mutex);
>> +       for (addr = PAGE_OFFSET; addr != 0; addr += PGDIR_SIZE) {
>> +               pgd = hyp_pgd + pgd_index(addr);
>> +               pud = pud_offset(pgd, addr);
>> +
>> +               if (pud_none(*pud))
>> +                       continue;
>> +               BUG_ON(pud_bad(*pud));
>> +
>> +               pmd = pmd_offset(pud, addr);
>> +               free_ptes(pmd, addr);
>> +               pmd_free(NULL, pmd);
>> +               pud_clear(pud);
>> +       }
>> +       mutex_unlock(&kvm_hyp_pgd_mutex);
>> +}
>> +
>> +/*
>> + * Create a HYP pte mapping.
>> + *
>> + * If pfn_base is NULL, we map kernel pages into HYP with the virtual
>> + * address. Otherwise, this is considered an I/O mapping and we map
>> + * the physical region starting at *pfn_base to [start, end[.
>> + */
>
> Seems fairly counter-intuitive to me. Why can't you have two separate
> functions?
>

I really don't want to replicate the whole set of functions, but I
split up the pte function and perform the pfn_base check before
calling the appropriate new one.

>> diff --git a/mm/memory.c b/mm/memory.c
>> index fb135ba..5ae0164 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -383,12 +383,14 @@ void pgd_clear_bad(pgd_t *pgd)
>>         pgd_ERROR(*pgd);
>>         pgd_clear(pgd);
>>  }
>> +EXPORT_SYMBOL_GPL(pgd_clear_bad);
>>
>>  void pud_clear_bad(pud_t *pud)
>>  {
>>         pud_ERROR(*pud);
>>         pud_clear(pud);
>>  }
>> +EXPORT_SYMBOL_GPL(pud_clear_bad);
>
> Do we really need these? If so, they should be a separate patch which needs
> sending to linux-mm with akpm on CC.
>
we sure don't, no module any more.


I am attaching the patches addressing your comments:

>From 5695da0494b0991f59b011ea00ca8a3b4f23f110 Mon Sep 17 00:00:00 2001
From: Christoffer Dall <c.dall@virtualopensystems.com>
Date: Thu, 29 Nov 2012 21:28:27 -0500
Subject: [PATCH 1/5] KVM: ARM: Fix PGD2 reminiscence

Some kvm-local defines were still named according to the PGD2 naming
scheme, so let's move this to S2_PGD...

Applied to: KVM: ARM: Hypervisor inititalization

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_arm.h |    8 ++++----
 arch/arm/kvm/mmu.c             |   12 ++++++------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index 8d31a08..b4bdd0c 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -127,15 +127,15 @@

 /*
  * The architecture supports 40-bit IPA as input to the 2nd stage translations
- * and PTRS_PER_PGD2 becomes 1024, because each entry covers 1GB of address
+ * and PTRS_PER_S2_PGD becomes 1024, because each entry covers 1GB of address
  * space.
  */
 #define KVM_PHYS_SHIFT	(40)
 #define KVM_PHYS_SIZE	(1ULL << KVM_PHYS_SHIFT)
 #define KVM_PHYS_MASK	(KVM_PHYS_SIZE - 1ULL)
-#define PTRS_PER_PGD2	(1ULL << (KVM_PHYS_SHIFT - 30))
-#define PGD2_ORDER	get_order(PTRS_PER_PGD2 * sizeof(pgd_t))
-#define PGD2_SIZE	(1 << PGD2_ORDER)
+#define PTRS_PER_S2_PGD	(1ULL << (KVM_PHYS_SHIFT - 30))
+#define S2_PGD_ORDER	get_order(PTRS_PER_S2_PGD * sizeof(pgd_t))
+#define S2_PGD_SIZE	(1 << S2_PGD_ORDER)

 /* Virtualization Translation Control Register (VTCR) bits */
 #define VTCR_SH0	(3 << 12)
diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 59d422f..aac671d 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -260,7 +260,7 @@ int create_hyp_io_mappings(void *from, void *to,
phys_addr_t addr)
  * kvm_alloc_stage2_pgd - allocate level-1 table for stage-2 translation.
  * @kvm:	The KVM struct pointer for the VM.
  *
- * Allocates the 1st level table only of size defined by PGD2_ORDER (can
+ * Allocates the 1st level table only of size defined by S2_PGD_ORDER (can
  * support either full 40-bit input addresses or limited to 32-bit input
  * addresses). Clears the allocated pages.
  *
@@ -276,15 +276,15 @@ int kvm_alloc_stage2_pgd(struct kvm *kvm)
 		return -EINVAL;
 	}

-	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, PGD2_ORDER);
+	pgd = (pgd_t *)__get_free_pages(GFP_KERNEL, S2_PGD_ORDER);
 	if (!pgd)
 		return -ENOMEM;

 	/* stage-2 pgd must be aligned to its size */
-	VM_BUG_ON((unsigned long)pgd & (PGD2_SIZE - 1));
+	VM_BUG_ON((unsigned long)pgd & (S2_PGD_SIZE - 1));

-	memset(pgd, 0, PTRS_PER_PGD2 * sizeof(pgd_t));
-	clean_dcache_area(pgd, PTRS_PER_PGD2 * sizeof(pgd_t));
+	memset(pgd, 0, PTRS_PER_S2_PGD * sizeof(pgd_t));
+	clean_dcache_area(pgd, PTRS_PER_S2_PGD * sizeof(pgd_t));
 	kvm->arch.pgd = pgd;

 	return 0;
@@ -395,7 +395,7 @@ void kvm_free_stage2_pgd(struct kvm *kvm)
 		return;

 	unmap_stage2_range(kvm, 0, KVM_PHYS_SIZE);
-	free_pages((unsigned long)kvm->arch.pgd, PGD2_ORDER);
+	free_pages((unsigned long)kvm->arch.pgd, S2_PGD_ORDER);
 	kvm->arch.pgd = NULL;
 }

-- 
1.7.9.5




>From 80c1c64ad5ec6d320afc3523d988b26d5fb05c29 Mon Sep 17 00:00:00 2001
From: Christoffer Dall <c.dall@virtualopensystems.com>
Date: Fri, 30 Nov 2012 01:57:47 -0500
Subject: [PATCH 2/5] KVM: ARM: Fixup httbr initialization

Use 64 bit value passed to the hyp mode init code which simplifies that
code and allows using a physical address for the HTTBR which is above
the 4G limit.

Applies to: KVM: ARM: Hypervisor inititalization

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_mmu.h |    2 +-
 arch/arm/kvm/arm.c             |   16 +++++++++-------
 arch/arm/kvm/init.S            |   33 ++++++++++-----------------------
 arch/arm/kvm/mmu.c             |    3 ++-
 4 files changed, 22 insertions(+), 32 deletions(-)

diff --git a/arch/arm/include/asm/kvm_mmu.h b/arch/arm/include/asm/kvm_mmu.h
index 4d55218..ab4272f 100644
--- a/arch/arm/include/asm/kvm_mmu.h
+++ b/arch/arm/include/asm/kvm_mmu.h
@@ -32,7 +32,7 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu,
struct kvm_run *run);

 void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu);

-unsigned long kvm_mmu_get_httbr(void);
+phys_addr_t kvm_mmu_get_httbr(void);
 int kvm_mmu_init(void);
 void kvm_mmu_exit(void);
 #endif /* __ARM_KVM_MMU_H__ */
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9827a3d..39d5f51 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -928,7 +928,7 @@ long kvm_arch_vm_ioctl(struct file *filp,

 static void cpu_init_hyp_mode(void *vector)
 {
-	unsigned long pgd_ptr;
+	unsigned long long pgd_ptr;
 	unsigned long hyp_stack_ptr;
 	unsigned long stack_page;
 	unsigned long vector_ptr;
@@ -936,7 +936,7 @@ static void cpu_init_hyp_mode(void *vector)
 	/* Switch from the HYP stub to our own HYP init vector */
 	__hyp_set_vectors((unsigned long)vector);

-	pgd_ptr = kvm_mmu_get_httbr();
+	pgd_ptr = (unsigned long long)kvm_mmu_get_httbr();
 	stack_page = __get_cpu_var(kvm_arm_hyp_stack_page);
 	hyp_stack_ptr = stack_page + PAGE_SIZE;
 	vector_ptr = (unsigned long)__kvm_hyp_vector;
@@ -947,14 +947,16 @@ static void cpu_init_hyp_mode(void *vector)
 	 * list accordingly.
 	 */
 	asm volatile (
-		"mov	r0, %[pgd_ptr]\n\t"
-		"mov	r1, %[hyp_stack_ptr]\n\t"
-		"mov	r2, %[vector_ptr]\n\t"
+		"mov	r0, %[pgd_ptr_low]\n\t"
+		"mov	r1, %[pgd_ptr_high]\n\t"
+		"mov	r2, %[hyp_stack_ptr]\n\t"
+		"mov	r3, %[vector_ptr]\n\t"
 		"hvc	#0\n\t" : :
-		[pgd_ptr] "r" (pgd_ptr),
+		[pgd_ptr_low] "r" ((unsigned long)(pgd_ptr & 0xffffffff)),
+		[pgd_ptr_high] "r" ((unsigned long)(pgd_ptr >> 32ULL)),
 		[hyp_stack_ptr] "r" (hyp_stack_ptr),
 		[vector_ptr] "r" (vector_ptr) :
-		"r0", "r1", "r2", "r12");
+		"r0", "r1", "r2", "r3", "r12");
 }

 /**
diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 5b52851..f179f10 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -25,14 +25,14 @@
 /********************************************************************
  * Hypervisor initialization
  *   - should be called with:
- *       r0 = Hypervisor pgd pointer
- *       r1 = top of Hyp stack (kernel VA)
- *       r2 = pointer to hyp vectors
+ *       r0,r1 = Hypervisor pgd pointer
+ *       r2 = top of Hyp stack (kernel VA)
+ *       r3 = pointer to hyp vectors
  */

 	.text
 	.pushsection    .hyp.idmap.text,"ax"
-	.align 12
+	.align 5
 __kvm_hyp_init:
 	.globl __kvm_hyp_init

@@ -47,17 +47,8 @@ __kvm_hyp_init:
 	W(b)	.

 __do_hyp_init:
-	@ Set the sp to end of this page and push data for later use
-ARM(	add	r12, pc, #(__kvm_init_sp - .)	)
-ARM(	sub	r12, r12, #8			)
-THUMB(	adr	r12, __kvm_init_sp		)
-	mov	sp, r12
-	push	{r1, r2}
-
-	@ Set the HTTBR to point to the hypervisor PGD pointer passed to
-	@ function and set the upper bits equal to the kernel PGD.
-	mrrc	p15, 1, r1, r2, c2
-	mcrr	p15, 4, r0, r2, c2
+	@ Set the HTTBR to point to the hypervisor PGD pointer passed
+	mcrr	p15, 4, r0, r1, c2

 	@ Set the HTCR and VTCR to the same shareability and cacheability
 	@ settings as the non-secure TTBCR and with T0SZ == 0.
@@ -70,8 +61,8 @@ THUMB(	adr	r12, __kvm_init_sp		)
 	mcr	p15, 4, r0, c2, c0, 2	@ HTCR

 	mrc	p15, 4, r1, c2, c1, 2	@ VTCR
-	ldr	r2, =VTCR_MASK
-	bic	r1, r1, r2
+	ldr	r12, =VTCR_MASK
+	bic	r1, r1, r12
 	bic	r0, r0, #(~VTCR_HTCR_SH)	@ clear non-reusable HTCR bits
 	orr	r1, r0, r1
 	orr	r1, r1, #(KVM_VTCR_SL0 | KVM_VTCR_T0SZ | KVM_VTCR_S)
@@ -108,19 +99,15 @@ THUMB(	adr	r12, __kvm_init_sp		)
 	isb

 	@ Set stack pointer and return to the kernel
-	pop	{r1, r2}
-	mov	sp, r1
+	mov	sp, r2

 	@ Set HVBAR to point to the HYP vectors
-	mcr	p15, 4, r2, c12, c0, 0	@ HVBAR
+	mcr	p15, 4, r3, c12, c0, 0	@ HVBAR

 	eret

 	.ltorg

-	.align 12
-
-	__kvm_init_sp:
 	.globl __kvm_hyp_init_end
 __kvm_hyp_init_end:

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index aac671d..6fc9489 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -718,8 +718,9 @@ void kvm_mmu_free_memory_caches(struct kvm_vcpu *vcpu)
 	mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
 }

-unsigned long kvm_mmu_get_httbr(void)
+phys_addr_t kvm_mmu_get_httbr(void)
 {
+	VM_BUG_ON(!virt_addr_valid(hyp_pgd));
 	return virt_to_phys(hyp_pgd);
 }

-- 
1.7.9.5



>From 875a67eadd0a95b4cd2fd279ff4533fec1142b32 Mon Sep 17 00:00:00 2001
From: Christoffer Dall <c.dall@virtualopensystems.com>
Date: Fri, 30 Nov 2012 02:01:26 -0500
Subject: [PATCH 3/5] KVM: ARM: Remove page requirements for hyp code

We can allocate over physically non-contigous pages so remove the
alignment and page size requirement from arch/arm/kvm/interrupts.S.

Applies to: KVM: ARM: Hypervisor inititalization

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kvm/interrupts.S |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index f62c621..8a1f2df 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -28,7 +28,6 @@
 #include "interrupts_head.S"

 	.text
-	.align	PAGE_SHIFT

 __kvm_hyp_code_start:
 	.globl __kvm_hyp_code_start
@@ -490,13 +489,5 @@ dabt_die_str:
 svc_die_str:
 	.ascii	"unexpected HVC/SVC trap in Hyp mode at: %#08x"

-/*
- * The below lines makes sure the HYP mode code fits in a single page (the
- * assembler will bark at you if it doesn't). Please keep them together. If
- * you plan to restructure the code or increase its size over a page, you'll
- * have to fix the code in init_hyp_mode().
- */
 __kvm_hyp_code_end:
 	.globl	__kvm_hyp_code_end
-
-	.org	__kvm_hyp_code_start + PAGE_SIZE
-- 
1.7.9.5


>From 713f0c91c2c881e14c8aa5e3a9b019e0ad07e4a3 Mon Sep 17 00:00:00 2001
From: Christoffer Dall <c.dall@virtualopensystems.com>
Date: Fri, 30 Nov 2012 02:02:42 -0500
Subject: [PATCH 4/5] KVM: ARM: Revert unnecessary exported mm symbols

We don't support compiling KVM as a module anymore so let's get rid
of these previously introduced exports.

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 mm/memory.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 5ae0164..fb135ba 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -383,14 +383,12 @@ void pgd_clear_bad(pgd_t *pgd)
 	pgd_ERROR(*pgd);
 	pgd_clear(pgd);
 }
-EXPORT_SYMBOL_GPL(pgd_clear_bad);

 void pud_clear_bad(pud_t *pud)
 {
 	pud_ERROR(*pud);
 	pud_clear(pud);
 }
-EXPORT_SYMBOL_GPL(pud_clear_bad);

 void pmd_clear_bad(pmd_t *pmd)
 {
-- 
1.7.9.5




>From ac1eec2f0121850ddbf2b2a027cbcfb069ac74c3 Mon Sep 17 00:00:00 2001
From: Christoffer Dall <c.dall@virtualopensystems.com>
Date: Fri, 30 Nov 2012 02:08:58 -0500
Subject: [PATCH 5/5] KVM: ARM: Split create_hyp_pte_mappings in io/non-io
 versions

create_hyp_pte_mappings basically has all its logic in equally
balanced if-else clauses, so splitting up the function makes things
slightly more clear.

Applies to: KVM: ARM: Hypervisor inititalization

Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/kvm/mmu.c |   55 ++++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
index 6fc9489..a87e47b 100644
--- a/arch/arm/kvm/mmu.c
+++ b/arch/arm/kvm/mmu.c
@@ -127,38 +127,33 @@ void free_hyp_pmds(void)
 	mutex_unlock(&kvm_hyp_pgd_mutex);
 }

-/*
- * Create a HYP pte mapping.
- *
- * If pfn_base is NULL, we map kernel pages into HYP with the virtual
- * address. Otherwise, this is considered an I/O mapping and we map
- * the physical region starting at *pfn_base to [start, end[.
- */
 static void create_hyp_pte_mappings(pmd_t *pmd, unsigned long start,
-				    unsigned long end, unsigned long *pfn_base)
+				    unsigned long end)
 {
 	pte_t *pte;
 	unsigned long addr;
-	pgprot_t prot;
-
-	if (pfn_base)
-		prot = PAGE_HYP_DEVICE;
-	else
-		prot = PAGE_HYP;
+	struct page *page;

 	for (addr = start & PAGE_MASK; addr < end; addr += PAGE_SIZE) {
 		pte = pte_offset_kernel(pmd, addr);
-		if (pfn_base) {
-			BUG_ON(pfn_valid(*pfn_base));
-			kvm_set_pte(pte, pfn_pte(*pfn_base, prot));
-			(*pfn_base)++;
-		} else {
-			struct page *page;
-			BUG_ON(!virt_addr_valid(addr));
-			page = virt_to_page(addr);
-			kvm_set_pte(pte, mk_pte(page, prot));
-		}
+		BUG_ON(!virt_addr_valid(addr));
+		page = virt_to_page(addr);
+		kvm_set_pte(pte, mk_pte(page, PAGE_HYP));
+	}
+}

+static void create_hyp_io_pte_mappings(pmd_t *pmd, unsigned long start,
+				       unsigned long end,
+				       unsigned long *pfn_base)
+{
+	pte_t *pte;
+	unsigned long addr;
+
+	for (addr = start & PAGE_MASK; addr < end; addr += PAGE_SIZE) {
+		pte = pte_offset_kernel(pmd, addr);
+		BUG_ON(pfn_valid(*pfn_base));
+		kvm_set_pte(pte, pfn_pte(*pfn_base, PAGE_HYP_DEVICE));
+		(*pfn_base)++;
 	}
 }

@@ -184,7 +179,17 @@ static int create_hyp_pmd_mappings(pud_t *pud,
unsigned long start,
 		}

 		next = pmd_addr_end(addr, end);
-		create_hyp_pte_mappings(pmd, addr, next, pfn_base);
+
+		/*
+		 * If pfn_base is NULL, we map kernel pages into HYP with the
+		 * virtual address. Otherwise, this is considered an I/O
+		 * mapping and we map the physical region starting at
+		 * *pfn_base to [start, end[.
+		 */
+		if (!pfn_base)
+			create_hyp_pte_mappings(pmd, addr, next);
+		else
+			create_hyp_io_pte_mappings(pmd, addr, next, pfn_base);
 	}

 	return 0;
-- 
1.7.9.5



Thanks!!
-Christoffer
