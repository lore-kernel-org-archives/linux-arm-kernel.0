From: premi@ti.com (Sanjeev Premi)
Date: Mon, 27 Jun 2011 16:06:49 +0530
Subject: [PATCHv2] omap3: beagle: Use GPTIMER1 for clockevents
Message-ID: <1309171009-8075-1-git-send-email-premi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>

Present current selection of the GPTIMER on Beagleboard
was result of a hardware issue in early versions of the
Beagleboards (Ax and B1 thru B4). [1][2]

Its been long since the hardware issue has been fixed.
This patch uses GPTIMER 1 for all newer board revisions
incl. Beagleboard XM.

Also, the clock source for GPTIMER12 is much less frequency
stable than clock sources for GPTIMER1. Using GPTIMER12 can
result in major time skew over a fairly short interval.

 [1] http://thread.gmane.org/gmane.comp.hardware.beagleboard.general/91
 [2] Errata #7 at http://elinux.org/BeagleBoard#Errata

Signed-off-by: Sanjeev Premi <premi@ti.com>
Reviewed-by: Paul Walmsley <paul@pwsan.com>
Cc: Hrishikesh Bhandiwad <hrishikesh.b@ti.com>
Cc: Thomas Weber <weber@corscience.de>
Cc: Jason Lam <lzg@ema-tech.com>
Cc: Gregoire Gentil <gregoire@gentil.com>
---

 Changes since v1:
   * Updated description with details from Paul Walmsley.
   * Changed author to Hrishikesh.
   * Expanded cc: to include original authors for other
     boards that are still using GPTIMER12.

 arch/arm/mach-omap2/board-omap3beagle.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 4b113b2..edc1596 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -509,7 +509,10 @@ static void __init omap3_beagle_init_irq(void)
 {
 	omap_init_irq();
 #ifdef CONFIG_OMAP_32K_TIMER
-	omap2_gp_clockevent_set_gptimer(12);
+	if (omap3_beagle_version == OMAP3BEAGLE_BOARD_AXBX)
+		omap2_gp_clockevent_set_gptimer(12);
+	else
+		omap2_gp_clockevent_set_gptimer(1);
 #endif
 }
 
-- 
1.7.2.2
