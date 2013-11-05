From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:55:25 +0800
Subject: [PATCH v3 10/10] usb: chipidea: imx: Enable CI_HDRC_IMX_EHCI_QUIRK
In-Reply-To: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1383616525-10769-11-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CI_HDRC_IMX_EHCI_QUIRK for controllers who use mxs-phy.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |   17 ++++++++++++++---
 1 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index fd26c38..78ccde1 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -25,6 +25,7 @@
 
 #define CI_HDRC_IMX_IMX28_WRITE_FIX		BIT(0)
 #define CI_HDRC_IMX_SUPPORT_RUNTIME_PM		BIT(1)
+#define CI_HDRC_IMX_MXS_PHY_EHCI_QUIRK		BIT(2)
 
 struct ci_hdrc_imx_platform_flag {
 	unsigned int flags;
@@ -33,17 +34,24 @@ struct ci_hdrc_imx_platform_flag {
 static const struct ci_hdrc_imx_platform_flag imx27_usb_data = {
 };
 
+static const struct ci_hdrc_imx_platform_flag imx23_usb_data = {
+	.flags = CI_HDRC_IMX_MXS_PHY_EHCI_QUIRK,
+};
+
 static const struct ci_hdrc_imx_platform_flag imx28_usb_data = {
-	.flags = CI_HDRC_IMX_IMX28_WRITE_FIX,
+	.flags = CI_HDRC_IMX_IMX28_WRITE_FIX |
+		CI_HDRC_IMX_MXS_PHY_EHCI_QUIRK,
 };
 
 static const struct ci_hdrc_imx_platform_flag imx6q_usb_data = {
-	.flags = CI_HDRC_IMX_SUPPORT_RUNTIME_PM,
+	.flags = CI_HDRC_IMX_SUPPORT_RUNTIME_PM |
+		CI_HDRC_IMX_MXS_PHY_EHCI_QUIRK,
 };
 
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-usb", .data = &imx6q_usb_data},
 	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
+	{ .compatible = "fsl,imx23-usb", .data = &imx23_usb_data},
 	{ .compatible = "fsl,imx27-usb", .data = &imx27_usb_data},
 	{ /* sentinel */ }
 };
@@ -153,11 +161,14 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	if (imx_platform_flag->flags & CI_HDRC_IMX_IMX28_WRITE_FIX)
 		pdata.flags |= CI_HDRC_IMX28_WRITE_FIX;
 
-	if (imx_platform_flag->flags & CI_HDRC_IMX_SUPPORT_RUNTIME_PM)
+	if (imx_platform_flag->flags & CI_HDRC_IMX_SUPPORT_RUNTIME_PM) {
 		pdata.flags |= CI_HDRC_SUPPORTS_RUNTIME_PM;
 		data->supports_runtime_pm = true;
 	}
 
+	if (imx_platform_flag->flags & CI_HDRC_IMX_MXS_PHY_EHCI_QUIRK)
+		pdata.flags |= CI_HDRC_IMX_EHCI_QUIRK;
+
 	if (data->usbmisc_data) {
 		ret = imx_usbmisc_init(data->usbmisc_data);
 		if (ret) {
-- 
1.7.1
