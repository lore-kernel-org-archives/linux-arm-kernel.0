From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 19 Mar 2015 09:19:15 +0800
Subject: [PATCH 04/12] usb: chipidea: imx: add stream mode enable for device
 mode at imx6sl/imx6sx
In-Reply-To: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
References: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1426727963-32280-5-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stream mode enable is known for better performance, this stream mode
enable patch has been passed with stress tests at device mode for
imx6sl and imx6sx, and no issue is found.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 389f0e0..5373984 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -29,26 +29,31 @@ struct ci_hdrc_imx_platform_flag {
 };
 
 static const struct ci_hdrc_imx_platform_flag imx27_usb_data = {
+		CI_HDRC_DISABLE_STREAMING,
 };
 
 static const struct ci_hdrc_imx_platform_flag imx28_usb_data = {
 	.flags = CI_HDRC_IMX28_WRITE_FIX |
-		CI_HDRC_TURN_VBUS_EARLY_ON,
+		CI_HDRC_TURN_VBUS_EARLY_ON |
+		CI_HDRC_DISABLE_STREAMING,
 };
 
 static const struct ci_hdrc_imx_platform_flag imx6q_usb_data = {
 	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM |
-		CI_HDRC_TURN_VBUS_EARLY_ON,
+		CI_HDRC_TURN_VBUS_EARLY_ON |
+		CI_HDRC_DISABLE_STREAMING,
 };
 
 static const struct ci_hdrc_imx_platform_flag imx6sl_usb_data = {
 	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM |
-		CI_HDRC_TURN_VBUS_EARLY_ON,
+		CI_HDRC_TURN_VBUS_EARLY_ON |
+		CI_HDRC_DISABLE_HOST_STREAMING,
 };
 
 static const struct ci_hdrc_imx_platform_flag imx6sx_usb_data = {
 	.flags = CI_HDRC_SUPPORTS_RUNTIME_PM |
-		CI_HDRC_TURN_VBUS_EARLY_ON,
+		CI_HDRC_TURN_VBUS_EARLY_ON |
+		CI_HDRC_DISABLE_HOST_STREAMING,
 };
 
 static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
@@ -126,7 +131,6 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	struct ci_hdrc_platform_data pdata = {
 		.name		= dev_name(&pdev->dev),
 		.capoffset	= DEF_CAPOFFSET,
-		.flags		= CI_HDRC_DISABLE_STREAMING,
 	};
 	int ret;
 	const struct of_device_id *of_id =
-- 
1.9.1
