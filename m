From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 16 Jan 2013 12:58:39 -0500
Subject: [PATCH v6 08/15] KVM: ARM: Emulation framework and CP15 emulation
In-Reply-To: <20130116175716.29147.15348.stgit@ubuntu>
References: <20130116175716.29147.15348.stgit@ubuntu>
Message-ID: <20130116175838.29147.32494.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds a new important function in the main KVM/ARM code called
handle_exit() which is called from kvm_arch_vcpu_ioctl_run() on returns
from guest execution. This function examines the Hyp-Syndrome-Register
(HSR), which contains information telling KVM what caused the exit from
the guest.

Some of the reasons for an exit are CP15 accesses, which are
not allowed from the guest and this commit handles these exits by
emulating the intended operation in software and skipping the guest
instruction.

Minor notes about the coproc register reset:
1) We reserve a value of 0 as an invalid cp15 offset, to catch bugs in our
   table, at cost of 4 bytes per vcpu.

2) Added comments on the table indicating how we handle each register, for
   simplicity of understanding.

Reviewed-by: Will Deacon <will.deacon@arm.com>
Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>
---
 arch/arm/include/asm/kvm_arm.h     |   11 +
 arch/arm/include/asm/kvm_coproc.h  |   14 +
 arch/arm/include/asm/kvm_emulate.h |    6 +
 arch/arm/include/asm/kvm_host.h    |    4 
 arch/arm/kvm/Makefile              |    2 
 arch/arm/kvm/arm.c                 |  168 +++++++++++++++++
 arch/arm/kvm/coproc.c              |  360 ++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/coproc.h              |  153 +++++++++++++++
 arch/arm/kvm/coproc_a15.c          |  162 ++++++++++++++++
 arch/arm/kvm/emulate.c             |  218 ++++++++++++++++++++++
 arch/arm/kvm/trace.h               |   65 +++++++
 11 files changed, 1159 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/kvm/coproc.h
 create mode 100644 arch/arm/kvm/coproc_a15.c

diff --git a/arch/arm/include/asm/kvm_arm.h b/arch/arm/include/asm/kvm_arm.h
index c69936b..9a34c20 100644
--- a/arch/arm/include/asm/kvm_arm.h
+++ b/arch/arm/include/asm/kvm_arm.h
@@ -70,6 +70,11 @@
 			HCR_SWIO | HCR_TIDCP)
 #define HCR_VIRT_EXCP_MASK (HCR_VA | HCR_VI | HCR_VF)
 
+/* System Control Register (SCTLR) bits */
+#define SCTLR_TE	(1 << 30)
+#define SCTLR_EE	(1 << 25)
+#define SCTLR_V		(1 << 13)
+
 /* Hyp System Control Register (HSCTLR) bits */
 #define HSCTLR_TE	(1 << 30)
 #define HSCTLR_EE	(1 << 25)
@@ -171,6 +176,10 @@
 #define HSR_FSC		(0x3f)
 #define HSR_FSC_TYPE	(0x3c)
 #define HSR_WNR		(1 << 6)
+#define HSR_CV_SHIFT	(24)
+#define HSR_CV		(1U << HSR_CV_SHIFT)
+#define HSR_COND_SHIFT	(20)
+#define HSR_COND	(0xfU << HSR_COND_SHIFT)
 
 #define FSC_FAULT	(0x04)
 #define FSC_PERM	(0x0c)
@@ -197,4 +206,6 @@
 #define HSR_EC_DABT	(0x24)
 #define HSR_EC_DABT_HYP	(0x25)
 
+#define HSR_HVC_IMM_MASK	((1UL << 16) - 1)
+
 #endif /* __ARM_KVM_ARM_H__ */
diff --git a/arch/arm/include/asm/kvm_coproc.h b/arch/arm/include/asm/kvm_coproc.h
index b6d023d..bd1ace0 100644
--- a/arch/arm/include/asm/kvm_coproc.h
+++ b/arch/arm/include/asm/kvm_coproc.h
@@ -21,4 +21,18 @@
 
 void kvm_reset_coprocs(struct kvm_vcpu *vcpu);
 
+struct kvm_coproc_target_table {
+	unsigned target;
+	const struct coproc_reg *table;
+	size_t num;
+};
+void kvm_register_target_coproc_table(struct kvm_coproc_target_table *table);
+
+int kvm_handle_cp10_id(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_handle_cp_0_13_access(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_handle_cp14_access(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run);
+int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run);
+void kvm_coproc_table_init(void);
 #endif /* __ARM_KVM_COPROC_H__ */
diff --git a/arch/arm/include/asm/kvm_emulate.h b/arch/arm/include/asm/kvm_emulate.h
index 17dad67..01a755b 100644
--- a/arch/arm/include/asm/kvm_emulate.h
+++ b/arch/arm/include/asm/kvm_emulate.h
@@ -25,6 +25,12 @@
 u32 *vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num);
 u32 *vcpu_spsr(struct kvm_vcpu *vcpu);
 
+int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run);
+void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr);
+void kvm_inject_undefined(struct kvm_vcpu *vcpu);
+void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
+void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
+
 static inline u32 *vcpu_pc(struct kvm_vcpu *vcpu)
 {
 	return (u32 *)&vcpu->arch.regs.usr_regs.ARM_pc;
diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 7a12108..e1d4168 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -94,6 +94,10 @@ struct kvm_vcpu_arch {
 	 * Anything that is not used directly from assembly code goes
 	 * here.
 	 */
+	/* dcache set/way operation pending */
+	int last_pcpu;
+	cpumask_t require_dcache_flush;
+
 	/* Interrupt related fields */
 	u32 irq_lines;		/* IRQ and FIQ levels */
 
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index dfc293f..88edce6 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -18,4 +18,4 @@ kvm-arm-y = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
 
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o guest.o mmu.o emulate.o reset.o
-obj-y += coproc.o
+obj-y += coproc.o coproc_a15.o
diff --git a/arch/arm/kvm/arm.c b/arch/arm/kvm/arm.c
index 9e9fa44..875c63e 100644
--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -36,11 +36,14 @@
 #include <asm/mman.h>
 #include <asm/cputype.h>
 #include <asm/tlbflush.h>
+#include <asm/cacheflush.h>
 #include <asm/virt.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_asm.h>
 #include <asm/kvm_mmu.h>
 #include <asm/kvm_emulate.h>
+#include <asm/kvm_coproc.h>
+#include <asm/opcodes.h>
 
 #ifdef REQUIRES_VIRT
 __asm__(".arch_extension	virt");
@@ -294,6 +297,15 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
 	vcpu->cpu = cpu;
 	vcpu->arch.vfp_host = this_cpu_ptr(kvm_host_vfp_state);
+
+	/*
+	 * Check whether this vcpu requires the cache to be flushed on
+	 * this physical CPU. This is a consequence of doing dcache
+	 * operations by set/way on this vcpu. We do it here to be in
+	 * a non-preemptible section.
+	 */
+	if (cpumask_test_and_clear_cpu(cpu, &vcpu->arch.require_dcache_flush))
+		flush_cache_all(); /* We'd really want v7_flush_dcache_all() */
 }
 
 void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
@@ -319,9 +331,16 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
+/**
+ * kvm_arch_vcpu_runnable - determine if the vcpu can be scheduled
+ * @v:		The VCPU pointer
+ *
+ * If the guest CPU is not waiting for interrupts or an interrupt line is
+ * asserted, the CPU is by definition runnable.
+ */
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
 {
-	return 0;
+	return !!v->arch.irq_lines;
 }
 
 /* Just ensure a guest exit from a particular CPU */
@@ -411,6 +430,109 @@ static void update_vttbr(struct kvm *kvm)
 	spin_unlock(&kvm_vmid_lock);
 }
 
