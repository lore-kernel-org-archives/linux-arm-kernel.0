From: jonathan.austin@arm.com (Jonathan Austin)
Date: Thu, 26 Sep 2013 16:49:28 +0100
Subject: [PATCH 3/3] KVM: ARM: Add support for Cortex-A7
In-Reply-To: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
References: <1380210568-23175-1-git-send-email-jonathan.austin@arm.com>
Message-ID: <1380210568-23175-4-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for running Cortex-A7 guests on Cortex-A7 hosts.

As Cortex-A7 is architecturally compatible with A15, this patch is largely just
generalising existing code. Areas where 'implementation defined' behaviour
is identical for A7 and A15 is moved to allow it to be used by both cores.

The check to ensure that coprocessor register tables are sorted correctly is
also moved in to 'common' code to avoid each new cpu doing its own check
(and possibly forgetting to do so!)

Signed-off-by: Jonathan Austin <jonathan.austin@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/include/asm/kvm_asm.h  |    2 +-
 arch/arm/include/uapi/asm/kvm.h |    3 +-
 arch/arm/kvm/Makefile           |    2 +-
 arch/arm/kvm/coproc.c           |  114 +++++++++++++++++++++++++++++++++++++++
 arch/arm/kvm/coproc_a15.c       |  114 +--------------------------------------
 arch/arm/kvm/coproc_a7.c        |   54 +++++++++++++++++++
 arch/arm/kvm/guest.c            |    4 +-
 arch/arm/kvm/reset.c            |   15 +++---
 8 files changed, 184 insertions(+), 124 deletions(-)
 create mode 100644 arch/arm/kvm/coproc_a7.c

diff --git a/arch/arm/include/asm/kvm_asm.h b/arch/arm/include/asm/kvm_asm.h
index a2f43dd..661da11 100644
--- a/arch/arm/include/asm/kvm_asm.h
+++ b/arch/arm/include/asm/kvm_asm.h
@@ -39,7 +39,7 @@
 #define c6_IFAR		17	/* Instruction Fault Address Register */
 #define c7_PAR		18	/* Physical Address Register */
 #define c7_PAR_high	19	/* PAR top 32 bits */
-#define c9_L2CTLR	20	/* Cortex A15 L2 Control Register */
+#define c9_L2CTLR	20	/* Cortex A15/A7 L2 Control Register */
 #define c10_PRRR	21	/* Primary Region Remap Register */
 #define c10_NMRR	22	/* Normal Memory Remap Register */
 #define c12_VBAR	23	/* Vector Base Address Register */
