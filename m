From: james.morse@arm.com (James Morse)
Date: Tue, 21 Jul 2015 13:23:27 +0100
Subject: [PATCH v3 2/6] arm64: kernel: preparatory: Move config_sctlr_el1
In-Reply-To: <1437481411-1595-1-git-send-email-james.morse@arm.com>
References: <1437481411-1595-1-git-send-email-james.morse@arm.com>
Message-ID: <1437481411-1595-3-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Later patches need config_sctlr_el1 to set/clear bits in the sctlr_el1
register.

This patch moves this function into header a file.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/include/asm/cputype.h     |  3 ---
 arch/arm64/include/asm/sysreg.h      | 12 ++++++++++++
 arch/arm64/kernel/armv8_deprecated.c | 11 +----------
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index a84ec605bed8..ee6403df9fe4 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -81,9 +81,6 @@
 #define ID_AA64MMFR0_BIGEND(mmfr0)	\
 	(((mmfr0) & ID_AA64MMFR0_BIGEND_MASK) >> ID_AA64MMFR0_BIGEND_SHIFT)
 
-#define SCTLR_EL1_CP15BEN	(0x1 << 5)
-#define SCTLR_EL1_SED		(0x1 << 8)
-
 #ifndef __ASSEMBLY__
 
 /*
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 5c89df0acbcb..56391fbae1e1 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -20,6 +20,9 @@
 #ifndef __ASM_SYSREG_H
 #define __ASM_SYSREG_H
 
+#define SCTLR_EL1_CP15BEN	(0x1 << 5)
+#define SCTLR_EL1_SED		(0x1 << 8)
+
 #define sys_reg(op0, op1, crn, crm, op2) \
 	((((op0)-2)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))
 
@@ -55,6 +58,15 @@ asm(
 "	.endm\n"
 );
 
+static inline void config_sctlr_el1(u32 clear, u32 set)
+{
+	u32 val;
+
+	asm volatile("mrs %0, sctlr_el1" : "=r" (val));
+	val &= ~clear;
+	val |= set;
+	asm volatile("msr sctlr_el1, %0" : : "r" (val));
+}
 #endif
 
 #endif	/* __ASM_SYSREG_H */
diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 7922c2e710ca..78d56bff91fd 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -16,6 +16,7 @@
 
 #include <asm/insn.h>
 #include <asm/opcodes.h>
+#include <asm/sysreg.h>
 #include <asm/system_misc.h>
 #include <asm/traps.h>
 #include <asm/uaccess.h>
@@ -504,16 +505,6 @@ ret:
 	return 0;
 }
 
-static inline void config_sctlr_el1(u32 clear, u32 set)
-{
-	u32 val;
-
-	asm volatile("mrs %0, sctlr_el1" : "=r" (val));
-	val &= ~clear;
-	val |= set;
-	asm volatile("msr sctlr_el1, %0" : : "r" (val));
-}
-
 static int cp15_barrier_set_hw_mode(bool enable)
 {
 	if (enable)
-- 
2.1.4