+static int handle_svc_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/* SVC called from Hyp mode should never get here */
+	kvm_debug("SVC called from Hyp mode shouldn't go here\n");
+	BUG();
+	return -EINVAL; /* Squash warning */
+}
+
+static int handle_hvc(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	trace_kvm_hvc(*vcpu_pc(vcpu), *vcpu_reg(vcpu, 0),
+		      vcpu->arch.hsr & HSR_HVC_IMM_MASK);
+
+	return 1;
+}
+
+static int handle_smc(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/* We don't support SMC; don't do that. */
+	kvm_debug("smc: at %08x", *vcpu_pc(vcpu));
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+static int handle_pabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/* The hypervisor should never cause aborts */
+	kvm_err("Prefetch Abort taken from Hyp mode at %#08x (HSR: %#08x)\n",
+		vcpu->arch.hxfar, vcpu->arch.hsr);
+	return -EFAULT;
+}
+
+static int handle_dabt_hyp(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/* This is either an error in the ws. code or an external abort */
+	kvm_err("Data Abort taken from Hyp mode at %#08x (HSR: %#08x)\n",
+		vcpu->arch.hxfar, vcpu->arch.hsr);
+	return -EFAULT;
+}
+
+typedef int (*exit_handle_fn)(struct kvm_vcpu *, struct kvm_run *);
+static exit_handle_fn arm_exit_handlers[] = {
+	[HSR_EC_WFI]		= kvm_handle_wfi,
+	[HSR_EC_CP15_32]	= kvm_handle_cp15_32,
+	[HSR_EC_CP15_64]	= kvm_handle_cp15_64,
+	[HSR_EC_CP14_MR]	= kvm_handle_cp14_access,
+	[HSR_EC_CP14_LS]	= kvm_handle_cp14_load_store,
+	[HSR_EC_CP14_64]	= kvm_handle_cp14_access,
+	[HSR_EC_CP_0_13]	= kvm_handle_cp_0_13_access,
+	[HSR_EC_CP10_ID]	= kvm_handle_cp10_id,
+	[HSR_EC_SVC_HYP]	= handle_svc_hyp,
+	[HSR_EC_HVC]		= handle_hvc,
+	[HSR_EC_SMC]		= handle_smc,
+	[HSR_EC_IABT]		= kvm_handle_guest_abort,
+	[HSR_EC_IABT_HYP]	= handle_pabt_hyp,
+	[HSR_EC_DABT]		= kvm_handle_guest_abort,
+	[HSR_EC_DABT_HYP]	= handle_dabt_hyp,
+};
+
+/*
+ * A conditional instruction is allowed to trap, even though it
+ * wouldn't be executed.  So let's re-implement the hardware, in
+ * software!
+ */
+static bool kvm_condition_valid(struct kvm_vcpu *vcpu)
+{
+	unsigned long cpsr, cond, insn;
+
+	/*
+	 * Exception Code 0 can only happen if we set HCR.TGE to 1, to
+	 * catch undefined instructions, and then we won't get past
+	 * the arm_exit_handlers test anyway.
+	 */
+	BUG_ON(((vcpu->arch.hsr & HSR_EC) >> HSR_EC_SHIFT) == 0);
+
+	/* Top two bits non-zero?  Unconditional. */
+	if (vcpu->arch.hsr >> 30)
+		return true;
+
+	cpsr = *vcpu_cpsr(vcpu);
+
+	/* Is condition field valid? */
+	if ((vcpu->arch.hsr & HSR_CV) >> HSR_CV_SHIFT)
+		cond = (vcpu->arch.hsr & HSR_COND) >> HSR_COND_SHIFT;
+	else {
+		/* This can happen in Thumb mode: examine IT state. */
+		unsigned long it;
+
+		it = ((cpsr >> 8) & 0xFC) | ((cpsr >> 25) & 0x3);
+
+		/* it == 0 => unconditional. */
+		if (it == 0)
+			return true;
+
+		/* The cond for this insn works out as the top 4 bits. */
+		cond = (it >> 4);
+	}
+
+	/* Shift makes it look like an ARM-mode instruction */
+	insn = cond << 28;
+	return arm_check_condition(insn, cpsr) != ARM_OPCODE_CONDTEST_FAIL;
+}
+
 /*
  * Return > 0 to return to guest, < 0 on error, 0 (and set exit_reason) on
  * proper exit to QEMU.
@@ -418,8 +540,46 @@ static void update_vttbr(struct kvm *kvm)
 static int handle_exit(struct kvm_vcpu *vcpu, struct kvm_run *run,
 		       int exception_index)
 {
-	run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-	return 0;
+	unsigned long hsr_ec;
+
+	switch (exception_index) {
+	case ARM_EXCEPTION_IRQ:
+		return 1;
+	case ARM_EXCEPTION_UNDEFINED:
+		kvm_err("Undefined exception in Hyp mode at: %#08x\n",
+			vcpu->arch.hyp_pc);
+		BUG();
+		panic("KVM: Hypervisor undefined exception!\n");
+	case ARM_EXCEPTION_DATA_ABORT:
+	case ARM_EXCEPTION_PREF_ABORT:
+	case ARM_EXCEPTION_HVC:
+		hsr_ec = (vcpu->arch.hsr & HSR_EC) >> HSR_EC_SHIFT;
+
+		if (hsr_ec >= ARRAY_SIZE(arm_exit_handlers)
+		    || !arm_exit_handlers[hsr_ec]) {
+			kvm_err("Unkown exception class: %#08lx, "
+				"hsr: %#08x\n", hsr_ec,
+				(unsigned int)vcpu->arch.hsr);
+			BUG();
+		}
+
+		/*
+		 * See ARM ARM B1.14.1: "Hyp traps on instructions
+		 * that fail their condition code check"
+		 */
+		if (!kvm_condition_valid(vcpu)) {
+			bool is_wide = vcpu->arch.hsr & HSR_IL;
+			kvm_skip_instr(vcpu, is_wide);
+			return 1;
+		}
+
+		return arm_exit_handlers[hsr_ec](vcpu, run);
+	default:
+		kvm_pr_unimpl("Unsupported exception type: %d",
+			      exception_index);
+		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+		return 0;
+	}
 }
 
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)
@@ -493,6 +653,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		ret = kvm_call_hyp(__kvm_vcpu_run, vcpu);
 
 		vcpu->mode = OUTSIDE_GUEST_MODE;
