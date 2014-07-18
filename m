From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Fri, 18 Jul 2014 15:00:48 +0100
Subject: [PATCH 2/7] arm: add new asm macro update_sctlr
In-Reply-To: <1405692053-7514-1-git-send-email-leif.lindholm@linaro.org>
References: <1405692053-7514-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <1405692053-7514-3-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A new macro for setting/clearing bits in the SCTLR.

Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
Suggested-by: Will Deacon <will.deacon@arm.com>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/assembler.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 57f0584..c0cabba 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -425,4 +425,18 @@ THUMB(	orr	\reg , \reg , #PSR_T_BIT	)
 #endif
 	.endm
 
+#ifdef CONFIG_CPU_CP15
+/* Macro for setting/clearing bits in sctlr */
+	.macro	update_sctlr, tmp:req, set=, clear=
+	mrc	p15, 0, \tmp, c1, c0, 0
+	.ifnc	\set,
+	orr	\tmp, \tmp, \set
+	.endif
+	.ifnc	\clear,
+	bic	\tmp, \tmp, \clear
+	.endif
+	mcr	p15, 0, \tmp, c1, c0, 0
+	.endm
+#endif
+
 #endif /* __ASM_ASSEMBLER_H__ */
-- 
1.7.10.4
