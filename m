From: m.grzeschik@pengutronix.de (Michael Grzeschik)
Date: Wed, 14 Nov 2012 17:19:05 +0100
Subject: [PATCH 4/9] usb: chipidea: ci13xxx-imx: add "dr_mode" property to
 device tree bindings
In-Reply-To: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
References: <1352909950-32555-1-git-send-email-m.grzeschik@pengutronix.de>
Message-ID: <1352909950-32555-5-git-send-email-m.grzeschik@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Kleine-Budde <mkl@pengutronix.de>

Its necessary to limit a hostonly soc to its single role, since
debugging has shown that reading on the "CAP_DCCPARAMS" register inside
a host-only port, what ci_hdrc_gadget_init does, can lead to an
instable behaviour of the IC.

This patch allows the device tree to limit the chipidea to host or
peripheral mode only. Its uses the oftree name dr_mode, which is already
mainline and used i.e. in fsl-mph-dr-of.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    4 ++
 arch/arm/boot/dts/imx28.dtsi                       |    2 +
 drivers/usb/chipidea/ci13xxx_imx.c                 |    2 +
 drivers/usb/chipidea/core.c                        |   39 +++++++++++++++++---
 include/linux/usb/chipidea.h                       |    7 ++++
 5 files changed, 48 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
index 5778b9c..c83aea4 100644
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
@@ -20,4 +23,5 @@ usb at 02184000 { /* USB OTG */
 	fsl,usbphy = <&usbphy1>;
 	fsl,usbmisc = <&usbmisc 0>;
 	disable-over-current;
+	dr_mode= "otg";
 };
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 55c57ea..2a6dd21 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -874,6 +874,7 @@
 			clocks = <&clks 60>;
 			fsl,usbphy = <&usbphy0>;
 			status = "disabled";
+			dr_mode = "otg";
 		};
 
 		usb1: usb at 80090000 {
@@ -883,6 +884,7 @@
 			clocks = <&clks 61>;
 			fsl,usbphy = <&usbphy1>;
 			status = "disabled";
+			dr_mode = "host";
 		};
 
 		dflpt at 800c0000 {
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 7b99c96..ee4dab0 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -237,6 +237,8 @@ static int __devinit ci13xxx_imx_probe(struct platform_device *pdev)
 		}
 	}
 
+	ci13xxx_get_dr_mode(pdev->dev.of_node, pdata);
+
 	plat_ci = ci13xxx_add_device(&pdev->dev,
 				pdev->resource, pdev->num_resources,
 				pdata);
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index b50b77a..3e3e159 100644
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
@@ -521,6 +522,23 @@ void ci13xxx_remove_device(struct platform_device *pdev)
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
+		pdata->flags |= CI13XXX_DR_MODE_HOST | CI13XXX_DR_MODE_PERIPHERAL;
+}
+EXPORT_SYMBOL_GPL(ci13xxx_get_dr_mode);
+
 static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 {
 	struct device	*dev = &pdev->dev;
@@ -591,13 +609,22 @@ static int __devinit ci_hdrc_probe(struct platform_device *pdev)
 	hw_write(ci, OP_OTGSC, OTGSC_INT_STATUS_BITS, OTGSC_INT_STATUS_BITS);
 
 	/* initialize role(s) before the interrupt is requested */
-	ret = ci_hdrc_host_init(ci);
-	if (ret)
-		dev_info(dev, "doesn't support host\n");
+	/* default to otg */
+	if (!(ci->platdata->flags & CI13XXX_DR_MODE_MASK))
+		ci->platdata->flags |= CI13XXX_DR_MODE_HOST |
+			CI13XXX_DR_MODE_PERIPHERAL;
+
+	if (ci->platdata->flags & CI13XXX_DR_MODE_HOST) {
+		ret = ci_hdrc_host_init(ci);
+		if (ret)
+			dev_info(dev, "doesn't support host\n");
+	}
 
-	ret = ci_hdrc_gadget_init(ci);
-	if (ret)
-		dev_info(dev, "doesn't support gadget\n");
+	if (ci->platdata->flags & CI13XXX_DR_MODE_PERIPHERAL) {
+		ret = ci_hdrc_gadget_init(ci);
+		if (ret)
+			dev_info(dev, "doesn't support gadget\n");
+	}
 
 	if (!ci->roles[CI_ROLE_HOST] && !ci->roles[CI_ROLE_GADGET]) {
 		dev_err(dev, "no supported roles\n");
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 544825d..906d259 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -19,6 +19,10 @@ struct ci13xxx_platform_data {
 #define CI13XXX_REQUIRE_TRANSCEIVER	BIT(1)
 #define CI13XXX_PULLUP_ON_VBUS		BIT(2)
 #define CI13XXX_DISABLE_STREAMING	BIT(3)
+#define CI13XXX_DR_MODE_HOST		BIT(4)
+#define CI13XXX_DR_MODE_PERIPHERAL	BIT(5)
+#define CI13XXX_DR_MODE_MASK \
+	(CI13XXX_DR_MODE_HOST | CI13XXX_DR_MODE_PERIPHERAL)
 
 #define CI13XXX_CONTROLLER_RESET_EVENT		0
 #define CI13XXX_CONTROLLER_STOPPED_EVENT	1
@@ -35,4 +39,7 @@ struct platform_device *ci13xxx_add_device(struct device *dev,
 /* Remove ci13xxx device */
 void ci13xxx_remove_device(struct platform_device *pdev);
 
+/* Parse of-tree "dr_mode" property */
+void ci13xxx_get_dr_mode(struct device_node *of_node, struct ci13xxx_platform_data *pdata);
+
 #endif
-- 
1.7.10.4
