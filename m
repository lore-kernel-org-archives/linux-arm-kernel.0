From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:13:29 +0300
Subject: [PATCH] usb: gadget: s3c2410: Move to
 clk_prepare_enable/clk_disable_unprepare
Message-ID: <1404155609-3103-1-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use clk_prepare_enable/clk_disable_unprepare to make the driver
work properly with common clock framework.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/usb/gadget/s3c2410_udc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/s3c2410_udc.c b/drivers/usb/gadget/s3c2410_udc.c
index 7987aa0..357b58e 100644
--- a/drivers/usb/gadget/s3c2410_udc.c
+++ b/drivers/usb/gadget/s3c2410_udc.c
@@ -1788,7 +1788,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 		return PTR_ERR(usb_bus_clock);
 	}
 
-	clk_enable(usb_bus_clock);
+	clk_prepare_enable(usb_bus_clock);
 
 	udc_clock = clk_get(NULL, "usb-device");
 	if (IS_ERR(udc_clock)) {
@@ -1796,7 +1796,7 @@ static int s3c2410_udc_probe(struct platform_device *pdev)
 		return PTR_ERR(udc_clock);
 	}
 
-	clk_enable(udc_clock);
+	clk_prepare_enable(udc_clock);
 
 	mdelay(10);
 
@@ -1952,13 +1952,13 @@ static int s3c2410_udc_remove(struct platform_device *pdev)
 	release_mem_region(rsrc_start, rsrc_len);
 
 	if (!IS_ERR(udc_clock) && udc_clock != NULL) {
-		clk_disable(udc_clock);
+		clk_disable_unprepare(udc_clock);
 		clk_put(udc_clock);
 		udc_clock = NULL;
 	}
 
 	if (!IS_ERR(usb_bus_clock) && usb_bus_clock != NULL) {
-		clk_disable(usb_bus_clock);
+		clk_disable_unprepare(usb_bus_clock);
 		clk_put(usb_bus_clock);
 		usb_bus_clock = NULL;
 	}
-- 
2.0.0
