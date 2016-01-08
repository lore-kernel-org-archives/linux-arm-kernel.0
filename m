From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri,  8 Jan 2016 12:54:27 +0000
Subject: [PATCH] arm64: kernel: fix PMUv3 registers unconditional access
Message-ID: <1452257667-7967-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Performance Monitors extension is an optional feature of the
AArch64 architecture, therefore, in order to access Performance
Monitors registers safely, the kernel should detect the PMUv3 unit
presence through the ID_AA64DFR0_EL1 register PMUVer field before
accessing them.

This patch implements a guard by reading the ID_AA64DFR0_EL1 register
PMUVer field to detect the PMUv3 presence and prevent accessing PMUv3
system registers if the Performance Monitors extension is not
implemented in the core.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>
---
Based on arm64 for-next/perf branch.

Tested on QEMU and Juno, I checked that the reported PMUVer field
is correct on both A57 and A53 (ie == 0x1), it should leave behaviour
unchanged on platforms implementing PMUv3.

 arch/arm64/kernel/head.S    |  5 +++++
 arch/arm64/mm/proc-macros.S | 12 ++++++++++++
 arch/arm64/mm/proc.S        |  4 ++--
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 23cfc08..6146fea 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -512,9 +512,14 @@ CPU_LE(	movk	x0, #0x30d0, lsl #16	)	// Clear EE and E0E on LE systems
 #endif
 
 	/* EL2 debug */
+	mrs	x0, id_aa64dfr0_el1		// Check ID_AA64DFR0_EL1 PMUVer
+	ubfx	x0, x0, #8, #4
+	cmp	x0, #1
+	b.ne	4f				// Skip if no PMUv3 present
 	mrs	x0, pmcr_el0			// Disable debug access traps
 	ubfx	x0, x0, #11, #5			// to EL2 and allow access to
 	msr	mdcr_el2, x0			// all PMU counters from EL1
+4:
 
 	/* Stage-2 translation */
 	msr	vttbr_el2, xzr
diff --git a/arch/arm64/mm/proc-macros.S b/arch/arm64/mm/proc-macros.S
index 4c4d93c..25b43c1 100644
--- a/arch/arm64/mm/proc-macros.S
+++ b/arch/arm64/mm/proc-macros.S
@@ -62,3 +62,15 @@
 	bfi	\valreg, \tmpreg, #TCR_T0SZ_OFFSET, #TCR_TxSZ_WIDTH
 #endif
 	.endm
+
+/*
+ * reset_pmuserenr_el0 - reset PMUSERENR_EL0 if PMUv3 present
+ */
+	.macro	reset_pmuserenr_el0, tmpreg
+	mrs	\tmpreg, id_aa64dfr0_el1	// Check ID_AA64DFR0_EL1 PMUVer
+	ubfx	\tmpreg, \tmpreg, #8, #4
+	cmp	\tmpreg, #1			// Skip if no PMUv3 present
+	b.ne	9000f
+	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
+9000:
+	.endm
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 9c4dce3..b8f04b3 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -117,7 +117,7 @@ ENTRY(cpu_do_resume)
 	 */
 	ubfx	x11, x11, #1, #1
 	msr	oslar_el1, x11
-	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
+	reset_pmuserenr_el0 x0			// Disable PMU access from EL0
 	mov	x0, x12
 	dsb	nsh		// Make sure local tlb invalidation completed
 	isb
@@ -156,7 +156,7 @@ ENTRY(__cpu_setup)
 	msr	cpacr_el1, x0			// Enable FP/ASIMD
 	mov	x0, #1 << 12			// Reset mdscr_el1 and disable
 	msr	mdscr_el1, x0			// access to the DCC from EL0
-	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
+	reset_pmuserenr_el0 x0			// Disable PMU access from EL0
 	/*
 	 * Memory region attributes for LPAE:
 	 *
-- 
2.5.1
