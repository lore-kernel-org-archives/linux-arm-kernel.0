From: will.deacon@arm.com (Will Deacon)
Date: Fri, 26 Jan 2018 12:03:11 +0000
Subject: [PATCH 1/7] arm64: Add software workaround for Falkor erratum 1041
In-Reply-To: <1516968197-23206-1-git-send-email-will.deacon@arm.com>
References: <1516968197-23206-1-git-send-email-will.deacon@arm.com>
Message-ID: <1516968197-23206-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shanker Donthineni <shankerd@codeaurora.org>

The ARM architecture defines the memory locations that are permitted
to be accessed as the result of a speculative instruction fetch from
an exception level for which all stages of translation are disabled.
Specifically, the core is permitted to speculatively fetch from the
4KB region containing the current program counter 4K and next 4K.

When translation is changed from enabled to disabled for the running
exception level (SCTLR_ELn[M] changed from a value of 1 to 0), the
Falkor core may errantly speculatively access memory locations outside
of the 4KB region permitted by the architecture. The errant memory
access may lead to one of the following unexpected behaviors.

1) A System Error Interrupt (SEI) being raised by the Falkor core due
   to the errant memory access attempting to access a region of memory
   that is protected by a slave-side memory protection unit.
2) Unpredictable device behavior due to a speculative read from device
   memory. This behavior may only occur if the instruction cache is
   disabled prior to or coincident with translation being changed from
   enabled to disabled.

The conditions leading to this erratum will not occur when either of the
following occur:
 1) A higher exception level disables translation of a lower exception level
   (e.g. EL2 changing SCTLR_EL1[M] from a value of 1 to 0).
 2) An exception level disabling its stage-1 translation if its stage-2
    translation is enabled (e.g. EL1 changing SCTLR_EL1[M] from a value of 1
    to 0 when HCR_EL2[VM] has a value of 1).

To avoid the errant behavior, software must execute an ISB immediately
prior to executing the MSR that will change SCTLR_ELn[M] from 1 to 0.

Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 12 +++++++++++-
 arch/arm64/include/asm/assembler.h     | 10 ++++++++++
 arch/arm64/kernel/cpu-reset.S          |  1 +
 arch/arm64/kernel/efi-entry.S          |  2 ++
 arch/arm64/kernel/head.S               |  1 +
 arch/arm64/kernel/relocate_kernel.S    |  1 +
 arch/arm64/kvm/hyp-init.S              |  1 +
 8 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index b9d93e981a05..c1d520de6dfe 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -75,3 +75,4 @@ stable kernels.
 | Qualcomm Tech. | Kryo/Falkor v1  | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
 | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
+| Qualcomm Tech. | Falkor v{1,2}   | E1041           | QCOM_FALKOR_ERRATUM_1041    |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1d51c8edf34b..b488076d63c2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -550,7 +550,6 @@ config QCOM_QDF2400_ERRATUM_0065
 
 	  If unsure, say Y.
 
-
 config SOCIONEXT_SYNQUACER_PREITS
 	bool "Socionext Synquacer: Workaround for GICv3 pre-ITS"
 	default y
@@ -569,6 +568,17 @@ config HISILICON_ERRATUM_161600802
 	  a 128kB offset to be applied to the target address in this commands.
 
 	  If unsure, say Y.
+
+config QCOM_FALKOR_ERRATUM_E1041
+	bool "Falkor E1041: Speculative instruction fetches might cause errant memory access"
+	default y
+	help
+	  Falkor CPU may speculatively fetch instructions from an improper
+	  memory location when MMU translation is changed from SCTLR_ELn[M]=1
+	  to SCTLR_ELn[M]=0. Prefix an ISB instruction to fix the problem.
+
+	  If unsure, say Y.
+
 endmenu
 
 
diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 794fe8122602..3873dd7b5a32 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -523,4 +523,14 @@ alternative_endif
 #endif
 	.endm
 
+/**
+ * Errata workaround prior to disable MMU. Insert an ISB immediately prior
+ * to executing the MSR that will change SCTLR_ELn[M] from a value of 1 to 0.
+ */
+	.macro pre_disable_mmu_workaround
+#ifdef CONFIG_QCOM_FALKOR_ERRATUM_E1041
+	isb
+#endif
+	.endm
+
 #endif	/* __ASM_ASSEMBLER_H */
diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 65f42d257414..2a752cb2a0f3 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -37,6 +37,7 @@ ENTRY(__cpu_soft_restart)
 	mrs	x12, sctlr_el1
 	ldr	x13, =SCTLR_ELx_FLAGS
 	bic	x12, x12, x13
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x12
 	isb
 
diff --git a/arch/arm64/kernel/efi-entry.S b/arch/arm64/kernel/efi-entry.S
index 4e6ad355bd05..6b9736c3fb56 100644
--- a/arch/arm64/kernel/efi-entry.S
+++ b/arch/arm64/kernel/efi-entry.S
@@ -96,6 +96,7 @@ ENTRY(entry)
 	mrs	x0, sctlr_el2
 	bic	x0, x0, #1 << 0	// clear SCTLR.M
 	bic	x0, x0, #1 << 2	// clear SCTLR.C
+	pre_disable_mmu_workaround
 	msr	sctlr_el2, x0
 	isb
 	b	2f
@@ -103,6 +104,7 @@ ENTRY(entry)
 	mrs	x0, sctlr_el1
 	bic	x0, x0, #1 << 0	// clear SCTLR.M
 	bic	x0, x0, #1 << 2	// clear SCTLR.C
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x0
 	isb
 2:
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index c3b241b8b659..ba3ab04788dc 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -849,6 +849,7 @@ __primary_switch:
 	 * to take into account by discarding the current kernel mapping and
 	 * creating a new one.
 	 */
+	pre_disable_mmu_workaround
 	msr	sctlr_el1, x20			// disable the MMU
 	isb
 	bl	__create_page_tables		// recreate kernel mapping
diff --git a/arch/arm64/kernel/relocate_kernel.S b/arch/arm64/kernel/relocate_kernel.S
index ce704a4aeadd..f407e422a720 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -45,6 +45,7 @@ ENTRY(arm64_relocate_new_kernel)
 	mrs	x0, sctlr_el2
 	ldr	x1, =SCTLR_ELx_FLAGS
 	bic	x0, x0, x1
+	pre_disable_mmu_workaround
 	msr	sctlr_el2, x0
 	isb
 1:
diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index 8a00de187e56..e086c6eff8c6 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -153,6 +153,7 @@ reset:
 	mrs	x5, sctlr_el2
 	ldr	x6, =SCTLR_ELx_FLAGS
 	bic	x5, x5, x6		// Clear SCTL_M and etc
+	pre_disable_mmu_workaround
 	msr	sctlr_el2, x5
 	isb
 
-- 
2.1.4
