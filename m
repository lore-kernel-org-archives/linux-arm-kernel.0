From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Nov 2015 14:41:16 +0000
Subject: [PATCH 6/9] ARM: meson: serial: use meson_uart_tx_empty() to wait for
 empty
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1447857679-30158-7-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the meson_uart_tx_empty() instead of a direct read of the status
register. This is easier to read and will ensure the UART's transmit
state machine is idle when trying to update the baud rate.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/tty/serial/meson_uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index 9327efd..d3f2c96 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -285,7 +285,7 @@ static void meson_uart_change_speed(struct uart_port *port, unsigned long baud)
 {
 	u32 val;
 
-	while (!(readl(port->membase + AML_UART_STATUS) & AML_UART_TX_EMPTY))
+	while (!meson_uart_tx_empty(port))
 		cpu_relax();
 
 	val = readl(port->membase + AML_UART_REG5);
-- 
2.6.2
