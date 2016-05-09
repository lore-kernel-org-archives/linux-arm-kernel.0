From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  9 May 2016 17:49:45 +0100
Subject: [PATCH 1/6] arm64: alternatives: drop enable parameter from _else and
 _endif macro
In-Reply-To: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
References: <1462812590-4494-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1462812590-4494-2-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 77ee306c0aea9 ("arm64: alternatives: add enable parameter to
conditional asm macros") extended the alternative assembly macros.
Unfortunately this does not really work as one would expect, as the
enable parameter in fact correctly protects the alternative section
magic, but not the actual code sequences.
So if enable is false, we will have the original instruction(s) _and_
the alternative ones in the file, which is just wrong.
To make this work one would need to additionally protect the
alternative sequence with extra .if directives, which makes
the intention of the enable parameter rather pointless.
Instead users should directly guard the whole "_else; insn; _endif"
sequence with .if directives.
Add a comment describing this usage and drop the enable parameter from
the alternative_else and alternative_endif macros.

This reverts parts of commit 77ee306c0aea ("arm64: alternatives: add
enable parameter to conditional asm macros").

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/alternative.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index beccbde..502c9ef 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -94,6 +94,8 @@ void apply_alternatives(void *start, size_t length);
  *
  * The code that follows this macro will be assembled and linked as
  * normal. There are no restrictions on this code.
+ * If you use the enable parameter, see the comments below for _else
+ * and _endif.
  */
 .macro alternative_if_not cap, enable = 1
 	.if \enable
@@ -117,23 +119,33 @@ void apply_alternatives(void *start, size_t length);
  * 2. Not contain a branch target that is used outside of the
  *    alternative sequence it is defined in (branches into an
  *    alternative sequence are not fixed up).
+ *
+ * If you used the optional enable parameter in the opening
+ * alternative_if_not macro above, please protect the whole _else
+ * branch with an .if directive:
+ *	alternative_if_not CAP_SOMETHING, condition
+ *		orig_insn
+ *	.if condition
+ *	alternative_else
+ *		repl_insn
+ *	alternative_endif
+ *	.endif
  */
-.macro alternative_else, enable = 1
-	.if \enable
+.macro alternative_else
 662:	.pushsection .altinstr_replacement, "ax"
 663:
-	.endif
 .endm
 
 /*
  * Complete an alternative code sequence.
+ *
+ * Please mind the comment at alternative_else above if you used the
+ * optional enable parameter with the opening alternative_if_not macro.
  */
-.macro alternative_endif, enable = 1
-	.if \enable
+.macro alternative_endif
 664:	.popsection
 	.org	. - (664b-663b) + (662b-661b)
 	.org	. - (662b-661b) + (664b-663b)
-	.endif
 .endm
 
 #define _ALTERNATIVE_CFG(insn1, insn2, cap, cfg, ...)	\
-- 
2.7.3
