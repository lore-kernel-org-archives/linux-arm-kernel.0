From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Thu, 19 Apr 2018 15:30:53 +0200
Subject: [PATCH v2 2/2] usb: host: xhci-plat: Fix clock resource by adding a
 register clock
In-Reply-To: <20180419133053.11894-1-gregory.clement@bootlin.com>
References: <20180419133053.11894-1-gregory.clement@bootlin.com>
Message-ID: <20180419133053.11894-3-gregory.clement@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Armada 7K/8K we need to explicitly enable the register clock. This
clock is optional because not all the SoCs using this IP need it but at
least for Armada 7K/8K it is actually mandatory.

The change was done at xhci-plat level and not at a xhci-mvebu.c because,
it is expected that other SoC would have this kind of constraint.

The binding documentation is updating accordingly.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt |  5 ++++-
 drivers/usb/host/xhci-plat.c                       | 25 ++++++++++++++++++----
 drivers/usb/host/xhci.h                            |  3 ++-
 3 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index c4c00dff4b56..bd1dd316fb23 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -28,7 +28,10 @@ Required properties:
   - interrupts: one XHCI interrupt should be described here.
 
 Optional properties:
-  - clocks: reference to a clock
+  - clocks: reference to the clocks
+  - clock-names: mandatory if there is a second clock, in this case
+    the name must be "core" for the first clock and "reg" for the
+    second one
   - usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
   - usb3-lpm-capable: determines if platform is USB3 LPM capable
   - quirk-broken-port-ped: set if the controller has broken port disable mechanism
diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index f0231fea524e..596e7a71b666 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -157,6 +157,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	struct resource         *res;
 	struct usb_hcd		*hcd;
 	struct clk              *clk;
+	struct clk              *reg_clk;
 	int			ret;
 	int			irq;
 
@@ -226,17 +227,27 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	hcd->rsrc_len = resource_size(res);
 
 	/*
-	 * Not all platforms have a clk so it is not an error if the
-	 * clock does not exists.
+	 * Not all platforms have clks so it is not an error if the
+	 * clock do not exist.
 	 */
+	reg_clk = devm_clk_get(&pdev->dev, "reg");
+	if (!IS_ERR(reg_clk)) {
+		ret = clk_prepare_enable(reg_clk);
+		if (ret)
+			goto put_hcd;
+	} else if (PTR_ERR(reg_clk) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto put_hcd;
+	}
+
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (!IS_ERR(clk)) {
 		ret = clk_prepare_enable(clk);
 		if (ret)
-			goto put_hcd;
+			goto disable_reg_clk;
 	} else if (PTR_ERR(clk) == -EPROBE_DEFER) {
 		ret = -EPROBE_DEFER;
-		goto put_hcd;
+		goto disable_reg_clk;
 	}
 
 	xhci = hcd_to_xhci(hcd);
@@ -252,6 +263,7 @@ static int xhci_plat_probe(struct platform_device *pdev)
 	device_wakeup_enable(hcd->self.controller);
 
 	xhci->clk = clk;
+	xhci->reg_clk = reg_clk;
 	xhci->main_hcd = hcd;
 	xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
 			dev_name(&pdev->dev), hcd);
@@ -322,6 +334,9 @@ static int xhci_plat_probe(struct platform_device *pdev)
 disable_clk:
 	clk_disable_unprepare(clk);
 
+disable_reg_clk:
+	clk_disable_unprepare(reg_clk);
+
 put_hcd:
 	usb_put_hcd(hcd);
 
@@ -337,6 +352,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	struct usb_hcd	*hcd = platform_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
 	struct clk *clk = xhci->clk;
+	struct clk *reg_clk = xhci->reg_clk;
 
 	xhci->xhc_state |= XHCI_STATE_REMOVING;
 
@@ -347,6 +363,7 @@ static int xhci_plat_remove(struct platform_device *dev)
 	usb_put_hcd(xhci->shared_hcd);
 
 	clk_disable_unprepare(clk);
+	clk_disable_unprepare(reg_clk);
 	usb_put_hcd(hcd);
 
 	pm_runtime_set_suspended(&dev->dev);
diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 05c909b04f14..6dfc4867dbcf 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1729,8 +1729,9 @@ struct xhci_hcd {
 	int		page_shift;
 	/* msi-x vectors */
 	int		msix_count;
-	/* optional clock */
+	/* optional clocks */
 	struct clk		*clk;
+	struct clk		*reg_clk;
 	/* data structures */
 	struct xhci_device_context_array *dcbaa;
 	struct xhci_ring	*cmd_ring;
-- 
2.16.3
