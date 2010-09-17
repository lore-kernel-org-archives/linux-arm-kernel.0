From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 17 Sep 2010 15:17:46 +0530
Subject: [PATCH 02/14] omap: Map only available sram memory
In-Reply-To: <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently we map 1 MB section while setting up SRAM on OMAPs.
The actual physcal OCM RAM available on OMAP SOCs is in order
of KBs. This patch maps only available sram and removes some
non necessary cpu_is_xxx checks.

On the newer ARMs with speculation, this is dangerous and can
result in untraceable aborts.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/sram.c |   25 +++++--------------------
 1 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/arm/plat-omap/sram.c b/arch/arm/plat-omap/sram.c
index 226b2e8..10b3b4c 100644
--- a/arch/arm/plat-omap/sram.c
+++ b/arch/arm/plat-omap/sram.c
@@ -220,20 +220,7 @@ void __init omap_map_sram(void)
 	if (omap_sram_size == 0)
 		return;
 
-	if (cpu_is_omap24xx()) {
-		omap_sram_io_desc[0].virtual = OMAP2_SRAM_VA;
-
-		base = OMAP2_SRAM_PA;
-		base = ROUND_DOWN(base, PAGE_SIZE);
-		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
-	}
-
 	if (cpu_is_omap34xx()) {
-		omap_sram_io_desc[0].virtual = OMAP3_SRAM_VA;
-		base = OMAP3_SRAM_PA;
-		base = ROUND_DOWN(base, PAGE_SIZE);
-		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
-
 		/*
 		 * SRAM must be marked as non-cached on OMAP3 since the
 		 * CORE DPLL M2 divider change code (in SRAM) runs with the
@@ -244,13 +231,11 @@ void __init omap_map_sram(void)
 		omap_sram_io_desc[0].type = MT_MEMORY_NONCACHED;
 	}
 
-	if (cpu_is_omap44xx()) {
-		omap_sram_io_desc[0].virtual = OMAP4_SRAM_VA;
-		base = OMAP4_SRAM_PA;
-		base = ROUND_DOWN(base, PAGE_SIZE);
-		omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
-	}
-	omap_sram_io_desc[0].length = 1024 * 1024;	/* Use section desc */
+	omap_sram_io_desc[0].virtual = omap_sram_base;
+	base = omap_sram_start;
+	base = ROUND_DOWN(base, PAGE_SIZE);
+	omap_sram_io_desc[0].pfn = __phys_to_pfn(base);
+	omap_sram_io_desc[0].length = ROUND_DOWN(omap_sram_size, PAGE_SIZE);
 	iotable_init(omap_sram_io_desc, ARRAY_SIZE(omap_sram_io_desc));
 
 	printk(KERN_INFO "SRAM: Mapped pa 0x%08lx to va 0x%08lx size: 0x%lx\n",
-- 
1.6.0.4
