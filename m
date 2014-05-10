From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 10 May 2014 07:56:57 -0500
Subject: [PATCH v2 5/7] usb: ohci-platform: Enable optional use of reset
 controller
In-Reply-To: <1399726619-30150-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1399726619-30150-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1399726619-30150-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OHCI controllers used in the Allwinner A31 are asserted in reset using a
global reset controller.

Add optional support for such a controller in the OHCI platform driver.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/usb/usb-ohci.txt |  1 +
 drivers/usb/host/ohci-platform.c                   | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

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
index b6002c951c5c..25073112abea 100644
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
 
@@ -191,6 +193,19 @@ static int ohci_platform_probe(struct platform_device *dev)
 				break;
 			}
 		}
+
+		priv->rst = devm_reset_control_get_optional(&dev->dev,
+							    NULL);
+		if (IS_ERR(priv->rst)) {
+			err = PTR_ERR(priv->rst);
+			if (err == -EPROBE_DEFER)
+				goto err_put_clks;
+			priv->rst = NULL;
+		} else {
+			err = reset_control_deassert(priv->rst);
+			if (err)
+				goto err_put_clks;
+		}
 	}
 
 	if (pdata->big_endian_desc)
@@ -266,6 +281,9 @@ static int ohci_platform_remove(struct platform_device *dev)
 	if (pdata->power_off)
 		pdata->power_off(dev);
 
+	if (priv->rst)
+		reset_control_assert(priv->rst);
+
 	for (clk = 0; clk < OHCI_MAX_CLKS && priv->clks[clk]; clk++)
 		clk_put(priv->clks[clk]);
 
-- 
1.9.1