diff --git a/arch/arm/include/uapi/asm/kvm.h b/arch/arm/include/uapi/asm/kvm.h
index c1ee007..c498b60 100644
--- a/arch/arm/include/uapi/asm/kvm.h
+++ b/arch/arm/include/uapi/asm/kvm.h
@@ -63,7 +63,8 @@ struct kvm_regs {
 
 /* Supported Processor Types */
 #define KVM_ARM_TARGET_CORTEX_A15	0
-#define KVM_ARM_NUM_TARGETS		1
+#define KVM_ARM_TARGET_CORTEX_A7	1
+#define KVM_ARM_NUM_TARGETS		2
 
 /* KVM_ARM_SET_DEVICE_ADDR ioctl id encoding */
 #define KVM_ARM_DEVICE_TYPE_SHIFT	0
diff --git a/arch/arm/kvm/Makefile b/arch/arm/kvm/Makefile
index d99bee4..789bca9 100644
--- a/arch/arm/kvm/Makefile
+++ b/arch/arm/kvm/Makefile
@@ -19,6 +19,6 @@ kvm-arm-y = $(KVM)/kvm_main.o $(KVM)/coalesced_mmio.o
 
 obj-y += kvm-arm.o init.o interrupts.o
 obj-y += arm.o handle_exit.o guest.o mmu.o emulate.o reset.o
-obj-y += coproc.o coproc_a15.o mmio.o psci.o perf.o
+obj-y += coproc.o coproc_a15.o coproc_a7.o mmio.o psci.o perf.o
 obj-$(CONFIG_KVM_ARM_VGIC) += $(KVM)/arm/vgic.o
 obj-$(CONFIG_KVM_ARM_TIMER) += $(KVM)/arm/arch_timer.o
diff --git a/arch/arm/kvm/coproc.c b/arch/arm/kvm/coproc.c
index db9cf69..a629f2c 100644
--- a/arch/arm/kvm/coproc.c
+++ b/arch/arm/kvm/coproc.c
@@ -71,6 +71,92 @@ int kvm_handle_cp14_access(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	return 1;
 }
 
+static void reset_mpidr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
+{
+	/*
+	 * Compute guest MPIDR. No need to mess around with different clusters
+	 * but we read the 'U' bit from the underlying hardware directly.
+	 */
+	vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & MPIDR_SMP_BITMASK)
+					| vcpu->vcpu_id;
+}
+
+/* TRM entries A7:4.3.31 A15:4.3.28 - RO WI */
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
+/* TRM entries A7:4.3.56, A15:4.3.60 - R/O. */
+static bool access_cbar(struct kvm_vcpu *vcpu,
+			const struct coproc_params *p,
+			const struct coproc_reg *r)
+{
+	if (p->is_write)
+		return write_to_read_only(vcpu, p);
+	return read_zero(vcpu, p);
+}
+
+/* TRM entries A7:4.3.49, A15:4.3.48 - R/O WI */
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
+/*
+ * TRM entries: A7:4.3.50, A15:4.3.49
+ * R/O WI (even if NSACR.NS_L2ERR, a write of 1 is ignored).
+ */
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
 /* See note at ARM ARM B1.14.4 */
 static bool access_dcsw(struct kvm_vcpu *vcpu,
 			const struct coproc_params *p,
@@ -153,10 +239,22 @@ static bool pm_fake(struct kvm_vcpu *vcpu,
  *            registers preceding 32-bit ones.
  */
 static const struct coproc_reg cp15_regs[] = {
+	/* MPIDR: we use VMPIDR for guest access. */
+	{ CRn( 0), CRm( 0), Op1( 0), Op2( 5), is32,
+			NULL, reset_mpidr, c0_MPIDR },
+
 	/* CSSELR: swapped by interrupt.S. */
 	{ CRn( 0), CRm( 0), Op1( 2), Op2( 0), is32,
 			NULL, reset_unknown, c0_CSSELR },
 
+	/* ACTLR: trapped by HCR.TAC bit. */
+	{ CRn( 1), CRm( 0), Op1( 0), Op2( 1), is32,
+			access_actlr, reset_actlr, c1_ACTLR },
+
+	/* CPACR: swapped by interrupt.S. */
+	{ CRn( 1), CRm( 0), Op1( 0), Op2( 2), is32,
+			NULL, reset_val, c1_CPACR, 0x00000000 },
+
 	/* TTBR0/TTBR1: swapped by interrupt.S. */
 	{ CRm64( 2), Op1( 0), is64, NULL, reset_unknown64, c2_TTBR0 },
 	{ CRm64( 2), Op1( 1), is64, NULL, reset_unknown64, c2_TTBR1 },
@@ -195,6 +293,13 @@ static const struct coproc_reg cp15_regs[] = {
 	{ CRn( 7), CRm(10), Op1( 0), Op2( 2), is32, access_dcsw},
 	{ CRn( 7), CRm(14), Op1( 0), Op2( 2), is32, access_dcsw},
 	/*
+	 * L2CTLR access (guest wants to know #CPUs).
+	 */
+	{ CRn( 9), CRm( 0), Op1( 1), Op2( 2), is32,
+			access_l2ctlr, reset_l2ctlr, c9_L2CTLR },
+	{ CRn( 9), CRm( 0), Op1( 1), Op2( 3), is32, access_l2ectlr},
+
+	/*
 	 * Dummy performance monitor implementation.
 	 */
 	{ CRn( 9), CRm(12), Op1( 0), Op2( 0), is32, access_pmcr},
@@ -234,6 +339,9 @@ static const struct coproc_reg cp15_regs[] = {
 	/* CNTKCTL: swapped by interrupt.S. */
 	{ CRn(14), CRm( 1), Op1( 0), Op2( 0), is32,
 			NULL, reset_val, c14_CNTKCTL, 0x00000000 },
+
+	/* The Configuration Base Address Register. */
+	{ CRn(15), CRm( 0), Op1( 4), Op2( 0), is32, access_cbar},
 };
 
 /* Target specific emulation tables */
@@ -241,6 +349,12 @@ static struct kvm_coproc_target_table *target_tables[KVM_ARM_NUM_TARGETS];
 
 void kvm_register_target_coproc_table(struct kvm_coproc_target_table *table)
 {
+	unsigned int i;
+
+	for (i = 1; i < table->num; i++)
+		BUG_ON(cmp_reg(&table->table[i-1],
+			       &table->table[i]) >= 0);
+
 	target_tables[table->target] = table;
 }
 
diff --git a/arch/arm/kvm/coproc_a15.c b/arch/arm/kvm/coproc_a15.c
index bbd4b88..bb0cac1 100644
--- a/arch/arm/kvm/coproc_a15.c
+++ b/arch/arm/kvm/coproc_a15.c
@@ -17,98 +17,12 @@
  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 #include <linux/kvm_host.h>
-#include <asm/cputype.h>
-#include <asm/kvm_arm.h>
-#include <asm/kvm_host.h>
-#include <asm/kvm_emulate.h>
 #include <asm/kvm_coproc.h>
+#include <asm/kvm_emulate.h>
 #include <linux/init.h>
 
-static void reset_mpidr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
-{
-	/*
-	 * Compute guest MPIDR. No need to mess around with different clusters
-	 * but we read the 'U' bit from the underlying hardware directly.
-	 */
-	vcpu->arch.cp15[c0_MPIDR] = (read_cpuid_mpidr() & MPIDR_SMP_BITMASK)
-					| vcpu->vcpu_id;
-}
-
 #include "coproc.h"
 
-/* A15 TRM 4.3.28: RO WI */
-static bool access_actlr(struct kvm_vcpu *vcpu,
-			 const struct coproc_params *p,
-			 const struct coproc_reg *r)
-{
-	if (p->is_write)
-		return ignore_write(vcpu, p);
-
-	*vcpu_reg(vcpu, p->Rt1) = vcpu->arch.cp15[c1_ACTLR];
-	return true;
-}
-
-/* A15 TRM 4.3.60: R/O. */
-static bool access_cbar(struct kvm_vcpu *vcpu,
-			const struct coproc_params *p,
-			const struct coproc_reg *r)
-{
-	if (p->is_write)
-		return write_to_read_only(vcpu, p);
-	return read_zero(vcpu, p);
-}
-
-/* A15 TRM 4.3.48: R/O WI. */
-static bool access_l2ctlr(struct kvm_vcpu *vcpu,
-			  const struct coproc_params *p,
-			  const struct coproc_reg *r)
-{
-	if (p->is_write)
-		return ignore_write(vcpu, p);
-
-	*vcpu_reg(vcpu, p->Rt1) = vcpu->arch.cp15[c9_L2CTLR];
-	return true;
-}
-
-static void reset_l2ctlr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
-{
-	u32 l2ctlr, ncores;
-
-	asm volatile("mrc p15, 1, %0, c9, c0, 2\n" : "=r" (l2ctlr));
-	l2ctlr &= ~(3 << 24);
-	ncores = atomic_read(&vcpu->kvm->online_vcpus) - 1;
-	l2ctlr |= (ncores & 3) << 24;
-
-	vcpu->arch.cp15[c9_L2CTLR] = l2ctlr;
-}
-
-static void reset_actlr(struct kvm_vcpu *vcpu, const struct coproc_reg *r)
-{
-	u32 actlr;
-
-	/* ACTLR contains SMP bit: make sure you create all cpus first! */
-	asm volatile("mrc p15, 0, %0, c1, c0, 1\n" : "=r" (actlr));
-	/* Make the SMP bit consistent with the guest configuration */
-	if (atomic_read(&vcpu->kvm->online_vcpus) > 1)
-		actlr |= 1U << 6;
-	else
-		actlr &= ~(1U << 6);
-
-	vcpu->arch.cp15[c1_ACTLR] = actlr;
-}
-
-/* A15 TRM 4.3.49: R/O WI (even if NSACR.NS_L2ERR, a write of 1 is ignored). */
-static bool access_l2ectlr(struct kvm_vcpu *vcpu,
-			   const struct coproc_params *p,
-			   const struct coproc_reg *r)
-{
-	if (p->is_write)
-		return ignore_write(vcpu, p);
-
-	*vcpu_reg(vcpu, p->Rt1) = 0;
-	return true;
-}
-
 /*
  * A15-specific CP15 registers.
  * CRn denotes the primary register number, but is copied to the CRm in the
@@ -118,29 +32,9 @@ static bool access_l2ectlr(struct kvm_vcpu *vcpu,
  *            registers preceding 32-bit ones.
  */
 static const struct coproc_reg a15_regs[] = {
-	/* MPIDR: we use VMPIDR for guest access. */
-	{ CRn( 0), CRm( 0), Op1( 0), Op2( 5), is32,
-			NULL, reset_mpidr, c0_MPIDR },
-
 	/* SCTLR: swapped by interrupt.S. */
 	{ CRn( 1), CRm( 0), Op1( 0), Op2( 0), is32,
 			NULL, reset_val, c1_SCTLR, 0x00C50078 },
-	/* ACTLR: trapped by HCR.TAC bit. */
-	{ CRn( 1), CRm( 0), Op1( 0), Op2( 1), is32,
-			access_actlr, reset_actlr, c1_ACTLR },
-	/* CPACR: swapped by interrupt.S. */
-	{ CRn( 1), CRm( 0), Op1( 0), Op2( 2), is32,
-			NULL, reset_val, c1_CPACR, 0x00000000 },
-
-	/*
-	 * L2CTLR access (guest wants to know #CPUs).
-	 */
-	{ CRn( 9), CRm( 0), Op1( 1), Op2( 2), is32,
-			access_l2ctlr, reset_l2ctlr, c9_L2CTLR },
-	{ CRn( 9), CRm( 0), Op1( 1), Op2( 3), is32, access_l2ectlr},
-
-	/* The Configuration Base Address Register. */
-	{ CRn(15), CRm( 0), Op1( 4), Op2( 0), is32, access_cbar},
 };
 
 static struct kvm_coproc_target_table a15_target_table = {
@@ -151,12 +45,6 @@ static struct kvm_coproc_target_table a15_target_table = {
 
 static int __init coproc_a15_init(void)
 {
-	unsigned int i;
-
-	for (i = 1; i < ARRAY_SIZE(a15_regs); i++)
-		BUG_ON(cmp_reg(&a15_regs[i-1],
-			       &a15_regs[i]) >= 0);
-
 	kvm_register_target_coproc_table(&a15_target_table);
 	return 0;
 }
diff --git a/arch/arm/kvm/coproc_a7.c b/arch/arm/kvm/coproc_a7.c
new file mode 100644
index 0000000..1df7673
--- /dev/null
+++ b/arch/arm/kvm/coproc_a7.c
@@ -0,0 +1,54 @@
+/*
+ * Copyright (C) 2012 - Virtual Open Systems and Columbia University
+ * Copyright (C) 2013 - ARM Ltd
+ *
+ * Authors: Rusty Russell <rusty@rustcorp.au>
+ *          Christoffer Dall <c.dall@virtualopensystems.com>
+ *          Jonathan Austin <jonathan.austin@arm.com>
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
+#include <asm/kvm_coproc.h>
+#include <asm/kvm_emulate.h>
+#include <linux/init.h>
+
+#include "coproc.h"
+
+/*
+ * Cortex-A7 specific CP15 registers.
+ * CRn denotes the primary register number, but is copied to the CRm in the
+ * user space API for 64-bit register access in line with the terminology used
+ * in the ARM ARM.
+ * Important: Must be sorted ascending by CRn, CRM, Op1, Op2 and with 64-bit
+ *            registers preceding 32-bit ones.
+ */
+static const struct coproc_reg a7_regs[] = {
+	/* SCTLR: swapped by interrupt.S. */
+	{ CRn( 1), CRm( 0), Op1( 0), Op2( 0), is32,
+			NULL, reset_val, c1_SCTLR, 0x00C50878 },
+};
+
+static struct kvm_coproc_target_table a7_target_table = {
+	.target = KVM_ARM_TARGET_CORTEX_A7,
+	.table = a7_regs,
+	.num = ARRAY_SIZE(a7_regs),
+};
+
+static int __init coproc_a7_init(void)
+{
+	kvm_register_target_coproc_table(&a7_target_table);
+	return 0;
+}
+late_initcall(coproc_a7_init);
diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 152d036..c01ae86 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -190,6 +190,8 @@ int __attribute_const__ kvm_target_cpu(void)
 		return -EINVAL;
 
 	switch (part_number) {
+	case ARM_CPU_PART_CORTEX_A7:
+		return KVM_ARM_TARGET_CORTEX_A7;
 	case ARM_CPU_PART_CORTEX_A15:
 		return KVM_ARM_TARGET_CORTEX_A15;
 	default:
@@ -202,7 +204,7 @@ int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 {
 	unsigned int i;
 
-	/* We can only do a cortex A15 for now. */
+	/* We can only cope with guest==host and only on A15/A7 (for now). */
 	if (init->target != kvm_target_cpu())
 		return -EINVAL;
 
diff --git a/arch/arm/kvm/reset.c b/arch/arm/kvm/reset.c
index b7840e7..14b2f83 100644
--- a/arch/arm/kvm/reset.c
+++ b/arch/arm/kvm/reset.c
@@ -30,16 +30,16 @@
 #include <kvm/arm_arch_timer.h>
 
 /******************************************************************************
- * Cortex-A15 Reset Values
+ * Cortex-A15 and Cortex-A7 Reset Values
  */
 
-static const int a15_max_cpu_idx = 3;
+static const int cortexa_max_cpu_idx = 3;
 
-static struct kvm_regs a15_regs_reset = {
+static struct kvm_regs cortexa_regs_reset = {
 	.usr_regs.ARM_cpsr = SVC_MODE | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT,
 };
 
-static const struct kvm_irq_level a15_vtimer_irq = {
+static const struct kvm_irq_level cortexa_vtimer_irq = {
 	.irq = 27,
 	.level = 1,
 };
@@ -62,12 +62,13 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 	const struct kvm_irq_level *cpu_vtimer_irq;
 
 	switch (vcpu->arch.target) {
+	case KVM_ARM_TARGET_CORTEX_A7:
 	case KVM_ARM_TARGET_CORTEX_A15:
-		if (vcpu->vcpu_id > a15_max_cpu_idx)
+		if (vcpu->vcpu_id > cortexa_max_cpu_idx)
 			return -EINVAL;
-		cpu_reset = &a15_regs_reset;
+		cpu_reset = &cortexa_regs_reset;
 		vcpu->arch.midr = read_cpuid_id();
-		cpu_vtimer_irq = &a15_vtimer_irq;
+		cpu_vtimer_irq = &cortexa_vtimer_irq;
 		break;
 	default:
 		return -ENODEV;
-- 
1.7.9.5
