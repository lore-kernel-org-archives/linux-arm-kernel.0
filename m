From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 27 Jan 2016 17:11:10 +0100
Subject: [PATCH v4 11/13] clk: at91: pmc: drop at91_pmc_base
In-Reply-To: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1453911072-23608-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1453911072-23608-12-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91_pmc_base is not used anymore, remove it along with at91_pmc_read and
at91_pmc_write.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Acked-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Acked-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/at91/pmc.c       |  7 -------
 include/linux/clk/at91_pmc.h | 12 ------------
 2 files changed, 19 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 361ea0c1d3c9..dce285549de2 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -12,7 +12,6 @@
 #include <linux/clkdev.h>
 #include <linux/clk/at91_pmc.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/mfd/syscon.h>
 #include <linux/regmap.h>
 
@@ -29,9 +28,6 @@ struct at91_pmc {
 	const struct at91_pmc_caps *caps;
 };
 
-void __iomem *at91_pmc_base;
-EXPORT_SYMBOL_GPL(at91_pmc_base);
-
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range)
 {
@@ -108,11 +104,8 @@ static void __init of_at91_pmc_setup(struct device_node *np,
 				     const struct at91_pmc_caps *caps)
 {
 	struct at91_pmc *pmc;
-	void __iomem *regbase = of_iomap(np, 0);
 	struct regmap *regmap;
 
-	at91_pmc_base = regbase;
-
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		panic("Could not retrieve syscon regmap");
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 1e6932222e11..17f413bbbedf 100644
--- a/include/linux/clk/at91_pmc.h
+++ b/include/linux/clk/at91_pmc.h
@@ -16,18 +16,6 @@
 #ifndef AT91_PMC_H
 #define AT91_PMC_H
 
-#ifndef __ASSEMBLY__
-extern void __iomem *at91_pmc_base;
-
-#define at91_pmc_read(field) \
-	readl_relaxed(at91_pmc_base + field)
-
-#define at91_pmc_write(field, value) \
-	writel_relaxed(value, at91_pmc_base + field)
-#else
-.extern at91_pmc_base
-#endif
-
 #define	AT91_PMC_SCER		0x00			/* System Clock Enable Register */
 #define	AT91_PMC_SCDR		0x04			/* System Clock Disable Register */
 
-- 
2.5.0
