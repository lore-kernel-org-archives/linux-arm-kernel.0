From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 12 Jul 2017 14:28:27 +0100
Subject: [boot-wrapper] [PATCH 1/2] gic-v3: Make sure all the supported SPIs
 are marked non-secure
Message-ID: <1499866108-15140-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The maximum SPI INTID is 32(N+1) - 1, where N = GICD_TYPER:ITLinesNumber.
But currently we only mark the range, {32, 32*(N)-1} as Group1 non-secure.
If there happens to be an SPI allocated in the last 32 INTIDs, the EL1
will fail to use them as it would be marked Group0.

Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 gic-v3.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/gic-v3.c b/gic-v3.c
index 476f703..1372e8c 100644
--- a/gic-v3.c
+++ b/gic-v3.c
@@ -45,7 +45,7 @@ void gic_secure_init_primary(void)
 	unsigned int i;
 	void *gicr_ptr = (void *)GIC_RDIST_BASE;
 	void *gicd_base = (void *)GIC_DIST_BASE;
-	uint32_t typer;
+	uint32_t typer, n_itlines;
 
 	raw_writel(GICD_CTLR_EnableGrp0 | GICD_CTLR_EnableGrp1ns
 		| GICD_CTLR_EnableGrp1s | GICD_CTLR_ARE_S | GICD_CTLR_ARE_NS,
@@ -82,8 +82,9 @@ void gic_secure_init_primary(void)
 
 	} while (!(typer & GICR_TYPER_Last));
 
-	typer = raw_readl(gicd_base + GICD_TYPER);
-	for (i = 1; i < (typer & GICD_TYPER_ITLineNumber); i++) {
+	n_itlines = raw_readl(gicd_base + GICD_TYPER) & GICD_TYPER_ITLineNumber;
+	/* Maximum SPI INTID = 32(ITLinesNumber + 1) - 1 */
+	for (i = 1; i < n_itlines + 1; i++) {
 		raw_writel(~0x0, gicd_base + GICD_IGROUP0 + i * 4);
 		raw_writel(0x0, gicd_base + GICD_IGRPMOD0 + i * 4);
 	}
-- 
2.7.5
