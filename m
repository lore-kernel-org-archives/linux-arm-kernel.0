From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 18 Dec 2013 18:03:01 +0100
Subject: [PATCH V2 3/4] ARM: socfpga: clk: fix compile error
In-Reply-To: <1387386182-30923-1-git-send-email-s.trumtrar@pengutronix.de>
References: <1387386182-30923-1-git-send-email-s.trumtrar@pengutronix.de>
Message-ID: <1387386182-30923-4-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following compile error:

drivers/clk/socfpga/clk-gate.c:118:27: error: invalid operands to binary & (have 'void *' and 'int')

introduced by:

clk: socfpga: Look for the GPIO_DB_CLK by its offset

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/clk/socfpga/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/socfpga/clk.c b/drivers/clk/socfpga/clk.c
index f140ece..e1284fb 100644
--- a/drivers/clk/socfpga/clk.c
+++ b/drivers/clk/socfpga/clk.c
@@ -244,7 +244,7 @@ static unsigned long socfpga_clk_recalc_rate(struct clk_hw *hwclk,
 		val = readl(socfpgaclk->div_reg) >> socfpgaclk->shift;
 		val &= div_mask(socfpgaclk->width);
 		/* Check for GPIO_DB_CLK by its offset */
-		if (socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
+		if ((int) socfpgaclk->div_reg & SOCFPGA_GPIO_DB_CLK_OFFSET)
 			div = val + 1;
 		else
 			div = (1 << val);
-- 
1.8.5.1
