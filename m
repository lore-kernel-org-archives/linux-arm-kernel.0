From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 11 May 2014 20:17:52 +0200
Subject: [PATCHv5 04/20] usb: ehci-orion: add optional PHY support
In-Reply-To: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399832288-19899-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

This commit extends the ehci-orion so that it can optionally be passed
a reference to a PHY through the Device Tree. It will be useful for
the Armada 375 SoCs. If no PHY is provided then the behavior of the
driver is unchanged.

[Thomas: use devm_phy_optional_get() so that we handle -EPROBE_DEFER
properly. Also call phy_power_off() when needed, and rename goto
labels.]

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-orion.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 9c98bac..22e15ca 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -15,6 +15,7 @@
 #include <linux/clk.h>
 #include <linux/platform_data/usb-ehci-orion.h>
 #include <linux/of.h>
+#include <linux/phy/phy.h>
 #include <linux/of_device.h>
 #include <linux/of_irq.h>
 #include <linux/usb.h>
@@ -46,6 +47,7 @@
 
 struct orion_ehci_hcd {
 	struct clk *clk;
+	struct phy *phy;
 };
 
 static const char hcd_name[] = "ehci-orion";
@@ -221,6 +223,20 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	if (!IS_ERR(priv->clk))
 		clk_prepare_enable(priv->clk);
 
+	priv->phy = devm_phy_optional_get(&pdev->dev, "usb");
+	if (IS_ERR(priv->phy)) {
+		err = PTR_ERR(priv->phy);
+		goto err_phy_get;
+	} else {
+		err = phy_init(priv->phy);
+		if (err)
+			goto err_phy_init;
+
+		err = phy_power_on(priv->phy);
+		if (err)
+			goto err_phy_power_on;
+	}
+
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
@@ -256,6 +272,13 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	return 0;
 
 err_add_hcd:
+	if (!IS_ERR(priv->phy))
+		phy_power_off(priv->phy);
+err_phy_power_on:
+	if (!IS_ERR(priv->phy))
+		phy_exit(priv->phy);
+err_phy_init:
+err_phy_get:
 	if (!IS_ERR(priv->clk))
 		clk_disable_unprepare(priv->clk);
 	usb_put_hcd(hcd);
@@ -273,6 +296,11 @@ static int ehci_orion_drv_remove(struct platform_device *pdev)
 
 	usb_remove_hcd(hcd);
 
+	if (!IS_ERR(priv->phy)) {
+		phy_power_off(priv->phy);
+		phy_exit(priv->phy);
+	}
+
 	if (!IS_ERR(priv->clk))
 		clk_disable_unprepare(priv->clk);
 
-- 
1.9.2