+		vcpu->arch.last_pcpu = smp_processor_id();
 		kvm_guest_exit();
 		trace_kvm_exit(*vcpu_pc(vcpu));
 		/*
@@ -801,6 +962,7 @@ int kvm_arch_init(void *opaque)
 	if (err)
 		goto out_err;
 
+	kvm_coproc_table_init();
 	return 0;
 out_err:
 	return err;
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index 0c43355..722efe3 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -16,8 +16,368 @@
  * along with this program; if not, write to the Free Software
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
+#include <linux/mm.h>
 #include <linux/kvm_host.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_host.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_coproc.h>
+#include <asm/cacheflush.h>
+#include <asm/cputype.h>
+#include <trace/events/kvm.h>
 
+#include "trace.h"
+#include "coproc.h"
+
+
+/******************************************************************************
+ * Co-processor emulation
+ *****************************************************************************/
+
+int kvm_handle_cp10_id(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+int kvm_handle_cp_0_13_access(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	/*
+	 * We can get here, if the host has been built without VFPv3 support,
+	 * but the guest attempted a floating point operation.
+	 */
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+int kvm_handle_cp14_load_store(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+int kvm_handle_cp14_access(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+/* See note at ARM ARM B1.14.4 */
+static bool access_dcsw(struct kvm_vcpu *vcpu,
+			const struct coproc_params *p,
+			const struct coproc_reg *r)
+{
+	u32 val;
+	int cpu;
+
+	cpu = get_cpu();
+
+	if (!p->is_write)
+		return read_from_write_only(vcpu, p);
+
+	cpumask_setall(&vcpu->arch.require_dcache_flush);
+	cpumask_clear_cpu(cpu, &vcpu->arch.require_dcache_flush);
+
+	/* If we were already preempted, take the long way around */
+	if (cpu != vcpu->arch.last_pcpu) {
+		flush_cache_all();
+		goto done;
+	}
+
+	val = *vcpu_reg(vcpu, p->Rt1);
+
+	switch (p->CRm) {
+	case 6:			/* Upgrade DCISW to DCCISW, as per HCR.SWIO */
+	case 14:		/* DCCISW */
+		asm volatile("mcr p15, 0, %0, c7, c14, 2" : : "r" (val));
+		break;
+
+	case 10:		/* DCCSW */
+		asm volatile("mcr p15, 0, %0, c7, c10, 2" : : "r" (val));
+		break;
+	}
+
+done:
+	put_cpu();
+
+	return true;
+}
+
+/*
+ * We could trap ID_DFR0 and tell the guest we don't support performance
+ * monitoring.  Unfortunately the patch to make the kernel check ID_DFR0 was
+ * NAKed, so it will read the PMCR anyway.
+ *
+ * Therefore we tell the guest we have 0 counters.  Unfortunately, we
+ * must always support PMCCNTR (the cycle counter): we just RAZ/WI for
+ * all PM registers, which doesn't crash the guest kernel at least.
+ */
+static bool pm_fake(struct kvm_vcpu *vcpu,
+		    const struct coproc_params *p,
+		    const struct coproc_reg *r)
+{
+	if (p->is_write)
+		return ignore_write(vcpu, p);
+	else
+		return read_zero(vcpu, p);
+}
+
+#define access_pmcr pm_fake
+#define access_pmcntenset pm_fake
+#define access_pmcntenclr pm_fake
+#define access_pmovsr pm_fake
+#define access_pmselr pm_fake
+#define access_pmceid0 pm_fake
+#define access_pmceid1 pm_fake
+#define access_pmccntr pm_fake
+#define access_pmxevtyper pm_fake
+#define access_pmxevcntr pm_fake
+#define access_pmuserenr pm_fake
+#define access_pmintenset pm_fake
+#define access_pmintenclr pm_fake
+
+/* Architected CP15 registers.
+ * Important: Must be sorted ascending by CRn, CRM, Op1, Op2
+ */
+static const struct coproc_reg cp15_regs[] = {
+	/* CSSELR: swapped by interrupt.S. */
+	{ CRn( 0), CRm( 0), Op1( 2), Op2( 0), is32,
+			NULL, reset_unknown, c0_CSSELR },
+
+	/* TTBR0/TTBR1: swapped by interrupt.S. */
+	{ CRm( 2), Op1( 0), is64, NULL, reset_unknown64, c2_TTBR0 },
+	{ CRm( 2), Op1( 1), is64, NULL, reset_unknown64, c2_TTBR1 },
+
+	/* TTBCR: swapped by interrupt.S. */
+	{ CRn( 2), CRm( 0), Op1( 0), Op2( 2), is32,
+			NULL, reset_val, c2_TTBCR, 0x00000000 },
+
+	/* DACR: swapped by interrupt.S. */
+	{ CRn( 3), CRm( 0), Op1( 0), Op2( 0), is32,
+			NULL, reset_unknown, c3_DACR },
+
+	/* DFSR/IFSR/ADFSR/AIFSR: swapped by interrupt.S. */
+	{ CRn( 5), CRm( 0), Op1( 0), Op2( 0), is32,
+			NULL, reset_unknown, c5_DFSR },
+	{ CRn( 5), CRm( 0), Op1( 0), Op2( 1), is32,
+			NULL, reset_unknown, c5_IFSR },
+	{ CRn( 5), CRm( 1), Op1( 0), Op2( 0), is32,
+			NULL, reset_unknown, c5_ADFSR },
+	{ CRn( 5), CRm( 1), Op1( 0), Op2( 1), is32,
+			NULL, reset_unknown, c5_AIFSR },
+
+	/* DFAR/IFAR: swapped by interrupt.S. */
+	{ CRn( 6), CRm( 0), Op1( 0), Op2( 0), is32,
+			NULL, reset_unknown, c6_DFAR },
+	{ CRn( 6), CRm( 0), Op1( 0), Op2( 2), is32,
+			NULL, reset_unknown, c6_IFAR },
+	/*
+	 * DC{C,I,CI}SW operations:
+	 */
+	{ CRn( 7), CRm( 6), Op1( 0), Op2( 2), is32, access_dcsw},
+	{ CRn( 7), CRm(10), Op1( 0), Op2( 2), is32, access_dcsw},
+	{ CRn( 7), CRm(14), Op1( 0), Op2( 2), is32, access_dcsw},
+	/*
+	 * Dummy performance monitor implementation.
+	 */
+	{ CRn( 9), CRm(12), Op1( 0), Op2( 0), is32, access_pmcr},
+	{ CRn( 9), CRm(12), Op1( 0), Op2( 1), is32, access_pmcntenset},
+	{ CRn( 9), CRm(12), Op1( 0), Op2( 2), is32, access_pmcntenclr},
+	{ CRn( 9), CRm(12), Op1( 0), Op2( 3), is32, access_pmovsr},
+	{ CRn( 9), CRm(12), Op1( 0), Op2( 5), is32, access_pmselr},
+	{ CRn( 9), CRm(12), Op1( 0), Op2( 6), is32, access_pmceid0},
+	{ CRn( 9), CRm(12), Op1( 0), Op2( 7), is32, access_pmceid1},
+	{ CRn( 9), CRm(13), Op1( 0), Op2( 0), is32, access_pmccntr},
+	{ CRn( 9), CRm(13), Op1( 0), Op2( 1), is32, access_pmxevtyper},
+	{ CRn( 9), CRm(13), Op1( 0), Op2( 2), is32, access_pmxevcntr},
+	{ CRn( 9), CRm(14), Op1( 0), Op2( 0), is32, access_pmuserenr},
+	{ CRn( 9), CRm(14), Op1( 0), Op2( 1), is32, access_pmintenset},
+	{ CRn( 9), CRm(14), Op1( 0), Op2( 2), is32, access_pmintenclr},
+
+	/* PRRR/NMRR (aka MAIR0/MAIR1): swapped by interrupt.S. */
+	{ CRn(10), CRm( 2), Op1( 0), Op2( 0), is32,
+			NULL, reset_unknown, c10_PRRR},
+	{ CRn(10), CRm( 2), Op1( 0), Op2( 1), is32,
+			NULL, reset_unknown, c10_NMRR},
+
+	/* VBAR: swapped by interrupt.S. */
+	{ CRn(12), CRm( 0), Op1( 0), Op2( 0), is32,
+			NULL, reset_val, c12_VBAR, 0x00000000 },
+
+	/* CONTEXTIDR/TPIDRURW/TPIDRURO/TPIDRPRW: swapped by interrupt.S. */
+	{ CRn(13), CRm( 0), Op1( 0), Op2( 1), is32,
+			NULL, reset_val, c13_CID, 0x00000000 },
+	{ CRn(13), CRm( 0), Op1( 0), Op2( 2), is32,
+			NULL, reset_unknown, c13_TID_URW },
+	{ CRn(13), CRm( 0), Op1( 0), Op2( 3), is32,
+			NULL, reset_unknown, c13_TID_URO },
+	{ CRn(13), CRm( 0), Op1( 0), Op2( 4), is32,
+			NULL, reset_unknown, c13_TID_PRIV },
+};
+
+/* Target specific emulation tables */
+static struct kvm_coproc_target_table *target_tables[KVM_ARM_NUM_TARGETS];
+
+void kvm_register_target_coproc_table(struct kvm_coproc_target_table *table)
+{
+	target_tables[table->target] = table;
+}
+
+/* Get specific register table for this target. */
+static const struct coproc_reg *get_target_table(unsigned target, size_t *num)
+{
+	struct kvm_coproc_target_table *table;
+
+	table = target_tables[target];
+	*num = table->num;
+	return table->table;
+}
+
+static const struct coproc_reg *find_reg(const struct coproc_params *params,
+					 const struct coproc_reg table[],
+					 unsigned int num)
+{
+	unsigned int i;
+
+	for (i = 0; i < num; i++) {
+		const struct coproc_reg *r = &table[i];
+
+		if (params->is_64bit != r->is_64)
+			continue;
+		if (params->CRn != r->CRn)
+			continue;
+		if (params->CRm != r->CRm)
+			continue;
+		if (params->Op1 != r->Op1)
+			continue;
+		if (params->Op2 != r->Op2)
+			continue;
+
+		return r;
+	}
+	return NULL;
+}
+
+static int emulate_cp15(struct kvm_vcpu *vcpu,
+			const struct coproc_params *params)
+{
+	size_t num;
+	const struct coproc_reg *table, *r;
+
+	trace_kvm_emulate_cp15_imp(params->Op1, params->Rt1, params->CRn,
+				   params->CRm, params->Op2, params->is_write);
+
+	table = get_target_table(vcpu->arch.target, &num);
+
+	/* Search target-specific then generic table. */
+	r = find_reg(params, table, num);
+	if (!r)
+		r = find_reg(params, cp15_regs, ARRAY_SIZE(cp15_regs));
+
+	if (likely(r)) {
+		/* If we don't have an accessor, we should never get here! */
+		BUG_ON(!r->access);
+
+		if (likely(r->access(vcpu, params, r))) {
+			/* Skip instruction, since it was emulated */
+			kvm_skip_instr(vcpu, (vcpu->arch.hsr >> 25) & 1);
+			return 1;
+		}
+		/* If access function fails, it should complain. */
+	} else {
+		kvm_err("Unsupported guest CP15 access at: %08x\n",
+			*vcpu_pc(vcpu));
+		print_cp_instr(params);
+	}
+	kvm_inject_undefined(vcpu);
+	return 1;
+}
+
+/**
+ * kvm_handle_cp15_64 -- handles a mrrc/mcrr trap on a guest CP15 access
+ * @vcpu: The VCPU pointer
+ * @run:  The kvm_run struct
+ */
+int kvm_handle_cp15_64(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	struct coproc_params params;
+
+	params.CRm = (vcpu->arch.hsr >> 1) & 0xf;
+	params.Rt1 = (vcpu->arch.hsr >> 5) & 0xf;
+	params.is_write = ((vcpu->arch.hsr & 1) == 0);
+	params.is_64bit = true;
+
+	params.Op1 = (vcpu->arch.hsr >> 16) & 0xf;
+	params.Op2 = 0;
+	params.Rt2 = (vcpu->arch.hsr >> 10) & 0xf;
+	params.CRn = 0;
+
+	return emulate_cp15(vcpu, &params);
+}
+
+static void reset_coproc_regs(struct kvm_vcpu *vcpu,
+			      const struct coproc_reg *table, size_t num)
+{
+	unsigned long i;
+
+	for (i = 0; i < num; i++)
+		if (table[i].reset)
+			table[i].reset(vcpu, &table[i]);
+}
+
+/**
+ * kvm_handle_cp15_32 -- handles a mrc/mcr trap on a guest CP15 access
+ * @vcpu: The VCPU pointer
+ * @run:  The kvm_run struct
+ */
+int kvm_handle_cp15_32(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	struct coproc_params params;
+
+	params.CRm = (vcpu->arch.hsr >> 1) & 0xf;
+	params.Rt1 = (vcpu->arch.hsr >> 5) & 0xf;
+	params.is_write = ((vcpu->arch.hsr & 1) == 0);
+	params.is_64bit = false;
+
+	params.CRn = (vcpu->arch.hsr >> 10) & 0xf;
+	params.Op1 = (vcpu->arch.hsr >> 14) & 0x7;
+	params.Op2 = (vcpu->arch.hsr >> 17) & 0x7;
+	params.Rt2 = 0;
+
+	return emulate_cp15(vcpu, &params);
+}
+
+void kvm_coproc_table_init(void)
+{
+	unsigned int i;
+
+	/* Make sure tables are unique and in order. */
+	for (i = 1; i < ARRAY_SIZE(cp15_regs); i++)
+		BUG_ON(cmp_reg(&cp15_regs[i-1], &cp15_regs[i]) >= 0);
+}
+
+/**
+ * kvm_reset_coprocs - sets cp15 registers to reset value
+ * @vcpu: The VCPU pointer
+ *
+ * This function finds the right table above and sets the registers on the
+ * virtual CPU struct to their architecturally defined reset values.
+ */
 void kvm_reset_coprocs(struct kvm_vcpu *vcpu)
 {
+	size_t num;
+	const struct coproc_reg *table;
+
+	/* Catch someone adding a register without putting in reset entry. */
+	memset(vcpu->arch.cp15, 0x42, sizeof(vcpu->arch.cp15));
+
+	/* Generic chip reset first (so target could override). */
+	reset_coproc_regs(vcpu, cp15_regs, ARRAY_SIZE(cp15_regs));
+
+	table = get_target_table(vcpu->arch.target, &num);
+	reset_coproc_regs(vcpu, table, num);
+
+	for (num = 1; num < NR_CP15_REGS; num++)
+		if (vcpu->arch.cp15[num] == 0x42424242)
+			panic("Didn't reset vcpu->arch.cp15[%zi]", num);
 }
diff --git a/arch/arm/kvm/coproc.h b/arch/arm/kvm/coproc.h
new file mode 100644
index 0000000..992adfa
--- /dev/null
+++ b/arch/arm/kvm/coproc.h
@@ -0,0 +1,153 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Authors: Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+
+#ifndef __ARM_KVM_COPROC_LOCAL_H__
+#define __ARM_KVM_COPROC_LOCAL_H__
+
+struct coproc_params {
+	unsigned long CRn;
+	unsigned long CRm;
+	unsigned long Op1;
+	unsigned long Op2;
+	unsigned long Rt1;
+	unsigned long Rt2;
+	bool is_64bit;
+	bool is_write;
+};
+
+struct coproc_reg {
+	/* MRC/MCR/MRRC/MCRR instruction which accesses it. */
+	unsigned long CRn;
+	unsigned long CRm;
+	unsigned long Op1;
+	unsigned long Op2;
+
+	bool is_64;
+
+	/* Trapped access from guest, if non-NULL. */
+	bool (*access)(struct kvm_vcpu *,
+		       const struct coproc_params *,
+		       const struct coproc_reg *);
+
+	/* Initialization for vcpu. */
+	void (*reset)(struct kvm_vcpu *, const struct coproc_reg *);
+
+	/* Index into vcpu->arch.cp15[], or 0 if we don't need to save it. */
+	unsigned long reg;
+
+	/* Value (usually reset value) */
+	u64 val;
+};
+
+static inline void print_cp_instr(const struct coproc_params *p)
+{
+	/* Look, we even formatted it for you to paste into the table! */
+	if (p->is_64bit) {
+		kvm_pr_unimpl(" { CRm(%2lu), Op1(%2lu), is64, func_%s },\n",
+			      p->CRm, p->Op1, p->is_write ? "write" : "read");
+	} else {
+		kvm_pr_unimpl(" { CRn(%2lu), CRm(%2lu), Op1(%2lu), Op2(%2lu), is32,"
+			      " func_%s },\n",
+			      p->CRn, p->CRm, p->Op1, p->Op2,
+			      p->is_write ? "write" : "read");
+	}
+}
+
+static inline bool ignore_write(struct kvm_vcpu *vcpu,
+				const struct coproc_params *p)
+{
+	return true;
+}
+
+static inline bool read_zero(struct kvm_vcpu *vcpu,
+			     const struct coproc_params *p)
+{
+	*vcpu_reg(vcpu, p->Rt1) = 0;
+	return true;
+}
+
+static inline bool write_to_read_only(struct kvm_vcpu *vcpu,
+				      const struct coproc_params *params)
+{
+	kvm_debug("CP15 write to read-only register at: %08x\n",
+		  *vcpu_pc(vcpu));
+	print_cp_instr(params);
+	return false;
+}
+
+static inline bool read_from_write_only(struct kvm_vcpu *vcpu,
+					const struct coproc_params *params)
+{
+	kvm_debug("CP15 read to write-only register at: %08x\n",
+		  *vcpu_pc(vcpu));
+	print_cp_instr(params);
+	return false;
+}
+
+/* Reset functions */
+static inline void reset_unknown(struct kvm_vcpu *vcpu,
+				 const struct coproc_reg *r)
+{
+	BUG_ON(!r->reg);
+	BUG_ON(r->reg >= ARRAY_SIZE(vcpu->arch.cp15));
+	vcpu->arch.cp15[r->reg] = 0xdecafbad;
+}
+
+static inline void reset_val(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
+{
+	BUG_ON(!r->reg);
+	BUG_ON(r->reg >= ARRAY_SIZE(vcpu->arch.cp15));
+	vcpu->arch.cp15[r->reg] = r->val;
+}
+
+static inline void reset_unknown64(struct kvm_vcpu *vcpu,
+				   const struct coproc_reg *r)
+{
+	BUG_ON(!r->reg);
+	BUG_ON(r->reg + 1 >= ARRAY_SIZE(vcpu->arch.cp15));
+
+	vcpu->arch.cp15[r->reg] = 0xdecafbad;
+	vcpu->arch.cp15[r->reg+1] = 0xd0c0ffee;
+}
+
+static inline int cmp_reg(const struct coproc_reg *i1,
+			  const struct coproc_reg *i2)
+{
+	BUG_ON(i1 == i2);
+	if (!i1)
+		return 1;
+	else if (!i2)
+		return -1;
+	if (i1->CRn != i2->CRn)
+		return i1->CRn - i2->CRn;
+	if (i1->CRm != i2->CRm)
+		return i1->CRm - i2->CRm;
+	if (i1->Op1 != i2->Op1)
+		return i1->Op1 - i2->Op1;
+	return i1->Op2 - i2->Op2;
+}
+
+
+#define CRn(_x)		.CRn = _x
+#define CRm(_x) 	.CRm = _x
+#define Op1(_x) 	.Op1 = _x
+#define Op2(_x) 	.Op2 = _x
+#define is64		.is_64 = true
+#define is32		.is_64 = false
+
+#endif /* __ARM_KVM_COPROC_LOCAL_H__ */
diff --git a/arch/arm/kvm/coproc_a15.c b/arch/arm/kvm/coproc_a15.c
new file mode 100644
index 0000000..685063a
--- /dev/null
+++ b/arch/arm/kvm/coproc_a15.c
@@ -0,0 +1,162 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Authors: Rusty Russell <rusty@rustcorp.au>
+ *          Christoffer Dall <c.dall@virtualopensystems.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2, as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+ */
+#include <linux/kvm_host.h>
+#include <asm/cputype.h>
+#include <asm/kvm_arm.h>
+#include <asm/kvm_host.h>
+#include <asm/kvm_emulate.h>
+#include <asm/kvm_coproc.h>
+#include <linux/init.h>
+
+static void reset_mpidr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
+{
+	/*
+	 * Compute guest MPIDR:
+	 * (Even if we present only one VCPU to the guest on an SMP
+	 * host we don't set the U bit in the MPIDR, or vice versa, as
+	 * revealing the underlying hardware properties is likely to
+	 * be the best choice).
+	 */
+	vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & ~MPIDR_LEVEL_MASK)
+		| (vcpu->vcpu_id & MPIDR_LEVEL_MASK);
+}
+
+#include "coproc.h"
+
+/* A15 TRM 4.3.28: RO WI */
+static bool access_actlr(struct kvm_vcpu *vcpu,
+			 const struct coproc_params *p,
+			 const struct coproc_reg *r)
+{
+	if (p->is_write)
+		return ignore_write(vcpu, p);
+
+	*vcpu_reg(vcpu, p->Rt1) = vcpu->arch.cp15[c1_ACTLR];
+	return true;
+}
+
+/* A15 TRM 4.3.60: R/O. */
+static bool access_cbar(struct kvm_vcpu *vcpu,
+			const struct coproc_params *p,
+			const struct coproc_reg *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p);
+	return read_zero(vcpu, p);
+}
+
+/* A15 TRM 4.3.48: R/O WI. */
+static bool access_l2ctlr(struct kvm_vcpu *vcpu,
+			  const struct coproc_params *p,
+			  const struct coproc_reg *r)
+{
+	if (p->is_write)
+		return ignore_write(vcpu, p);
+
+	*vcpu_reg(vcpu, p->Rt1) = vcpu->arch.cp15[c9_L2CTLR];
+	return true;
+}
+
+static void reset_l2ctlr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
+{
+	u32 l2ctlr, ncores;
+
+	asm volatile("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
+	l2ctlr &= ~(3 << 24);
+	ncores = atomic_read(&vcpu->kvm->online_vcpus) - 1;
+	l2ctlr |= (ncores & 3) << 24;
+
+	vcpu->arch.cp15[c9_L2CTLR] = l2ctlr;
+}
+
+static void reset_actlr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
+{
+	u32 actlr;
+
+	/* ACTLR contains SMP bit: make sure you create all cpus first! */
+	asm volatile("mrc p15, 0, %0, c1, c0, 1\n" : "=r" (actlr));
+	/* Make the SMP bit consistent with the guest configuration */
+	if (atomic_read(&vcpu->kvm->online_vcpus) > 1)
+		actlr |= 1U << 6;
+	else
+		actlr &= ~(1U << 6);
+
+	vcpu->arch.cp15[c1_ACTLR] = actlr;
+}
+
+/* A15 TRM 4.3.49: R/O WI (even if NSACR.NS_L2ERR, a write of 1 is ignored). */
+static bool access_l2ectlr(struct kvm_vcpu *vcpu,
+			   const struct coproc_params *p,
+			   const struct coproc_reg *r)
+{
+	if (p->is_write)
+		return ignore_write(vcpu, p);
+
+	*vcpu_reg(vcpu, p->Rt1) = 0;
+	return true;
+}
+
+/*
+ * A15-specific CP15 registers.
+ * Important: Must be sorted ascending by CRn, CRM, Op1, Op2
+ */
+static const struct coproc_reg a15_regs[] = {
+	/* MPIDR: we use VMPIDR for guest access. */
+	{ CRn( 0), CRm( 0), Op1( 0), Op2( 5), is32,
+			NULL, reset_mpidr, c0_MPIDR },
+
+	/* SCTLR: swapped by interrupt.S. */
+	{ CRn( 1), CRm( 0), Op1( 0), Op2( 0), is32,
+			NULL, reset_val, c1_SCTLR, 0x00C50078 },
+	/* ACTLR: trapped by HCR.TAC bit. */
+	{ CRn( 1), CRm( 0), Op1( 0), Op2( 1), is32,
+			access_actlr, reset_actlr, c1_ACTLR },
+	/* CPACR: swapped by interrupt.S. */
+	{ CRn( 1), CRm( 0), Op1( 0), Op2( 2), is32,
+			NULL, reset_val, c1_CPACR, 0x00000000 },
+
+	/*
+	 * L2CTLR access (guest wants to know #CPUs).
+	 */
+	{ CRn( 9), CRm( 0), Op1( 1), Op2( 2), is32,
+			access_l2ctlr, reset_l2ctlr, c9_L2CTLR },
+	{ CRn( 9), CRm( 0), Op1( 1), Op2( 3), is32, access_l2ectlr},
+
+	/* The Configuration Base Address Register. */
+	{ CRn(15), CRm( 0), Op1( 4), Op2( 0), is32, access_cbar},
+};
+
+static struct kvm_coproc_target_table a15_target_table = {
+	.target = KVM_ARM_TARGET_CORTEX_A15,
+	.table = a15_regs,
+	.num = ARRAY_SIZE(a15_regs),
+};
+
+static int __init coproc_a15_init(void)
+{
+	unsigned int i;
+
+	for (i = 1; i < ARRAY_SIZE(a15_regs); i++)
+		BUG_ON(cmp_reg(&a15_regs[i-1],
+			       &a15_regs[i]) >= 0);
+
+	kvm_register_target_coproc_table(&a15_target_table);
+	return 0;
+}
+late_initcall(coproc_a15_init);
diff --git a/arch/arm/kvm/emulate.c b/arch/arm/kvm/emulate.c
index 3eadc25..d61450a 100644
--- a/arch/arm/kvm/emulate.c
+++ b/arch/arm/kvm/emulate.c
@@ -16,7 +16,13 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 
+#include <linux/mm.h>
+#include <linux/kvm_host.h>
+#include <asm/kvm_arm.h>
 #include <asm/kvm_emulate.h>
+#include <trace/events/kvm.h>
+
+#include "trace.h"
 
 #define VCPU_NR_MODES		6
 #define VCPU_REG_OFFSET_USR	0
@@ -153,3 +159,215 @@ u32 *vcpu_spsr(struct kvm_vcpu *vcpu)
 		BUG();
 	}
 }
+
+/**
+ * kvm_handle_wfi - handle a wait-for-interrupts instruction executed by a guest
+ * @vcpu:	the vcpu pointer
+ * @run:	the kvm_run structure pointer
+ *
+ * Simply sets the wait_for_interrupts flag on the vcpu structure, which will
+ * halt execution of world-switches and schedule other host processes until
+ * there is an incoming IRQ or FIQ to the VM.
+ */
+int kvm_handle_wfi(struct kvm_vcpu *vcpu, struct kvm_run *run)
+{
+	trace_kvm_wfi(*vcpu_pc(vcpu));
+	kvm_vcpu_block(vcpu);
+	return 1;
+}
+
+/**
+ * adjust_itstate - adjust ITSTATE when emulating instructions in IT-block
+ * @vcpu:	The VCPU pointer
+ *
+ * When exceptions occur while instructions are executed in Thumb IF-THEN
+ * blocks, the ITSTATE field of the CPSR is not advanved (updated), so we have
+ * to do this little bit of work manually. The fields map like this:
+ *
+ * IT[7:0] -> CPSR[26:25],CPSR[15:10]
+ */
+static void kvm_adjust_itstate(struct kvm_vcpu *vcpu)
+{
+	unsigned long itbits, cond;
+	unsigned long cpsr = *vcpu_cpsr(vcpu);
+	bool is_arm = !(cpsr & PSR_T_BIT);
+
+	BUG_ON(is_arm && (cpsr & PSR_IT_MASK));
+
+	if (!(cpsr & PSR_IT_MASK))
+		return;
+
+	cond = (cpsr & 0xe000) >> 13;
+	itbits = (cpsr & 0x1c00) >> (10 - 2);
+	itbits |= (cpsr & (0x3 << 25)) >> 25;
+
+	/* Perform ITAdvance (see page A-52 in ARM DDI 0406C) */
+	if ((itbits & 0x7) == 0)
+		itbits = cond = 0;
+	else
+		itbits = (itbits << 1) & 0x1f;
+
+	cpsr &= ~PSR_IT_MASK;
+	cpsr |= cond << 13;
+	cpsr |= (itbits & 0x1c) << (10 - 2);
+	cpsr |= (itbits & 0x3) << 25;
+	*vcpu_cpsr(vcpu) = cpsr;
+}
+
+/**
+ * kvm_skip_instr - skip a trapped instruction and proceed to the next
+ * @vcpu: The vcpu pointer
+ */
+void kvm_skip_instr(struct kvm_vcpu *vcpu, bool is_wide_instr)
+{
+	bool is_thumb;
+
+	is_thumb = !!(*vcpu_cpsr(vcpu) & PSR_T_BIT);
+	if (is_thumb && !is_wide_instr)
+		*vcpu_pc(vcpu) += 2;
+	else
+		*vcpu_pc(vcpu) += 4;
+	kvm_adjust_itstate(vcpu);
+}
+
+
+/******************************************************************************
+ * Inject exceptions into the guest
+ */
+
+static u32 exc_vector_base(struct kvm_vcpu *vcpu)
+{
+	u32 sctlr = vcpu->arch.cp15[c1_SCTLR];
+	u32 vbar = vcpu->arch.cp15[c12_VBAR];
+
+	if (sctlr & SCTLR_V)
+		return 0xffff0000;
+	else /* always have security exceptions */
+		return vbar;
+}
+
+/**
+ * kvm_inject_undefined - inject an undefined exception into the guest
+ * @vcpu: The VCPU to receive the undefined exception
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ *
+ * Modelled after TakeUndefInstrException() pseudocode.
+ */
+void kvm_inject_undefined(struct kvm_vcpu *vcpu)
+{
+	u32 new_lr_value;
+	u32 new_spsr_value;
+	u32 cpsr = *vcpu_cpsr(vcpu);
+	u32 sctlr = vcpu->arch.cp15[c1_SCTLR];
+	bool is_thumb = (cpsr & PSR_T_BIT);
+	u32 vect_offset = 4;
+	u32 return_offset = (is_thumb) ? 2 : 4;
+
+	new_spsr_value = cpsr;
+	new_lr_value = *vcpu_pc(vcpu) - return_offset;
+
+	*vcpu_cpsr(vcpu) = (cpsr & ~MODE_MASK) | UND_MODE;
+	*vcpu_cpsr(vcpu) |= PSR_I_BIT;
+	*vcpu_cpsr(vcpu) &= ~(PSR_IT_MASK | PSR_J_BIT | PSR_E_BIT | PSR_T_BIT);
+
+	if (sctlr & SCTLR_TE)
+		*vcpu_cpsr(vcpu) |= PSR_T_BIT;
+	if (sctlr & SCTLR_EE)
+		*vcpu_cpsr(vcpu) |= PSR_E_BIT;
+
+	/* Note: These now point to UND banked copies */
+	*vcpu_spsr(vcpu) = cpsr;
+	*vcpu_reg(vcpu, 14) = new_lr_value;
+
+	/* Branch to exception vector */
+	*vcpu_pc(vcpu) = exc_vector_base(vcpu) + vect_offset;
+}
+
+/*
+ * Modelled after TakeDataAbortException() and TakePrefetchAbortException
+ * pseudocode.
+ */
+static void inject_abt(struct kvm_vcpu *vcpu, bool is_pabt, unsigned long addr)
+{
+	u32 new_lr_value;
+	u32 new_spsr_value;
+	u32 cpsr = *vcpu_cpsr(vcpu);
+	u32 sctlr = vcpu->arch.cp15[c1_SCTLR];
+	bool is_thumb = (cpsr & PSR_T_BIT);
+	u32 vect_offset;
+	u32 return_offset = (is_thumb) ? 4 : 0;
+	bool is_lpae;
+
+	new_spsr_value = cpsr;
+	new_lr_value = *vcpu_pc(vcpu) + return_offset;
+
+	*vcpu_cpsr(vcpu) = (cpsr & ~MODE_MASK) | ABT_MODE;
+	*vcpu_cpsr(vcpu) |= PSR_I_BIT | PSR_A_BIT;
+	*vcpu_cpsr(vcpu) &= ~(PSR_IT_MASK | PSR_J_BIT | PSR_E_BIT | PSR_T_BIT);
+
+	if (sctlr & SCTLR_TE)
+		*vcpu_cpsr(vcpu) |= PSR_T_BIT;
+	if (sctlr & SCTLR_EE)
+		*vcpu_cpsr(vcpu) |= PSR_E_BIT;
+
+	/* Note: These now point to ABT banked copies */
+	*vcpu_spsr(vcpu) = cpsr;
+	*vcpu_reg(vcpu, 14) = new_lr_value;
+
+	if (is_pabt)
+		vect_offset = 12;
+	else
+		vect_offset = 16;
+
+	/* Branch to exception vector */
+	*vcpu_pc(vcpu) = exc_vector_base(vcpu) + vect_offset;
+
+	if (is_pabt) {
+		/* Set DFAR and DFSR */
+		vcpu->arch.cp15[c6_IFAR] = addr;
+		is_lpae = (vcpu->arch.cp15[c2_TTBCR] >> 31);
+		/* Always give debug fault for now - should give guest a clue */
+		if (is_lpae)
+			vcpu->arch.cp15[c5_IFSR] = 1 << 9 | 0x22;
+		else
+			vcpu->arch.cp15[c5_IFSR] = 2;
+	} else { /* !iabt */
+		/* Set DFAR and DFSR */
+		vcpu->arch.cp15[c6_DFAR] = addr;
+		is_lpae = (vcpu->arch.cp15[c2_TTBCR] >> 31);
+		/* Always give debug fault for now - should give guest a clue */
+		if (is_lpae)
+			vcpu->arch.cp15[c5_DFSR] = 1 << 9 | 0x22;
+		else
+			vcpu->arch.cp15[c5_DFSR] = 2;
+	}
+
+}
+
+/**
+ * kvm_inject_dabt - inject a data abort into the guest
+ * @vcpu: The VCPU to receive the undefined exception
+ * @addr: The address to report in the DFAR
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ */
+void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr)
+{
+	inject_abt(vcpu, false, addr);
+}
+
+/**
+ * kvm_inject_pabt - inject a prefetch abort into the guest
+ * @vcpu: The VCPU to receive the undefined exception
+ * @addr: The address to report in the DFAR
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ */
+void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr)
+{
+	inject_abt(vcpu, true, addr);
+}
diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
index 105d1f7..022305b 100644
--- a/arch/arm/kvm/trace.h
+++ b/arch/arm/kvm/trace.h
@@ -64,6 +64,51 @@ TRACE_EVENT(kvm_irq_line,
 		  __entry->type, __entry->vcpu_idx, __entry->irq_num, __entry->level)
 );
 
