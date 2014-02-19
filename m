From: florian.vaussard@epfl.ch (Florian Vaussard)
Date: Wed, 19 Feb 2014 10:15:04 +0100
Subject: [PATCH v2 1/2] CLK: TI: OMAP4: Remove gpmc_fck from dummy clocks
In-Reply-To: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch>
References: <1392801305-1698-1-git-send-email-florian.vaussard@epfl.ch>
Message-ID: <1392801305-1698-2-git-send-email-florian.vaussard@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When arch/arm/mach-omap2/gpmc.c calls clk_get(..., "fck"), it will
get a dummy clock and try to use it. As the rate is configured to zero,
this will result in several divisions by zero, and misconfigured
timings, with devices on the bus being lost in the La La Land.

It is better to remove gpmc_fck from the dummy clocks, so that gpmc.c
can fail gracefully.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 drivers/clk/ti/clk-44xx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/ti/clk-44xx.c b/drivers/clk/ti/clk-44xx.c
index ae00218..02517a8 100644
--- a/drivers/clk/ti/clk-44xx.c
+++ b/drivers/clk/ti/clk-44xx.c
@@ -222,7 +222,6 @@ static struct ti_dt_clk omap44xx_clks[] = {
 	DT_CLK(NULL, "auxclk5_src_ck", "auxclk5_src_ck"),
 	DT_CLK(NULL, "auxclk5_ck", "auxclk5_ck"),
 	DT_CLK(NULL, "auxclkreq5_ck", "auxclkreq5_ck"),
-	DT_CLK("50000000.gpmc", "fck", "dummy_ck"),
 	DT_CLK("omap_i2c.1", "ick", "dummy_ck"),
 	DT_CLK("omap_i2c.2", "ick", "dummy_ck"),
 	DT_CLK("omap_i2c.3", "ick", "dummy_ck"),
-- 
1.8.1.2
