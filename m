From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 25 Nov 2016 19:38:58 +0000
Subject: [RFC PATCH 10/29] arm64/sve: Boot-time feature enablement
In-Reply-To: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
References: <1480102762-23647-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1480102762-23647-11-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables Scalable Vector Extension access for the kernel
on boot.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/kvm_arm.h |  1 +
 arch/arm64/include/asm/sysreg.h  | 10 ++++++++++
 arch/arm64/kernel/head.S         | 16 +++++++++++++++-
 arch/arm64/mm/proc.S             | 22 +++++++++++++++++++++-
 4 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index 2a2752b..ae7afb2 100644
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
index ccce9ad..09a44b3 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -302,4 +302,14 @@ static inline void config_sctlr_el1(u32 clear, u32 set)
 
 #endif
 
+#define ZIDR_EL1	sys_reg(3, 0, 0, 0, 7)
+#define ZCR_EL1		sys_reg(3, 0, 1, 2, 0)
+#define ZCR_EL2		sys_reg(3, 4, 1, 2, 0)
+
+#define ZCR_EL1_LEN_MASK	0x1ff
+
+#define CPACR_EL1_ZEN_EL1EN	(1 << 16)
+#define CPACR_EL1_ZEN_EL0EN	(1 << 17)
+#define CPACR_EL1_ZEN		(CPACR_EL1_ZEN_EL1EN | CPACR_EL1_ZEN_EL0EN)
+
 #endif	/* __ASM_SYSREG_H */
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 332e331..ae4448f 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -572,9 +572,23 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 
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
+	mrs_s	x1, ZIDR_EL1			// Scalable Vector Extension:
+	and	x1, x1, #ZCR_EL1_LEN_MASK	// Enable full vector length
+	msr_s	ZCR_EL2, x1			// for EL1.
+	b	1f
 
+4:	msr	cptr_el2, x0			// Disable copro. traps to EL2
+1:
 #ifdef CONFIG_COMPAT
 	msr	hstr_el2, xzr			// Disable CP15 traps to EL2
 #endif
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 352c73b..1da8160 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -27,6 +27,7 @@
 #include <asm/pgtable-hwdef.h>
 #include <asm/cpufeature.h>
 #include <asm/alternative.h>
+#include <asm/sysreg.h>
 
 #ifdef CONFIG_ARM64_64K_PAGES
 #define TCR_TG_FLAGS	TCR_TG0_64K | TCR_TG1_64K
@@ -184,12 +185,31 @@ ENTRY(__cpu_setup)
 	dsb	nsh
 
 	mov	x0, #3 << 20
+
+	/* SVE */
+	mrs	x5, id_aa64pfr0_el1
+	ubfx	x5, x5, #ID_AA64PFR0_SVE_SHIFT, #4
+	cbz	x5, 1f
+
+	bic	x0, x0, #CPACR_EL1_ZEN
+	orr	x0, x0, #CPACR_EL1_ZEN_EL1EN	// SVE: trap for EL0, not EL1
 	msr	cpacr_el1, x0			// Enable FP/ASIMD
-	mov	x0, #1 << 12			// Reset mdscr_el1 and disable
+	isb
+
+	mrs_s	x5, ZIDR_EL1			// SVE: Enable full vector len
+	and	x5, x5, #ZCR_EL1_LEN_MASK	// initially
+	msr_s	ZCR_EL1, x5
+
+	b	2f
+
+1:	msr	cpacr_el1, x0			// Enable FP/ASIMD
+
+2:	mov	x0, #1 << 12			// Reset mdscr_el1 and disable
 	msr	mdscr_el1, x0			// access to the DCC from EL0
 	isb					// Unmask debug exceptions now,
 	enable_dbg				// since this is per-cpu
 	reset_pmuserenr_el0 x0			// Disable PMU access from EL0
+
 	/*
 	 * Memory region attributes for LPAE:
 	 *
-- 
2.1.4
