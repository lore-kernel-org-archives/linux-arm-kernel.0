From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Fri, 16 Jun 2017 13:30:18 +0200
Subject: [PATCH] usb: gadget: udc: atmel: Remove unnecessary macros
Message-ID: <20170616113018.32009-1-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 46ddd79e893b ("usb: gadget: udc: atmel: Remove AVR32 bits from the
driver") left the accessor macros introduced by commit a3dd3befd7cb ("usb:
gadget: atmel_usba: use endian agnostic IO on ARM"). They can now be
removed.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/usb/gadget/udc/atmel_usba_udc.c |  4 ++--
 drivers/usb/gadget/udc/atmel_usba_udc.h | 16 ++++++----------
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
index 3ccc34176a5a..98d71400f8a1 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.c
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
@@ -152,7 +152,7 @@ static int regs_dbg_open(struct inode *inode, struct file *file)
 
 	spin_lock_irq(&udc->lock);
 	for (i = 0; i < inode->i_size / 4; i++)
-		data[i] = usba_io_readl(udc->regs + i * 4);
+		data[i] = readl_relaxed(udc->regs + i * 4);
 	spin_unlock_irq(&udc->lock);
 
 	file->private_data = data;
@@ -1369,7 +1369,7 @@ static int handle_ep0_setup(struct usba_udc *udc, struct usba_ep *ep,
 		if (crq->wLength != cpu_to_le16(sizeof(status)))
 			goto stall;
 		ep->state = DATA_STAGE_IN;
-		usba_io_writew(status, ep->fifo);
+		writew_relaxed(status, ep->fifo);
 		usba_ep_writel(ep, SET_STA, USBA_TX_PK_RDY);
 		break;
 	}
diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
index 433bed0c481e..f8ebe0389bd4 100644
--- a/drivers/usb/gadget/udc/atmel_usba_udc.h
+++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
@@ -186,22 +186,18 @@
 	 | USBA_BF(name, value))
 
 /* Register access macros */
-#define usba_io_readl	readl_relaxed
-#define usba_io_writel	writel_relaxed
-#define usba_io_writew	writew_relaxed
-
 #define usba_readl(udc, reg)					\
-	usba_io_readl((udc)->regs + USBA_##reg)
+	readl_relaxed((udc)->regs + USBA_##reg)
 #define usba_writel(udc, reg, value)				\
-	usba_io_writel((value), (udc)->regs + USBA_##reg)
+	writel_relaxed((value), (udc)->regs + USBA_##reg)
 #define usba_ep_readl(ep, reg)					\
-	usba_io_readl((ep)->ep_regs + USBA_EPT_##reg)
+	readl_relaxed((ep)->ep_regs + USBA_EPT_##reg)
 #define usba_ep_writel(ep, reg, value)				\
-	usba_io_writel((value), (ep)->ep_regs + USBA_EPT_##reg)
+	writel_relaxed((value), (ep)->ep_regs + USBA_EPT_##reg)
 #define usba_dma_readl(ep, reg)					\
-	usba_io_readl((ep)->dma_regs + USBA_DMA_##reg)
+	readl_relaxed((ep)->dma_regs + USBA_DMA_##reg)
 #define usba_dma_writel(ep, reg, value)				\
-	usba_io_writel((value), (ep)->dma_regs + USBA_DMA_##reg)
+	writel_relaxed((value), (ep)->dma_regs + USBA_DMA_##reg)
 
 /* Calculate base address for a given endpoint or DMA controller */
 #define USBA_EPT_BASE(x)	(0x100 + (x) * 0x20)
-- 
2.11.0
