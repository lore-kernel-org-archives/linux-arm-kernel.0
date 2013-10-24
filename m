From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 24 Oct 2013 17:30:31 +0800
Subject: [PATCH v2 3/3] usb: chipidea: imx: set CI_HDRC_IMX28_WRITE_FIX for
 imx28
In-Reply-To: <1382607031-26131-1-git-send-email-peter.chen@freescale.com>
References: <1382607031-26131-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1382607031-26131-3-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to imx28 needs ARM swp instruction for writing, we set
CI_HDRC_IMX28_WRITE_FIX for imx28.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---

Changes for v2:
- Using of_device_id->data to get platform's flag

 drivers/usb/chipidea/ci_hdrc_imx.c |   32 ++++++++++++++++++++++++++------
 1 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index 023d3cb..68f7f5e 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -23,6 +23,26 @@
 #include "ci.h"
 #include "ci_hdrc_imx.h"
 
+#define CI_HDRC_IMX_IMX28_WRITE_FIX BIT(0)
+
+struct ci_hdrc_imx_platform_flag {
+	unsigned int flags;
+};
+
+static const struct ci_hdrc_imx_platform_flag imx27_usb_data = {
+};
+
+static const struct ci_hdrc_imx_platform_flag imx28_usb_data = {
+	.flags = CI_HDRC_IMX_IMX28_WRITE_FIX,
+};
+
+static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
+	{ .compatible = "fsl,imx28-usb", .data = &imx28_usb_data},
+	{ .compatible = "fsl,imx27-usb", .data = &imx27_usb_data},
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ci_hdrc_imx_dt_ids);
+
 struct ci_hdrc_imx_data {
 	struct usb_phy *phy;
 	struct platform_device *ci_pdev;
@@ -82,6 +102,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 				  CI_HDRC_DISABLE_STREAMING,
 	};
 	int ret;
+	const struct of_device_id *of_id =
+			of_match_device(ci_hdrc_imx_dt_ids, &pdev->dev);
+	const struct ci_hdrc_imx_platform_flag *imx_platform_flag = of_id->data;
 
 	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
 	if (!data) {
@@ -115,6 +138,9 @@ static int ci_hdrc_imx_probe(struct platform_device *pdev)
 
 	pdata.phy = data->phy;
 
+	if (imx_platform_flag->flags & CI_HDRC_IMX_IMX28_WRITE_FIX)
+		pdata.flags |= CI_HDRC_IMX28_WRITE_FIX;
+
 	if (!pdev->dev.dma_mask)
 		pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
 	if (!pdev->dev.coherent_dma_mask)
@@ -174,12 +200,6 @@ static int ci_hdrc_imx_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id ci_hdrc_imx_dt_ids[] = {
-	{ .compatible = "fsl,imx27-usb", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, ci_hdrc_imx_dt_ids);
-
 static struct platform_driver ci_hdrc_imx_driver = {
 	.probe = ci_hdrc_imx_probe,
 	.remove = ci_hdrc_imx_remove,
-- 
1.7.1
