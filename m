From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 28 Aug 2013 12:35:55 +0100
Subject: [RFC PATCH 03/14] arm64: kernel: add structure to define cpu context
 layout
In-Reply-To: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1377689766-17642-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1377689766-17642-4-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to define registers that have to be saved and restored on
cpu suspend, this patch adds to the kernel a structure declaration
that defines registers that needs saving and restoring across power
cycles.
asm offsets for size and members of the struct are generated so that
assembly code can make use of them in the cpu_{suspend}/{resume} code
path.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm64/include/asm/processor.h | 18 ++++++++++++++++++
 arch/arm64/kernel/asm-offsets.c    | 12 ++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
index ab239b2..2b5f694 100644
--- a/arch/arm64/include/asm/processor.h
+++ b/arch/arm64/include/asm/processor.h
@@ -74,6 +74,24 @@ struct cpu_context {
 	unsigned long pc;
 };
 
+/*
+ * struct cpu_suspend_ctx must be 16-byte aligned since it is allocated on
+ * the stack, which must be 16-byte aligned on v8
+ */
+struct cpu_suspend_ctx {
+	unsigned long tpidr_el0;
+	unsigned long tpidrro_el0;
+	unsigned long contextidr_el1;
+	unsigned long mair_el1;
+	unsigned long cpacr_el1;
+	unsigned long ttbr0_el1;
+	unsigned long ttbr1_el1;
+	unsigned long tcr_el1;
+	unsigned long vbar_el1;
+	unsigned long sctlr_el1;
+	unsigned long sp;
+} __aligned(16);
+
 struct thread_struct {
 	struct cpu_context	cpu_context;	/* cpu context */
 	unsigned long		tp_value;
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index f300a13..77b12d1 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -140,6 +140,18 @@ int main(void)
   DEFINE(KVM_VGIC_VCTRL,	offsetof(struct kvm, arch.vgic.vctrl_base));
 #endif
 #ifdef CONFIG_ARM_CPU_SUSPEND
+  DEFINE(CPU_SUSPEND_SZ,	sizeof(struct cpu_suspend_ctx));
+  DEFINE(CPU_CTX_TPIDR_EL0,	offsetof(struct cpu_suspend_ctx, tpidr_el0));
+  DEFINE(CPU_CTX_TPIDRRO_EL0,	offsetof(struct cpu_suspend_ctx, tpidrro_el0));
+  DEFINE(CPU_CTX_CTXIDR_EL1,	offsetof(struct cpu_suspend_ctx, contextidr_el1));
+  DEFINE(CPU_CTX_MAIR_EL1,	offsetof(struct cpu_suspend_ctx, mair_el1));
+  DEFINE(CPU_CTX_CPACR_EL1,	offsetof(struct cpu_suspend_ctx, cpacr_el1));
+  DEFINE(CPU_CTX_TTBR0_EL1,	offsetof(struct cpu_suspend_ctx, ttbr0_el1));
+  DEFINE(CPU_CTX_TTBR1_EL1,	offsetof(struct cpu_suspend_ctx, ttbr1_el1));
+  DEFINE(CPU_CTX_TCR_EL1,	offsetof(struct cpu_suspend_ctx, tcr_el1));
+  DEFINE(CPU_CTX_VBAR_EL1,	offsetof(struct cpu_suspend_ctx, vbar_el1));
+  DEFINE(CPU_CTX_SCTLR_EL1,	offsetof(struct cpu_suspend_ctx, sctlr_el1));
+  DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
   DEFINE(MPIDR_HASH_MASK,	offsetof(struct mpidr_hash, mask));
   DEFINE(MPIDR_HASH_SHIFTS,	offsetof(struct mpidr_hash, shift_aff));
 #endif
-- 
1.8.3.4
