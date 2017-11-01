From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu,  2 Nov 2017 01:01:58 +0900
Subject: [PATCH v2 1/2] usb: ehci-platform: use reset array API
Message-ID: <1509552119-23816-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Generic drivers like this need to control arbitrary number of reset
lines.  Instead of hard-coding the maximum number of resets, use the
reset array API.  It can manage a bunch of resets behind the scene.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Goto err_put_clks when it fails to get reset_control.

 drivers/usb/host/ehci-platform.c | 35 +++++++++++++----------------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index f1908ea..a41acd6 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -40,12 +40,11 @@
 
 #define DRIVER_DESC "EHCI generic platform driver"
 #define EHCI_MAX_CLKS 4
-#define EHCI_MAX_RSTS 4
 #define hcd_to_ehci_priv(h) ((struct ehci_platform_priv *)hcd_to_ehci(h)->priv)
 
 struct ehci_platform_priv {
 	struct clk *clks[EHCI_MAX_CLKS];
-	struct reset_control *rsts[EHCI_MAX_RSTS];
+	struct reset_control *rsts;
 	struct phy **phys;
 	int num_phys;
 	bool reset_on_resume;
@@ -151,7 +150,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct ehci_platform_priv *priv;
 	struct ehci_hcd *ehci;
-	int err, irq, phy_num, clk = 0, rst;
+	int err, irq, phy_num, clk = 0;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -239,22 +238,16 @@ static int ehci_platform_probe(struct platform_device *dev)
 		}
 	}
 
-	for (rst = 0; rst < EHCI_MAX_RSTS; rst++) {
-		priv->rsts[rst] = devm_reset_control_get_shared_by_index(
-					&dev->dev, rst);
-		if (IS_ERR(priv->rsts[rst])) {
-			err = PTR_ERR(priv->rsts[rst]);
-			if (err == -EPROBE_DEFER)
-				goto err_reset;
-			priv->rsts[rst] = NULL;
-			break;
-		}
-
-		err = reset_control_deassert(priv->rsts[rst]);
-		if (err)
-			goto err_reset;
+	priv->rsts = devm_reset_control_array_get_optional_shared(&dev->dev);
+	if (IS_ERR(priv->rsts)) {
+		err = PTR_ERR(priv->rsts);
+		goto err_put_clks;
 	}
 
+	err = reset_control_deassert(priv->rsts);
+	if (err)
+		goto err_put_clks;
+
 	if (pdata->big_endian_desc)
 		ehci->big_endian_desc = 1;
 	if (pdata->big_endian_mmio)
@@ -310,8 +303,7 @@ static int ehci_platform_probe(struct platform_device *dev)
 	if (pdata->power_off)
 		pdata->power_off(dev);
 err_reset:
-	while (--rst >= 0)
-		reset_control_assert(priv->rsts[rst]);
+	reset_control_assert(priv->rsts);
 err_put_clks:
 	while (--clk >= 0)
 		clk_put(priv->clks[clk]);
@@ -329,15 +321,14 @@ static int ehci_platform_remove(struct platform_device *dev)
 	struct usb_hcd *hcd = platform_get_drvdata(dev);
 	struct usb_ehci_pdata *pdata = dev_get_platdata(&dev->dev);
 	struct ehci_platform_priv *priv = hcd_to_ehci_priv(hcd);
-	int clk, rst;
+	int clk;
 
 	usb_remove_hcd(hcd);
 
 	if (pdata->power_off)
 		pdata->power_off(dev);
 
-	for (rst = 0; rst < EHCI_MAX_RSTS && priv->rsts[rst]; rst++)
-		reset_control_assert(priv->rsts[rst]);
+	reset_control_assert(priv->rsts);
 
 	for (clk = 0; clk < EHCI_MAX_CLKS && priv->clks[clk]; clk++)
 		clk_put(priv->clks[clk]);
-- 
2.7.4
