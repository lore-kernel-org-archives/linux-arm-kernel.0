From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Feb 2016 15:29:32 +0100
Subject: [PATCH 1/4] ARM: shmobile: rcar-gen2: Make rcar_gen2_dma_contiguous
 static
In-Reply-To: <cover.1454595116.git.horms+renesas@verge.net.au>
References: <cover.1454595116.git.horms+renesas@verge.net.au>
Message-ID: <0c1690705417ac1b33f01125552349e3cfc9766d.1454595116.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

make C=1:

    arch/arm/mach-shmobile/setup-rcar-gen2.c:186:12: warning: symbol 'rcar_gen2_dma_contiguous' was not declared. Should it be static?

Make it static, and move it inside the function to avoid a "defined but
not used" warning if CONFIG_DMA_CMA=n.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-rcar-gen2.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-rcar-gen2.c b/arch/arm/mach-shmobile/setup-rcar-gen2.c
index 9eccde3c7b13..6d0ebdfb03a2 100644
--- a/arch/arm/mach-shmobile/setup-rcar-gen2.c
+++ b/arch/arm/mach-shmobile/setup-rcar-gen2.c
@@ -182,8 +182,6 @@ static int __init rcar_gen2_scan_mem(unsigned long node, const char *uname,
 	return 0;
 }
 
-struct cma *rcar_gen2_dma_contiguous;
-
 void __init rcar_gen2_reserve(void)
 {
 	struct memory_reserve_config mrc;
@@ -194,8 +192,11 @@ void __init rcar_gen2_reserve(void)
 
 	of_scan_flat_dt(rcar_gen2_scan_mem, &mrc);
 #ifdef CONFIG_DMA_CMA
-	if (mrc.size && memblock_is_region_memory(mrc.base, mrc.size))
+	if (mrc.size && memblock_is_region_memory(mrc.base, mrc.size)) {
+		static struct cma *rcar_gen2_dma_contiguous;
+
 		dma_contiguous_reserve_area(mrc.size, mrc.base, 0,
 					    &rcar_gen2_dma_contiguous, true);
+	}
 #endif
 }
-- 
2.7.0.rc3.207.g0ac5344
