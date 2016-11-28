From: abailon@baylibre.com (Alexandre Bailon)
Date: Mon, 28 Nov 2016 17:29:26 +0100
Subject: [PATCH] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
Message-ID: <1480350566-26225-1-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Everytime the usb20 phy is enabled, there is a
"sleeping function called from invalid context" BUG.
usb20_phy_clk_enable(), called with the irq disabled uses
clk_get() and clk_enable_prepapre() which may sleep.
Move clk_get() to da8xx_register_usb20_phy_clk() and
replace clk_prepare_enable() by clk_enable().

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/mach-davinci/usb-da8xx.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index b010e5f..c9b5cd4 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -156,23 +156,23 @@ int __init da8xx_register_usb_refclkin(int rate)
 	return 0;
 }
 
+static struct clk *usb20_clk;
+
 static void usb20_phy_clk_enable(struct clk *clk)
 {
-	struct clk *usb20_clk;
 	int err;
 	u32 val;
 	u32 timeout = 500000; /* 500 msec */
 
 	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 
-	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
-	if (IS_ERR(usb20_clk)) {
+	if (!usb20_clk || IS_ERR(usb20_clk)) {
 		pr_err("could not get usb20 clk: %ld\n", PTR_ERR(usb20_clk));
 		return;
 	}
 
 	/* The USB 2.O PLL requires that the USB 2.O PSC is enabled as well. */
-	err = clk_prepare_enable(usb20_clk);
+	err = clk_enable(usb20_clk);
 	if (err) {
 		pr_err("failed to enable usb20 clk: %d\n", err);
 		clk_put(usb20_clk);
@@ -197,8 +197,7 @@ static void usb20_phy_clk_enable(struct clk *clk)
 
 	pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
 done:
-	clk_disable_unprepare(usb20_clk);
-	clk_put(usb20_clk);
+	clk_disable(usb20_clk);
 }
 
 static void usb20_phy_clk_disable(struct clk *clk)
@@ -287,6 +286,10 @@ int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
 	struct clk *parent;
 	int ret = 0;
 
+	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
+	if (IS_ERR(usb20_clk))
+		return PTR_ERR(parent);
+
 	parent = clk_get(NULL, use_usb_refclkin ? "usb_refclkin" : "pll0_aux");
 	if (IS_ERR(parent))
 		return PTR_ERR(parent);
-- 
2.7.3
