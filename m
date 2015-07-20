From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 20 Jul 2015 16:10:00 +0100
Subject: [PATCH v2 1/5] arm64: alternative: Provide if/else/endif assembler
 macros
In-Reply-To: <1437405004-1296-1-git-send-email-daniel.thompson@linaro.org>
References: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
 <1437405004-1296-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1437405004-1296-2-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The existing alternative_insn macro has some limitations that make it
hard to work with. In particular the fact it takes instructions from it
own macro arguments means it doesn't play very nicely with C pre-processor
macros because the macro arguments look like a string to the C
pre-processor. Workarounds are (probably) possible but things start to
look ugly.

Introduce an alternative set of macros that allows instructions to be
presented to the assembler as normal and switch everything over to the
new macros.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/include/asm/alternative.h | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm64/include/asm/alternative.h b/arch/arm64/include/asm/alternative.h
index c385a0c4057f..31b19ad18f7e 100644
--- a/arch/arm64/include/asm/alternative.h
+++ b/arch/arm64/include/asm/alternative.h
@@ -77,6 +77,46 @@ void free_alternatives_memory(void);
 	.org	. - (662b-661b) + (664b-663b)
 .endm
 
+/*
+ * Begin an alternative code sequence.
+ *
+ * The code that follows this marco will be assembled and linked as
+ * normal. There are no restrictions on this code.
+ */
+.macro alternative_if_not cap
+	.pushsection .altinstructions, "a"
+	altinstruction_entry 661f, 663f, \cap, 662f-661f, 664f-663f
+	.popsection
+661:
+.endm
+
+/*
+ * Provide the alternative code sequence.
+ *
+ * The code that follows this macro is assembled into a special
+ * section to be used for dynamic patching. Code that follows this
+ * macro must:
+ *
+ * 1. Be exactly the same length (in bytes) as the default code
+ *    sequence.
+ *
+ * 2. Not jump to local labels defined outside of the alternative
+ *    sequence.
+ */
+.macro alternative_else
+662:	.pushsection .altinstr_replacement, "ax"
+663:
+.endm
+
+/*
+ * Complete an alternative code sequence.
+ */
+.macro alternative_endif
+664:	.popsection
+	.org	. - (664b-663b) + (662b-661b)
+	.org	. - (662b-661b) + (664b-663b)
+.endm
+
 #endif  /*  __ASSEMBLY__  */
 
 #endif /* __ASM_ALTERNATIVE_H */
-- 
2.4.3
