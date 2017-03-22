From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 22 Mar 2017 14:50:40 +0000
Subject: [RFC PATCH v2 10/41] arm64/sve: Boot-time feature enablement
In-Reply-To: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
References: <1490194274-30569-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1490194274-30569-11-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables Scalable Vector Extension access for the kernel
on boot.

If entered at EL2 without VHE support, ZCR_EL2 is also configured
to allow the maximum available vector length for EL1 initially, so
that the vector length can be correctly probed in advance of KVM
being initialised.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h |  1 +
 arch/arm64/include/asm/sysreg.h  | 10 ++++++++++
 arch/arm64/kernel/head.S         | 15 ++++++++++++++-
 arch/arm64/mm/proc.S             | 14 ++++++++++++--
 4 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 6e99978..6f536ef 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -185,6 +185,7 @@
 #define CPTR_EL2_TCPAC	(1 << 31)
 #define CPTR_EL2_TTA	(1 << 20)
 #define CPTR_EL2_TFP	(1 << CPTR_EL2_TFP_SHIFT)
+#define CPTR_EL2_TZ	(1 << 8)
 #define CPTR_EL2_DEFAULT	0x000033ff
 
 /* Hyp Debug Configuration Register bits */
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 8f1a43e..9c4a2cc 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -118,6 +118,9 @@
 #define SYS_ID_AA64MMFR1_EL1		sys_reg(3, 0, 0, 7, 1)
 #define SYS_ID_AA64MMFR2_EL1		sys_reg(3, 0, 0, 7, 2)
 
+#define SYS_ZCR_EL1			sys_reg(3, 0, 1, 2, 0)
+#define SYS_ZCR_EL2			sys_reg(3, 4, 1, 2, 0)
+
 #define SYS_CNTFRQ_EL0			sys_reg(3, 3, 14, 0, 0)
 #define SYS_CTR_EL0			sys_reg(3, 3, 0, 0, 1)
 #define SYS_DCZID_EL0			sys_reg(3, 3, 0, 0, 7)
@@ -267,6 +270,13 @@
 #endif
 
 
+#define ZCR_EL1_LEN_MASK	0x1ff
+
+#define CPACR_EL1_ZEN_EL1EN	(1 << 16)
+#define CPACR_EL1_ZEN_EL0EN	(1 << 17)
+#define CPACR_EL1_ZEN		(CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN)
+
+
 /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
 #define SYS_MPIDR_SAFE_VAL		(1UL << 31)
 
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4fb6ccd..344a0dd 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -629,9 +629,22 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 
 	/* Coprocessor traps. */
 	mov	x0, #0x33ff
+
+	/* SVE register access */
+	mrs	x1, id_aa64pfr0_el1
+	ubfx	x1, x1, #ID_AA64PFR0_SVE_SHIFT, #4
+	cbz	x1, 4f
+
+	bic	x0, x0, #CPTR_EL2_TZ		// Disable SVE traps to EL2
 	msr	cptr_el2, x0			// Disable copro. traps to EL2
-1:
+	isb
+
+	mov	x1, #ZCR_EL1_LEN_MASK		// SVE: Enable full vector
+	msr_s	SYS_ZCR_EL1, x1			// length for EL1.
+	b	1f
 
+4:	msr	cptr_el2, x0			// Disable copro. traps to EL2
+1:
 #ifdef CONFIG_COMPAT
 	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
 #endif
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 877d42f..dd22ef2 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -27,6 +27,7 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
+#include <asm/sysreg.h>
 
 #ifdef CONFIG_ARM64_64K_PAGES
 #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
@@ -186,8 +187,17 @@ ENTRY(__cpu_setup)
 	tlbi	vmalle1				// Invalidate local TLB
 	dsb	nsh
 
-	mov	x0, #3 << 20
-	msr	cpacr_el1, x0			// Enable FP/ASIMD
+	mov	x0, #3 << 20			// FEN
+
+	/* SVE */
+	mrs	x5, id_aa64pfr0_el1
+	ubfx	x5, x5, #ID_AA64PFR0_SVE_SHIFT, #4
+	cbz	x5, 1f
+
+	bic	x0, x0, #CPACR_EL1_ZEN
+	orr	x0, x0, #CPACR_EL1_ZEN_EL1EN	// SVE: trap for EL0, not EL1
+1:	msr	cpacr_el1, x0			// Enable FP/ASIMD
+
 	mov	x0, #1 << 12			// Reset mdscr_el1 and disable
 	msr	mdscr_el1, x0			// access to the DCC from EL0
 	isb					// Unmask debug exceptions now,
-- 
2.1.4
