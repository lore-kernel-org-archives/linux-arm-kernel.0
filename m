From: james.morse@arm.com (James Morse)
Date: Thu, 16 Jul 2015 17:01:58 +0100
Subject: [PATCH 4/5] arm64: kernel: Add optional CONFIG_ parameter to
 ALTERNATIVE().
In-Reply-To: <1437062519-18883-1-git-send-email-james.morse@arm.com>
References: <1437062519-18883-1-git-send-email-james.morse@arm.com>
Message-ID: <1437062519-18883-5-git-send-email-james.morse@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some uses of ALTERNATIVE() may depend on a feature that is disabled at
compile time by a Kconfig option. In this case the unused alternative
instructions waste space, and if the original instruction is a nop, it
wastes time and space.

This patch adds an optional 'config' option to ALTERNATIVE() and
alternative_insn that allows the compiler to remove both the original
and alternative instructions if the config option is not defined.

Signed-off-by: James Morse <james.morse@arm.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 arch/arm64/include/asm/alternative.h | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index c385a0c4057f..5598182dea28 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -3,6 +3,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/kconfig.h>
 #include <linux/types.h>
 #include <linux/stddef.h>
 #include <linux/stringify.h>
@@ -40,7 +41,8 @@ void free_alternatives_memory(void);
  * be fixed in a binutils release posterior to 2.25.51.0.2 (anything
  * containing commit 4e4d08cf7399b606 or c1baaddf8861).
  */
-#define ALTERNATIVE(oldinstr, newinstr, feature)			\
+#define __ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg_enabled)	\
+	".if "__stringify(cfg_enabled)" == 1\n"				\
 	"661:\n\t"							\
 	oldinstr "\n"							\
 	"662:\n"							\
@@ -53,7 +55,11 @@ void free_alternatives_memory(void);
 	"664:\n\t"							\
 	".popsection\n\t"						\
 	".org	. - (664b-663b) + (662b-661b)\n\t"			\
-	".org	. - (662b-661b) + (664b-663b)\n"
+	".org	. - (662b-661b) + (664b-663b)\n"			\
+	".endif\n"
+
+#define _ALTERNATIVE_CFG(oldinstr, newinstr, feature, cfg, ...)	\
+	__ALTERNATIVE_CFG(oldinstr, newinstr, feature, IS_ENABLED(cfg))
 
 #else
 
@@ -65,7 +71,8 @@ void free_alternatives_memory(void);
 	.byte \alt_len
 .endm
 
-.macro alternative_insn insn1 insn2 cap
+.macro alternative_insn insn1, insn2, cap, enable = 1
+	.if \enable
 661:	\insn1
 662:	.pushsection .altinstructions, "a"
 	altinstruction_entry 661b, 663f, \cap, 662b-661b, 664f-663f
@@ -75,8 +82,23 @@ void free_alternatives_memory(void);
 664:	.popsection
 	.org	. - (664b-663b) + (662b-661b)
 	.org	. - (662b-661b) + (664b-663b)
+	.endif
 .endm
 
+#define _ALTERNATIVE_CFG(insn1, insn2, cap, cfg, ...)	\
+	alternative_insn insn1, insn2, cap, IS_ENABLED(cfg)
+
+
 #endif  /*  __ASSEMBLY__  */
 
+/*
+ * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature));
+ *
+ * Usage: asm(ALTERNATIVE(oldinstr, newinstr, feature, CONFIG_FOO));
+ * N.B. If CONFIG_FOO is specified, but not selected, the whole block
+ *      will be omitted, including oldinstr.
+ */
+#define ALTERNATIVE(oldinstr, newinstr, ...)   \
+	_ALTERNATIVE_CFG(oldinstr, newinstr, __VA_ARGS__, 1)
+
 #endif /* __ASM_ALTERNATIVE_H */
-- 
2.1.4
