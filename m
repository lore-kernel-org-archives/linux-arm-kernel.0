From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Dec 2012 16:10:42 +0000
Subject: [PATCH] ARM: cache: flush to LoUU instead of LoUIS on uniprocessor
 CPUs
Message-ID: <1355760642-28559-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

flush_cache_louis flushes the D-side caches to the point of unification
inner-shareable. On uniprocessor CPUs, this is defined as zero and
therefore no flushing will take place. Rather than invent a new interface
for UP systems, instead use our SMP_ON_UP patching code to read the
LoUU from the CLIDR instead.

Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Tested-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mm/cache-v7.S | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index cd95664..7539ec2 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -44,8 +44,10 @@ ENDPROC(v7_flush_icache_all)
 ENTRY(v7_flush_dcache_louis)
 	dmb					@ ensure ordering with previous memory accesses
 	mrc	p15, 1, r0, c0, c0, 1		@ read clidr, r0 = clidr
-	ands	r3, r0, #0xe00000		@ extract LoUIS from clidr
-	mov	r3, r3, lsr #20			@ r3 = LoUIS * 2
+	ALT_SMP(ands	r3, r0, #(7 << 21))	@ extract LoUIS from clidr
+	ALT_UP(ands	r3, r0, #(7 << 27))	@ extract LoUU from clidr
+	ALT_SMP(mov	r3, r3, lsr #20)	@ r3 = LoUIS * 2
+	ALT_UP(mov	r3, r3, lsr #26)	@ r3 = LoUU * 2
 	moveq	pc, lr				@ return if level == 0
 	mov	r10, #0				@ r10 (starting level) = 0
 	b	flush_levels			@ start flushing cache levels
-- 
1.8.0
