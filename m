From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Wed, 10 Nov 2010 19:50:24 -0600
Subject: [PATCH 01/02] omap: dsp: remove shm from normal memory
In-Reply-To: <1289440225-27221-1-git-send-email-omar.ramirez@ti.com>
References: <1289440225-27221-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1289440225-27221-2-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Felipe Contreras <felipe.contreras@gmail.com>

Also, don't be picky about the location, which incidentally fixes the
build since MEMBLOCK_REAL_LIMIT is gone on 2.6.37.

arch/arm/plat-omap/devices.c: In function 'omap_dsp_reserve_sdram_memblock':
arch/arm/plat-omap/devices.c:287: error: 'MEMBLOCK_REAL_LIMIT'
    undeclared (first use in this function)

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
---
 arch/arm/plat-omap/devices.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
index 6f42a18..fc81912 100644
--- a/arch/arm/plat-omap/devices.c
+++ b/arch/arm/plat-omap/devices.c
@@ -284,12 +284,14 @@ void __init omap_dsp_reserve_sdram_memblock(void)
 	if (!size)
 		return;
 
-	paddr = __memblock_alloc_base(size, SZ_1M, MEMBLOCK_REAL_LIMIT);
+	paddr = memblock_alloc(size, SZ_1M);
 	if (!paddr) {
 		pr_err("%s: failed to reserve %x bytes\n",
 				__func__, size);
 		return;
 	}
+	memblock_free(paddr, size);
+	memblock_remove(paddr, size);
 
 	omap_dsp_phys_mempool_base = paddr;
 }
-- 
1.7.1
