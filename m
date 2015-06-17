From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 17 Jun 2015 14:40:38 +0200
Subject: [PATCH v2 1/2] clk: at91: cleanup PMC header file for PCR register
 fields
Message-ID: <62604b586c61f119ffb5942b77eb9b759c17a790.1434544584.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add _MASK and _OFFSET values and cleanup register fields layout.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/clk/at91/clk-peripheral.c |  8 ++++----
 include/linux/clk/at91_pmc.h      | 14 ++++++--------
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 597fed423d7d..61d0adda7088 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -165,7 +165,7 @@ static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
 	if (periph->id < PERIPHERAL_ID_MIN)
 		return 0;
 
-	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID) |
+	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK) |
 				     AT91_PMC_PCR_CMD |
 				     AT91_PMC_PCR_DIV(periph->div) |
 				     AT91_PMC_PCR_EN);
@@ -180,7 +180,7 @@ static void clk_sam9x5_peripheral_disable(struct clk_hw *hw)
 	if (periph->id < PERIPHERAL_ID_MIN)
 		return;
 
-	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID) |
+	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK) |
 				     AT91_PMC_PCR_CMD);
 }
 
@@ -194,7 +194,7 @@ static int clk_sam9x5_peripheral_is_enabled(struct clk_hw *hw)
 		return 1;
 
 	pmc_lock(pmc);
-	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID));
+	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK));
 	ret = !!(pmc_read(pmc, AT91_PMC_PCR) & AT91_PMC_PCR_EN);
 	pmc_unlock(pmc);
 
@@ -213,7 +213,7 @@ clk_sam9x5_peripheral_recalc_rate(struct clk_hw *hw,
 		return parent_rate;
 
 	pmc_lock(pmc);
-	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID));
+	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID_MASK));
 	tmp = pmc_read(pmc, AT91_PMC_PCR);
 	pmc_unlock(pmc);
 
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 7669f7618f39..dfc59e2b64fb 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -182,13 +182,11 @@ extern void __iomem *at91_pmc_base;
 #define AT91_PMC_PCSR1		0x108			/* Peripheral Clock Enable Register 1 */
 
 #define AT91_PMC_PCR		0x10c			/* Peripheral Control Register [some SAM9 and SAMA5] */
-#define		AT91_PMC_PCR_PID	(0x3f  <<  0)		/* Peripheral ID */
-#define		AT91_PMC_PCR_CMD	(0x1  <<  12)		/* Command (read=0, write=1) */
-#define		AT91_PMC_PCR_DIV(n)	((n)  <<  16)		/* Divisor Value */
-#define			AT91_PMC_PCR_DIV0	0x0			/* Peripheral clock is MCK */
-#define			AT91_PMC_PCR_DIV2	0x1			/* Peripheral clock is MCK/2 */
-#define			AT91_PMC_PCR_DIV4	0x2			/* Peripheral clock is MCK/4 */
-#define			AT91_PMC_PCR_DIV8	0x3			/* Peripheral clock is MCK/8 */
-#define		AT91_PMC_PCR_EN		(0x1  <<  28)		/* Enable */
+#define		AT91_PMC_PCR_PID_MASK		0x3f
+#define		AT91_PMC_PCR_CMD		(0x1  <<  12)				/* Command (read=0, write=1) */
+#define		AT91_PMC_PCR_DIV_OFFSET		16
+#define		AT91_PMC_PCR_DIV_MASK		(0x3  << AT91_PMC_PCR_DIV_OFFSET)
+#define		AT91_PMC_PCR_DIV(n)		((n)  << AT91_PMC_PCR_DIV_OFFSET)	/* Divisor Value */
+#define		AT91_PMC_PCR_EN			(0x1  <<  28)				/* Enable */
 
 #endif
-- 
2.1.3
