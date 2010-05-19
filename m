From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 19 May 2010 17:28:21 +0530
Subject: [PATCH] ARMv7: Use the Inner Shareable I-cache on MP
Message-ID: <1274270301-28592-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the flush_cache_all for ARMv7 SMP. It was
missing from commit b8349b569aae661dea9d59d7d2ee587ccea3336c

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-v7.S |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 06a90dc..d9b7128 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -91,7 +91,11 @@ ENTRY(v7_flush_kern_cache_all)
  THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
 	bl	v7_flush_dcache_all
 	mov	r0, #0
+#ifdef CONFIG_SMP
+	mcr	p15, 0, r0, c7, c1, 0		@ invalidate I-cache inner shareable
+#elese
 	mcr	p15, 0, r0, c7, c5, 0		@ I+BTB cache invalidate
+#endif
  ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
  THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
 	mov	pc, lr
@@ -168,7 +172,7 @@ ENTRY(v7_coherent_user_range)
 	blo	1b
 	mov	r0, #0
 #ifdef CONFIG_SMP
-	mcr	p15, 0, r0, c7, c1, 6		@ invalidate BTB Inner Shareable
+	mcr	p15, 0, r0, c7, c1, 6		@ invalidate BTB inner shareable
 #else
 	mcr	p15, 0, r0, c7, c5, 6		@ invalidate BTB
 #endif
-- 
1.6.0.4
