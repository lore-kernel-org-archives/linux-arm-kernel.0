From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 5 Sep 2012 23:34:45 +0000 (UTC)
Subject: [PATCH] ARM: OMAP4: wakeupgen: remove duplicate AUXCOREBOOT*
 read/write
Message-ID: <alpine.DEB.2.00.1209052333410.11516@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


The wakeupgen context-save code reads and stores the AUXCOREBOOT0 and
AUXCOREBOOT1 register contents twice.  This seems like a waste of
time, so, remove the duplicates.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---

Santosh, care to review/ack this one?

 arch/arm/mach-omap2/omap-wakeupgen.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap-wakeupgen.c b/arch/arm/mach-omap2/omap-wakeupgen.c
index 05fdebf..b55432d 100644
--- a/arch/arm/mach-omap2/omap-wakeupgen.c
+++ b/arch/arm/mach-omap2/omap-wakeupgen.c
@@ -233,12 +233,6 @@ static inline void omap4_irq_save_context(void)
 	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);
 
 	/* Save SyncReq generation logic */
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + AUXCOREBOOT0_OFFSET);
-	val = __raw_readl(wakeupgen_base + OMAP_AUX_CORE_BOOT_0);
-	__raw_writel(val, sar_base + AUXCOREBOOT1_OFFSET);
-
-	/* Save SyncReq generation logic */
 	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_MASK);
 	__raw_writel(val, sar_base + PTMSYNCREQ_MASK_OFFSET);
 	val = __raw_readl(wakeupgen_base + OMAP_PTMSYNCREQ_EN);
-- 
1.7.10.4
