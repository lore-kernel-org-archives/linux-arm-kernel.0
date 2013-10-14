From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 14 Oct 2013 12:03:01 +0100
Subject: [PATCH v2 04/13] arm64: kernel: cpu_{suspend/resume} implementation
In-Reply-To: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1381748590-14279-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1381748590-14279-5-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kernel subsystems like CPU idle and suspend to RAM require a generic
mechanism to suspend a processor, save its context and put it into
a quiescent state. The cpu_{suspend}/{resume} implementation provides
such a framework through a kernel interface allowing to save/restore
registers, flush the context to DRAM and suspend/resume to/from
low-power states where processor context may be lost.

The CPU suspend implementation relies on the suspend protocol registered
in CPU operations to carry out a suspend request after context is
saved and flushed to DRAM. The cpu_suspend interface:

int cpu_suspend(unsigned long arg);

allows to pass an opaque parameter that is handed over to the suspend CPU
operations back-end so that it can take action according to the
semantics attached to it. The arg parameter allows suspend to RAM and CPU
idle drivers to communicate to suspend protocol back-ends; it requires
standardization so that the interface can be reused seamlessly across
systems, paving the way for generic drivers.

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

The suspend CPU operation, depending on the required operations (eg CPU vs
Cluster shutdown) is in charge of flushing the cache hierarchy either
implicitly (by calling firmware implementations like PSCI) or explicitly
by executing the required cache maintainance functions.

In order to enable the suspend infrastructure for the ARM64 kernel this patch
also adds the necessary Kconfig and Makefile entries.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/Kconfig               |  12 +++
 arch/arm64/include/asm/cpu_ops.h |   6 ++
 arch/arm64/include/asm/suspend.h |   9 ++
 arch/arm64/kernel/Makefile       |   1 +
 arch/arm64/kernel/asm-offsets.c  |  11 +++
 arch/arm64/kernel/sleep.S        | 191 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/kernel/suspend.c      |  93 +++++++++++++++++++
 7 files changed, 323 insertions(+)
 create mode 100644 arch/arm64/kernel/sleep.S
 create mode 100644 arch/arm64/kernel/suspend.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e892003..9d0c8dd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -273,6 +273,18 @@ config SYSVIPC_COMPAT
 
 endmenu
 
+menu "Power management options"
+
+source "kernel/power/Kconfig"
+
+config ARCH_SUSPEND_POSSIBLE
+	def_bool y
+
+config ARM64_CPU_SUSPEND
+	def_bool PM_SLEEP
+
+endmenu
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/arch/arm64/include/asm/cpu_ops.h b/arch/arm64/include/asm/cpu_ops.h
index f53409f..2efacc7 100644
--- a/arch/arm64/include/asm/cpu_ops.h
+++ b/arch/arm64/include/asm/cpu_ops.h
@@ -39,6 +39,9 @@ struct device_node;
  * 		from the cpu to be killed.
  * @cpu_die:	Makes the a leave the kernel. Must not fail. Called from the
  *		cpu being killed.
+ * @cpu_suspend: Suspends a cpu and saves the required context. May fail owing
+ *               to wrong parameters or error conditions. Called from the
+ *               CPU being suspended. Must be called with IRQs disabled.
  */
 struct cpu_operations {
 	const char	*name;
@@ -50,6 +53,9 @@ struct cpu_operations {
 	int		(*cpu_disable)(unsigned int cpu);
 	void		(*cpu_die)(unsigned int cpu);
 #endif
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+	int		(*cpu_suspend)(unsigned long);
+#endif
 };
 
 extern const struct cpu_operations *cpu_ops[NR_CPUS];
diff --git a/arch/arm64/include/asm/suspend.h b/arch/arm64/include/asm/suspend.h
index 2b9f1a9..d41a928 100644
--- a/arch/arm64/include/asm/suspend.h
+++ b/arch/arm64/include/asm/suspend.h
@@ -24,4 +24,13 @@ struct cpu_suspend_ctx {
 	} ctx_regs;
 	u64 sp;
 } __aligned(16);
+
+struct sleep_save_sp {
+	phys_addr_t *save_ptr_stash;
+	phys_addr_t save_ptr_stash_phys;
+};
+
+extern void cpu_resume(void);
+extern int cpu_suspend(unsigned long);
+
 #endif
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 5ba2fd4..1cd339d 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -18,6 +18,7 @@ arm64-obj-$(CONFIG_SMP)			+= smp.o smp_spin_table.o
 arm64-obj-$(CONFIG_HW_PERF_EVENTS)	+= perf_event.o
 arm64-obj-$(CONFIG_HAVE_HW_BREAKPOINT)+= hw_breakpoint.o
 arm64-obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
