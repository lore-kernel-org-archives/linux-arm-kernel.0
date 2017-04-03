From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Mon, 3 Apr 2017 10:19:53 +0300
Subject: [PATCH linux-next v3 3/4] usb: gadget: udc: atmel: Use dev_err() to
 display EP configuration error
In-Reply-To: <cover.1491201365.git.cristian.birsan@microchip.com>
References: <cover.1491201365.git.cristian.birsan@microchip.com>
Message-ID: <226692c3b986abe4ec4239472a4d57e32dfc5a71.1491201365.git.cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Use dev_err() to display EP configuration error to avoid silent failure.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 8bc0b52a..3ccc341 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1851,8 +1851,8 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 		 * but it's clearly harmless...
 		 */
 		if (!(usba_ep_readl(ep0, CFG) & USBA_EPT_MAPPED))
-			dev_dbg(&udc->pdev->dev,
-				 "ODD: EP0 configuration is invalid!\n");
+			dev_err(&udc->pdev->dev,
+				"ODD: EP0 configuration is invalid!\n");
 
 		/* Preallocate other endpoints */
 		n = fifo_mode ? udc->num_ep : udc->configured_ep;
@@ -1860,8 +1860,8 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 			ep = &udc->usba_ep[i];
 			usba_ep_writel(ep, CFG, ep->ept_cfg);
 			if (!(usba_ep_readl(ep, CFG) & USBA_EPT_MAPPED))
-				dev_dbg(&udc->pdev->dev,
-				 "ODD: EP%d configuration is invalid!\n", i);
+				dev_err(&udc->pdev->dev,
+					"ODD: EP%d configuration is invalid!\n", i);
 		}
 	}
 
-- 
2.7.4
