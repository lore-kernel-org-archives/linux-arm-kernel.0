From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Sat, 11 Jan 2014 13:05:21 +0000
Subject: [PATCH v4 2/5] arm: add new asm macro update_sctlr
In-Reply-To: <1389445524-30623-1-git-send-email-leif.lindholm@linaro.org>
References: <1389445524-30623-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1389445524-30623-3-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new macro for setting/clearing bits in the SCTLR.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Suggested-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/assembler.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 5c22851..aba6458 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -383,4 +383,17 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+#ifdef CONFIG_CPU_CP15
+/* Macro for setting/clearing bits in sctlr */
+	.macro update_sctlr, set:req, clear:req, tmp:req, tmp2:req
+	mrc	p15, 0, \tmp, c1, c0, 0
+	ldr	\tmp2, =\set
+	orr	\tmp, \tmp, \tmp2
+	ldr	\tmp2, =\clear
+	mvn	\tmp2, \tmp2
+	and	\tmp, \tmp, \tmp2
+	mcr	p15, 0, \tmp, c1, c0, 0
+	.endm
+#endif
+
 #endif /* __ASM_ASSEMBLER_H__ */
-- 
1.7.10.4
