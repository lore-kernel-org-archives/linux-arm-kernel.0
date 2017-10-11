From: julien.thierry@arm.com (Julien Thierry)
Date: Wed, 11 Oct 2017 14:00:59 +0100
Subject: [RFC 4/7] arm64: irqflags: Use ICC sysregs to implement IRQ masking
In-Reply-To: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
References: <1507726862-11944-1-git-send-email-julien.thierry@arm.com>
Message-ID: <1507726862-11944-5-git-send-email-julien.thierry@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Thompson <daniel.thompson@linaro.org>

Currently irqflags is implemented using the PSR's I bit. It is possible
to implement irqflags by using the co-processor interface to the GIC.
Using the co-processor interface makes it feasible to simulate NMIs
using GIC interrupt prioritization.

This patch changes the irqflags macros to modify, save and restore
ICC_PMR_EL1. This has a substantial knock on effect for the rest of
the kernel. There are four reasons for this:

1. The state of the PMR becomes part of the interrupt context and must be
   saved and restored during exceptions. It is saved on the stack as part
   of the saved context when an interrupt/exception is taken.

2. The hardware automatically masks the I bit (at boot, during traps, etc).
   When the I bit is set by hardware we must add code to switch from I
   bit masking and PMR masking:
       - For IRQs, this is done after the interrupt has been acknowledged
       	 avoiding the need to unmask.
       - For other exceptions, this is done right after saving the context.

3. Some instructions, such as wfi, require that the PMR not be used
   for interrupt masking. Before calling these instructions we must
   switch from PMR masking to I bit masking.
   This is also the case when KVM runs a guest, if the CPU receives
   an interrupt from the host, interrupts must not be masked in PMR
   otherwise the GIC will not signal it to the CPU.

4. We use the alternatives system to allow a single kernel to boot and
   be switched to the alternative masking approach at runtime.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
[julien.thierry at arm.com: changes reflected in commit,
			 message, fixes, renaming]
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
---
 arch/arm64/Kconfig                     |  15 ++++
 arch/arm64/include/asm/arch_gicv3.h    |  19 +++++
 arch/arm64/include/asm/assembler.h     |  33 ++++++++-
 arch/arm64/include/asm/efi.h           |   5 ++
 arch/arm64/include/asm/irqflags.h      | 125 +++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h      |  40 +++++++++++
 arch/arm64/include/asm/processor.h     |   4 ++
 arch/arm64/include/asm/ptrace.h        |  14 +++-
 arch/arm64/kernel/asm-offsets.c        |   1 +
 arch/arm64/kernel/entry.S              |  78 ++++++++++++++++----
 arch/arm64/kernel/head.S               |  38 ++++++++++
 arch/arm64/kernel/process.c            |   6 ++
 arch/arm64/kernel/smp.c                |   8 +++
 arch/arm64/mm/proc.S                   |  23 ++++++
 drivers/irqchip/irq-gic-v3-its.c       |   2 +-
 drivers/irqchip/irq-gic-v3.c           |  82 +++++++++++----------
 include/linux/irqchip/arm-gic-common.h |   6 ++
 include/linux/irqchip/arm-gic.h        |   5 --
 18 files changed, 444 insertions(+), 60 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6..269e506 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -803,6 +803,21 @@ config FORCE_MAX_ZONEORDER
 	  However for 4K, we choose a higher default value, 11 as opposed to 10, giving us
 	  4M allocations matching the default size used by generic code.

+config USE_ICC_SYSREGS_FOR_IRQFLAGS
+	bool "Use ICC system registers for IRQ masking"
+	select CONFIG_ARM_GIC_V3
+	help
+	  Using the ICC system registers for IRQ masking makes it possible
+	  to simulate NMI on ARM64 systems. This allows several interesting
+	  features (especially debug features) to be used on these systems.
+
+	  Say Y here to implement IRQ masking using ICC system
+	  registers when the GIC System Registers are available. The changes
+	  are applied dynamically using the alternatives system so it is safe
+	  to enable this option on systems with older interrupt controllers.
+
+	  If unsure, say N
+
 menuconfig ARMV8_DEPRECATED
 	bool "Emulate deprecated/obsolete ARMv8 instructions"
 	depends on COMPAT
