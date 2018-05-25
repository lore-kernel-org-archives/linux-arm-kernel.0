From: david@lechnology.com (David Lechner)
Date: Fri, 25 May 2018 13:11:42 -0500
Subject: [PATCH 1/9] clk: davinci: pll-dm355: drop pll2_sysclk2
In-Reply-To: <20180525181150.17873-1-david@lechnology.com>
References: <20180525181150.17873-1-david@lechnology.com>
Message-ID: <20180525181150.17873-2-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This removes pll2_sysclk2 from the TI DM355 clock driver. This SoC
doesn't have such a clock. Also, SYSCLK_ALWAYS_ENABLED is transferred
to pll2_sysclk1 since it drives the DDR and doesn't have another
mechanism to keep it on.

Reported-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: David Lechner <david@lechnology.com>
Acked-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/clk/davinci/pll-dm355.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/clk/davinci/pll-dm355.c b/drivers/clk/davinci/pll-dm355.c
index 5345f8286c50..718d9bbbf30d 100644
--- a/drivers/clk/davinci/pll-dm355.c
+++ b/drivers/clk/davinci/pll-dm355.c
@@ -62,8 +62,7 @@ static const struct davinci_pll_clk_info dm355_pll2_info = {
 		 PLL_POSTDIV_ALWAYS_ENABLED | PLL_POSTDIV_FIXED_DIV,
 };
 
-SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV);
-SYSCLK(2, pll2_sysclk2, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
+SYSCLK(1, pll2_sysclk1, pll2, 5, SYSCLK_FIXED_DIV | SYSCLK_ALWAYS_ENABLED);
 
 int dm355_pll2_init(struct device *dev, void __iomem *base)
 {
@@ -71,8 +70,6 @@ int dm355_pll2_init(struct device *dev, void __iomem *base)
 
 	davinci_pll_sysclk_register(dev, &pll2_sysclk1, base);
 
-	davinci_pll_sysclk_register(dev, &pll2_sysclk2, base);
-
 	davinci_pll_sysclkbp_clk_register(dev, "pll2_sysclkbp", base);
 
 	return 0;
-- 
2.17.0
