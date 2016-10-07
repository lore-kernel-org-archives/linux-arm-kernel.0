From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:46 +0200
Subject: [PATCH/RFT 01/12] ARM: davinci: da8xx: Enable the usb20 "per" clk on
 phy_clk_enable
In-Reply-To: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
Message-ID: <1475858577-10366-2-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

While probing ochi phy with usb20 phy as a parent clock for usb11_phy,
the usb20_phy clock enable would time out. This is because the usb20
module clock needs to enabled while trying to lock the usb20_phy PLL.

Call clk enable and get for the usb20 peripheral before trying to
enable the phy PLL.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/usb-da8xx.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-davinci/usb-da8xx.c b/arch/arm/mach-davinci/usb-da8xx.c
index 9e41a7f..982e105 100644
--- a/arch/arm/mach-davinci/usb-da8xx.c
+++ b/arch/arm/mach-davinci/usb-da8xx.c
@@ -53,11 +53,19 @@ int __init da8xx_register_usb_refclkin(int rate)
 
 static void usb20_phy_clk_enable(struct clk *clk)
 {
+	struct clk *usb20_clk;
 	u32 val;
 	u32 timeout = 500000; /* 500 msec */
 
 	val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 
+	usb20_clk = clk_get(NULL, "usb20");
+	if (IS_ERR(usb20_clk)) {
+		pr_err("could not get usb20 clk\n");
+		return;
+	}
+
+	clk_prepare_enable(usb20_clk);
 	/*
 	 * Turn on the USB 2.0 PHY, but just the PLL, and not OTG. The USB 1.1
 	 * host may use the PLL clock without USB 2.0 OTG being used.
@@ -70,11 +78,14 @@ static void usb20_phy_clk_enable(struct clk *clk)
 	while (--timeout) {
 		val = readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
 		if (val & CFGCHIP2_PHYCLKGD)
-			return;
+			goto done;
 		udelay(1);
 	}
 
 	pr_err("Timeout waiting for USB 2.0 PHY clock good.\n");
+done:
+	clk_disable_unprepare(usb20_clk);
+	clk_put(usb20_clk);
 }
 
 static void usb20_phy_clk_disable(struct clk *clk)
-- 
2.7.1
