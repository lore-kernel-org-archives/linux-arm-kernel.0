From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  8 Aug 2017 21:08:18 +0200
Subject: [PATCH] clk: gemini: hands off PCI OE bit
Message-ID: <20170808190818.11740-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This bit is pin control, and needs to be carefully managed by the
new pin control driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/clk/clk-gemini.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/clk/clk-gemini.c b/drivers/clk/clk-gemini.c
index b4cf2f699a21..f940e5af845b 100644
--- a/drivers/clk/clk-gemini.c
+++ b/drivers/clk/clk-gemini.c
@@ -37,7 +37,6 @@ static DEFINE_SPINLOCK(gemini_clk_lock);
 
 #define GEMINI_GLOBAL_MISC_CONTROL	0x30
 #define PCI_CLK_66MHZ			BIT(18)
-#define PCI_CLK_OE			BIT(17)
 
 #define GEMINI_GLOBAL_CLOCK_CONTROL	0x34
 #define PCI_CLKRUN_EN			BIT(16)
@@ -159,9 +158,6 @@ static int gemini_pci_enable(struct clk_hw *hw)
 
 	regmap_update_bits(pciclk->map, GEMINI_GLOBAL_CLOCK_CONTROL,
 			   0, PCI_CLKRUN_EN);
-	regmap_update_bits(pciclk->map,
-			   GEMINI_GLOBAL_MISC_CONTROL,
-			   0, PCI_CLK_OE);
 	return 0;
 }
 
@@ -169,9 +165,6 @@ static void gemini_pci_disable(struct clk_hw *hw)
 {
 	struct clk_gemini_pci *pciclk = to_pciclk(hw);
 
-	regmap_update_bits(pciclk->map,
-			   GEMINI_GLOBAL_MISC_CONTROL,
-			   PCI_CLK_OE, 0);
 	regmap_update_bits(pciclk->map, GEMINI_GLOBAL_CLOCK_CONTROL,
 			   PCI_CLKRUN_EN, 0);
 }
-- 
2.9.4
