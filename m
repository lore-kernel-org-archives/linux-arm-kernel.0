From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 4 Nov 2015 23:21:15 -0800
Subject: [PATCH v2 06/10] tty: xuartps: Keep lock for whole ISR
In-Reply-To: <1446708079-1105-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1446708079-1105-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1446708079-1105-7-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RX path in the interrupt handler released a lock unnecessarily.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 167e0f4bcf7a..5efd1b9d220f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -265,9 +265,7 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 			uart_insert_char(port, isrstatus, CDNS_UART_IXR_OVERRUN,
 					data, status);
 		}
-		spin_unlock(&port->lock);
 		tty_flip_buffer_push(&port->state->port);
-		spin_lock(&port->lock);
 	}
 
 	/* Dispatch an appropriate handler */
-- 
2.6.2.3.ga463a5b
