From: computersforpeace@gmail.com (Brian Norris)
Date: Mon,  3 Nov 2014 19:07:48 -0800
Subject: [PATCH] ARM: v7: replace magic numbers with CP15 macros
Message-ID: <1415070468-4667-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These CP15 register bit-masks are slightly more readable when using the
CP15 macro definitions from <asm/cp15.h>. They also assist in grepping
for sites which mess with SCTLR bits.

Tested on a B15 SMP x4 system, and checked the disassembly before/after
to confirm equivalence.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/mm/proc-v7.S | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
index b3a947863ac7..3f9dbe91168b 100644
--- a/arch/arm/mm/proc-v7.S
+++ b/arch/arm/mm/proc-v7.S
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <asm/assembler.h>
 #include <asm/asm-offsets.h>
+#include <asm/cp15.h>
 #include <asm/hwcap.h>
 #include <asm/pgtable-hwdef.h>
 #include <asm/pgtable.h>
@@ -31,8 +32,8 @@ ENDPROC(cpu_v7_proc_init)
 
 ENTRY(cpu_v7_proc_fin)
 	mrc	p15, 0, r0, c1, c0, 0		@ ctrl register
-	bic	r0, r0, #0x1000			@ ...i............
-	bic	r0, r0, #0x0006			@ .............ca.
+	bic	r0, r0, #CR_I			@ ...i............
+	bic	r0, r0, #(CR_C | CR_A)		@ .............ca.
 	mcr	p15, 0, r0, c1, c0, 0		@ disable caches
 	ret	lr
 ENDPROC(cpu_v7_proc_fin)
@@ -53,8 +54,8 @@ ENDPROC(cpu_v7_proc_fin)
 	.pushsection	.idmap.text, "ax"
 ENTRY(cpu_v7_reset)
 	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
-	bic	r1, r1, #0x1			@ ...............m
- THUMB(	bic	r1, r1, #1 << 30 )		@ SCTLR.TE (Thumb exceptions)
+	bic	r1, r1, #CR_M			@ ...............m
+ THUMB(	bic	r1, r1, #CR_TE )		@ SCTLR.TE (Thumb exceptions)
 	mcr	p15, 0, r1, c1, c0, 0		@ disable MMU
 	isb
 	bx	r0
-- 
1.9.1
