From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 14 Oct 2015 12:20:31 +0100
Subject: [PATCHv3 08/11] arm64: Check for selected granule support
In-Reply-To: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
References: <1444821634-1689-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1444821634-1689-9-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that the selected page size is supported by the
CPU(s).

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/include/asm/sysreg.h |   12 ++++++++++++
 arch/arm64/kernel/head.S        |   28 ++++++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index a7f3d4b..1f07cc5 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -44,6 +44,18 @@
 #define SET_PSTATE_PAN(x) __inst_arm(0xd5000000 | REG_PSTATE_PAN_IMM |\
 				     (!!x)<<8 | 0x1f)
 
+
+#define ID_AA64MMFR0_TGRAN4_SHIFT	28
+#define ID_AA64MMFR0_TGRAN64_SHIFT	24
+#define ID_AA64MMFR0_TGRAN16_SHIFT	20
+
+#define ID_AA64MMFR0_TGRAN4_NI		0xf
+#define ID_AA64MMFR0_TGRAN4_ON		0x0
+#define ID_AA64MMFR0_TGRAN64_NI		0xf
+#define ID_AA64MMFR0_TGRAN64_ON		0x0
+#define ID_AA64MMFR0_TGRAN16_NI		0x0
+#define ID_AA64MMFR0_TGRAN16_ON		0x1
+
 #ifdef __ASSEMBLY__
 
 	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 7ace955..b6aa9e0 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -31,10 +31,11 @@
 #include <asm/cputype.h>
 #include <asm/kernel-pgtable.h>
 #include <asm/memory.h>
-#include <asm/thread_info.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/sysreg.h>
+#include <asm/thread_info.h>
 #include <asm/virt.h>
 
 #define __PHYS_OFFSET	(KERNEL_START - TEXT_OFFSET)
@@ -613,10 +614,28 @@ ENDPROC(__secondary_switched)
  *  x0  = SCTLR_EL1 value for turning on the MMU.
  *  x27 = *virtual* address to jump to upon completion
  *
- * other registers depend on the function called upon completion
+ * Other registers depend on the function called upon completion.
+ *
+ * Checks if the selected granule size is supported by the CPU.
+ * If it doesn't park the CPU
  */
+#if	defined(CONFIG_ARM64_64K_PAGES)
+
+#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN64_SHIFT
+#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN64_ON
+
+#else
+
+#define id_aa64mmfr0_tgran_shift	ID_AA64MMFR0_TGRAN4_SHIFT
+#define id_aa64mmfr0_tgran_on		ID_AA64MMFR0_TGRAN4_ON
+
+#endif
 	.section	".idmap.text", "ax"
 __enable_mmu:
+	mrs	x1, ID_AA64MMFR0_EL1
+	ubfx	x2, x1, #id_aa64mmfr0_tgran_shift, 4
+	cmp	x2, #id_aa64mmfr0_tgran_on
+	b.ne	__no_granule_support
 	ldr	x5, =vectors
 	msr	vbar_el1, x5
 	msr	ttbr0_el1, x25			// load TTBR0
@@ -634,3 +653,8 @@ __enable_mmu:
 	isb
 	br	x27
 ENDPROC(__enable_mmu)
+
+__no_granule_support:
+	wfe
+	b __no_granule_support
+ENDPROC(__no_granule_support)
-- 
1.7.9.5
