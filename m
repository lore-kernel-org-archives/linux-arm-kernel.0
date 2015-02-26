From: leilei.zhao@atmel.com (Leilei Zhao)
Date: Thu, 26 Feb 2015 14:55:21 +0800
Subject: [PATCH 1/5] tty/serial: at91: correct check of buf used in DMA
In-Reply-To: <1424933725-16242-1-git-send-email-leilei.zhao@atmel.com>
References: <1424933725-16242-1-git-send-email-leilei.zhao@atmel.com>
Message-ID: <1424933725-16242-2-git-send-email-leilei.zhao@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We only use buf of ring In DMA rx function while using buf of xmit
in DMA tx function. So here we need definitively to check the buf
of ring which is corresponding to DMA rx function.

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 846552b..460903c 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1027,7 +1027,7 @@ static int atmel_prepare_rx_dma(struct uart_port *port)
 	spin_lock_init(&atmel_port->lock_rx);
 	sg_init_table(&atmel_port->sg_rx, 1);
 	/* UART circular rx buffer is an aligned page. */
-	BUG_ON((int)port->state->xmit.buf & ~PAGE_MASK);
+	BUG_ON((int)ring->buf & ~PAGE_MASK);
 	sg_set_page(&atmel_port->sg_rx,
 		    virt_to_page(ring->buf),
 		    ATMEL_SERIAL_RINGSIZE,
-- 
1.7.9.5
