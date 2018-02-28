From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:51 +0800
Subject: [PATCH 29/29] arm64: idmap: Use "awx" flags for .idmap.text
 .pushsection directives
In-Reply-To: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
Message-ID: <1519790211-16582-30-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Will Deacon <will.deacon@arm.com>

commit 439e70e27a51 upstream.

The identity map is mapped as both writeable and executable by the
SWAPPER_MM_MMUFLAGS and this is relied upon by the kpti code to manage
a synchronisation flag. Update the .pushsection flags to reflect the
actual mapping attributes.

Reported-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Alex Shi <alex.shi@linaro.org>
---
 arch/arm64/kernel/cpu-reset.S | 2 +-
 arch/arm64/kernel/head.S      | 2 +-
 arch/arm64/kernel/sleep.S     | 2 +-
 arch/arm64/mm/proc.S          | 8 ++++----
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
index 65f42d2..f736a6f 100644
--- a/arch/arm64/kernel/cpu-reset.S
+++ b/arch/arm64/kernel/cpu-reset.S
@@ -16,7 +16,7 @@
 #include <asm/virt.h>
 
 .text
-.pushsection    .idmap.text, "ax"
+.pushsection    .idmap.text, "awx"
 
 /*
  * __cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2) - Helper for
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 539bebc..fa52817 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -473,7 +473,7 @@ ENDPROC(__primary_switched)
  * end early head section, begin head code that is also used for
  * hotplug and needs to have the same protections as the text region
  */
-	.section ".idmap.text","ax"
+	.section ".idmap.text","awx"
 
 ENTRY(kimage_vaddr)
 	.quad		_text - TEXT_OFFSET
diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
index 1bec41b..0030d69 100644
--- a/arch/arm64/kernel/sleep.S
+++ b/arch/arm64/kernel/sleep.S
@@ -95,7 +95,7 @@ ENTRY(__cpu_suspend_enter)
 	ret
 ENDPROC(__cpu_suspend_enter)
 
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(cpu_resume)
 	bl	el2_setup		// if in EL2 drop to EL1 cleanly
 	bl	__cpu_setup
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 5c268f5..c07d9cc 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -83,7 +83,7 @@ ENDPROC(cpu_do_suspend)
  *
  * x0: Address of context pointer
  */
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(cpu_do_resume)
 	ldp	x2, x3, [x0]
 	ldp	x4, x5, [x0, #16]
@@ -147,7 +147,7 @@ alternative_else_nop_endif
 	ret
 ENDPROC(cpu_do_switch_mm)
 
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 
 .macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
 	adrp	\tmp1, empty_zero_page
@@ -180,7 +180,7 @@ ENDPROC(idmap_cpu_replace_ttbr1)
 	.popsection
 
 #ifdef CONFIG_UNMAP_KERNEL_AT_EL0
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 
 	.macro	__idmap_kpti_get_pgtable_ent, type
 	dc	cvac, cur_\()\type\()p		// Ensure any existing dirty
@@ -368,7 +368,7 @@ ENDPROC(idmap_kpti_install_ng_mappings)
  *	Initialise the processor for turning the MMU on.  Return in x0 the
  *	value of the SCTLR_EL1 register.
  */
-	.pushsection ".idmap.text", "ax"
+	.pushsection ".idmap.text", "awx"
 ENTRY(__cpu_setup)
 	tlbi	vmalle1				// Invalidate local TLB
 	dsb	nsh
-- 
2.7.4