+/* Architecturally implementation defined CP15 register access */
+TRACE_EVENT(kvm_emulate_cp15_imp,
+	TP_PROTO(unsigned long Op1, unsigned long Rt1, unsigned long CRn,
+		 unsigned long CRm, unsigned long Op2, bool is_write),
+	TP_ARGS(Op1, Rt1, CRn, CRm, Op2, is_write),
+
+	TP_STRUCT__entry(
+		__field(	unsigned int,	Op1		)
+		__field(	unsigned int,	Rt1		)
+		__field(	unsigned int,	CRn		)
+		__field(	unsigned int,	CRm		)
+		__field(	unsigned int,	Op2		)
+		__field(	bool,		is_write	)
+	),
+
+	TP_fast_assign(
+		__entry->is_write		= is_write;
+		__entry->Op1			= Op1;
+		__entry->Rt1			= Rt1;
+		__entry->CRn			= CRn;
+		__entry->CRm			= CRm;
+		__entry->Op2			= Op2;
+	),
+
+	TP_printk("Implementation defined CP15: %s\tp15, %u, r%u, c%u, c%u, %u",
+			(__entry->is_write) ? "mcr" : "mrc",
+			__entry->Op1, __entry->Rt1, __entry->CRn,
+			__entry->CRm, __entry->Op2)
+);
+
+TRACE_EVENT(kvm_wfi,
+	TP_PROTO(unsigned long vcpu_pc),
+	TP_ARGS(vcpu_pc),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_pc		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc		= vcpu_pc;
+	),
+
+	TP_printk("guest executed wfi at: 0x%08lx", __entry->vcpu_pc)
+);
+
 TRACE_EVENT(kvm_unmap_hva,
 	TP_PROTO(unsigned long hva),
 	TP_ARGS(hva),
@@ -112,6 +157,26 @@ TRACE_EVENT(kvm_set_spte_hva,
 	TP_printk("mmu notifier set pte hva: %#08lx", __entry->hva)
 );
 
+TRACE_EVENT(kvm_hvc,
+	TP_PROTO(unsigned long vcpu_pc, unsigned long r0, unsigned long imm),
+	TP_ARGS(vcpu_pc, r0, imm),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_pc		)
+		__field(	unsigned long,	r0		)
+		__field(	unsigned long,	imm		)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc		= vcpu_pc;
+		__entry->r0		= r0;
+		__entry->imm		= imm;
+	),
+
+	TP_printk("HVC at 0x%08lx (r0: 0x%08lx, imm: 0x%lx",
+		  __entry->vcpu_pc, __entry->r0, __entry->imm)
+);
+
 #endif /* _TRACE_KVM_H */
 
 #undef TRACE_INCLUDE_PATH