+arm64-obj-$(CONFIG_ARM64_CPU_SUSPEND)	+= sleep.o suspend.o
 
 obj-y					+= $(arm64-obj-y) vdso/
 obj-m					+= $(arm64-obj-m)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 666e231..646f888 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -25,6 +25,8 @@
 #include <asm/thread_info.h>
 #include <asm/memory.h>
 #include <asm/cputable.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
 #include <asm/vdso_datapage.h>
 #include <linux/kbuild.h>
 
@@ -138,5 +140,14 @@ int main(void)
   DEFINE(KVM_VTTBR,		offsetof(struct kvm, arch.vttbr));
   DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
 #endif
+#ifdef CONFIG_ARM64_CPU_SUSPEND
+  DEFINE(CPU_SUSPEND_SZ,	sizeof(struct cpu_suspend_ctx));
+  DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
+  DEFINE(MPIDR_HASH_MASK,	offsetof(struct mpidr_hash, mask));
+  DEFINE(MPIDR_HASH_SHIFTS,	offsetof(struct mpidr_hash, shift_aff));
+  DEFINE(SLEEP_SAVE_SP_SZ,	sizeof(struct sleep_save_sp));
+  DEFINE(SLEEP_SAVE_SP_PHYS,	offsetof(struct sleep_save_sp, save_ptr_stash_phys));
+  DEFINE(SLEEP_SAVE_SP_VIRT,	offsetof(struct sleep_save_sp, save_ptr_stash));
+#endif
   return 0;
 }
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
new file mode 100644
index 0000000..fded790
--- /dev/null
+++ b/arch/arm64/kernel/sleep.S
@@ -0,0 +1,191 @@
+#include <linux/errno.h>
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
+         (eg: a macro instance with mpidr = x1 and dst = x1 is invalid)
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
+ * Save CPU state for a suspend.  This saves callee registers, and allocates
+ * space on the kernel stack to save the CPU specific registers + some
+ * other data for resume.
+ *
+ *  x0 = suspend finisher argument
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
+	mov	x1, sp
+	/*
+	 * x1 now points to struct cpu_suspend_ctx allocated on the stack
+	 */
+	str	x2, [x1, #CPU_CTX_SP]
+	ldr	x2, =sleep_save_sp
+	ldr	x2, [x2, #SLEEP_SAVE_SP_VIRT]
+#ifdef CONFIG_SMP
+	mrs	x7, mpidr_el1
+	ldr	x9, =mpidr_hash
+	ldr	x10, [x9, #MPIDR_HASH_MASK]
+	/*
+	 * Following code relies on the struct mpidr_hash
+	 * members size.
+	 */
+	ldp	w3, w4, [x9, #MPIDR_HASH_SHIFTS]
+	ldp	w5, w6, [x9, #(MPIDR_HASH_SHIFTS + 8)]
+	compute_mpidr_hash x8, x3, x4, x5, x6, x7, x10
+	add	x2, x2, x8, lsl #3
+#endif
+	bl	__cpu_suspend_finisher
+        /*
+	 * Never gets here, unless suspend fails.
+	 * Successful cpu_suspend should return from cpu_resume, returning
+	 * through this code path is considered an error
+	 * If the return value is set to 0 force x0 = -EOPNOTSUPP
+	 * to make sure a proper error condition is propagated
+	 */
+	cmp	x0, #0
+	mov	x3, #-EOPNOTSUPP
+	csel	x0, x3, x0, eq
+	add	sp, sp, #CPU_SUSPEND_SZ	// rewind stack pointer
+	ldp	x19, x20, [sp, #16]
+	ldp	x21, x22, [sp, #32]
+	ldp	x23, x24, [sp, #48]
+	ldp	x25, x26, [sp, #64]
+	ldp	x27, x28, [sp, #80]
+	ldp	x29, lr, [sp], #96
+	ret
+ENDPROC(__cpu_suspend)
+	.ltorg
+
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
+	adr	x0, sleep_save_sp
+	ldr	x0, [x0, #SLEEP_SAVE_SP_PHYS]
+	ldr	x0, [x0, x7, lsl #3]
+	/* load sp from context */
+	ldr	x2, [x0, #CPU_CTX_SP]
+	adr	x1, sleep_idmap_phys
+	/* load physical address of identity map page table in x1 */
+	ldr	x1, [x1]
+	mov	sp, x2
+	/*
+	 * cpu_do_resume expects x0 to contain context physical address
+	 * pointer and x1 to contain physical address of 1:1 page tables
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
+ * physical address of identity mapped page tables
+ */
+	.type	sleep_idmap_phys, #object
+ENTRY(sleep_idmap_phys)
+	.quad	0
+/*
+ * struct sleep_save_sp {
+ *	phys_addr_t *save_ptr_stash;
+ *	phys_addr_t save_ptr_stash_phys;
+ * };
+ */
+	.type	sleep_save_sp, #object
+ENTRY(sleep_save_sp)
+	.space	SLEEP_SAVE_SP_SZ	// struct sleep_save_sp
diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
new file mode 100644
index 0000000..b9f3592
--- /dev/null
+++ b/arch/arm64/kernel/suspend.c
@@ -0,0 +1,93 @@
+#include <linux/slab.h>
+#include <asm/cacheflush.h>
+#include <asm/cpu_ops.h>
+#include <asm/pgtable.h>
+#include <asm/memory.h>
+#include <asm/smp_plat.h>
+#include <asm/suspend.h>
+#include <asm/tlbflush.h>
+
+extern int __cpu_suspend(unsigned long);
+/*
+ * This is called by __cpu_suspend() to save the state, and do whatever
+ * flushing is required to ensure that when the CPU goes to sleep we have
+ * the necessary data available when the caches are not searched.
+ *
+ * @arg: Argument to pass to suspend operations
+ * @ptr: CPU context virtual address
+ * @save_ptr: address of the location where the context physical address
+ *            must be saved
+ */
+int __cpu_suspend_finisher(unsigned long arg, struct cpu_suspend_ctx *ptr,
+			   phys_addr_t *save_ptr)
+{
+	int cpu = smp_processor_id();
+
+	*save_ptr = virt_to_phys(ptr);
+
+	cpu_do_suspend(ptr);
+	/*
+	 * Only flush the context that must be retrieved with the MMU
+	 * off. VA primitives ensure the flush is applied to all
+	 * cache levels so context is pushed to DRAM.
+	 */
+	__flush_dcache_area(ptr, sizeof(*ptr));
+	__flush_dcache_area(save_ptr, sizeof(*save_ptr));
+
+	return cpu_ops[cpu]->cpu_suspend(arg);
+}
+
+/**
+ * cpu_suspend
+ *
+ * @arg: argument to pass to the finisher function
+ */
+int cpu_suspend(unsigned long arg)
+{
+	struct mm_struct *mm = current->active_mm;
+	int ret, cpu = smp_processor_id();
+
+	/*
+	 * If cpu_ops have not been registered or suspend
+	 * has not been initialized, cpu_suspend call fails early.
+	 */
+	if (!cpu_ops[cpu] || !cpu_ops[cpu]->cpu_suspend)
+		return -EOPNOTSUPP;
+
+	/*
+	 * Save the mm context on the stack, it will be restored when
+	 * the cpu comes out of reset through the identity mapped
+	 * page tables, so that the thread address space is properly
+	 * set-up on function return.
+	 */
+	ret = __cpu_suspend(arg);
+	if (ret == 0) {
+		cpu_switch_mm(mm->pgd, mm);
+		flush_tlb_all();
+	}
+
+	return ret;
+}
+
+extern struct sleep_save_sp sleep_save_sp;
+extern phys_addr_t sleep_idmap_phys;
+
+static int cpu_suspend_init(void)
+{
+	void *ctx_ptr;
+
+	/* ctx_ptr is an array of physical addresses */
+	ctx_ptr = kcalloc(mpidr_hash_size(), sizeof(phys_addr_t), GFP_KERNEL);
+
+	if (WARN_ON(!ctx_ptr))
+		return -ENOMEM;
+
+	sleep_save_sp.save_ptr_stash = ctx_ptr;
+	sleep_save_sp.save_ptr_stash_phys = virt_to_phys(ctx_ptr);
+	sleep_idmap_phys = virt_to_phys(idmap_pg_dir);
+	__flush_dcache_area(&sleep_save_sp, sizeof(struct sleep_save_sp));
+	__flush_dcache_area(&sleep_idmap_phys, sizeof(sleep_idmap_phys));
+
+	return 0;
+}
+early_initcall(cpu_suspend_init);
-- 
1.8.4
