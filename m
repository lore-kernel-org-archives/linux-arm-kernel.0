From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:55:22 +0800
Subject: [PATCH v3 07/10] usb: chipidea: imx: Enable runtime pm support for
 imx6q
In-Reply-To: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1383616525-10769-8-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, only imx6q adds wakeup logic, so only enable
runtime pm for imx6q.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |   13 ++++++++++++-
 1 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 5fbaa73..fd26c38 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -23,7 +23,8 @@
 #include "ci.h"
 #include "ci_hdrc_imx.h"
 
-#define CI_HDRC_IMX_IMX28_WRITE_FIX BIT(0)
+#define CI_HDRC_IMX_IMX28_WRITE_FIX		BIT(0)
+#define CI_HDRC_IMX_SUPPORT_RUNTIME_PM		BIT(1)
 
 struct ci_hdrc_imx_platform_flag {
 	unsigned int flags;
@@ -36,7 +37,12 @@ static const struct ci_hdrc_imx_platform_flag imx28_usb_data = {
 	.flags = CI_HDRC_IMX_IMX28_WRITE_FIX,
 };
 
+static const struct ci_hdrc_imx_platform_flag imx6q_usb_data = {
+	.flags = CI_HDRC_IMX_SUPPORT_RUNTIME_PM,
+};
+
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-usb", .data = &imx6q_usb_data},
 	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
 	{ .compatible = "fsl,imx27-usb", .data = &imx27_usb_data},
 	{ /* sentinel */ }
@@ -147,6 +153,11 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	if (imx_platform_flag->flags & CI_HDRC_IMX_IMX28_WRITE_FIX)
 		pdata.flags |= CI_HDRC_IMX28_WRITE_FIX;
 
+	if (imx_platform_flag->flags & CI_HDRC_IMX_SUPPORT_RUNTIME_PM)
+		pdata.flags |= CI_HDRC_SUPPORTS_RUNTIME_PM;
+		data->supports_runtime_pm = true;
+	}
+
 	if (data->usbmisc_data) {
 		ret = imx_usbmisc_init(data->usbmisc_data);
 		if (ret) {
-- 
1.7.1
