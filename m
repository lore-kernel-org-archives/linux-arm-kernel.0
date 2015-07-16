From: james.morse@arm.com (James Morse)
Date: Thu, 16 Jul 2015 17:01:55 +0100
Subject: [PATCH 1/5] arm64: kernel: preparatory: Move config_sctlr_el1
In-Reply-To: <1437062519-18883-1-git-send-email-james.morse@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
Message-ID: <1437062519-18883-2-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Later patches need config_sctlr_el1 to set/clear bits in the sctlr_el1
register.

This patch moves this function into header a file.

Signed-off-by: James Morse <james.morse@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/sysreg.h      |  9 +++++++++
 arch/arm64/kernel/armv8_deprecated.c | 11 +----------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 5c89df0acbcb..7e419fabe75a 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -55,6 +55,15 @@ asm(
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
