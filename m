From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 14 May 2013 15:13:50 +0100
Subject: [PATCH v4 22/32] arm64: KVM: define 32bit specific registers
In-Reply-To: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
References: <1368540840-26750-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1368540840-26750-23-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the 32bit specific registers (SPSRs, cp15...).

Most CPU registers are directly mapped to a 64bit register
(r0->x0...). Only the SPSRs have separate registers.

cp15 registers are also mapped into their 64bit counterpart in most
cases.

Reviewed-by: Christopher Covington <cov@codeaurora.org>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_asm.h  | 38 +++++++++++++++++++++++++++++++++++++-
 arch/arm64/include/asm/kvm_host.h |  5 ++++-
 arch/arm64/include/uapi/asm/kvm.h |  7 ++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_asm.h b/arch/arm64/include/asm/kvm_asm.h
index 591ac21..c92de41 100644
--- a/arch/arm64/include/asm/kvm_asm.h
+++ b/arch/arm64/include/asm/kvm_asm.h
@@ -42,7 +42,43 @@
 #define	TPIDR_EL1	18	/* Thread ID, Privileged */
 #define	AMAIR_EL1	19	/* Aux Memory Attribute Indirection Register */
 #define	CNTKCTL_EL1	20	/* Timer Control Register (EL1) */
-#define	NR_SYS_REGS	21
+/* 32bit specific registers. Keep them at the end of the range */
+#define	DACR32_EL2	21	/* Domain Access Control Register */
+#define	IFSR32_EL2	22	/* Instruction Fault Status Register */
+#define	FPEXC32_EL2	23	/* Floating-Point Exception Control Register */
+#define	DBGVCR32_EL2	24	/* Debug Vector Catch Register */
+#define	TEECR32_EL1	25	/* ThumbEE Configuration Register */
+#define	TEEHBR32_EL1	26	/* ThumbEE Handler Base Register */
+#define	NR_SYS_REGS	27
+
+/* 32bit mapping */
+#define c0_MPIDR	(MPIDR_EL1 * 2)	/* MultiProcessor ID Register */
+#define c0_CSSELR	(CSSELR_EL1 * 2)/* Cache Size Selection Register */
+#define c1_SCTLR	(SCTLR_EL1 * 2)	/* System Control Register */
+#define c1_ACTLR	(ACTLR_EL1 * 2)	/* Auxiliary Control Register */
+#define c1_CPACR	(CPACR_EL1 * 2)	/* Coprocessor Access Control */
+#define c2_TTBR0	(TTBR0_EL1 * 2)	/* Translation Table Base Register 0 */
+#define c2_TTBR0_high	(c2_TTBR0 + 1)	/* TTBR0 top 32 bits */
+#define c2_TTBR1	(TTBR1_EL1 * 2)	/* Translation Table Base Register 1 */
+#define c2_TTBR1_high	(c2_TTBR1 + 1)	/* TTBR1 top 32 bits */
+#define c2_TTBCR	(TCR_EL1 * 2)	/* Translation Table Base Control R. */
+#define c3_DACR		(DACR32_EL2 * 2)/* Domain Access Control Register */
+#define c5_DFSR		(ESR_EL1 * 2)	/* Data Fault Status Register */
+#define c5_IFSR		(IFSR32_EL2 * 2)/* Instruction Fault Status Register */
+#define c5_ADFSR	(AFSR0_EL1 * 2)	/* Auxiliary Data Fault Status R */
+#define c5_AIFSR	(AFSR1_EL1 * 2)	/* Auxiliary Instr Fault Status R */
+#define c6_DFAR		(FAR_EL1 * 2)	/* Data Fault Address Register */
+#define c6_IFAR		(c6_DFAR + 1)	/* Instruction Fault Address Register */
+#define c10_PRRR	(MAIR_EL1 * 2)	/* Primary Region Remap Register */
+#define c10_NMRR	(c10_PRRR + 1)	/* Normal Memory Remap Register */
+#define c12_VBAR	(VBAR_EL1 * 2)	/* Vector Base Address Register */
+#define c13_CID		(CONTEXTIDR_EL1 * 2)	/* Context ID Register */
+#define c13_TID_URW	(TPIDR_EL0 * 2)	/* Thread ID, User R/W */
+#define c13_TID_URO	(TPIDRRO_EL0 * 2)/* Thread ID, User R/O */
+#define c13_TID_PRIV	(TPIDR_EL1 * 2)	/* Thread ID, Privileged */
+#define c10_AMAIR	(AMAIR_EL1 * 2)	/* Aux Memory Attr Indirection Reg */
+#define c14_CNTKCTL	(CNTKCTL_EL1 * 2) /* Timer Control Register (PL1) */
+#define NR_CP15_REGS	(NR_SYS_REGS * 2)
 
 #define ARM_EXCEPTION_IRQ	  0
 #define ARM_EXCEPTION_TRAP	  1
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 2fdeb32..3f5830b 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -84,7 +84,10 @@ struct kvm_vcpu_fault_info {
 
 struct kvm_cpu_context {
 	struct kvm_regs	gp_regs;
-	u64 sys_regs[NR_SYS_REGS];
+	union {
+		u64 sys_regs[NR_SYS_REGS];
+		u32 cp15[NR_CP15_REGS];
+	};
 };
 
 typedef struct kvm_cpu_context kvm_cpu_context_t;
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index fb60f90..5b1110c 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -23,7 +23,12 @@
 #define __ARM_KVM_H__
 
 #define KVM_SPSR_EL1	0
-#define KVM_NR_SPSR	1
+#define KVM_SPSR_SVC	KVM_SPSR_EL1
+#define KVM_SPSR_ABT	1
+#define KVM_SPSR_UND	2
+#define KVM_SPSR_IRQ	3
+#define KVM_SPSR_FIQ	4
+#define KVM_NR_SPSR	5
 
 #ifndef __ASSEMBLY__
 #include <asm/types.h>
-- 
1.8.2.3
