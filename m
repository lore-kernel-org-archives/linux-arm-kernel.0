From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 18 Nov 2010 15:46:30 +0000
Subject: [PATCH 1/2] ARM: Use CTR instead of CCSIDR for the D-cache line
	size on ARMv7
Message-ID: <20101118154630.5680.36667.stgit@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current implementation of the dcache_line_size macro reads the L1
cache size from the CCSIDR register. This, however, is not guaranteed to
be the smallest cache line in the cache hierarchy. The patch changes to
the macro to use the more architecturally correct CTR register.

Reported-by: Kevin Sapp <ksapp@quicinc.com>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/proc-macros.S |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/proc-macros.S b/arch/arm/mm/proc-macros.S
index 337f102..a5e2253 100644
--- a/arch/arm/mm/proc-macros.S
+++ b/arch/arm/mm/proc-macros.S
@@ -61,14 +61,14 @@
 	.endm
 
 /*
- * cache_line_size - get the cache line size from the CSIDR register
- * (available on ARMv7+). It assumes that the CSSR register was configured
- * to access the L1 data cache CSIDR.
+ * dcache_line_size - get the minimum D-cache line size from the CTR register
+ * on ARMv7.
  */
 	.macro	dcache_line_size, reg, tmp
-	mrc	p15, 1, \tmp, c0, c0, 0		@ read CSIDR
-	and	\tmp, \tmp, #7			@ cache line size encoding
-	mov	\reg, #16			@ size offset
+	mrc	p15, 0, \tmp, c0, c0, 1		@ read ctr
+	lsr	\tmp, \tmp, #16
+	and	\tmp, \tmp, #0xf		@ cache line size encoding
+	mov	\reg, #4			@ bytes per word
 	mov	\reg, \reg, lsl \tmp		@ actual cache line size
 	.endm
 