diff --git a/arch/arm64/include/asm/arch_gicv3.h b/arch/arm64/include/asm/arch_gicv3.h
index b7e3f74..b6b430c 100644
--- a/arch/arm64/include/asm/arch_gicv3.h
+++ b/arch/arm64/include/asm/arch_gicv3.h
@@ -140,5 +140,24 @@ static inline void gic_write_bpr1(u32 val)
 #define gits_write_vpendbaser(v, c)	writeq_relaxed(v, c)
 #define gits_read_vpendbaser(c)		readq_relaxed(c)

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+static inline void gic_start_pmr_masking(void)
+{
+	if (static_branch_likely(&cpu_hwcap_keys[ARM64_HAS_SYSREG_GIC_CPUIF])) {
+		gic_write_pmr(ICC_PMR_EL1_MASKED);
+		asm volatile ("msr daifclr, #2" : : : "memory");
+	}
+}
+
+static inline void gic_end_pmr_masking(void)
+{
+	if (static_branch_likely(&cpu_hwcap_keys[ARM64_HAS_SYSREG_GIC_CPUIF])) {
+		asm volatile ("msr	daifset, #2" : : : "memory");
+		gic_write_pmr(ICC_PMR_EL1_UNMASKED);
+		dsb(sy);
+	}
+}
+#endif
+
 #endif /* __ASSEMBLY__ */
 #endif /* __ASM_ARCH_GICV3_H */
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index d58a625..33ebe21 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -23,6 +23,8 @@
 #ifndef __ASM_ASSEMBLER_H
 #define __ASM_ASSEMBLER_H

+#include <asm/alternative.h>
+#include <asm/arch_gicv3.h>
 #include <asm/asm-offsets.h>
 #include <asm/cpufeature.h>
 #include <asm/mmu_context.h>
@@ -34,12 +36,32 @@
 /*
  * Enable and disable interrupts.
  */
-	.macro	disable_irq
+	.macro	disable_irq, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mov	\tmp, #ICC_PMR_EL1_MASKED
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
 	msr	daifset, #2
+alternative_else
+	msr_s	SYS_ICC_PMR_EL1, \tmp
+alternative_endif
+#else
+	msr	daifset, #2
+#endif
 	.endm

-	.macro	enable_irq
+	.macro	enable_irq, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	mov     \tmp, #ICC_PMR_EL1_UNMASKED
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
 	msr	daifclr, #2
+	nop
+alternative_else
+	msr_s	SYS_ICC_PMR_EL1, \tmp
+	dsb	sy
+alternative_endif
+#else
+	msr	daifclr, #2
+#endif
 	.endm

 	.macro	save_and_disable_irq, flags
@@ -85,8 +107,13 @@
  * faster than two daifclr operations, since writes to this register
  * are self-synchronising.
  */
-	.macro	enable_dbg_and_irq
+	.macro	enable_dbg_and_irq, tmp
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	enable_dbg
+	enable_irq \tmp
+#else
 	msr	daifclr, #(8 | 2)
+#endif
 	.endm

 /*
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index b93904b..166dd2f 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -39,7 +39,12 @@
 	efi_virtmap_unload();						\
 })

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+#define ARCH_EFI_IRQ_FLAGS_MASK \
+	(PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT | ARCH_FLAG_PMR_EN)
+#else
 #define ARCH_EFI_IRQ_FLAGS_MASK (PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT)
+#endif

 /* arch specific definitions used by the stub code */

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index f367cbd..1c69ebb 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -18,7 +18,12 @@

 #ifdef __KERNEL__

+#include <asm/alternative.h>
+#include <asm/cpufeature.h>
 #include <asm/ptrace.h>
