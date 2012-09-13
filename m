From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 13 Sep 2012 11:20:47 +0100
Subject: [RFC PATCH 2/6] ARM: mm: add v7 cache LoUIS API implementation
In-Reply-To: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1347531651-28218-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1347531651-28218-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM v7 architecture introduces the concept of cache levels and registers to
probe and manage cache levels accordingly.

This patch adds v7 support for cache LoUIS (Level of Unification Inner
Shareable) operations and defines a function that allows to clean and
invalidate data caches up to LoUIS.

Power-down operations like hotplug and CPU idle require to clean/invalidate
only cache levels that are within the CPU power domain, and LoUIS reflects
this requirement properly in most of the systems.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 arch/arm/mm/cache-v7.S | 42 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index 39e3fb3..74aec79 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -33,6 +33,24 @@ ENTRY(v7_flush_icache_all)
 	mov	pc, lr
 ENDPROC(v7_flush_icache_all)
 
+ /*
+ *     v7_flush_dcache_louis()
+ *
+ *     Flush the D-cache up to the Level of Unification Inner Shareable
+ *
+ *     Corrupted registers: r0-r7, r9-r11 (r6 only in Thumb mode)
+ */
+
+ENTRY(v7_flush_dcache_louis)
+	dmb					@ ensure ordering with previous memory accesses
+	mrc	p15, 1, r0, c0, c0, 1		@ read clidr
+	ands	r3, r0, #0xe00000		@ extract louis from clidr
+	mov	r3, r3, lsr #20			@ left align louis bit field
+	moveq	pc, lr				@ return if level == 0
+	mov	r10, #0				@ starting level == 0
+	b	__flush_level
+ENDPROC(v7_flush_dcache_louis)
+
 /*
  *	v7_flush_dcache_all()
  *
@@ -49,7 +67,7 @@ ENTRY(v7_flush_dcache_all)
 	mov	r3, r3, lsr #23			@ left align loc bit field
 	beq	finished			@ if loc is 0, then no need to clean
 	mov	r10, #0				@ start clean at cache level 0
-loop1:
+__flush_level:
 	add	r2, r10, r10, lsr #1		@ work out 3x current cache level
 	mov	r1, r0, lsr r2			@ extract cache type bits from clidr
 	and	r1, r1, #7			@ mask of the bits for current cache only
@@ -88,7 +106,7 @@ loop3:
 skip:
 	add	r10, r10, #2			@ increment cache number
 	cmp	r3, r10
-	bgt	loop1
+	bgt	__flush_level
 finished:
 	mov	r10, #0				@ swith back to cache level 0
 	mcr	p15, 2, r10, c0, c0, 0		@ select current cache level in cssr
@@ -120,6 +138,24 @@ ENTRY(v7_flush_kern_cache_all)
 	mov	pc, lr
 ENDPROC(v7_flush_kern_cache_all)
 
+ /*
+ *     v7_flush_kern_cache_louis(void)
+ *
+ *     Flush the data cache up to Level of Unification Inner Shareable.
+ *     Invalidate the I-cache to the point of unification.
+ */
+ENTRY(v7_flush_kern_cache_louis)
+ ARM(	stmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
+ THUMB(	stmfd	sp!, {r4-r7, r9-r11, lr}	)
+	bl	v7_flush_dcache_louis
+	mov	r0, #0
+	ALT_SMP(mcr	p15, 0, r0, c7, c1, 0)	@ invalidate I-cache inner shareable
+	ALT_UP(mcr	p15, 0, r0, c7, c5, 0)	@ I+BTB cache invalidate
+ ARM(	ldmfd	sp!, {r4-r5, r7, r9-r11, lr}	)
+ THUMB(	ldmfd	sp!, {r4-r7, r9-r11, lr}	)
+	mov	pc, lr
+ENDPROC(v7_flush_kern_cache_louis)
+
 /*
  *	v7_flush_cache_all()
  *
@@ -350,4 +386,4 @@ ENDPROC(v7_dma_unmap_area)
 	__INITDATA
 
 	@ define struct cpu_cache_fns (see <asm/cacheflush.h> and proc-macros.S)
-	define_cache_functions v7
+       define_cache_functions v7, cachelouis=1
-- 
1.7.12
