From: omar.ramirez@ti.com (Omar Ramirez Luna)
Date: Mon, 18 Apr 2011 11:39:40 -0500
Subject: [PATCH v2 1/3] OMAP3: l3: fix for "irq 10: nobody cared" message
In-Reply-To: <1303144782-5591-1-git-send-email-omar.ramirez@ti.com>
References: <1303144782-5591-1-git-send-email-omar.ramirez@ti.com>
Message-ID: <1303144782-5591-2-git-send-email-omar.ramirez@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If an error occurs in the L3 on any other initiator than MPU,
the interrupt goes unhandled given that the 'base' register
was calculated with the initialized err_source value (which
coincidentally points to MPU) and not with the actual source
of the error.

Removed parenthesis that are not needed for the touched lines.

Signed-off-by: Omar Ramirez Luna <omar.ramirez@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-omap2/omap_l3_smx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_l3_smx.c b/arch/arm/mach-omap2/omap_l3_smx.c
index 5f2da75..4321e79 100644
--- a/arch/arm/mach-omap2/omap_l3_smx.c
+++ b/arch/arm/mach-omap2/omap_l3_smx.c
@@ -196,11 +196,11 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
 		/* No timeout error for debug sources */
 	}
 
-	base = ((l3->rt) + (*(omap3_l3_bases[int_type] + err_source)));
-
 	/* identify the error source */
 	for (err_source = 0; !(status & (1 << err_source)); err_source++)
 									;
+
+	base = l3->rt + *(omap3_l3_bases[int_type] + err_source);
 	error = omap3_l3_readll(base, L3_ERROR_LOG);
 
 	if (error) {
-- 
1.7.1
