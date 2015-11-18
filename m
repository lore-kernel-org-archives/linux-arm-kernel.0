From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Wed, 18 Nov 2015 14:41:13 +0000
Subject: [PATCH 3/9] ARM: meson: serial: tx_empty fails to check for
 transmitter busy
In-Reply-To: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1447857679-30158-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1447857679-30158-4-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The tx_empty() uart_op should only return empty if both the transmit fifo
and the transmit state-machine are both idle. Add a test for the hardware's
XMIT_BUSY flag.

Note, this is possibly related to an issue where the port is being shutdown
with paritally transmitted characters in it.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
Reported-by: Edward Cragg <edward.cragg@codethink.co.uk>
---
 drivers/tty/serial/meson_uart.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/meson_uart.c b/drivers/tty/serial/meson_uart.c
index b87eb97..54d1b95 100644
--- a/drivers/tty/serial/meson_uart.c
+++ b/drivers/tty/serial/meson_uart.c
@@ -57,6 +57,7 @@
 #define AML_UART_RX_EMPTY		BIT(20)
 #define AML_UART_TX_FULL		BIT(21)
 #define AML_UART_TX_EMPTY		BIT(22)
+#define AML_UART_XMIT_BUSY		BIT(25)
 #define AML_UART_ERR			(AML_UART_PARITY_ERR | \
 					 AML_UART_FRAME_ERR  | \
 					 AML_UART_TX_FIFO_WERR)
@@ -100,7 +101,8 @@ static unsigned int meson_uart_tx_empty(struct uart_port *port)
 	u32 val;
 
 	val = readl(port->membase + AML_UART_STATUS);
-	return (val & AML_UART_TX_EMPTY) ? TIOCSER_TEMT : 0;
+	val &= (AML_UART_TX_EMPTY | AML_UART_XMIT_BUSY);
+	return (val == AML_UART_TX_EMPTY) ? TIOCSER_TEMT : 0;
 }
 
 static void meson_uart_stop_tx(struct uart_port *port)
-- 
2.6.2
