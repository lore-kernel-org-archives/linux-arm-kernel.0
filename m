From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  9 Feb 2011 13:44:28 +0100
Subject: [PATCH 2/2] usb: gadget: at91_udc: Fix error path
Message-ID: <1297255468-7044-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rahul Ruikar <rahul.ruikar@gmail.com>

In function at91udc_probe()
call put_device() when device_register() fails.

Signed-off-by: Rahul Ruikar <rahul.ruikar@gmail.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/usb/gadget/at91_udc.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index bdec36a..bb8ddf0 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1798,8 +1798,10 @@ static int __init at91udc_probe(struct platform_device *pdev)
 	}
 
 	retval = device_register(&udc->gadget.dev);
-	if (retval < 0)
+	if (retval < 0) {
+		put_device(&udc->gadget.dev);
 		goto fail0b;
+	}
 
 	/* don't do anything until we have both gadget driver and VBUS */
 	clk_enable(udc->iclk);
-- 
1.7.2.3
