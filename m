From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 11 May 2014 20:17:51 +0200
Subject: [PATCHv5 03/20] usb: ehci-orion: fix clock reference leaking
In-Reply-To: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1399832288-19899-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1399832288-19899-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@free-electrons.com>

In order to disable the clock in the ->remove() function, a call to
devm_clk_get() is being made, which further increases the reference
count of the clock.

In order to clean this up, a private structure holding a pointer to
the clock is added using the override mechanism provided by the ehci
framework. This makes the driver clock handling much more logical.

The bug was introduced in v3.6, however the ehci framework allowing to
use the override mechanism has only been introduced in v3.8, so this
patch won't apply before it.

[Thomas: reword commit log, fix goto label names.]

Fixes: 8c869edaee07c623066266827371235fb9c12e01 ('ARM: Orion: EHCI: Add support for enabling clocks')
Cc: <stable@vger.kernel.org> # v3.8+
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/usb/host/ehci-orion.c | 45 ++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/host/ehci-orion.c b/drivers/usb/host/ehci-orion.c
index 9298be7..9c98bac 100644
--- a/drivers/usb/host/ehci-orion.c
+++ b/drivers/usb/host/ehci-orion.c
@@ -42,6 +42,12 @@
 
 #define DRIVER_DESC "EHCI orion driver"
 
+#define hcd_to_orion_priv(h) ((struct orion_ehci_hcd *)hcd_to_ehci(h)->priv)
+
+struct orion_ehci_hcd {
+	struct clk *clk;
+};
+
 static const char hcd_name[] = "ehci-orion";
 
 static struct hc_driver __read_mostly ehci_orion_hc_driver;
@@ -137,6 +143,10 @@ ehci_orion_conf_mbus_windows(struct usb_hcd *hcd,
 	}
 }
 
+static const struct ehci_driver_overrides orion_overrides __initconst = {
+	.extra_priv_size =	sizeof(struct orion_ehci_hcd),
+};
+
 static int ehci_orion_drv_probe(struct platform_device *pdev)
 {
 	struct orion_ehci_data *pd = dev_get_platdata(&pdev->dev);
@@ -144,10 +154,10 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct usb_hcd *hcd;
 	struct ehci_hcd *ehci;
-	struct clk *clk;
 	void __iomem *regs;
 	int irq, err;
 	enum orion_ehci_phy_ver phy_version;
+	struct orion_ehci_hcd *priv;
 
 	if (usb_disabled())
 		return -ENODEV;
@@ -187,17 +197,11 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	/* Not all platforms can gate the clock, so it is not
-	   an error if the clock does not exists. */
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(clk))
-		clk_prepare_enable(clk);
-
 	hcd = usb_create_hcd(&ehci_orion_hc_driver,
 			&pdev->dev, dev_name(&pdev->dev));
 	if (!hcd) {
 		err = -ENOMEM;
-		goto err_create_hcd;
+		goto err;
 	}
 
 	hcd->rsrc_start = res->start;
@@ -208,6 +212,15 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	ehci->caps = hcd->regs + 0x100;
 	hcd->has_tt = 1;
 
+	priv = hcd_to_orion_priv(hcd);
+	/*
+	 * Not all platforms can gate the clock, so it is not an error if
+	 * the clock does not exists.
+	 */
+	priv->clk = devm_clk_get(&pdev->dev, NULL);
+	if (!IS_ERR(priv->clk))
+		clk_prepare_enable(priv->clk);
+
 	/*
 	 * (Re-)program MBUS remapping windows if we are asked to.
 	 */
@@ -243,10 +256,9 @@ static int ehci_orion_drv_probe(struct platform_device *pdev)
 	return 0;
 
 err_add_hcd:
+	if (!IS_ERR(priv->clk))
+		clk_disable_unprepare(priv->clk);
 	usb_put_hcd(hcd);
-err_create_hcd:
-	if (!IS_ERR(clk))
-		clk_disable_unprepare(clk);
 err:
 	dev_err(&pdev->dev, "init %s fail, %d\n",
 		dev_name(&pdev->dev), err);
@@ -257,14 +269,15 @@ err:
 static int ehci_orion_drv_remove(struct platform_device *pdev)
 {
 	struct usb_hcd *hcd = platform_get_drvdata(pdev);
-	struct clk *clk;
+	struct orion_ehci_hcd *priv = hcd_to_orion_priv(hcd);
 
 	usb_remove_hcd(hcd);
+
+	if (!IS_ERR(priv->clk))
+		clk_disable_unprepare(priv->clk);
+
 	usb_put_hcd(hcd);
 
-	clk = devm_clk_get(&pdev->dev, NULL);
-	if (!IS_ERR(clk))
-		clk_disable_unprepare(clk);
 	return 0;
 }
 
@@ -292,7 +305,7 @@ static int __init ehci_orion_init(void)
 
 	pr_info("%s: " DRIVER_DESC "\n", hcd_name);
 
-	ehci_init_driver(&ehci_orion_hc_driver, NULL);
+	ehci_init_driver(&ehci_orion_hc_driver, &orion_overrides);
 	return platform_driver_register(&ehci_orion_driver);
 }
 module_init(ehci_orion_init);
-- 
1.9.2
