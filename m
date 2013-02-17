From: peter.chen@freescale.com (Peter Chen)
Date: Sun, 17 Feb 2013 17:24:43 +0800
Subject: [PATCH v9 9/9] usb: chipidea: imx: fix the error that using
 uninitialized pointer
In-Reply-To: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
References: <1361093083-22940-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1361093083-22940-10-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the core's probe fails, the platform layer may not get core's
private data, if the platform tries to use struct ci13xxx, it will
use uninitialized pointer. Besides, if the core's probe fails,
the platform layer should know it, and let its probe fail too.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/chipidea/ci13xxx_imx.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/chipidea/ci13xxx_imx.c b/drivers/usb/chipidea/ci13xxx_imx.c
index 5499cf8..8352679 100644
--- a/drivers/usb/chipidea/ci13xxx_imx.c
+++ b/drivers/usb/chipidea/ci13xxx_imx.c
@@ -227,8 +227,9 @@ static int ci13xxx_imx_probe(struct platform_device *pdev)
 	plat_ci = ci13xxx_add_device(&pdev->dev,
 				pdev->resource, pdev->num_resources,
 				pdata);
-	if (IS_ERR(plat_ci)) {
-		ret = PTR_ERR(plat_ci);
+	pdata = plat_ci->dev.platform_data;
+	ret = pdata->probe_retval;
+	if (ret) {
 		dev_err(&pdev->dev,
 			"Can't register ci_hdrc platform device, err=%d\n",
 			ret);
-- 
1.7.0.4
