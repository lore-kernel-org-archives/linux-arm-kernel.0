From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 18 Sep 2018 16:25:06 -0700
Subject: [PATCH] usb: host: fotg2: Fix potential NULL dereference
Message-ID: <20180918232506.29857-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is code in the .remove() hook to handle the drvdata
being NULL, for good reasons: it is never set, so it will
always be NULL. As I moved code around, static checkers
start complaining.

Instead of this, make sure to always set it on successful
probe so we can always dereference it on the remove path.

Use the platform_device_[set|get]_drvdata() since this is
a platform device.

Fixes: ffa8a31b5b3b ("usb: host: fotg2: add silicon clock handling")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/usb/host/fotg210-hcd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/host/fotg210-hcd.c b/drivers/usb/host/fotg210-hcd.c
index 058ff82ea789..bbcc68179bfc 100644
--- a/drivers/usb/host/fotg210-hcd.c
+++ b/drivers/usb/host/fotg210-hcd.c
@@ -5636,6 +5636,7 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
 		goto failed_dis_clk;
 	}
 	device_wakeup_enable(hcd->self.controller);
+	platform_set_drvdata(pdev, hcd);
 
 	return retval;
 
@@ -5656,16 +5657,12 @@ static int fotg210_hcd_probe(struct platform_device *pdev)
  */
 static int fotg210_hcd_remove(struct platform_device *pdev)
 {
-	struct device *dev = &pdev->dev;
-	struct usb_hcd *hcd = dev_get_drvdata(dev);
+	struct usb_hcd *hcd = platform_get_drvdata(pdev);
 	struct fotg210_hcd *fotg210 = hcd_to_fotg210(hcd);
 
 	if (!IS_ERR(fotg210->pclk))
 		clk_disable_unprepare(fotg210->pclk);
 
-	if (!hcd)
-		return 0;
-
 	usb_remove_hcd(hcd);
 	usb_put_hcd(hcd);
 
-- 
2.17.1
