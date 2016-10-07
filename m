From: ahaslam@baylibre.com (ahaslam at baylibre.com)
Date: Fri,  7 Oct 2016 18:42:53 +0200
Subject: [PATCH/RFT 08/12] ARM: davinci: register the usb20_phy clock on the
 SoC file
In-Reply-To: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
References: <1475858577-10366-1-git-send-email-ahaslam@baylibre.com>
Message-ID: <1475858577-10366-9-git-send-email-ahaslam@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Axel Haslam <ahaslam@baylibre.com>

The usb20_phy clock needs to be registered for the driver to be able
to get and enable a clock. Currently the usb phy clocks are registered
form board files, which will not be called during a device tree based
boot.

To be able to probe correctly usb form a device tree boot, register
the usb phy clocks form the SoC specific init.

Unfourtunatly, davinci does not have proper clock support on device tree
yet, so by registering the clock form de SoC specific file we are
forced to hardcode the parent clock, and cannot select refclkin as
parent for any of the phy clocks of the da850 family.

As none of the current da850 based boards currently in mainline use
refclkin as source. I guess we can live with this limitation until clocks
are correctly represented through CCF/device tree.

Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
---
 arch/arm/mach-davinci/board-omapl138-hawk.c | 10 ----------
 arch/arm/mach-davinci/da850.c               |  2 ++
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c b/arch/arm/mach-davinci/board-omapl138-hawk.c
index 8d72bc1..a78fa16 100644
--- a/arch/arm/mach-davinci/board-omapl138-hawk.c
+++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
@@ -187,16 +187,6 @@ static __init void omapl138_hawk_usb_init(void)
 {
 	int ret;
 
-	/* USB_REFCLKIN is not used. */
-	ret = da8xx_register_usb20_phy_clk(false);
-	if (ret)
-		pr_warn("%s: USB 2.0 PHY CLK registration failed: %d\n",
-			__func__, ret);
-	ret = da8xx_register_usb11_phy_clk(false);
-	if (ret)
-		pr_warn("%s: USB 1.1 PHY CLK registration failed: %d\n",
-			__func__, ret);
-
 	ret = da8xx_register_usb_phy();
 	if (ret)
 		pr_warn("%s: USB PHY registration failed: %d\n",
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index ed3d0e9..621880d 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -1350,4 +1350,6 @@ void __init da850_init(void)
 	__raw_writel(v, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP3_REG));
 
 	davinci_clk_init(davinci_soc_info_da850.cpu_clks);
+	da8xx_register_usb20_phy_clk(false);
+	da8xx_register_usb11_phy_clk(false);
 }
-- 
2.7.1
