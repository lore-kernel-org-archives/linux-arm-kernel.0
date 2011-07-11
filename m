From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 11 Jul 2011 17:38:57 +0100
Subject: [PATCH 1/1] ARM: Only clean the D-cache to the PoU in v7_flush_kern_dcache_area()
Message-ID: <mailman.18.1310402988.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With PIPT caches (like ARMv7), there is no need to clean&invalidate the
D-cache via the __cpuc_flush_dcache_area() function as there are no
aliases.  The D-cache only needs to be cleaned for the coherency with
the I-cache.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm/mm/cache-v7.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/cache-v7.S b/arch/arm/mm/cache-v7.S
index d32f02b..b4faccd 100644
--- a/arch/arm/mm/cache-v7.S
+++ b/arch/arm/mm/cache-v7.S
@@ -224,7 +224,7 @@ ENTRY(v7_flush_kern_dcache_area)
 	sub	r3, r2, #1
 	bic	r0, r0, r3
 1:
-	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line / unified line
+	mcr	p15, 0, r0, c7, c11, 1		@ clean D line to the point of unification
 	add	r0, r0, r2
 	cmp	r0, r1
 	blo	1b


-- 
Catalin
