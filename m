From: johnyoun@synopsys.com (John Youn)
Date: Wed, 09 Nov 2016 19:27:40 -0800
Subject: [PATCH v2 01/30] usb: dwc2: Deprecate g-use-dma binding
In-Reply-To: <cover.1478748145.git.johnyoun@synopsys.com>
References: <cover.1478748145.git.johnyoun@synopsys.com>
Message-ID: <966d342a5a7fee9ac3ef8140b60c228c4a87c7d3.1478748145.git.johnyoun@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is not needed as the gadget now fully supports DMA and it can
autodetect it. This was initially added because gadget DMA mode was only
partially implemented so could not be automatically enabled.

Signed-off-by: John Youn <johnyoun@synopsys.com>
---
 Documentation/devicetree/bindings/usb/dwc2.txt |  4 +++-
 arch/arm/boot/dts/rk3036.dtsi                  |  1 -
 arch/arm/boot/dts/rk3288.dtsi                  |  1 -
 arch/arm/boot/dts/rk3xxx.dtsi                  |  1 -
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  1 -
 arch/arm64/boot/dts/rockchip/rk3368.dtsi       |  1 -
 drivers/usb/dwc2/core.h                        |  4 +---
 drivers/usb/dwc2/params.c                      | 17 ++++++++++++++---
 drivers/usb/dwc2/pci.c                         |  1 -
 9 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.txt b/Documentation/devicetree/bindings/usb/dwc2.txt
index 9472111..389bb13 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.txt
+++ b/Documentation/devicetree/bindings/usb/dwc2.txt
@@ -26,11 +26,13 @@ Refer to phy/phy-bindings.txt for generic phy consumer properties
 - dr_mode: shall be one of "host", "peripheral" and "otg"
   Refer to usb/generic.txt
 - snps,host-dma-disable: disable host DMA mode.
-- g-use-dma: enable dma usage in gadget driver.
 - g-rx-fifo-size: size of rx fifo size in gadget mode.
 - g-np-tx-fifo-size: size of non-periodic tx fifo size in gadget mode.
 - g-tx-fifo-size: size of periodic tx fifo per endpoint (except ep0) in gadget mode.
 
+Deprecated properties:
+- g-use-dma: gadget DMA mode is automatically detected
+
 Example:
 
         usb at 101c0000 {
diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index a935523..7c2dc19 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -204,7 +204,6 @@
 		g-np-tx-fifo-size = <16>;
 		g-rx-fifo-size = <275>;
 		g-tx-fifo-size = <256 128 128 64 64 32>;
-		g-use-dma;
 		status = "disabled";
 	};
 
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 17ec2e2..74a749c 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -596,7 +596,6 @@
 		g-np-tx-fifo-size = <16>;
 		g-rx-fifo-size = <275>;
 		g-tx-fifo-size = <256 128 128 64 64 32>;
-		g-use-dma;
 		phys = <&usbphy0>;
 		phy-names = "usb2-phy";
 		status = "disabled";
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index e15beb3..8fbd3c8 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -181,7 +181,6 @@
 		g-np-tx-fifo-size = <16>;
 		g-rx-fifo-size = <275>;
 		g-tx-fifo-size = <256 128 128 64 64 32>;
-		g-use-dma;
 		phys = <&usbphy0>;
 		phy-names = "usb2-phy";
 		status = "disabled";
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 17839db..e0ea603 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -747,7 +747,6 @@
 			clocks = <&sys_ctrl HI6220_USBOTG_HCLK>;
 			clock-names = "otg";
 			dr_mode = "otg";
-			g-use-dma;
 			g-rx-fifo-size = <512>;
 			g-np-tx-fifo-size = <128>;
 			g-tx-fifo-size = <128 128 128 128 128 128>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index 0fcb214..df231c4 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -537,7 +537,6 @@
 		g-np-tx-fifo-size = <16>;
 		g-rx-fifo-size = <275>;
 		g-tx-fifo-size = <256 128 128 64 64 32>;
-		g-use-dma;
 		status = "disabled";
 	};
 
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index a1075ad..f8c97f5 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -418,9 +418,7 @@ enum dwc2_ep0_state {
  *			needed.
  *			0 - No (default)
  *			1 - Yes
- * @g_dma:              If true, enables dma usage on the device. This
- *                      setting is not auto-detected. It must be
- *                      explicitly enabled (default: false).
+ * @g_dma:              Enables gadget dma usage (default: autodetect).
  * @g_rx_fifo_size:	The periodic rx fifo size for the device, in
  *			DWORDS from 16-32768 (default: 2048 if
  *			possible, otherwise autodetect).
diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 2eb79e8..74c3728 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -1086,6 +1086,19 @@ static void dwc2_set_param_tx_fifo_sizes(struct dwc2_hsotg *hsotg)
 	}
 }
 
+static void dwc2_set_gadget_dma(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_hw_params *hw = &hsotg->hw_params;
+	struct dwc2_core_params *p = &hsotg->params;
+	bool dma_capable = !(hw->arch == GHWCFG2_SLAVE_ONLY_ARCH);
+
+	/* Buffer DMA */
+	dwc2_set_param_bool(hsotg, &p->g_dma,
+			    false, "gadget-dma",
+			    true, false,
+			    dma_capable);
+}
+
 /**
  * dwc2_set_parameters() - Set all core parameters.
  *
@@ -1161,9 +1174,7 @@ static void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
 	    (hsotg->dr_mode == USB_DR_MODE_OTG)) {
 		dev_dbg(hsotg->dev, "Setting peripheral device properties\n");
 
-		dwc2_set_param_bool(hsotg, &p->g_dma, true, "g-use-dma",
-				    false, false,
-				    dma_capable);
+		dwc2_set_gadget_dma(hsotg);
 
 		/*
 		 * The values for g_rx_fifo_size (2048) and
diff --git a/drivers/usb/dwc2/pci.c b/drivers/usb/dwc2/pci.c
index b3f3b58..a23329e 100644
--- a/drivers/usb/dwc2/pci.c
+++ b/drivers/usb/dwc2/pci.c
@@ -67,7 +67,6 @@ static int dwc2_pci_quirks(struct pci_dev *pdev, struct platform_device *dwc2)
 	if (pdev->vendor == PCI_VENDOR_ID_SYNOPSYS &&
 	    pdev->device == PCI_PRODUCT_ID_HAPS_HSOTG) {
 		struct property_entry properties[] = {
-			PROPERTY_ENTRY_BOOL("g-use-dma"),
 			{ },
 		};
 
-- 
2.10.0
