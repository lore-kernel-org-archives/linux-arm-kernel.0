From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Wed, 27 Jun 2012 14:21:50 +0200
Subject: [PATCH 3/3] usb: chipidea: ci13xxx-imx: add "dr_role" property to
 device tree bindings
In-Reply-To: <1340799710-32696-1-git-send-email-mkl@pengutronix.de>
References: <1340799710-32696-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1340799710-32696-4-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch allows the device tree to limit the chipidea to host or
peripheral mode only.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    4 ++
 arch/arm/boot/dts/imx28.dtsi                       |    1 +
 drivers/usb/chipidea/ci13xxx_imx.c                 |    3 ++
 drivers/usb/chipidea/core.c                        |   40 +++++++++++++++++---
 include/linux/usb/chipidea.h                       |    9 +++++
 5 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
index 8bcd071..f55f2d5 100644
--- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
+++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
@@ -4,6 +4,9 @@ Required properties:
 - compatible: Should be "fsl,imx27-usb"
 - reg: Should contain registers location and length
 - interrupts: Should contain controller interrupt
+- dr_mode: indicates the working mode for "fsl,imx27-usb" compatible
+  controllers. Can be "host", "peripheral", or "otg". Defaults to
+  "otg" if not defined.
 
 Optional properties:
 - fsl,usbphy: phandler of usb phy that connects to the only one port
@@ -17,4 +20,5 @@ usb at 02184000 { /* USB OTG */
 	interrupts = <0 43 0x04>;
 	fsl,usbphy = <&usbphy1>;
 	fsl,vbus-power-gpios = <&gpio3 22 0>;
+	dr_mode= "otg";
 };
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 65d6ae3..9cbf9b9 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -467,6 +467,7 @@
 			interrupts = <93>;
 			fsl,usbphy = <&usbphy0>;
 			status = "disabled";
+			dr_mode = "host";
 		};
 
 		usb1: usb at 80090000 {
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index efae2be..8e926fb 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -120,6 +120,9 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 		*pdev->dev.dma_mask = DMA_BIT_MASK(32);
 		dma_set_coherent_mask(&pdev->dev, *pdev->dev.dma_mask);
 	}
+
+	ci13xxx_get_dr_mode(pdev->dev.of_node, &ci13xxx_imx_platdata);
+
 	plat_ci = ci13xxx_add_device(&pdev->dev,
 				pdev->resource, pdev->num_resources,
 				&ci13xxx_imx_platdata);
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 1083585..89d2cae 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -63,6 +63,7 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
+#include <linux/of_platform.h>
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
@@ -386,6 +387,23 @@ void ci13xxx_remove_device(struct platform_device *pdev)
 }
 EXPORT_SYMBOL_GPL(ci13xxx_remove_device);
 
+void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata)
+{
+	const unsigned char *dr_mode;
+
+	dr_mode = of_get_property(of_node, "dr_mode", NULL);
+	if (!dr_mode)
+		return;
+
+	if (!strcmp(dr_mode, "host"))
+		pdata->flags |= CI13XXX_DR_MODE_HOST;
+	else if (!strcmp(dr_mode, "peripheral"))
+		pdata->flags |= CI13XXX_DR_MODE_PERIPHERAL;
+	else if (!strcmp(dr_mode, "otg"))
+		pdata->flags |= CI13XXX_DR_MODE_OTG;
+}
+EXPORT_SYMBOL_GPL(ci13xxx_get_dr_mode);
+
 static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
@@ -446,13 +464,23 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 	}
 
 	/* initialize role(s) before the interrupt is requested */
-	ret = ci_hdrc_host_init(ci);
-	if (ret)
-		dev_info(dev, "doesn't support host\n");
+	/* default to otg */
+	if (!(ci->platdata->flags & CI13XXX_DR_MODE_MASK))
+		ci->platdata->flags |= CI13XXX_DR_MODE_OTG;
+
+	if (ci->platdata->flags &
+	    (CI13XXX_DR_MODE_HOST | CI13XXX_DR_MODE_OTG)) {
+		ret = ci_hdrc_host_init(ci);
+		if (ret)
+			dev_info(dev, "doesn't support host\n");
+	}
 
-	ret = ci_hdrc_gadget_init(ci);
-	if (ret)
-		dev_info(dev, "doesn't support gadget\n");
+	if (ci->platdata->flags &
+	    (CI13XXX_DR_MODE_PERIPHERAL | CI13XXX_DR_MODE_OTG)) {
+		ret = ci_hdrc_gadget_init(ci);
+		if (ret)
+			dev_info(dev, "doesn't support gadget\n");
+	}
 
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 544825d..29ad908 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -19,6 +19,12 @@ struct ci13xxx_platform_data {
 #define CI13XXX_REQUIRE_TRANSCEIVER	BIT(1)
 #define CI13XXX_PULLUP_ON_VBUS		BIT(2)
 #define CI13XXX_DISABLE_STREAMING	BIT(3)
+#define CI13XXX_DR_MODE_HOST		BIT(4)
+#define CI13XXX_DR_MODE_PERIPHERAL	BIT(5)
+#define CI13XXX_DR_MODE_OTG		BIT(6)
+#define CI13XXX_DR_MODE_MASK \
+	(CI13XXX_DR_MODE_HOST | CI13XXX_DR_MODE_PERIPHERAL | \
+	 CI13XXX_DR_MODE_OTG)
 
 #define CI13XXX_CONTROLLER_RESET_EVENT		0
 #define CI13XXX_CONTROLLER_STOPPED_EVENT	1
@@ -35,4 +41,7 @@ struct platform_device *ci13xxx_add_device(struct device *dev,
 /* Remove ci13xxx device */
 void ci13xxx_remove_device(struct platform_device *pdev);
 
+/* Parse of-tree "dr_mode" property */
+void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata);
+
 #endif
-- 
1.7.10
