From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:35:57 +0100
Subject: [RFC PATCH 05/14] arm64: kernel: cpu_{suspend/resume} implementation
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1377689766-17642-6-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel subsystems like CPU idle and suspend to RAM require a generic
mechanism to suspend a processor, save its context and put it into
a quiescent state. The cpu_{suspend}/{resume} implementation provides
such a framework through a kernel interface allowing to save/restore
registers, flush the context to DRAM and suspend/resume to/from
low-power states where processor context may be lost.

Different SoCs might require different operations to be carried out
before a power down request is committed. For this reason the kernel
allows the caller of cpu_suspend to provide a function pointer (fn in
the cpu_suspend prototype below),

int cpu_suspend(unsigned long arg, int (*fn)(unsigned long));

called suspend finisher, that is executed after the context is saved and
flushed to DRAM, so that SoC/platform specific operations can be carried out
before issuing power down commands.

Context memory is allocated on the stack, whose address is stashed in a
per-cpu variable to keep track of it and passed to core functions that
save/restore the registers required by the architecture.

Even though, upon successful execution, the cpu_suspend function shuts
down the suspending processor, the warm boot resume mechanism, based
on the cpu_resume function, makes the resume path operate as a
cpu_suspend function return, so that cpu_suspend can be treated as a C
function by the caller, which simplifies coding the PM drivers that rely
on the cpu_suspend API.

Upon context save, the minimal amount of memory is flushed to DRAM so
that it can be retrieved when the MMU is off and caches are not searched.

The suspend finisher, depending on the required operations (eg CPU vs
Cluster shutdown) is in charge of flushing the cache hierarchy either
implicitly (by calling firmware implementations like PSCI) or explicitly
by executing the required cache maintainance functions.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/suspend.h |  12 +++
 arch/arm64/kernel/asm-offsets.c  |   4 +
 arch/arm64/kernel/sleep.S        | 181 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/suspend.c      |  76 ++++++++++++++++
 4 files changed, 273 insertions(+)
 create mode 100644 arch/arm64/include/asm/suspend.h
 create mode 100644 arch/arm64/kernel/sleep.S
 create mode 100644 arch/arm64/kernel/suspend.c

diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
new file mode 100644
index 0000000..aa47f51
--- /dev/null
+++ b/arch/arm64/include/asm/suspend.h
@@ -0,0 +1,12 @@
+#ifndef __ASM_ARM_SUSPEND_H
+#define __ASM_ARM_SUSPEND_H
+
+struct sleep_save_sp {
+	u64 *save_ptr_stash;
+	phys_addr_t save_ptr_stash_phys;
+};
+
+extern void cpu_resume(void);
+extern int cpu_suspend(unsigned long, int (*)(unsigned long));
+
+#endif
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 77b12d1..0dd1f51 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -26,6 +26,7 @@
 #include <asm/memory.h>
 #include <asm/cputable.h>
 #include <asm/smp_plat.h>
+#include <asm/suspend.h>
 #include <asm/vdso_datapage.h>
 #include <linux/kbuild.h>
 
@@ -152,6 +153,9 @@ int main(void)
   DEFINE(CPU_CTX_VBAR_EL1,	offsetof(struct cpu_suspend_ctx, vbar_el1));
   DEFINE(CPU_CTX_SCTLR_EL1,	offsetof(struct cpu_suspend_ctx, sctlr_el1));
   DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
