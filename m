From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon,  7 Oct 2013 14:12:27 +0200
Subject: [RFC PATCH 1/5] ARM64: allow limited use of some NEON registers in
 exceptions
In-Reply-To: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1381147951-7609-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1381147951-7609-2-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stack/unstack the bottom 4 NEON registers on exception entry/exit
so we can use them in places where we are not allowed to sleep.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/Kconfig              | 14 ++++++++++++++
 arch/arm64/include/asm/ptrace.h |  3 +++
 arch/arm64/kernel/asm-offsets.c |  3 +++
 arch/arm64/kernel/entry.S       |  8 ++++++++
 4 files changed, 28 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c044548..b97a458 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -98,6 +98,9 @@ config IOMMU_HELPER
 config KERNEL_MODE_NEON
 	def_bool y
 
+config STACK_NEON_REGS_ON_EXCEPTION
+	def_bool n
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
@@ -219,6 +222,17 @@ config FORCE_MAX_ZONEORDER
 	default "14" if (ARM64_64K_PAGES && TRANSPARENT_HUGEPAGE)
 	default "11"
 
+config KERNEL_MODE_SYNC_CE_CRYPTO
+	bool "Support for synchronous crypto ciphers using Crypto Extensions"
+	depends on KERNEL_MODE_NEON
+	select STACK_NEON_REGS_ON_EXCEPTION
+	help
+	  This enables support for using ARMv8 Crypto Extensions instructions
+	  in places where sleeping is not allowed. The synchronous ciphers are
+	  only allowed to use the bottom 4 NEON register q0 - q3, as stacking
+	  the entire NEON register file at every exception is too costly.
+
+
 endmenu
 
 menu "Boot options"
diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
index 0dacbbf..17ea483 100644
--- a/arch/arm64/include/asm/ptrace.h
+++ b/arch/arm64/include/asm/ptrace.h
@@ -103,6 +103,9 @@ struct pt_regs {
 	};
 	u64 orig_x0;
 	u64 syscallno;
+#ifdef CONFIG_STACK_NEON_REGS_ON_EXCEPTION
+	struct { u64 l, h; } qregs[4];
+#endif
 };
 
 #define arch_has_single_step()	(1)
diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
index 666e231..73c944a 100644
--- a/arch/arm64/kernel/asm-offsets.c
+++ b/arch/arm64/kernel/asm-offsets.c
@@ -58,6 +58,9 @@ int main(void)
   DEFINE(S_PC,			offsetof(struct pt_regs, pc));
   DEFINE(S_ORIG_X0,		offsetof(struct pt_regs, orig_x0));
   DEFINE(S_SYSCALLNO,		offsetof(struct pt_regs, syscallno));
+#ifdef CONFIG_STACK_NEON_REGS_ON_EXCEPTION
+  DEFINE(S_QREGS,		offsetof(struct pt_regs, qregs));
+#endif
   DEFINE(S_FRAME_SIZE,		sizeof(struct pt_regs));
   BLANK();
   DEFINE(MM_CONTEXT_ID,		offsetof(struct mm_struct, context.id));
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 3881fd1..c74dcca 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -58,6 +58,10 @@
 	push	x4, x5
 	push	x2, x3
 	push	x0, x1
+#ifdef CONFIG_STACK_NEON_REGS_ON_EXCEPTION
+	add	x21, sp, #S_QREGS
+	st1	{v0.16b-v3.16b}, [x21]
+#endif
 	.if	\el == 0
 	mrs	x21, sp_el0
 	.else
@@ -86,6 +90,10 @@
 	.endm
 
 	.macro	kernel_exit, el, ret = 0
+#ifdef CONFIG_STACK_NEON_REGS_ON_EXCEPTION
+	add	x21, sp, #S_QREGS
+	ld1	{v0.16b-v3.16b}, [x21]
+#endif
 	ldp	x21, x22, [sp, #S_PC]		// load ELR, SPSR
 	.if	\el == 0
 	ldr	x23, [sp, #S_SP]		// load return stack pointer
-- 
1.8.1.2
