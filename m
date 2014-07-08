From: mpa@pengutronix.de (Markus Pargmann)
Date: Tue,  8 Jul 2014 12:14:40 +0200
Subject: [PATCH 1/2] usb: ci_hdrc_imx: Return -EINVAL for missing USB PHY
Message-ID: <1404814481-7652-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-ENODEV is interpreted by the generic driver probing function as a
non-matching driver. This leads to a missing probe failure message.

Also a missing USB PHY is more of an invalid configuration of the usb
driver because it is necessary.

This patch returns -EINVAL if devm_usb_get_phy_by_phandle() returned -ENODEV.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 2e58f8dfd311..65444b02bd68 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -133,6 +133,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 	data->phy = devm_usb_get_phy_by_phandle(&pdev->dev, "fsl,usbphy", 0);
 	if (IS_ERR(data->phy)) {
 		ret = PTR_ERR(data->phy);
+		/* Return -EINVAL if no usbphy is available */
+		if (ret == -ENODEV)
+			ret = -EINVAL;
 		goto err_clk;
 	}
 
-- 
2.0.0
