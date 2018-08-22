From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 22 Aug 2018 22:43:04 +0200
Subject: [PATCH 11/14] USB: EHCI: ehci-mv: add DT support
In-Reply-To: <20180822204307.13251-1-lkundrak@v3.sk>
References: <20180822204307.13251-1-lkundrak@v3.sk>
Message-ID: <20180822204307.13251-12-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Device tree support.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/usb/host/ehci-mv.c | 41 +++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/host/ehci-mv.c b/drivers/usb/host/ehci-mv.c
index 43b300c90875..f26109eafdbf 100644
--- a/drivers/usb/host/ehci-mv.c
+++ b/drivers/usb/host/ehci-mv.c
@@ -34,11 +34,11 @@ struct ehci_hcd_mv {
 	void __iomem *op_regs;
 
 	struct usb_phy *otg;
+	struct clk *clk;
 
-	struct mv_usb_platform_data *pdata;
 	struct phy *phy;
 
-	struct clk *clk;
+	int (*set_vbus)(unsigned int vbus);
 };
 
 static void ehci_clock_enable(struct ehci_hcd_mv *ehci_mv)
@@ -100,11 +100,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	int retval = -ENODEV;
 	u32 offset;
 
-	if (!pdata) {
-		dev_err(&pdev->dev, "missing platform_data\n");
-		return -ENODEV;
-	}
-
 	if (usb_disabled())
 		return -ENODEV;
 
@@ -114,7 +109,12 @@ static int mv_ehci_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, hcd);
 	ehci_mv = hcd_to_ehci_hcd_mv(hcd);
-	ehci_mv->pdata = pdata;
+
+	ehci_mv->mode = MV_USB_MODE_HOST;
+	if (pdata) {
+		ehci_mv->mode = pdata->mode;
+		ehci_mv->set_vbus = pdata->set_vbus;
+	}
 
 	ehci_mv->phy = devm_phy_get(&pdev->dev, "usb");
 	if (IS_ERR(ehci_mv->phy)) {
@@ -166,7 +166,6 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	ehci = hcd_to_ehci(hcd);
 	ehci->caps = (struct ehci_caps *) ehci_mv->cap_regs;
 
-	ehci_mv->mode = pdata->mode;
 	if (ehci_mv->mode == MV_USB_MODE_OTG) {
 		ehci_mv->otg = devm_usb_get_phy(&pdev->dev, USB_PHY_TYPE_USB2);
 		if (IS_ERR(ehci_mv->otg)) {
@@ -191,8 +190,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 		/* otg will enable clock before use as host */
 		mv_ehci_disable(ehci_mv);
 	} else {
-		if (pdata->set_vbus)
-			pdata->set_vbus(1);
+		if (ehci_mv->set_vbus)
+			ehci_mv->set_vbus(1);
 
 		retval = usb_add_hcd(hcd, hcd->irq, IRQF_SHARED);
 		if (retval) {
@@ -211,8 +210,8 @@ static int mv_ehci_probe(struct platform_device *pdev)
 	return 0;
 
 err_set_vbus:
-	if (pdata->set_vbus)
-		pdata->set_vbus(0);
+	if (ehci_mv->set_vbus)
+		ehci_mv->set_vbus(0);
 err_disable_clk:
 	mv_ehci_disable(ehci_mv);
 err_put_hcd:
@@ -233,8 +232,8 @@ static int mv_ehci_remove(struct platform_device *pdev)
 		otg_set_host(ehci_mv->otg->otg, NULL);
 
 	if (ehci_mv->mode == MV_USB_MODE_HOST) {
-		if (ehci_mv->pdata->set_vbus)
-			ehci_mv->pdata->set_vbus(0);
+		if (ehci_mv->set_vbus)
+			ehci_mv->set_vbus(0);
 
 		mv_ehci_disable(ehci_mv);
 	}
@@ -265,14 +264,20 @@ static void mv_ehci_shutdown(struct platform_device *pdev)
 		hcd->driver->shutdown(hcd);
 }
 
+static const struct of_device_id ehci_mv_dt_ids[] = {
+	{ .compatible = "marvell,pxau2o-ehci", },
+	{},
+};
+
 static struct platform_driver ehci_mv_driver = {
 	.probe = mv_ehci_probe,
 	.remove = mv_ehci_remove,
 	.shutdown = mv_ehci_shutdown,
 	.driver = {
-		   .name = "mv-ehci",
-		   .bus = &platform_bus_type,
-		   },
+		.name = "mv-ehci",
+		.bus = &platform_bus_type,
+		.of_match_table = ehci_mv_dt_ids,
+	},
 	.id_table = ehci_id_table,
 };
 
-- 
2.17.1
