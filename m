From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 5 Nov 2013 09:55:21 +0800
Subject: [PATCH v3 06/10] usb: chipidea: imx: call set_wakeup when necessary
In-Reply-To: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
References: <1383616525-10769-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1383616525-10769-7-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- Disable wakeup after probe
- Enable wakeup during the suspend
- Disable wakeup after controller is active

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |   36 ++++++++++++++++++++++++++++++++++++
 1 files changed, 36 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 803630e..5fbaa73 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -176,6 +176,15 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 		}
 	}
 
+	if (data->usbmisc_data) {
+		ret = imx_usbmisc_set_wakeup(data->usbmisc_data, false);
+		if (ret) {
+			dev_err(&pdev->dev, "usbmisc set_wakeup failed, ret=%d\n",
+					ret);
+			goto disable_device;
+		}
+	}
+
 	platform_set_drvdata(pdev, data);
 
 	device_set_wakeup_capable(&pdev->dev, true);
@@ -213,12 +222,23 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
 static int imx_controller_suspend(struct device *dev)
 {
 	struct ci_hdrc_imx_data *data = dev_get_drvdata(dev);
+	int ret;
 
 	dev_dbg(dev, "at %s\n", __func__);
 
 	if (data->in_lpm)
 		return 0;
 
+	if (data->usbmisc_data) {
+		ret = imx_usbmisc_set_wakeup(data->usbmisc_data, true);
+		if (ret) {
+			dev_err(dev,
+				"usbmisc set_wakeup failed, ret=%d\n",
+				ret);
+			return ret;
+		}
+	}
+
 	clk_disable_unprepare(data->clk);
 
 	data->in_lpm = true;
@@ -242,6 +262,22 @@ static int imx_controller_resume(struct device *dev)
 
 	data->in_lpm = false;
 
+	if (data->usbmisc_data) {
+		ret = imx_usbmisc_set_wakeup(data->usbmisc_data, false);
+		if (ret) {
+			dev_err(dev,
+				"usbmisc set_wakeup failed, ret=%d\n",
+				ret);
+			ret = -EINVAL;
+			goto clk_disable;
+		}
+	}
+
+	return 0;
+
+clk_disable:
+	clk_disable_unprepare(data->clk);
+
 	return ret;
 }
 
-- 
1.7.1
