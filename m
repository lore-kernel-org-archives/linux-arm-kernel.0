From: abailon@baylibre.com (Alexandre Bailon)
Date: Fri,  9 Dec 2016 17:59:33 +0100
Subject: [PATCH v7 2/2] ARM: davinci: da8xx: Fix sleeping function called from
 invalid context
In-Reply-To: <1481302773-14181-1-git-send-email-abailon@baylibre.com>
References: <1481302773-14181-1-git-send-email-abailon@baylibre.com>
Message-ID: <1481302773-14181-2-git-send-email-abailon@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Everytime the usb20 phy is enabled, there is a
"sleeping function called from invalid context" BUG.
In addition, there is a recursive locking happening
because of the recurse call to clk_enable().

clk_enable() from arch/arm/mach-davinci/clock.c uses spin_lock_irqsave()
before to invoke the callback usb20_phy_clk_enable().
usb20_phy_clk_enable() uses clk_get() and clk_enable_prepapre()
which may sleep.
replace clk_prepare_enable() by davinci_clk_enable().

Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
Suggested-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/usb-da8xx.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index b010e5f..71f1e81 100644
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
@@ -158,26 +160,13 @@ int __init da8xx_register_usb_refclkin(int rate)
 
 static void usb20_phy_clk_enable(struct clk *clk)
 {
-	struct clk *usb20_clk;
-	int err;
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
-	if (err) {
-		pr_err("failed to enable usb20 clk: %d\n", err);
-		clk_put(usb20_clk);
-		return;
-	}
+	davinci_clk_enable(usb20_clk);
 
 	/*
 	 * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
@@ -197,8 +186,7 @@ static void usb20_phy_clk_enable(struct clk *clk)
 
 	pr_err("Timeout waiting for USB 2.0 PHY clock good\n");
 done:
-	clk_disable_unprepare(usb20_clk);
-	clk_put(usb20_clk);
+	davinci_clk_disable(usb20_clk);
 }
 
 static void usb20_phy_clk_disable(struct clk *clk)
@@ -285,11 +273,19 @@ static struct clk_lookup usb20_phy_clk_lookup =
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
