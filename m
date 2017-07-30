From: jernej.skrabec@siol.net (Jernej Skrabec)
Date: Sun, 30 Jul 2017 18:41:49 +0200
Subject: [PATCH 3/4] clk: sunxi-ng: Make fractional helper less chatty
In-Reply-To: <20170730164150.26302-1-jernej.skrabec@siol.net>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
Message-ID: <20170730164150.26302-4-jernej.skrabec@siol.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ccu_frac_helper_read_rate() prints some info which is not really
helpful except during debugging.

Replace printk() with pr_debug().

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
---
 drivers/clk/sunxi-ng/ccu_frac.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu_frac.c b/drivers/clk/sunxi-ng/ccu_frac.c
index 8b5eb7756bf7..ff9e72dc5337 100644
--- a/drivers/clk/sunxi-ng/ccu_frac.c
+++ b/drivers/clk/sunxi-ng/ccu_frac.c
@@ -67,18 +67,18 @@ unsigned long ccu_frac_helper_read_rate(struct ccu_common *common,
 {
 	u32 reg;
 
-	printk("%s: Read fractional\n", clk_hw_get_name(&common->hw));
+	pr_debug("%s: Read fractional\n", clk_hw_get_name(&common->hw));
 
 	if (!(common->features & CCU_FEATURE_FRACTIONAL))
 		return 0;
 
-	printk("%s: clock is fractional (rates %lu and %lu)\n",
-	       clk_hw_get_name(&common->hw), cf->rates[0], cf->rates[1]);
+	pr_debug("%s: clock is fractional (rates %lu and %lu)\n",
+		 clk_hw_get_name(&common->hw), cf->rates[0], cf->rates[1]);
 
 	reg = readl(common->base + common->reg);
 
-	printk("%s: clock reg is 0x%x (select is 0x%x)\n",
-	       clk_hw_get_name(&common->hw), reg, cf->select);
+	pr_debug("%s: clock reg is 0x%x (select is 0x%x)\n",
+		 clk_hw_get_name(&common->hw), reg, cf->select);
 
 	return (reg & cf->select) ? cf->rates[1] : cf->rates[0];
 }
-- 
2.13.3
