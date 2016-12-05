From: abailon@baylibre.com (Alexandre Bailon)
Date: Mon,  5 Dec 2016 15:13:44 +0100
Subject: [PATCH v5] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
Message-ID: <1480947224-26222-1-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Everytime the usb20 phy is enabled, there is a
"sleeping function called from invalid context" BUG.

clk_enable() from arch/arm/mach-davinci/clock.c uses spin_lock_irqsave()
before to invoke the callback usb20_phy_clk_enable().
usb20_phy_clk_enable() uses clk_get() and clk_enable_prepapre()
which may sleep.
Move clk_get() to da8xx_register_usb20_phy_clk() and
replace clk_prepare_enable() by clk_enable().

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
---
 arch/arm/mach-davinci/usb-da8xx.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index b010e5f..f62f9c2 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -22,6 +22,8 @@
 #define DA8XX_USB0_BASE		0x01e00000
 #define DA8XX_USB1_BASE		0x01e25000
 
+static struct clk *usb20_clk;
+
 static struct platform_device da8xx_usb_phy = {
 	.name		= "da8xx-usb-phy",
 	.id		= -1,
@@ -158,24 +160,16 @@ int __init da8xx_register_usb_refclkin(int rate)
 
 static void usb20_phy_clk_enable(struct clk *clk)
 {
-	struct clk *usb20_clk;
 	int err;
 	u32 val;
 	u32 timeout = 500000; /* 500 msec */
 
 	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 
-	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
-	if (IS_ERR(usb20_clk)) {
-		pr_err("could not get usb20 clk: %ld\n", PTR_ERR(usb20_clk));
-		return;
-	}
-
 	/* The USB 2.O PLL requires that the USB 2.O PSC is enabled as well. */
-	err = clk_prepare_enable(usb20_clk);
+	err = clk_enable(usb20_clk);
 	if (err) {
 		pr_err("failed to enable usb20 clk: %d\n", err);
-		clk_put(usb20_clk);
 		return;
 	}
 
@@ -197,8 +191,7 @@ static void usb20_phy_clk_enable(struct clk *clk)
 
 	pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
 done:
-	clk_disable_unprepare(usb20_clk);
-	clk_put(usb20_clk);
+	clk_disable(usb20_clk);
 }
 
 static void usb20_phy_clk_disable(struct clk *clk)
@@ -285,11 +278,19 @@ static struct clk_lookup usb20_phy_clk_lookup =
 int __init da8xx_register_usb20_phy_clk(bool use_usb_refclkin)
 {
 	struct clk *parent;
-	int ret = 0;
+	int ret;
+
+	usb20_clk = clk_get(&da8xx_usb20_dev.dev, "usb20");
+	ret = PTR_ERR_OR_ZERO(usb20_clk);
+	if (ret)
+		return ret;
 
 	parent = clk_get(NULL, use_usb_refclkin ? "usb_refclkin" : "pll0_aux");
-	if (IS_ERR(parent))
-		return PTR_ERR(parent);
+	ret = PTR_ERR_OR_ZERO(parent);
+	if (ret) {
+		clk_put(usb20_clk);
+		return ret;
+	}
 
 	usb20_phy_clk.parent = parent;
 	ret = clk_register(&usb20_phy_clk);
-- 
2.7.3
