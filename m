From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 12 Mar 2014 17:30:08 +0100
Subject: [PATCH RESEND] usb: at91-udc: fix irq and iomem resource retrieval
In-Reply-To: <1390488102-8548-1-git-send-email-jjhiblot@traphandler.com>
References: <1390488102-8548-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1394641808-27919-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Jacques Hiblot <jjhiblot@traphandler.com>

When using dt resources retrieval (interrupts and reg properties) there is
no predefined order for these resources in the platform dev resource
table. Also don't expect the number of resource to be always 2.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Acked-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: stable <stable@vger.kernel.org> # 3.4
---
 drivers/usb/gadget/at91_udc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/usb/gadget/at91_udc.c b/drivers/usb/gadget/at91_udc.c
index cea8c20a1425..1926925a52a9 100644
--- a/drivers/usb/gadget/at91_udc.c
+++ b/drivers/usb/gadget/at91_udc.c
@@ -1709,16 +1709,6 @@ static int at91udc_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	if (pdev->num_resources != 2) {
-		DBG("invalid num_resources\n");
-		return -ENODEV;
-	}
-	if ((pdev->resource[0].flags != IORESOURCE_MEM)
-			|| (pdev->resource[1].flags != IORESOURCE_IRQ)) {
-		DBG("invalid resource type\n");
-		return -ENODEV;
-	}
-
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!res)
 		return -ENXIO;
-- 
1.8.2.2
