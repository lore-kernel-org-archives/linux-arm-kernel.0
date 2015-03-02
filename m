From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 02 Mar 2015 17:06:16 +0000
Subject: [PATCH 03/10] clk: versatile: convert Integrator IM/PD-1 to use
 clkdev_add_table()
In-Reply-To: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
References: <20150302170538.GQ8656@n2100.arm.linux.org.uk>
Message-ID: <E1YSTnM-0001Jc-LU@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We have always had an efficient way of registering a table of clock
lookups - it's called clkdev_add_table().  However, some people seem
to really love writing inefficient and unnecessary code.

Convert Integrator IM-PD/1 to use the correct interface.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/clk/versatile/clk-impd1.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
index 1cc1330dc570..13e912e132d2 100644
--- a/drivers/clk/versatile/clk-impd1.c
+++ b/drivers/clk/versatile/clk-impd1.c
@@ -89,7 +89,6 @@ void integrator_impd1_clk_init(void __iomem *base, unsigned int id)
 	struct impd1_clk *imc;
 	struct clk *clk;
 	struct clk *pclk;
-	int i;
 
 	if (id > 3) {
 		pr_crit("no more than 4 LMs can be attached\n");
@@ -150,8 +149,7 @@ void integrator_impd1_clk_init(void __iomem *base, unsigned int id)
 	imc->clks[13] = clkdev_alloc(pclk, "apb_pclk", "lm%x:00600", id);
 	imc->clks[14] = clkdev_alloc(clk, NULL, "lm%x:00600", id);
 
-	for (i = 0; i < ARRAY_SIZE(imc->clks); i++)
-		clkdev_add(imc->clks[i]);
+	clkdev_add_table(imc->clks, ARRAY_SIZE(imc->clks));
 }
 EXPORT_SYMBOL_GPL(integrator_impd1_clk_init);
 
-- 
1.8.3.1
