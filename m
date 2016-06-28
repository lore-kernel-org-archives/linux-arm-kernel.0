From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 28 Jun 2016 18:07:29 +0100
Subject: [PATCH v2 3/6] arm64: include alternative handling in
 dcache_by_line_op
In-Reply-To: <20160628170732.523-1-andre.przywara@arm.com>
References: <20160628170732.523-1-andre.przywara@arm.com>
Message-ID: <20160628170732.523-4-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly introduced dcache_by_line_op macro is used at least in
one occassion at the moment to issue a "dc cvau" instruction,
which is affected by ARM errata 819472, 826319, 827319 and 824069.
Change the macro to allow for alternative patching in there to
protect affected Cortex-A53 cores.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm64/include/asm/assembler.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index 10b017c..1a021f1 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -24,6 +24,7 @@
 #define __ASM_ASSEMBLER_H
 
 #include <asm/asm-offsets.h>
+#include <asm/cpufeature.h>
 #include <asm/page.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/ptrace.h>
@@ -261,7 +262,16 @@ lr	.req	x30		// link register
 	add	\size, \kaddr, \size
 	sub	\tmp2, \tmp1, #1
 	bic	\kaddr, \kaddr, \tmp2
-9998:	dc	\op, \kaddr
+9998:
+	.if	(\op == cvau || \op == cvac)
+		alternative_if_not ARM64_WORKAROUND_CLEAN_CACHE
+		dc	\op, \kaddr
+		alternative_else
+		dc	civac, \kaddr
+		alternative_endif
+	.else
+		dc	\op, \kaddr
+	.endif
 	add	\kaddr, \kaddr, \tmp1
 	cmp	\kaddr, \size
 	b.lo	9998b
-- 
2.9.0
