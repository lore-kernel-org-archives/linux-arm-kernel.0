From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 24 Jul 2015 17:42:15 -0400 (EDT)
Subject: [PATCH] ARM: asm/unified.h: guard the IT macros against redefinition
 when using LTO
Message-ID: <alpine.LFD.2.20.1507241739280.1806@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


With LTO, the intermediate representation for each .c file contains those
global assembly macro definitions. When the lot is merged together during
the final link, we get duplicate definition errors:

[...]
/tmp/cc48fUMp.s:42352: Error: Macro `it' was already defined
/tmp/cc48fUMp.s:42354: Error: Macro `itt' was already defined
/tmp/cc48fUMp.s:42356: Error: Macro `ite' was already defined
[...]

Guard those against redefinitions.

Signed-off-by: Nicolas Pitre <nico@linaro.org>

diff --git a/arch/arm/include/asm/unified.h b/arch/arm/include/asm/unified.h
index a91ae49961..ee257a3de7 100644
--- a/arch/arm/include/asm/unified.h
+++ b/arch/arm/include/asm/unified.h
@@ -103,6 +103,8 @@
 	.endm
 #else	/* !__ASSEMBLY__ */
 __asm__(
+/* the .L_it_macros_defined guards against redefinition in the LTO case */
+"	.ifndef	.L_it_macros_defined\n"
 "	.macro	it, cond\n"
 "	.endm\n"
 "	.macro	itt, cond\n"
@@ -132,7 +134,9 @@ __asm__(
 "	.macro	iteet, cond\n"
 "	.endm\n"
 "	.macro	iteee, cond\n"
-"	.endm\n");
+"	.endm\n"
+"	.set	.L_it_macros_defined,1\n"
+"	.endif");
 #endif	/* __ASSEMBLY__ */
 
 #endif	/* CONFIG_ARM_ASM_UNIFIED */
