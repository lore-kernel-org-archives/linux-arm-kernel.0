From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  6 May 2014 22:50:21 -0500
Subject: [PATCH 5/7] usb: ohci-platform: Enable optional use of reset
 controller
In-Reply-To: <1399434623-20383-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399434623-20383-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399434623-20383-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OHCI controllers used in the Allwinner A31 are asserted in reset using a
global reset controller.

Add optional support for such a controller in the OHCI platform driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/usb/usb-ohci.txt |  1 +
 drivers/usb/host/ohci-platform.c                   | 25 +++++++++++++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-ohci.txt b/Documentation/devicetree/bindings/usb/usb-ohci.txt
index 45f67d91e888..b968a1aea995 100644
--- a/Documentation/devicetree/bindings/usb/usb-ohci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-ohci.txt
@@ -12,6 +12,7 @@ Optional properties:
 - clocks : a list of phandle + clock specifier pairs
 - phys : phandle + phy specifier pair
 - phy-names : "usb"
+- resets : phandle + reset specifier pair
 
 Example:
 
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index b6002c951c5c..55f6c87628eb 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -24,6 +24,7 @@
 #include <linux/err.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/usb/ohci_pdriver.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
@@ -36,6 +37,7 @@
 
 struct ohci_platform_priv {
 	struct clk *clks[OHCI_MAX_CLKS];
+	struct reset_control *rst;
 	struct phy *phy;
 };
 
@@ -67,10 +69,16 @@ static int ohci_platform_power_on(struct platform_device *dev)
 			goto err_disable_clks;
 	}
 
+	if (priv->rst) {
+		ret = reset_control_deassert(priv->rst);
+		if (ret)
+			goto err_disable_clks;
+	}
+
 	if (priv->phy) {
 		ret = phy_init(priv->phy);
 		if (ret)
-			goto err_disable_clks;
+			goto err_assert_rst;
 
 		ret = phy_power_on(priv->phy);
 		if (ret)
@@ -81,6 +89,9 @@ static int ohci_platform_power_on(struct platform_device *dev)
 
 err_exit_phy:
 	phy_exit(priv->phy);
+err_assert_rst:
+	if (priv->rst)
+		reset_control_assert(priv->rst);
 err_disable_clks:
 	while (--clk >= 0)
 		clk_disable_unprepare(priv->clks[clk]);
@@ -99,6 +110,9 @@ static void ohci_platform_power_off(struct platform_device *dev)
 		phy_exit(priv->phy);
 	}
 
+	if (priv->rst)
+		reset_control_assert(priv->rst);
+
 	for (clk = OHCI_MAX_CLKS - 1; clk >= 0; clk--)
 		if (priv->clks[clk])
 			clk_disable_unprepare(priv->clks[clk]);
@@ -191,6 +205,15 @@ static int ohci_platform_probe(struct platform_device *dev)
 				break;
 			}
 		}
+
+		priv->rst = devm_reset_control_get_optional(&dev->dev,
+							    NULL);
+		if (IS_ERR(priv->rst)) {
+			err = PTR_ERR(priv->rst);
+			if (err ==  -EPROBE_DEFER)
+				goto err_put_clks;
+			priv->rst = NULL;
+		}
 	}
 
 	if (pdata->big_endian_desc)
-- 
1.9.1
