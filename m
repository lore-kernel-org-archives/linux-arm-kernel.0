From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri,  1 Feb 2013 08:48:27 +0100
Subject: [PATCH 6/9] USB chipidea i.MX: introduce dr_mode property
In-Reply-To: <1359704911-8275-1-git-send-email-s.hauer@pengutronix.de>
References: <1359704911-8275-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1359704911-8275-7-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dr_mode devicetree property allows to explicitly specify the
host/peripheral/otg mode. This is necessary for boards without proper
ID pin handling.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Peter Chen <peter.chen@freescale.com>
---
 Documentation/devicetree/bindings/usb/ci13xxx-imx.txt |    1 +
 drivers/usb/chipidea/ci13xxx_imx.c                    |    1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
index dd42ccd..493a414 100644
--- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
+++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
@@ -9,6 +9,7 @@ Recommended properies:
 - phy_type: the type of the phy connected to the core. Should be one
   of "utmi", "utmi_wide", "ulpi", "serial" or "hsic". Without this
   property the PORTSC register won't be touched
+- dr_mode: One of "host", "peripheral" or "otg". Defaults to "otg"
 
 Optional properties:
 - fsl,usbphy: phandler of usb phy that connects to the only one port
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index ebc1148..b598bb8f 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -114,6 +114,7 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		       CI13XXX_DISABLE_STREAMING;
 
 	pdata->phy_mode = of_usb_get_phy_mode(pdev->dev.of_node);
+	pdata->dr_mode = of_usb_get_dr_mode(pdev->dev.of_node);
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
-- 
1.7.10.4