+  DEFINE(SLEEP_SAVE_SP_SZ,	sizeof(struct sleep_save_sp));
+  DEFINE(SLEEP_SAVE_SP_PHYS,	offsetof(struct sleep_save_sp, save_ptr_stash_phys));
+  DEFINE(SLEEP_SAVE_SP_VIRT,	offsetof(struct sleep_save_sp, save_ptr_stash));
   DEFINE(MPIDR_HASH_MASK,	offsetof(struct mpidr_hash, mask));
   DEFINE(MPIDR_HASH_SHIFTS,	offsetof(struct mpidr_hash, shift_aff));
 #endif
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
new file mode 100644
index 0000000..7924220
--- /dev/null
+++ b/arch/arm64/kernel/sleep.S
@@ -0,0 +1,181 @@
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/assembler.h>
+
+	.text
+/*
+ * Implementation of MPIDR_EL1 hash algorithm through shifting
+ * and OR'ing.
+ *
+ * @dst: register containing hash result
+ * @rs0: register containing affinity level 0 bit shift
+ * @rs1: register containing affinity level 1 bit shift
+ * @rs2: register containing affinity level 2 bit shift
+ * @rs3: register containing affinity level 3 bit shift
+ * @mpidr: register containing MPIDR_EL1 value
+ * @mask: register containing MPIDR mask
+ *
+ * Pseudo C-code:
+ *
+ *u32 dst;
+ *
+ *compute_mpidr_hash(u32 rs0, u32 rs1, u32 rs2, u32 rs3, u64 mpidr, u64 mask) {
+ *	u32 aff0, aff1, aff2, aff3;
+ *	u64 mpidr_masked = mpidr & mask;
+ *	aff0 = mpidr_masked & 0xff;
+ *	aff1 = mpidr_masked & 0xff00;
+ *	aff2 = mpidr_masked & 0xff0000;
+ *	aff2 = mpidr_masked & 0xff00000000;
+ *	dst = (aff0 >> rs0 | aff1 >> rs1 | aff2 >> rs2 | aff3 >> rs3);
+ *}
+ * Input registers: rs0, rs1, rs2, rs3, mpidr, mask
+ * Output register: dst
+ * Note: input and output registers must be disjoint register sets
+         (eg: a macro instance with mpidr = r1 and dst = r1 is invalid)
+ */
+	.macro compute_mpidr_hash dst, rs0, rs1, rs2, rs3, mpidr, mask
+	and	\mpidr, \mpidr, \mask		// mask out MPIDR bits
+	and	\dst, \mpidr, #0xff		// mask=aff0
+	lsr	\dst ,\dst, \rs0		// dst=aff0>>rs0
+	and	\mask, \mpidr, #0xff00		// mask = aff1
+	lsr	\mask ,\mask, \rs1
+	orr	\dst, \dst, \mask		// dst|=(aff1>>rs1)
+	and	\mask, \mpidr, #0xff0000	// mask = aff2
+	lsr	\mask ,\mask, \rs2
+	orr	\dst, \dst, \mask		// dst|=(aff2>>rs2)
+	and	\mask, \mpidr, #0xff00000000	// mask = aff3
+	lsr	\mask ,\mask, \rs3
+	orr	\dst, \dst, \mask		// dst|=(aff3>>rs3)
+	.endm
+/*
+ * Save CPU state for a suspend.  This saves the CPU general purpose
+ * registers, and allocates space on the kernel stack to save the CPU
+ * specific registers and some other data for resume.
+ *
+ *  x0 = suspend function arg0
+ *  x1 = suspend function
+ */
+ENTRY(__cpu_suspend)
+	stp	x29, lr, [sp, #-96]!
+	stp	x19, x20, [sp,#16]
+	stp	x21, x22, [sp,#32]
+	stp	x23, x24, [sp,#48]
+	stp	x25, x26, [sp,#64]
+	stp	x27, x28, [sp,#80]
+	mov	x2, sp
+	sub	sp, sp, #CPU_SUSPEND_SZ	// allocate cpu_suspend_ctx
+	mov	x19, x0
+	mov	x20, x1
+	mov	x0, sp
+	/*
+	 * x0 now points to struct cpu_suspend_ctx allocated on the stack
+	 */
+	str	x2, [x0, #CPU_CTX_SP]
+	ldr	x1, =sleep_save_sp
+	ldr	x1, [x1, #SLEEP_SAVE_SP_VIRT]
+#ifdef CONFIG_SMP
+	mrs	x7, mpidr_el1
+	ldr	x9, =mpidr_hash
+	ldr	x2, [x9, #MPIDR_HASH_MASK]
+	ldp	w3, w4, [x9, #MPIDR_HASH_SHIFTS]
+	ldp	w5, w6, [x9, #(MPIDR_HASH_SHIFTS + 8)]
+	compute_mpidr_hash x8, x3, x4, x5, x6, x7, x2
+	add	x1, x1, x8, lsl #3
+#endif
+	bl	__cpu_suspend_save
+	adr	lr, cpu_suspend_abort	// set lr, in case suspend fails
+	mov	x0, x19
+	br	x20			// jump to suspend finisher, x0 = arg
+ENDPROC(__cpu_suspend)
+	.ltorg
+
+cpu_suspend_abort:
+	pop 	x1, x2
+	cmp	x0, #0
+	mov	x3, #1
+	csel	x0, x3, x0, ne		// force x0 = 1 (error) in case x0 == 0
+	mov	sp, x2			// restore sp and return
+	ldp	x19, x20, [sp, #16]
+	ldp	x21, x22, [sp, #32]
+	ldp	x23, x24, [sp, #48]
+	ldp	x25, x26, [sp, #64]
+	ldp	x27, x28, [sp, #80]
+	ldp	x29, lr, [sp], #96
+	ret
+ENDPROC(cpu_suspend_abort)
+/*
+ * x0 must contain the sctlr value retrieved from restored context
+ */
+ENTRY(cpu_resume_mmu)
+	ldr	x3, =cpu_resume_after_mmu
+	msr	sctlr_el1, x0		// restore sctlr_el1
+	isb
+	br	x3			// global jump to virtual address
+ENDPROC(cpu_resume_mmu)
+cpu_resume_after_mmu:
+	mov	x0, #0			// return zero on success
+	ldp	x19, x20, [sp, #16]
+	ldp	x21, x22, [sp, #32]
+	ldp	x23, x24, [sp, #48]
+	ldp	x25, x26, [sp, #64]
+	ldp	x27, x28, [sp, #80]
+	ldp	x29, lr, [sp], #96
+	ret
+ENDPROC(cpu_resume_after_mmu)
+
+	.data
+ENTRY(cpu_resume)
+	adr	x4, sleep_save_sp
+	ldr	x5, =sleep_save_sp
+	sub	x28, x4, x5		// x28 = PHYS_OFFSET - PAGE_OFFSET
+        /*
+	 * make sure el2 is sane, el2_setup expects:
+	 * x28 = PHYS_OFFSET - PAGE_OFFSET
+	 */
+	bl	el2_setup		// if in EL2 drop to EL1 cleanly
+#ifdef CONFIG_SMP
+	mrs	x1, mpidr_el1
+	adr	x4, mpidr_hash_ptr
+	ldr	x5, [x4]
+	add	x8, x4, x5		// x8 = struct mpidr_hash phys address
+        /* retrieve mpidr_hash members to compute the hash */
+	ldr	x2, [x8, #MPIDR_HASH_MASK]
+	ldp	w3, w4, [x8, #MPIDR_HASH_SHIFTS]
+	ldp	w5, w6, [x8, #(MPIDR_HASH_SHIFTS + 8)]
+	compute_mpidr_hash x7, x3, x4, x5, x6, x1, x2
+        /* x7 contains hash index, let's use it to grab context pointer */
+#else
+	mov	x7, xzr
+#endif
+	adr	x0, _sleep_save_sp
+	ldr	x0, [x0, #SLEEP_SAVE_SP_PHYS]
+	ldr	x0, [x0, x7, lsl #3]
+	/* load phys identity pgd and sp */
+	ldr	x2, [x0, #CPU_CTX_SP]
+	ldr	x1, [x0, #CPU_CTX_TTBR0_EL1]
+	mov	sp, x2
+	/*
+	 * cpu_do_resume expects x1 to contain physical address of 1:1
+	 * page tables
+	 */
+	bl	cpu_do_resume		// PC relative jump, MMU off
+	b	cpu_resume_mmu		// Resume MMU, never returns
+ENDPROC(cpu_resume)
+
+	.align 3
+mpidr_hash_ptr:
+	/*
+	 * offset of mpidr_hash symbol from current location
+	 * used to obtain run-time mpidr_hash address with MMU off
+         */
+	.quad	mpidr_hash - .
+/*
+ * struct sleep_save_sp {
+ *	u64 *save_ptr_stash;
+ *	phys_addr_t save_ptr_stash_phys;
+ * };
+ */
+	.type	sleep_save_sp, #object
+ENTRY(sleep_save_sp)
+_sleep_save_sp:
+	.space	SLEEP_SAVE_SP_SZ	// struct sleep_save_sp
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
new file mode 100644
index 0000000..491aceb
--- /dev/null
+++ b/arch/arm64/kernel/suspend.c
@@ -0,0 +1,76 @@
+#include <linux/slab.h>
+#include <asm/cacheflush.h>
+#include <asm/pgtable.h>
+#include <asm/memory.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+#include <asm/tlbflush.h>
+
+extern int __cpu_suspend(unsigned long, int (*)(unsigned long));
+/*
+ * This is called by __cpu_suspend() to save the state, and do whatever
+ * flushing is required to ensure that when the CPU goes to sleep we have
+ * the necessary data available when the caches are not searched.
+ *
+ * @ptr: CPU context virtual address
+ * @save_ptr: address of the location where the context physical address
+ *            must be saved
+ */
+void __cpu_suspend_save(struct cpu_suspend_ctx *ptr, u64 *save_ptr)
+{
+	*save_ptr = virt_to_phys(ptr);
+
+	ptr->ttbr0_el1 = virt_to_phys(idmap_pg_dir);
+
+	cpu_do_suspend(ptr);
+	/*
+	 * Only flush the context that must be retrieved with the MMU
+	 * off. VA primitives ensure the flush is applied to all
+	 * cache levels so context is pushed to DRAM.
+	 */
+	__flush_dcache_area(ptr, sizeof(*ptr));
+	__flush_dcache_area(save_ptr, sizeof(*save_ptr));
+}
+
+/**
+ * cpu_suspend
+ *
+ * @arg: argument to pass to the finisher function
+ * @fn: suspend finisher function, the function that executes last
+ *	operations required to suspend a processor
+ */
+int cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
+{
+	struct mm_struct *mm = current->active_mm;
+	int ret;
+	/*
+	 * Save the mm context on the stack, it will be restored when
+	 * the cpu comes out of reset through the identity mapped
+	 * page tables, so that the thread address space is properly
+	 * set-up on function return.
+	 */
+	ret = __cpu_suspend(arg, fn);
+	if (ret == 0) {
+		cpu_switch_mm(mm->pgd, mm);
+		flush_tlb_all();
+	}
+
+	return ret;
+}
+
+extern struct sleep_save_sp sleep_save_sp;
+
+static int cpu_suspend_alloc_sp(void)
+{
+	void *ctx_ptr;
+	/* ctx_ptr is an array of physical addresses */
+	ctx_ptr = kcalloc(mpidr_hash_size(), sizeof(phys_addr_t), GFP_KERNEL);
+
+	if (WARN_ON(!ctx_ptr))
+		return -ENOMEM;
+	sleep_save_sp.save_ptr_stash = ctx_ptr;
+	sleep_save_sp.save_ptr_stash_phys = virt_to_phys(ctx_ptr);
+	__flush_dcache_area(&sleep_save_sp, sizeof(struct sleep_save_sp));
+	return 0;
+}
+early_initcall(cpu_suspend_alloc_sp);
-- 
1.8.3.4
