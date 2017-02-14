From: cristian.birsan@microchip.com (cristian.birsan at microchip.com)
Date: Tue, 14 Feb 2017 18:09:05 +0200
Subject: [PATCH 3/4 linux-next] usb: gadget: udc: atmel: Use dev_warn() to
 display EP configuration error
In-Reply-To: <cover.1487007870.git.cristian.birsan@microchip.com>
References: <cover.1487007870.git.cristian.birsan@microchip.com>
Message-ID: <b8c5b8bf100457995bcea40f7b0de3d68993949e.1487007870.git.cristian.birsan@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Cristian Birsan <cristian.birsan@microchip.com>

Use dev_warn() to display EP configuration error to avoid silent failure.

Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 3becb28..50f018a 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -1851,7 +1851,7 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 		 * but it's clearly harmless...
 		 */
 		if (!(usba_ep_readl(ep0, CFG) & USBA_EPT_MAPPED))
-			dev_dbg(&udc->pdev->dev,
+			dev_warn(&udc->pdev->dev,
 				 "ODD: EP0 configuration is invalid!\n");
 
 		/* Preallocate other endpoints */
@@ -1860,8 +1860,8 @@ static irqreturn_t usba_udc_irq(int irq, void *devid)
 			ep = &udc->usba_ep[i];
 			usba_ep_writel(ep, CFG, ep->ept_cfg);
 			if (!(usba_ep_readl(ep, CFG) & USBA_EPT_MAPPED))
-				dev_dbg(&udc->pdev->dev,
-				 "ODD: EP%d configuration is invalid!\n", i);
+				dev_warn(&udc->pdev->dev,
+					 "ODD: EP%d configuration is invalid!\n", i);
 		}
 	}
 
-- 
2.7.4
