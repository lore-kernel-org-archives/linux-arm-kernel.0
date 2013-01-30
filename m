From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 30 Jan 2013 16:29:40 +0100
Subject: [PATCH 4/6] usb: chipidea: add PTW and PTS handling
In-Reply-To: <1359559782-14552-1-git-send-email-s.hauer@pengutronix.de>
References: <1359559782-14552-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1359559782-14552-5-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Grzeschik <m.grzeschik@pengutronix.de>

This patch makes it possible to configure the PTW and PTS bits inside
the portsc register for host and device mode before the driver starts
and the phy can be addressed as hardware implementation is designed.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 .../devicetree/bindings/usb/ci13xxx-imx.txt        |    5 +++
 drivers/usb/chipidea/bits.h                        |    7 ++++
 drivers/usb/chipidea/ci13xxx_imx.c                 |    3 ++
 drivers/usb/chipidea/core.c                        |   40 ++++++++++++++++++++
 include/linux/usb/chipidea.h                       |    1 +
 5 files changed, 56 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
index 5778b9c..dd42ccd 100644
--- a/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
+++ b/Documentation/devicetree/bindings/usb/ci13xxx-imx.txt
@@ -5,6 +5,11 @@ Required properties:
 - reg: Should contain registers location and length
 - interrupts: Should contain controller interrupt
 
+Recommended properies:
+- phy_type: the type of the phy connected to the core. Should be one
+  of "utmi", "utmi_wide", "ulpi", "serial" or "hsic". Without this
+  property the PORTSC register won't be touched
+
 Optional properties:
 - fsl,usbphy: phandler of usb phy that connects to the only one port
 - fsl,usbmisc: phandler of non-core register device, with one argument
diff --git a/drivers/usb/chipidea/bits.h b/drivers/usb/chipidea/bits.h
index 050de85..4817fd8 100644
--- a/drivers/usb/chipidea/bits.h
+++ b/drivers/usb/chipidea/bits.h
@@ -48,6 +48,13 @@
 #define PORTSC_SUSP           BIT(7)
 #define PORTSC_HSP            BIT(9)
 #define PORTSC_PTC            (0x0FUL << 16)
+/* PTS and PTW for non lpm version only */
+#define PORTSC_PTS_PTW        (BIT(31) | BIT(30) | BIT(28) | BIT(25))
+#define PORTSC_PTS_PTW_UTMI   0
+#define PORTSC_PTS_PTW_HSIC   BIT(25)
+#define PORTSC_PTS_PTW_UTMIW  BIT(28)
+#define PORTSC_PTS_PTW_ULPI   BIT(31)
+#define PORTSC_PTS_PTW_SERIAL (BIT(30) | BIT(31))
 
 /* DEVLC */
 #define DEVLC_PSPD            (0x03UL << 25)
diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 69024e0..ebc1148 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -21,6 +21,7 @@
 #include <linux/clk.h>
 #include <linux/regulator/consumer.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/usb/of.h>
 
 #include "ci.h"
 #include "ci13xxx_imx.h"
@@ -112,6 +113,8 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 		       CI13XXX_PULLUP_ON_VBUS |
 		       CI13XXX_DISABLE_STREAMING;
 
+	pdata->phy_mode = of_usb_get_phy_mode(pdev->dev.of_node);
+
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
 		dev_err(&pdev->dev, "Failed to allocate CI13xxx-IMX data!\n");
diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c
index 57cae1f..dcb650f 100644
--- a/drivers/usb/chipidea/core.c
+++ b/drivers/usb/chipidea/core.c
@@ -67,6 +67,8 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 #include <linux/usb/chipidea.h>
+#include <linux/usb/of.h>
+#include <linux/phy.h>
 
 #include "ci.h"
 #include "udc.h"
@@ -211,6 +213,42 @@ static int hw_device_init(struct ci13xxx *ci, void __iomem *base)
 	return 0;
 }
 
+static void hw_phymode_configure(struct ci13xxx *ci)
+{
+	u32 portsc;
+
+	/*
+	 * The lpm version has the corresponding bits in the devlc register.
+	 * Currently not implemented.
+	 */
+	if (ci->hw_bank.lpm)
+		return;
+
+	switch (ci->platdata->phy_mode) {
+	case USBPHY_INTERFACE_MODE_UTMI:
+		portsc = PORTSC_PTS_PTW_UTMI;
+		break;
+	case USBPHY_INTERFACE_MODE_UTMIW:
+		portsc = PORTSC_PTS_PTW_UTMIW;
+		break;
+	case USBPHY_INTERFACE_MODE_ULPI:
+		portsc = PORTSC_PTS_PTW_ULPI;
+		break;
+	case USBPHY_INTERFACE_MODE_SERIAL:
+		portsc = PORTSC_PTS_PTW_SERIAL;
+		break;
+	case USBPHY_INTERFACE_MODE_HSIC:
+		portsc = PORTSC_PTS_PTW_HSIC;
+		break;
+	default:
+		return;
+	}
+
+	hw_write(ci, OP_PORTSC, PORTSC_PTS_PTW, portsc);
+
+	mdelay(10);
+}
+
 /**
  * hw_device_reset: resets chip (execute without interruption)
  * @ci: the controller
@@ -476,6 +514,8 @@ static int ci_hdrc_probe(struct platform_device *pdev)
 			: CI_ROLE_GADGET;
 	}
 
+	hw_phymode_configure(ci);
+
 	ret = ci_role_start(ci, ci->role);
 	if (ret) {
 		dev_err(dev, "can't start %s role\n", ci_role(ci)->name);
diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
index 544825d..1a2aa18 100644
--- a/include/linux/usb/chipidea.h
+++ b/include/linux/usb/chipidea.h
@@ -14,6 +14,7 @@ struct ci13xxx_platform_data {
 	uintptr_t	 capoffset;
 	unsigned	 power_budget;
 	struct usb_phy	*phy;
+	enum usb_phy_interface phy_mode;
 	unsigned long	 flags;
 #define CI13XXX_REGS_SHARED		BIT(0)
 #define CI13XXX_REQUIRE_TRANSCEIVER	BIT(1)
-- 
1.7.10.4
