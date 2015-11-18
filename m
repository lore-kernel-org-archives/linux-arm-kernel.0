From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Nov 2015 14:41:19 +0000
Subject: [PATCH 9/9] ARM: meson: serial: check for tx-irq enabled in irq code
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1447857679-30158-10-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ensure that if the interrupt handler is entered then only try and do tx
work if the tx irq is enabled.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/meson_uart.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 6c36526..b12a37b 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -237,8 +237,10 @@ static irqreturn_t meson_uart_interrupt(int irq, void *dev_id)
 	if (!(readl(port->membase + AML_UART_STATUS) & AML_UART_RX_EMPTY))
 		meson_receive_chars(port);
 
-	if (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_FULL))
-		meson_uart_start_tx(port);
+	if (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_FULL)) {
+		if (readl(port->membase + AML_UART_CONTROL) & AML_UART_TX_INT_EN)
+			meson_uart_start_tx(port);
+	}
 
 	spin_unlock(&port->lock);
 
-- 
2.6.2
