From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 26 Jul 2013 17:18:19 +0800
Subject: [PATCH v13 03/14] usb: chipidea: imx: add return value check for
 devm_regulator_get
In-Reply-To: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
References: <1374830310-21765-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1374830310-21765-4-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

- If devm_regulator_get returns -EPROBE_DEFER, we also return
-EPROBE_DEFER to wait regulator being ready later.
- If devm_regulator_get returns -ENODEV, we think there is
no "vbus-supply" node at DT, it means this board doesn't need
vbus control.
- If devm_regulator_get returns other error values, it means
there are something wrong for getting this regulator.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci_hdrc_imx.c |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index d06355e..0ced8c1 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -144,8 +144,18 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	/* Get the vbus regulator */
 	pdata.reg_vbus = devm_regulator_get(&pdev->dev, "vbus");
-	if (IS_ERR(pdata.reg_vbus))
-		pdata.reg_vbus = NULL;
+	if (PTR_ERR(pdata.reg_vbus) == -EPROBE_DEFER) {
+		ret = -EPROBE_DEFER;
+		goto err_clk;
+	} else if (PTR_ERR(pdata.reg_vbus) == -ENODEV) {
+		pdata.reg_vbus = NULL; /* no vbus regualator is needed */
+	} else if (IS_ERR(pdata.reg_vbus)) {
+		dev_err(&pdev->dev,
+				"Getting regulator error: %ld\n",
+					PTR_ERR(pdata.reg_vbus));
+		ret = PTR_ERR(pdata.reg_vbus);
+		goto err_clk;
+	}
 
 	if (!pdev->dev.dma_mask)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
-- 
1.7.0.4
