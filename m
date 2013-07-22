From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 23 Jul 2013 01:49:23 +0200
Subject: [PATCH v2 6/8] usb: host: ohci-s3c2410 Use
 clk_prepare_enable/clk_disable_unprepare
In-Reply-To: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
References: <1374536965-3545-1-git-send-email-tomasz.figa@gmail.com>
Message-ID: <1374536965-3545-7-git-send-email-tomasz.figa@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies the ohci-s3c2410 driver to prepare and unprepare
clocks in addition to enabling and disabling, since it is required
by common clock framework.

Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/usb/host/ohci-s3c2410.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ohci-s3c2410.c b/drivers/usb/host/ohci-s3c2410.c
index e125770..db096bf 100644
--- a/drivers/usb/host/ohci-s3c2410.c
+++ b/drivers/usb/host/ohci-s3c2410.c
@@ -47,10 +47,10 @@ static void s3c2410_start_hc(struct platform_device *dev, struct usb_hcd *hcd)
 
 	dev_dbg(&dev->dev, "s3c2410_start_hc:\n");
 
-	clk_enable(usb_clk);
+	clk_prepare_enable(usb_clk);
 	mdelay(2);			/* let the bus clock stabilise */
 
-	clk_enable(clk);
+	clk_prepare_enable(clk);
 
 	if (info != NULL) {
 		info->hcd	= hcd;
@@ -75,8 +75,8 @@ static void s3c2410_stop_hc(struct platform_device *dev)
 			(info->enable_oc)(info, 0);
 	}
 
-	clk_disable(clk);
-	clk_disable(usb_clk);
+	clk_disable_unprepare(clk);
+	clk_disable_unprepare(usb_clk);
 }
 
 /* ohci_s3c2410_hub_status_data
-- 
1.8.3.2
