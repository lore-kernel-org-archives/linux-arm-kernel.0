From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Mon, 28 Oct 2013 23:49:26 +0100
Subject: [PATCH 09/12] usb: gadget: r8a66597-udc: Convert to
 clk_prepare/unprepare
In-Reply-To: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383000569-8916-10-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
clk_disable_unprepare() to get ready for the migration to the common
clock framework.

Cc: Felipe Balbi <balbi@ti.com>
Cc: linux-usb at vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/usb/gadget/r8a66597-udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/r8a66597-udc.c b/drivers/usb/gadget/r8a66597-udc.c
index 68be48d..4728751 100644
--- a/drivers/usb/gadget/r8a66597-udc.c
+++ b/drivers/usb/gadget/r8a66597-udc.c
@@ -1833,7 +1833,7 @@ static int __exit r8a66597_remove(struct platform_device *pdev)
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 
 	if (r8a66597->pdata->on_chip) {
-		clk_disable(r8a66597->clk);
+		clk_disable_unprepare(r8a66597->clk);
 		clk_put(r8a66597->clk);
 	}
 
@@ -1931,7 +1931,7 @@ static int __init r8a66597_probe(struct platform_device *pdev)
 			ret = PTR_ERR(r8a66597->clk);
 			goto clean_up;
 		}
-		clk_enable(r8a66597->clk);
+		clk_prepare_enable(r8a66597->clk);
 	}
 
 	if (r8a66597->pdata->sudmac) {
@@ -1996,7 +1996,7 @@ clean_up3:
 	free_irq(irq, r8a66597);
 clean_up2:
 	if (r8a66597->pdata->on_chip) {
-		clk_disable(r8a66597->clk);
+		clk_disable_unprepare(r8a66597->clk);
 		clk_put(r8a66597->clk);
 	}
 clean_up:
-- 
1.8.1.5
