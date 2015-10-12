From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 12 Oct 2015 16:28:51 +0200
Subject: [PATCH v2 14/14] clk: at91: pmc: drop at91_pmc_base
In-Reply-To: <1444660131-14954-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1444660131-14954-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1444660131-14954-15-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91_pmc_base is not used anymore, remove it along with at91_pmc_read and
at91_pmc_write.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/clk/at91/pmc.c       |  5 -----
 include/linux/clk/at91_pmc.h | 12 ------------
 2 files changed, 17 deletions(-)

diff --git a/drivers/clk/at91/pmc.c b/drivers/clk/at91/pmc.c
index 3e150967b45e..79d8cbc74be5 100644
--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -41,9 +41,6 @@ struct at91_pmc {
 	u32 imr;
 };
 
-void __iomem *at91_pmc_base;
-EXPORT_SYMBOL_GPL(at91_pmc_base);
-
 int of_at91_get_clk_range(struct device_node *np, const char *propname,
 			  struct clk_range *range)
 {
@@ -240,8 +237,6 @@ static int __init atmel_pmc_probe(struct platform_device *pdev)
 	int virq;
 	int ret = 0;
 
-	at91_pmc_base = of_iomap(np, 0);
-
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap))
 		panic("Could not retrieve syscon regmap");
diff --git a/include/linux/clk/at91_pmc.h b/include/linux/clk/at91_pmc.h
index 7669f7618f39..b80b98b4df63 100644
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
2.1.4
