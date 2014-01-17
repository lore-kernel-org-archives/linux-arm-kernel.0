From: mpa@pengutronix.de (Markus Pargmann)
Date: Fri, 17 Jan 2014 10:22:36 +0100
Subject: [PATCH v4 2/2] usb: musb: dsps, use devm_kzalloc
In-Reply-To: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
References: <1389950556-6453-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1389950556-6453-3-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace kzalloc by devm_kzalloc and remove the kfree() calls.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/usb/musb/musb_dsps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index d0a97d6..6cae0c8 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -668,7 +668,7 @@ static int dsps_probe(struct platform_device *pdev)
 	wrp = match->data;
 
 	/* allocate glue */
-	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
+	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
 		dev_err(&pdev->dev, "unable to allocate glue memory\n");
 		return -ENOMEM;
@@ -696,7 +696,6 @@ err3:
 	pm_runtime_put(&pdev->dev);
 err2:
 	pm_runtime_disable(&pdev->dev);
-	kfree(glue);
 	return ret;
 }
 
@@ -709,7 +708,6 @@ static int dsps_remove(struct platform_device *pdev)
 	/* disable usbss clocks */
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	kfree(glue);
 
 	debugfs_remove_recursive(glue->dbgfs_root);
 
-- 
1.8.5.2
