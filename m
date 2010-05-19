From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 19 May 2010 17:41:02 +0530
Subject: [PATCH v2] ARMv7: Use the Inner Shareable I-cache on MP
Message-ID: <1274271062-30807-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes the flush_cache_all for ARMv7 SMP. It was
missing from commit b8349b569aae661dea9d59d7d2ee587ccea3336c

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
Updated version after removing the not necessary second hunk
 
arch/arm/mm/cache-v7.S |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 06a90dc..5009635 100644
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
-- 
1.6.0.4
