From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue,  9 Dec 2014 17:13:35 +0100
Subject: [PATCH 1/2] usb: chipidea: usbmisc: skip clocks on i.MX6
Message-ID: <1418141616-29671-1-git-send-email-p.zabel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6Q, the USBMISC registers are clocked by the IPG clock,
so there is no need to enable USBOH3 for the USBMISC driver.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/usb/chipidea/usbmisc_imx.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
index 926c997..f7b878d 100644
--- a/drivers/usb/chipidea/usbmisc_imx.c
+++ b/drivers/usb/chipidea/usbmisc_imx.c
@@ -338,23 +338,27 @@ static int usbmisc_imx_probe(struct platform_device *pdev)
 	if (IS_ERR(data->base))
 		return PTR_ERR(data->base);
 
-	data->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(data->clk)) {
-		dev_err(&pdev->dev,
-			"failed to get clock, err=%ld\n", PTR_ERR(data->clk));
-		return PTR_ERR(data->clk);
-	}
-
-	ret = clk_prepare_enable(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev,
-			"clk_prepare_enable failed, err=%d\n", ret);
-		return ret;
-	}
-
 	tmp_dev = (struct of_device_id *)
 		of_match_device(usbmisc_imx_dt_ids, &pdev->dev);
 	data->ops = (const struct usbmisc_ops *)tmp_dev->data;
+
+	/* on i.MX6Q, the USBMISC register space is clocked by the IPG clock */
+	if (data->ops != &imx6q_usbmisc_ops) {
+		data->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(data->clk)) {
+			dev_err(&pdev->dev, "failed to get clock, err=%ld\n",
+				PTR_ERR(data->clk));
+			return PTR_ERR(data->clk);
+		}
+
+		ret = clk_prepare_enable(data->clk);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"clk_prepare_enable failed, err=%d\n", ret);
+			return ret;
+		}
+	}
+
 	platform_set_drvdata(pdev, data);
 
 	return 0;
-- 
2.1.3
