From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 21 May 2017 02:52:13 +0900
Subject: [PATCH] usb: remove NULL pointer check for clk_disable_unprepare
Message-ID: <1495302733-6669-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After long term efforts of fixing non-common clock implementations,
clk_disable() is a no-op for a NULL pointer input, and this is now
tree-wide consistent.

All clock consumers can safely call clk_disable(_unprepare) without
NULL pointer check.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/usb/dwc2/platform.c          | 3 +--
 drivers/usb/gadget/udc/fsl_mxc_udc.c | 3 +--
 drivers/usb/host/ehci-mxc.c          | 8 ++------
 drivers/usb/host/ehci-platform.c     | 3 +--
 drivers/usb/host/ehci-spear.c        | 3 +--
 drivers/usb/host/ehci-st.c           | 3 +--
 drivers/usb/host/fsl-mph-dr-of.c     | 3 +--
 drivers/usb/host/ohci-platform.c     | 3 +--
 drivers/usb/host/ohci-spear.c        | 3 +--
 drivers/usb/host/ohci-st.c           | 3 +--
 drivers/usb/misc/usb3503.c           | 9 +++------
 11 files changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index daf0d37..8c5bf81 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -182,8 +182,7 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	if (ret)
 		return ret;
 
-	if (hsotg->clk)
-		clk_disable_unprepare(hsotg->clk);
+	clk_disable_unprepare(hsotg->clk);
 
 	ret = regulator_bulk_disable(ARRAY_SIZE(hsotg->supplies),
 				     hsotg->supplies);
diff --git a/drivers/usb/gadget/udc/fsl_mxc_udc.c b/drivers/usb/gadget/udc/fsl_mxc_udc.c
index f16e149..59dbcf7 100644
--- a/drivers/usb/gadget/udc/fsl_mxc_udc.c
+++ b/drivers/usb/gadget/udc/fsl_mxc_udc.c
@@ -118,8 +118,7 @@ int fsl_udc_clk_finalize(struct platform_device *pdev)
 
 void fsl_udc_clk_release(void)
 {
-	if (mxc_per_clk)
-		clk_disable_unprepare(mxc_per_clk);
+	clk_disable_unprepare(mxc_per_clk);
 	clk_disable_unprepare(mxc_ahb_clk);
 	clk_disable_unprepare(mxc_ipg_clk);
 }
diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index c7a9b31..1db5ef9 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -155,9 +155,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	if (pdata && pdata->exit)
 		pdata->exit(pdev);
 err_init:
-	if (priv->phyclk)
-		clk_disable_unprepare(priv->phyclk);
-
+	clk_disable_unprepare(priv->phyclk);
 	clk_disable_unprepare(priv->ahbclk);
 err_clk_ahb:
 	clk_disable_unprepare(priv->usbclk);
@@ -183,9 +181,7 @@ static int ehci_mxc_drv_remove(struct platform_device *pdev)
 
 	clk_disable_unprepare(priv->usbclk);
 	clk_disable_unprepare(priv->ahbclk);
-
-	if (priv->phyclk)
-		clk_disable_unprepare(priv->phyclk);
+	clk_disable_unprepare(priv->phyclk);
 
 	usb_put_hcd(hcd);
 	return 0;
diff --git a/drivers/usb/host/ehci-platform.c b/drivers/usb/host/ehci-platform.c
index bc7b9be..2d41447 100644
--- a/drivers/usb/host/ehci-platform.c
+++ b/drivers/usb/host/ehci-platform.c
@@ -127,8 +127,7 @@ static void ehci_platform_power_off(struct platform_device *dev)
 	}
 
 	for (clk = EHCI_MAX_CLKS - 1; clk >= 0; clk--)
-		if (priv->clks[clk])
-			clk_disable_unprepare(priv->clks[clk]);
+		clk_disable_unprepare(priv->clks[clk]);
 }
 
 static struct hc_driver __read_mostly ehci_platform_hc_driver;
diff --git a/drivers/usb/host/ehci-spear.c b/drivers/usb/host/ehci-spear.c
index 1f25c79..57257aa 100644
--- a/drivers/usb/host/ehci-spear.c
+++ b/drivers/usb/host/ehci-spear.c
@@ -138,8 +138,7 @@ static int spear_ehci_hcd_drv_remove(struct platform_device *pdev)
 
 	usb_remove_hcd(hcd);
 
-	if (sehci->clk)
-		clk_disable_unprepare(sehci->clk);
+	clk_disable_unprepare(sehci->clk);
 	usb_put_hcd(hcd);
 
 	return 0;
