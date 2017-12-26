From: grinberg@compulab.co.il (Igor Grinberg)
Date: Tue, 26 Dec 2017 15:30:36 +0200
Subject: [PATCH] clk: pxa: unbreak lookup of CLK_POUT
Message-ID: <20171226133036.11432-1-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since switching to clk drivers, the CLK_POUT cannot be searched for by
clk_get() API and thus it returns with ENOENT.
Register it with the clk_lookup and thus unbreak the users of it.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 drivers/clk/pxa/clk-pxa3xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/pxa/clk-pxa3xx.c b/drivers/clk/pxa/clk-pxa3xx.c
index 42bdaa772be0..2d126df2bccd 100644
--- a/drivers/clk/pxa/clk-pxa3xx.c
+++ b/drivers/clk/pxa/clk-pxa3xx.c
@@ -329,12 +329,16 @@ static void __init pxa3xx_dummy_clocks_init(void)
 
 static void __init pxa3xx_base_clocks_init(void)
 {
+	struct clk *clk;
+
 	pxa3xx_register_plls();
 	pxa3xx_register_core();
 	clk_register_clk_pxa3xx_system_bus();
 	clk_register_clk_pxa3xx_ac97();
 	clk_register_clk_pxa3xx_smemc();
-	clk_register_gate(NULL, "CLK_POUT", "osc_13mhz", 0, OSCC, 11, 0, NULL);
+	clk = clk_register_gate(NULL, "CLK_POUT",
+				"osc_13mhz", 0, OSCC, 11, 0, NULL);
+	clk_register_clkdev(clk, "CLK_POUT", NULL);
 	clkdev_pxa_register(CLK_OSTIMER, "OSTIMER0", NULL,
 			    clk_register_fixed_factor(NULL, "os-timer0",
 						      "osc_13mhz", 0, 1, 4));
-- 
2.13.6