+#include <asm/sysreg.h>
+
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS

 /*
  * CPU interrupt mask handling.
@@ -84,6 +89,126 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 	return flags & PSR_I_BIT;
 }

+static inline void maybe_switch_to_sysreg_gic_cpuif(void) {}
+
+#else /* CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS */
+
+#define ARCH_FLAG_PMR_EN 0x1
+
+#define MAKE_ARCH_FLAGS(daif, pmr)					\
+	((daif) | (((pmr) >> ICC_PMR_EL1_EN_SHIFT) & ARCH_FLAG_PMR_EN))
+
+#define ARCH_FLAGS_GET_PMR(flags)				\
+	((((flags) & ARCH_FLAG_PMR_EN) << ICC_PMR_EL1_EN_SHIFT) \
+		| ICC_PMR_EL1_MASKED)
+
+#define ARCH_FLAGS_GET_DAIF(flags) ((flags) & ~ARCH_FLAG_PMR_EN)
+
+/*
+ * CPU interrupt mask handling.
+ */
+static inline unsigned long arch_local_irq_save(void)
+{
+	unsigned long flags, masked = ICC_PMR_EL1_MASKED;
+	unsigned long pmr = 0;
+
+	asm volatile(ALTERNATIVE(
+		"mrs	%0, daif		// arch_local_irq_save\n"
+		"msr	daifset, #2\n"
+		"mov	%1, #" __stringify(ICC_PMR_EL1_UNMASKED),
+		/* --- */
+		"mrs	%0, daif\n"
+		"mrs_s  %1, " __stringify(SYS_ICC_PMR_EL1) "\n"
+		"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %2",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		: "=&r" (flags), "=&r" (pmr)
+		: "r" (masked)
+		: "memory");
+
+	return MAKE_ARCH_FLAGS(flags, pmr);
+}
+
+static inline void arch_local_irq_enable(void)
+{
+	unsigned long unmasked = ICC_PMR_EL1_UNMASKED;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifclr, #2		// arch_local_irq_enable\n"
+		"nop",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0\n"
+		"dsb	sy",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		:
+		: "r" (unmasked)
+		: "memory");
+}
+
+static inline void arch_local_irq_disable(void)
+{
+	unsigned long masked = ICC_PMR_EL1_MASKED;
+
+	asm volatile(ALTERNATIVE(
+		"msr	daifset, #2		// arch_local_irq_disable",
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%0",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		:
+		: "r" (masked)
+		: "memory");
+}
+
+/*
+ * Save the current interrupt enable state.
+ */
+static inline unsigned long arch_local_save_flags(void)
+{
+	unsigned long flags;
+	unsigned long pmr = 0;
+
+	asm volatile(ALTERNATIVE(
+		"mrs	%0, daif		// arch_local_save_flags\n"
+		"mov	%1, #" __stringify(ICC_PMR_EL1_UNMASKED),
+		"mrs	%0, daif\n"
+		"mrs_s  %1, " __stringify(SYS_ICC_PMR_EL1),
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+		: "=r" (flags), "=r" (pmr)
+		:
+		: "memory");
+
+	return MAKE_ARCH_FLAGS(flags, pmr);
+}
+
+/*
+ * restore saved IRQ state
+ */
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	unsigned long pmr = ARCH_FLAGS_GET_PMR(flags);
+
+	flags = ARCH_FLAGS_GET_DAIF(flags);
+
+	asm volatile(ALTERNATIVE(
+		"msr	daif, %0		// arch_local_irq_restore\n"
+		"nop\n"
+		"nop",
+		"msr	daif, %0\n"
+		"msr_s  " __stringify(SYS_ICC_PMR_EL1) ",%1\n"
+		"dsb	sy",
+		ARM64_HAS_SYSREG_GIC_CPUIF)
+	:
+	: "r" (flags), "r" (pmr)
+	: "memory");
+}
+
+static inline int arch_irqs_disabled_flags(unsigned long flags)
+{
+	return (ARCH_FLAGS_GET_DAIF(flags) & (PSR_I_BIT)) |
+		!(ARCH_FLAGS_GET_PMR(flags) & ICC_PMR_EL1_EN_BIT);
+}
+
+void maybe_switch_to_sysreg_gic_cpuif(void);
+
+#endif /* CONFIG_IRQFLAGS_GIC_MASKING */
+
 #define local_fiq_enable()	asm("msr	daifclr, #1" : : : "memory")
 #define local_fiq_disable()	asm("msr	daifset, #1" : : : "memory")

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e923b58..070e8a5 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -38,6 +38,10 @@
 #include <kvm/arm_arch_timer.h>
 #include <kvm/arm_pmu.h>

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+#include <asm/arch_gicv3.h>
+#endif
+
 #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS

 #define KVM_VCPU_MAX_FEATURES 4
@@ -332,7 +336,30 @@ int kvm_unmap_hva_range(struct kvm *kvm,
 void kvm_arm_resume_guest(struct kvm *kvm);

 u64 __kvm_call_hyp(void *hypfn, ...);
+
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+/*
+ * If we use PMR to disable interrupts, interrupts happening while the
+ * guest is executing will not be signaled to the host by the GIC  (and
+ * any call to a waiting kvm_kick_many_cpus will likely cause a
+ * deadlock).
+ * We need to switch back to using PSR.I.
+ */
+#define kvm_call_hyp(f, ...)						\
+	({								\
+		u64 res;						\
+		unsigned long flags;					\
+									\
+		flags = arch_local_irq_save();				\
+		gic_end_pmr_masking();					\
+		res = __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__);	\
+		gic_start_pmr_masking();				\
+		arch_local_irq_restore(flags);				\
+		res;							\
+	})
+#else
 #define kvm_call_hyp(f, ...) __kvm_call_hyp(kvm_ksym_ref(f), ##__VA_ARGS__)
+#endif

 void force_vm_exit(const cpumask_t *mask);
 void kvm_mmu_wp_memory_region(struct kvm *kvm, int slot);
@@ -349,6 +376,9 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 				       unsigned long hyp_stack_ptr,
 				       unsigned long vector_ptr)
 {
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	unsigned long flags;
+#endif
 	/*
 	 * Call initialization code, and switch to the full blown HYP code.
 	 * If the cpucaps haven't been finalized yet, something has gone very
@@ -356,7 +386,17 @@ static inline void __cpu_init_hyp_mode(phys_addr_t pgd_ptr,
 	 * cpus_have_const_cap() wrapper.
 	 */
 	BUG_ON(!static_branch_likely(&arm64_const_caps_ready));
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	flags = arch_local_irq_save();
+	gic_end_pmr_masking();
+#endif
+
 	__kvm_call_hyp((void *)pgd_ptr, hyp_stack_ptr, vector_ptr);
+
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	gic_start_pmr_masking();
+	arch_local_irq_restore(flags);
+#endif
 }

 static inline void kvm_arch_hardware_unsetup(void) {}
diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index 29adab8..2a871f6 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -114,6 +114,10 @@ static inline void start_thread_common(struct pt_regs *regs, unsigned long pc)
 	memset(regs, 0, sizeof(*regs));
 	forget_syscall(regs);
 	regs->pc = pc;
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/* Have IRQs enabled by default */
+	regs->pmr_save = ICC_PMR_EL1_UNMASKED;
+#endif
 }

 static inline void start_thread(struct pt_regs *regs, unsigned long pc,
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 6069d66..aa1e948 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -25,6 +25,12 @@
 #define CurrentEL_EL1		(1 << 2)
 #define CurrentEL_EL2		(2 << 2)

+/* PMR values used to mask/unmask interrupts */
+#define ICC_PMR_EL1_EN_SHIFT	6
+#define ICC_PMR_EL1_EN_BIT	(1 << ICC_PMR_EL1_EN_SHIFT) // PMR IRQ enable
+#define ICC_PMR_EL1_UNMASKED    0xf0
+#define ICC_PMR_EL1_MASKED      (ICC_PMR_EL1_UNMASKED ^ ICC_PMR_EL1_EN_BIT)
+
 /* AArch32-specific ptrace requests */
 #define COMPAT_PTRACE_GETREGS		12
 #define COMPAT_PTRACE_SETREGS		13
@@ -136,7 +142,7 @@ struct pt_regs {
 #endif

 	u64 orig_addr_limit;
-	u64 unused;	// maintain 16 byte alignment
+	u64 pmr_save;
 	u64 stackframe[2];
 };

@@ -171,8 +177,14 @@ static inline void forget_syscall(struct pt_regs *regs)
 #define processor_mode(regs) \
 	((regs)->pstate & PSR_MODE_MASK)

+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 #define interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_I_BIT))
+#else
+#define interrupts_enabled(regs)	    \
+	((!((regs)->pstate & PSR_I_BIT)) && \
+	 ((regs)->pmr_save & ICC_PMR_EL1_EN_BIT))
+#endif

 #define fast_interrupts_enabled(regs) \
 	(!((regs)->pstate & PSR_F_BIT))
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 71bf088..6b00b0d 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -75,6 +75,7 @@ int main(void)
   DEFINE(S_ORIG_X0,		offsetof(struct pt_regs, orig_x0));
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
   DEFINE(S_ORIG_ADDR_LIMIT,	offsetof(struct pt_regs, orig_addr_limit));
+  DEFINE(S_PMR_SAVE,		offsetof(struct pt_regs, pmr_save));
   DEFINE(S_STACKFRAME,		offsetof(struct pt_regs, stackframe));
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index e1c59d4..1933fea 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -20,6 +20,7 @@

 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>

 #include <asm/alternative.h>
 #include <asm/assembler.h>
@@ -210,6 +211,16 @@ alternative_else_nop_endif
 	msr	sp_el0, tsk
 	.endif

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/* Save pmr */
+alternative_if ARM64_HAS_SYSREG_GIC_CPUIF
+	mrs_s	x20, SYS_ICC_PMR_EL1
+alternative_else
+	mov	x20, #ICC_PMR_EL1_UNMASKED
+alternative_endif
+	str	x20, [sp, #S_PMR_SAVE]
+#endif
+
 	/*
 	 * Registers that may be useful after this macro is invoked:
 	 *
@@ -220,6 +231,16 @@ alternative_else_nop_endif
 	.endm

 	.macro	kernel_exit, el
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/* Restore pmr, ensuring IRQs are off before restoring context. */
+alternative_if ARM64_HAS_SYSREG_GIC_CPUIF
+	msr	daifset, #2
+	ldr	x20, [sp, #S_PMR_SAVE]
+	msr_s	SYS_ICC_PMR_EL1, x20
+	dsb	sy
+alternative_else_nop_endif
+#endif
+
 	.if	\el != 0
 	/* Restore the task's original addr_limit. */
 	ldr	x20, [sp, #S_ORIG_ADDR_LIMIT]
@@ -333,6 +354,19 @@ alternative_else_nop_endif
 	mov	sp, x19
 	.endm

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	/*
+	 * pmr_irq_mask_start
+	 */
+	.macro	pmr_irq_mask_start, tmp
+	alternative_if ARM64_HAS_SYSREG_GIC_CPUIF
+	mov	\tmp, #ICC_PMR_EL1_MASKED
+	msr_s	SYS_ICC_PMR_EL1, \tmp
+	msr	daifclr, #2
+	alternative_else_nop_endif
+	.endm
+#endif
+
 /*
  * These are the registers used in the syscall handler, and allow us to
  * have in theory up to 7 arguments to a function - x0 to x6.
@@ -426,6 +460,9 @@ __bad_stack:
  */
 	.macro	inv_entry, el, reason, regsize = 64
 	kernel_entry \el, \regsize
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	pmr_irq_mask_start x9
+#endif
 	mov	x0, sp
 	mov	x1, #\reason
 	mrs	x2, esr_el1
@@ -481,6 +518,9 @@ ENDPROC(el1_error_invalid)
 	.align	6
 el1_sync:
 	kernel_entry 1
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	pmr_irq_mask_start x9
+#endif
 	mrs	x1, esr_el1			// read the syndrome register
 	lsr	x24, x1, #ESR_ELx_EC_SHIFT	// exception class
 	cmp	x24, #ESR_ELx_EC_DABT_CUR	// data abort in EL1
@@ -510,15 +550,23 @@ el1_da:
 	mrs	x3, far_el1
 	enable_dbg
 	// re-enable interrupts if they were enabled in the aborted context
-	tbnz	x23, #7, 1f			// PSR_I_BIT
-	enable_irq
+	tbnz	x23, #7, el1_keep_irq_off	// PSR_I_BIT
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_if ARM64_HAS_SYSREG_GIC_CPUIF
+	ldr	x2, [sp, #S_PMR_SAVE]
+	tbnz	x2, #ICC_PMR_EL1_EN_SHIFT, 1f
+	b	el1_keep_irq_off
 1:
+alternative_else_nop_endif
+#endif
+	enable_irq x2
+el1_keep_irq_off:
 	clear_address_tag x0, x3
 	mov	x2, sp				// struct pt_regs
 	bl	do_mem_abort

 	// disable interrupts before pulling preserved data off the stack
-	disable_irq
+	disable_irq x21
 	kernel_exit 1
 el1_sp_pc:
 	/*
@@ -597,6 +645,9 @@ el1_preempt:
 	.align	6
 el0_sync:
 	kernel_entry 0
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	pmr_irq_mask_start x9
+#endif
 	mrs	x25, esr_el1			// read the syndrome register
 	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
 	cmp	x24, #ESR_ELx_EC_SVC64		// SVC in 64-bit state
@@ -625,6 +676,9 @@ el0_sync:
 	.align	6
 el0_sync_compat:
 	kernel_entry 0, 32
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	pmr_irq_mask_start x9
+#endif
 	mrs	x25, esr_el1			// read the syndrome register
 	lsr	x24, x25, #ESR_ELx_EC_SHIFT	// exception class
 	cmp	x24, #ESR_ELx_EC_SVC32		// SVC in 32-bit state
@@ -675,7 +729,7 @@ el0_da:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_dbg_and_irq x0
 	ct_user_exit
 	clear_address_tag x0, x26
 	mov	x1, x25
@@ -688,7 +742,7 @@ el0_ia:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
@@ -721,7 +775,7 @@ el0_sp_pc:
 	 */
 	mrs	x26, far_el1
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, x26
 	mov	x1, x25
@@ -733,7 +787,7 @@ el0_undef:
 	 * Undefined instruction
 	 */
 	// enable interrupts before calling the main handler
-	enable_dbg_and_irq
+	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, sp
 	bl	do_undefinstr
@@ -742,7 +796,7 @@ el0_sys:
 	/*
 	 * System instructions, for trapped cache maintenance instructions
 	 */
-	enable_dbg_and_irq
+	enable_dbg_and_irq x0
 	ct_user_exit
 	mov	x0, x25
 	mov	x1, sp
@@ -793,7 +847,7 @@ ENDPROC(el0_irq)
  * and this includes saving x0 back into the kernel stack.
  */
 ret_fast_syscall:
-	disable_irq				// disable interrupts
+	disable_irq x21				// disable interrupts
 	str	x0, [sp, #S_X0]			// returned x0
 	ldr	x1, [tsk, #TSK_TI_FLAGS]	// re-check for syscall tracing
 	and	x2, x1, #_TIF_SYSCALL_WORK
@@ -803,7 +857,7 @@ ret_fast_syscall:
 	enable_step_tsk x1, x2
 	kernel_exit 0
 ret_fast_syscall_trace:
-	enable_irq				// enable interrupts
+	enable_irq x0				// enable interrupts
 	b	__sys_trace_return_skipped	// we already saved x0

 /*
@@ -821,7 +875,7 @@ work_pending:
  * "slow" syscall return path.
  */
 ret_to_user:
-	disable_irq				// disable interrupts
+	disable_irq x21				// disable interrupts
 	ldr	x1, [tsk, #TSK_TI_FLAGS]
 	and	x2, x1, #_TIF_WORK_MASK
 	cbnz	x2, work_pending
@@ -840,7 +894,7 @@ el0_svc:
 	mov	wsc_nr, #__NR_syscalls
 el0_svc_naked:					// compat entry point
 	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
-	enable_dbg_and_irq
+	enable_dbg_and_irq x16
 	ct_user_exit 1

 	ldr	x16, [tsk, #TSK_TI_FLAGS]	// check for syscall hooks
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0b243ec..2ee06dd 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -545,6 +545,44 @@ set_cpu_boot_mode_flag:
 	ret
 ENDPROC(set_cpu_boot_mode_flag)

+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+/*
+ * void maybe_switch_to_sysreg_gic_cpuif(void)
+ *
+ * Enable interrupt controller system register access if this feature
+ * has been detected by the alternatives system.
+ *
+ * Before we jump into generic code we must enable interrupt controller system
+ * register access because this is required by the irqflags macros.  We must
+ * also mask interrupts at the PMR and unmask them within the PSR. That leaves
+ * us set up and ready for the kernel to make its first call to
+ * arch_local_irq_enable().
+
+ *
+ */
+ENTRY(maybe_switch_to_sysreg_gic_cpuif)
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	b	1f
+alternative_else
+	mrs_s	x0, SYS_ICC_SRE_EL1
+alternative_endif
+	orr	x0, x0, #1
+	msr_s	SYS_ICC_SRE_EL1, x0	// Set ICC_SRE_EL1.SRE==1
+	isb				// Make sure SRE is now set
+	mrs	x0, daif
+	tbz	x0, #7, no_mask_pmr	// Are interrupts on?
+	mov	x0, ICC_PMR_EL1_MASKED
+	msr_s	SYS_ICC_PMR_EL1, x0	// Prepare for unmask of I bit
+	msr	daifclr, #2		// Clear the I bit
+	b	1f
+no_mask_pmr:
+	mov	x0, ICC_PMR_EL1_UNMASKED
+	msr_s	SYS_ICC_PMR_EL1, x0
+1:
+	ret
+ENDPROC(maybe_switch_to_sysreg_gic_cpuif)
+#endif
+
 /*
  * These values are written with the MMU off, but read with the MMU on.
  * Writers will invalidate the corresponding address, discarding up to a
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 2dc0f84..6e1f4e8 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -65,6 +65,8 @@
 EXPORT_SYMBOL(__stack_chk_guard);
 #endif

+#include <asm/arch_gicv3.h>
+
 /*
  * Function pointers to optional machine specific functions
  */
@@ -191,6 +193,7 @@ void __show_regs(struct pt_regs *regs)
 	printk("pc : [<%016llx>] lr : [<%016llx>] pstate: %08llx\n",
 	       regs->pc, lr, regs->pstate);
 	printk("sp : %016llx\n", sp);
+	printk("pmr_save: %08llx\n", regs->pmr_save);

 	i = top_reg;

@@ -284,6 +287,9 @@ int copy_thread(unsigned long clone_flags, unsigned long stack_start,
 	} else {
 		memset(childregs, 0, sizeof(struct pt_regs));
 		childregs->pstate = PSR_MODE_EL1h;
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+		childregs->pmr_save = ICC_PMR_EL1_UNMASKED;
+#endif
 		if (IS_ENABLED(CONFIG_ARM64_UAO) &&
 		    cpus_have_const_cap(ARM64_HAS_UAO))
 			childregs->pstate |= PSR_UAO_BIT;
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 84c6983..401fc8e 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -219,6 +219,8 @@ asmlinkage void secondary_start_kernel(void)
 	struct mm_struct *mm = &init_mm;
 	unsigned int cpu;

+	maybe_switch_to_sysreg_gic_cpuif();
+
 	cpu = task_cpu(current);
 	set_my_cpu_offset(per_cpu_offset(cpu));

@@ -461,6 +463,12 @@ void __init smp_prepare_boot_cpu(void)
 	 * and/or scheduling is enabled.
 	 */
 	apply_alternatives_early();
+
+	/*
+	 * Conditionally switch to GIC PMR for interrupt masking (this
+	 * will be a nop if we are using normal interrupt masking)
+	 */
+	maybe_switch_to_sysreg_gic_cpuif();
 }

 static u64 __init of_get_cpu_mpidr(struct device_node *dn)
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 877d42f..111d6f4 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -20,6 +20,7 @@

 #include <linux/init.h>
 #include <linux/linkage.h>
+#include <linux/irqchip/arm-gic-v3.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
 #include <asm/hwcap.h>
@@ -47,11 +48,33 @@
  *	cpu_do_idle()
  *
  *	Idle the processor (wait for interrupt).
+ *
+ *	If CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS is set we must do additional
+ *	work to ensure that interrupts are not masked at the PMR (because the
+ *	core will not wake up if we block the wake up signal in the interrupt
+ *	controller).
  */
 ENTRY(cpu_do_idle)
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+#endif
+	dsb	sy				// WFI may enter a low-power mode
+	wfi
+	ret
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+alternative_else
+	mrs	x0, daif			// save I bit
+	msr	daifset, #2			// set I bit
+	mrs_s	x1, SYS_ICC_PMR_EL1		// save PMR
+alternative_endif
+	mov	x2, #ICC_PMR_EL1_UNMASKED
+	msr_s	SYS_ICC_PMR_EL1, x2		// unmask at PMR
 	dsb	sy				// WFI may enter a low-power mode
 	wfi
+	msr_s	SYS_ICC_PMR_EL1, x1		// restore PMR
+	msr	daif, x0			// restore I bit
 	ret
+#endif
 ENDPROC(cpu_do_idle)

 #ifdef CONFIG_CPU_PM
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index e8d8934..a72f7c4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -60,7 +60,7 @@
 #define LPI_PROPBASE_SZ		ALIGN(BIT(LPI_NRBITS), SZ_64K)
 #define LPI_PENDBASE_SZ		ALIGN(BIT(LPI_NRBITS) / 8, SZ_64K)

-#define LPI_PROP_DEFAULT_PRIO	0xa0
+#define LPI_PROP_DEFAULT_PRIO	GICD_INT_DEF_PRI

 /*
  * Collection structure - just an ID, and a redistributor address to
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b5df99c..1cdf495 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -68,9 +68,6 @@ struct gic_chip_data {
 #define gic_data_rdist_rd_base()	(gic_data_rdist()->rd_base)
 #define gic_data_rdist_sgi_base()	(gic_data_rdist_rd_base() + SZ_64K)

-/* Our default, arbitrary priority value. Linux only uses one anyway. */
-#define DEFAULT_PMR_VALUE	0xf0
-
 static inline unsigned int gic_irq(struct irq_data *d)
 {
 	return d->hwirq;
@@ -345,48 +342,55 @@ static asmlinkage void __exception_irq_entry gic_handle_irq(struct pt_regs *regs
 {
 	u32 irqnr;

-	do {
-		irqnr = gic_read_iar();
+	irqnr = gic_read_iar();
+
+#ifdef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+	isb();
+	/* Masking IRQs earlier would prevent to ack the current interrupt */
+	gic_start_pmr_masking();
+#endif
+
+	if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
+		int err;

-		if (likely(irqnr > 15 && irqnr < 1020) || irqnr >= 8192) {
-			int err;
+		if (static_key_true(&supports_deactivate))
+			gic_write_eoir(irqnr);
+		else {
+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
+			isb();
+#endif
+		}

-			if (static_key_true(&supports_deactivate))
+		err = handle_domain_irq(gic_data.domain, irqnr, regs);
+		if (err) {
+			WARN_ONCE(true, "Unexpected interrupt received!\n");
+			if (static_key_true(&supports_deactivate)) {
+				if (irqnr < 8192)
+					gic_write_dir(irqnr);
+			} else {
 				gic_write_eoir(irqnr);
-			else
-				isb();
-
-			err = handle_domain_irq(gic_data.domain, irqnr, regs);
-			if (err) {
-				WARN_ONCE(true, "Unexpected interrupt received!\n");
-				if (static_key_true(&supports_deactivate)) {
-					if (irqnr < 8192)
-						gic_write_dir(irqnr);
-				} else {
-					gic_write_eoir(irqnr);
-				}
 			}
-			continue;
 		}
-		if (irqnr < 16) {
-			gic_write_eoir(irqnr);
-			if (static_key_true(&supports_deactivate))
-				gic_write_dir(irqnr);
+		return;
+	}
+	if (irqnr < 16) {
+		gic_write_eoir(irqnr);
+		if (static_key_true(&supports_deactivate))
+			gic_write_dir(irqnr);
 #ifdef CONFIG_SMP
-			/*
-			 * Unlike GICv2, we don't need an smp_rmb() here.
-			 * The control dependency from gic_read_iar to
-			 * the ISB in gic_write_eoir is enough to ensure
-			 * that any shared data read by handle_IPI will
-			 * be read after the ACK.
-			 */
-			handle_IPI(irqnr, regs);
+		/*
+		 * Unlike GICv2, we don't need an smp_rmb() here.
+		 * The control dependency from gic_read_iar to
+		 * the ISB in gic_write_eoir is enough to ensure
+		 * that any shared data read by handle_IPI will
+		 * be read after the ACK.
+		 */
+		handle_IPI(irqnr, regs);
 #else
-			WARN_ONCE(true, "Unexpected SGI received!\n");
+		WARN_ONCE(true, "Unexpected SGI received!\n");
 #endif
-			continue;
-		}
-	} while (irqnr != ICC_IAR1_EL1_SPURIOUS);
+		return;
+	}
 }

 static void __init gic_dist_init(void)
@@ -536,8 +540,10 @@ static void gic_cpu_sys_reg_init(void)
 	if (!gic_enable_sre())
 		pr_err("GIC: unable to set SRE (disabled@EL2), panic ahead\n");

+#ifndef CONFIG_USE_ICC_SYSREGS_FOR_IRQFLAGS
 	/* Set priority mask register */
-	gic_write_pmr(DEFAULT_PMR_VALUE);
+	gic_write_pmr(ICC_PMR_EL1_UNMASKED);
+#endif

 	/*
 	 * Some firmwares hand over to the kernel with the BPR changed from
diff --git a/include/linux/irqchip/arm-gic-common.h b/include/linux/irqchip/arm-gic-common.h
index 0a83b43..2c9a4b3 100644
--- a/include/linux/irqchip/arm-gic-common.h
+++ b/include/linux/irqchip/arm-gic-common.h
@@ -13,6 +13,12 @@
 #include <linux/types.h>
 #include <linux/ioport.h>

+#define GICD_INT_DEF_PRI		0xc0
+#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
+					(GICD_INT_DEF_PRI << 16) |\
+					(GICD_INT_DEF_PRI << 8) |\
+					GICD_INT_DEF_PRI)
+
 enum gic_type {
 	GIC_V2,
 	GIC_V3,
diff --git a/include/linux/irqchip/arm-gic.h b/include/linux/irqchip/arm-gic.h
index d3453ee..47f5a8c 100644
--- a/include/linux/irqchip/arm-gic.h
+++ b/include/linux/irqchip/arm-gic.h
@@ -65,11 +65,6 @@
 #define GICD_INT_EN_CLR_X32		0xffffffff
 #define GICD_INT_EN_SET_SGI		0x0000ffff
 #define GICD_INT_EN_CLR_PPI		0xffff0000
-#define GICD_INT_DEF_PRI		0xa0
-#define GICD_INT_DEF_PRI_X4		((GICD_INT_DEF_PRI << 24) |\
-					(GICD_INT_DEF_PRI << 16) |\
-					(GICD_INT_DEF_PRI << 8) |\
-					GICD_INT_DEF_PRI)

 #define GICH_HCR			0x0
 #define GICH_VTR			0x4
--
1.9.1
