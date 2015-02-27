From: leilei.zhao@atmel.com (Leilei Zhao)
Date: Fri, 27 Feb 2015 16:07:15 +0800
Subject: [PATCH v2 2/5] tty/serial: at91: correct buffer size used in DMA
In-Reply-To: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
References: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
Message-ID: <1425024438-31355-3-git-send-email-leilei.zhao@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The buffer size set in DMA is inconsistent with its allocation.
So keep them consistent here. The structure atmel_uart_char is
used in PIO mode with its meaning. But here in DMA, all of the
buffer is treated as general char.

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index bac9e67..a99d89e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1030,7 +1030,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	BUG_ON(!PAGE_ALIGNED(ring->buf));
 	sg_set_page(&atmel_port->sg_rx,
 		    virt_to_page(ring->buf),
-		    ATMEL_SERIAL_RINGSIZE,
+		    sizeof(struct atmel_uart_char) * ATMEL_SERIAL_RINGSIZE,
 		    (int)ring->buf & ~PAGE_MASK);
 	nent = dma_map_sg(port->dev,
 			  &atmel_port->sg_rx,
-- 
1.7.9.5
