From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 03 Apr 2015 11:54:27 +0100
Subject: [PATCH 3/7] ARM: cache-v7: consolidate initialisation of cache level
 index
In-Reply-To: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
References: <20150403100848.GZ24899@n2100.arm.linux.org.uk>
Message-ID: <E1YdzF5-0008Cn-HQ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Both v7_flush_cache_louis and v7_flush_dcache_all both begin the
flush_levels loop with r10 initialised to zero.  In each case, this
is done immediately prior to entering the loop.  Branch to this
instruction in v7_flush_dcache_all from v7_flush_cache_louis and
eliminate the unnecessary initialisation in v7_flush_cache_louis.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/cache-v7.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index d062f8cbb886..5b5d0c00bca7 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -103,8 +103,7 @@ ALT_UP(	mov	r3, r0, lsr #26)		@ move LoUU into position
 	moveqs	r3, #1 << 1			@   fix LoUIS value (and set flags state to 'ne')
 #endif
 	reteq	lr				@ return if level == 0
-	mov	r10, #0				@ r10 (starting level) = 0
-	b	flush_levels			@ start flushing cache levels
+	b	start_flush_levels		@ start flushing cache levels
 ENDPROC(v7_flush_dcache_louis)
 
 /*
@@ -122,6 +121,7 @@ ENTRY(v7_flush_dcache_all)
 	mov	r3, r0, lsr #23			@ move LoC into position
 	ands	r3, r3, #7 << 1			@ extract LoC*2 from clidr
 	beq	finished			@ if loc is 0, then no need to clean
+start_flush_levels:
 	mov	r10, #0				@ start clean@cache level 0
 flush_levels:
 	add	r2, r10, r10, lsr #1		@ work out 3x current cache level
-- 
1.8.3.1
