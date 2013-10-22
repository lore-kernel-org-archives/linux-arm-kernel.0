From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 22 Oct 2013 14:23:35 +0800
Subject: [Patch v2 06/10] usb: chipidea: imx: call set_wakeup when necessary
In-Reply-To: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
References: <1382423019-26184-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382423019-26184-7-git-send-email-peter.chen@freescale.com>
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
index a1e5634..2a14152 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -152,6 +152,15 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
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
@@ -189,12 +198,23 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
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
@@ -218,6 +238,22 @@ static int imx_controller_resume(struct device *dev)
 
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
