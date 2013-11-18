From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 18 Nov 2013 16:54:38 +0100
Subject: [RESEND PATCH v3 4/4] usb: musb: dsps, use devm_kzalloc
In-Reply-To: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
References: <1384790078-15366-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1384790078-15366-5-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/usb/musb/musb_dsps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 06debf8..058d611 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -596,7 +596,7 @@ static int dsps_probe(struct platform_device *pdev)
 	wrp = match->data;
 
 	/* allocate glue */
-	glue = kzalloc(sizeof(*glue), GFP_KERNEL);
+	glue = devm_kzalloc(&pdev->dev, sizeof(*glue), GFP_KERNEL);
 	if (!glue) {
 		dev_err(&pdev->dev, "unable to allocate glue memory\n");
 		return -ENOMEM;
@@ -624,7 +624,6 @@ err3:
 	pm_runtime_put(&pdev->dev);
 err2:
 	pm_runtime_disable(&pdev->dev);
-	kfree(glue);
 	return ret;
 }
 
@@ -637,7 +636,6 @@ static int dsps_remove(struct platform_device *pdev)
 	/* disable usbss clocks */
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	kfree(glue);
 
 	debugfs_remove_recursive(glue->dbgfs_root);
 
-- 
1.8.4.2
