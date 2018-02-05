From: timur@codeaurora.org (Timur Tabi)
Date: Mon,  5 Feb 2018 14:11:30 -0600
Subject: [PATCH 2/2] [for 4.14] arm64: Add software workaround for Falkor
 erratum 1041
In-Reply-To: <1517861490-19395-1-git-send-email-timur@codeaurora.org>
References: <1517861490-19395-1-git-send-email-timur@codeaurora.org>
Message-ID: <1517861490-19395-3-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shanker Donthineni <shankerd@codeaurora.org>

commit 932b50c7c1c6 upstream

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

A minor conflict in arch/arm64/Kconfig was resolved when back-porting
this commit from 4.15.

 Documentation/arm64/silicon-errata.txt |  1 +
 arch/arm64/Kconfig                     | 10 ++++++++++
 arch/arm64/include/asm/assembler.h     | 10 ++++++++++
 arch/arm64/kernel/cpu-reset.S          |  1 +
 arch/arm64/kernel/efi-entry.S          |  2 ++
 arch/arm64/kernel/head.S               |  1 +
 arch/arm64/kernel/relocate_kernel.S    |  1 +
 arch/arm64/kvm/hyp-init.S              |  1 +
 8 files changed, 27 insertions(+)

diff --git a/Documentation/arm64/silicon-errata.txt b/Documentation/arm64/silicon-errata.txt
index 66e8ce14d23d..704770c0edf2 100644
--- a/Documentation/arm64/silicon-errata.txt
+++ b/Documentation/arm64/silicon-errata.txt
@@ -74,3 +74,4 @@ stable kernels.
 | Qualcomm Tech. | Falkor v1       | E1003           | QCOM_FALKOR_ERRATUM_1003    |
 | Qualcomm Tech. | Falkor v1       | E1009           | QCOM_FALKOR_ERRATUM_1009    |
 | Qualcomm Tech. | QDF2400 ITS     | E0065           | QCOM_QDF2400_ERRATUM_0065   |
+| Qualcomm Tech. | Falkor v{1,2}   | E1041           | QCOM_FALKOR_ERRATUM_1041    |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0df64a6a56d4..8f73eaccf50a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -539,6 +539,16 @@ config QCOM_QDF2400_ERRATUM_0065
 
 	  If unsure, say Y.
 
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
index d58a6253c6ab..7896728f3b22 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -499,4 +499,14 @@
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
index 0b243ecaf7ac..6657ae4f3c7a 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -732,6 +732,7 @@ __primary_switch:
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
index 3f9615582377..870828c364c5 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -151,6 +151,7 @@ reset:
 	mrs	x5, sctlr_el2
 	ldr	x6, =SCTLR_ELx_FLAGS
 	bic	x5, x5, x6		// Clear SCTL_M and etc
+	pre_disable_mmu_workaround
 	msr	sctlr_el2, x5
 	isb
 
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
