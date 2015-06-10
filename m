From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 10 Jun 2015 15:42:44 +0200
Subject: [PATCH] clk: at91: modify PMC peripheral clock to deal with newer
 register layout
Message-ID: <1433943764-18506-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As some more information is added to the PCR register, we'd better use
a copy of its content and modify just the peripheral-related bits.
Implement a read-modify-write for the enable() and disable() callbacks.

Header file is also modified to have the PCR_DIV mask.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/clk/at91/clk-peripheral.c | 19 +++++++++++++------
 include/linux/clk/at91_pmc.h      |  3 ++-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/at91/clk-peripheral.c b/drivers/clk/at91/clk-peripheral.c
index 597fed423d7d..37e2fea14890 100644
--- a/drivers/clk/at91/clk-peripheral.c
+++ b/drivers/clk/at91/clk-peripheral.c
@@ -161,14 +161,17 @@ static int clk_sam9x5_peripheral_enable(struct clk_hw *hw)
 {
 	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
 	struct at91_pmc *pmc = periph->pmc;
+	u32 tmp;
 
 	if (periph->id < PERIPHERAL_ID_MIN)
 		return 0;
 
-	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID) |
-				     AT91_PMC_PCR_CMD |
-				     AT91_PMC_PCR_DIV(periph->div) |
-				     AT91_PMC_PCR_EN);
+	pmc_lock(pmc);
+	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID));
+	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_P_DIV;
+	pmc_write(pmc, AT91_PMC_PCR, tmp | AT91_PMC_PCR_PDIV(periph->div)
+					 | AT91_PMC_PCR_EN);
+	pmc_unlock(pmc);
 	return 0;
 }
 
@@ -176,12 +179,16 @@ static void clk_sam9x5_peripheral_disable(struct clk_hw *hw)
 {
 	struct clk_sam9x5_peripheral *periph = to_clk_sam9x5_peripheral(hw);
 	struct at91_pmc *pmc = periph->pmc;
+	u32 tmp;
 
 	if (periph->id < PERIPHERAL_ID_MIN)
 		return;
 
-	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID) |
-				     AT91_PMC_PCR_CMD);
+	pmc_lock(pmc);
+	pmc_write(pmc, AT91_PMC_PCR, (periph->id & AT91_PMC_PCR_PID));
+	tmp = pmc_read(pmc, AT91_PMC_PCR) & ~AT91_PMC_PCR_EN;
+	pmc_write(pmc, AT91_PMC_PCR, tmp);
+	pmc_unlock(pmc);
 }
 
 static int clk_sam9x5_peripheral_is_enabled(struct clk_hw *hw)
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 7669f7618f39..4685c3d62f94 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -184,7 +184,8 @@ extern void __iomem *at91_pmc_base;
 #define AT91_PMC_PCR		0x10c			/* Peripheral Control Register [some SAM9 and SAMA5] */
 #define		AT91_PMC_PCR_PID	(0x3f  <<  0)		/* Peripheral ID */
 #define		AT91_PMC_PCR_CMD	(0x1  <<  12)		/* Command (read=0, write=1) */
-#define		AT91_PMC_PCR_DIV(n)	((n)  <<  16)		/* Divisor Value */
+#define		AT91_PMC_PCR_P_DIV	(0x3  <<  16)		/* Divisor mask */
+#define		AT91_PMC_PCR_PDIV(n)	((n)  <<  16)		/* Divisor Value */
 #define			AT91_PMC_PCR_DIV0	0x0			/* Peripheral clock is MCK */
 #define			AT91_PMC_PCR_DIV2	0x1			/* Peripheral clock is MCK/2 */
 #define			AT91_PMC_PCR_DIV4	0x2			/* Peripheral clock is MCK/4 */
-- 
2.1.3