diff --git a/drivers/usb/host/ehci-st.c b/drivers/usb/host/ehci-st.c
index be4a278..f3c433d 100644
--- a/drivers/usb/host/ehci-st.c
+++ b/drivers/usb/host/ehci-st.c
@@ -130,8 +130,7 @@ static void st_ehci_platform_power_off(struct platform_device *dev)
 	phy_exit(priv->phy);
 
 	for (clk = USB_MAX_CLKS - 1; clk >= 0; clk--)
-		if (priv->clks[clk])
-			clk_disable_unprepare(priv->clks[clk]);
+		clk_disable_unprepare(priv->clks[clk]);
 
 }
 
diff --git a/drivers/usb/host/fsl-mph-dr-of.c b/drivers/usb/host/fsl-mph-dr-of.c
index e90ddb5..ec5562d 100644
--- a/drivers/usb/host/fsl-mph-dr-of.c
+++ b/drivers/usb/host/fsl-mph-dr-of.c
@@ -325,8 +325,7 @@ static void fsl_usb2_mpc5121_exit(struct platform_device *pdev)
 
 	pdata->regs = NULL;
 
-	if (pdata->clk)
-		clk_disable_unprepare(pdata->clk);
+	clk_disable_unprepare(pdata->clk);
 }
 
 static struct fsl_usb2_platform_data fsl_usb2_mpc5121_pd = {
diff --git a/drivers/usb/host/ohci-platform.c b/drivers/usb/host/ohci-platform.c
index 6368fce..200137a 100644
--- a/drivers/usb/host/ohci-platform.c
+++ b/drivers/usb/host/ohci-platform.c
@@ -94,8 +94,7 @@ static void ohci_platform_power_off(struct platform_device *dev)
 	}
 
 	for (clk = OHCI_MAX_CLKS - 1; clk >= 0; clk--)
-		if (priv->clks[clk])
-			clk_disable_unprepare(priv->clks[clk]);
+		clk_disable_unprepare(priv->clks[clk]);
 }
 
 static struct hc_driver __read_mostly ohci_platform_hc_driver;
diff --git a/drivers/usb/host/ohci-spear.c b/drivers/usb/host/ohci-spear.c
index 56478ed..4037130 100644
--- a/drivers/usb/host/ohci-spear.c
+++ b/drivers/usb/host/ohci-spear.c
@@ -111,8 +111,7 @@ static int spear_ohci_hcd_drv_remove(struct platform_device *pdev)
 	struct spear_ohci *sohci_p = to_spear_ohci(hcd);
 
 	usb_remove_hcd(hcd);
-	if (sohci_p->clk)
-		clk_disable_unprepare(sohci_p->clk);
+	clk_disable_unprepare(sohci_p->clk);
 
 	usb_put_hcd(hcd);
 	return 0;
diff --git a/drivers/usb/host/ohci-st.c b/drivers/usb/host/ohci-st.c
index 02816a1..05ede9d 100644
--- a/drivers/usb/host/ohci-st.c
+++ b/drivers/usb/host/ohci-st.c
@@ -112,8 +112,7 @@ static void st_ohci_platform_power_off(struct platform_device *dev)
 	phy_exit(priv->phy);
 
 	for (clk = USB_MAX_CLKS - 1; clk >= 0; clk--)
-		if (priv->clks[clk])
-			clk_disable_unprepare(priv->clks[clk]);
+		clk_disable_unprepare(priv->clks[clk]);
 }
 
 static struct hc_driver __read_mostly ohci_platform_hc_driver;
diff --git a/drivers/usb/misc/usb3503.c b/drivers/usb/misc/usb3503.c
index 8e7737d..1d4d1e4 100644
--- a/drivers/usb/misc/usb3503.c
+++ b/drivers/usb/misc/usb3503.c
@@ -335,8 +335,7 @@ static int usb3503_i2c_remove(struct i2c_client *i2c)
 	struct usb3503 *hub;
 
 	hub = i2c_get_clientdata(i2c);
-	if (hub->clk)
-		clk_disable_unprepare(hub->clk);
+	clk_disable_unprepare(hub->clk);
 
 	return 0;
 }
@@ -359,8 +358,7 @@ static int usb3503_platform_remove(struct platform_device *pdev)
 	struct usb3503 *hub;
 
 	hub = platform_get_drvdata(pdev);
-	if (hub->clk)
-		clk_disable_unprepare(hub->clk);
+	clk_disable_unprepare(hub->clk);
 
 	return 0;
 }
@@ -373,8 +371,7 @@ static int usb3503_i2c_suspend(struct device *dev)
 
 	usb3503_switch_mode(hub, USB3503_MODE_STANDBY);
 
-	if (hub->clk)
-		clk_disable_unprepare(hub->clk);
+	clk_disable_unprepare(hub->clk);
 
 	return 0;
 }
-- 
2.7.4
