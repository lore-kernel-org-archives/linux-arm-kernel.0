From: h.grohne@intenta.de (Helmut Grohne)
Date: Mon, 4 Jun 2018 12:22:05 +0200
Subject: [PATCH v3 1/3] serial: xuartps: fix typo in cdns_uart_startup
In-Reply-To: <cover.1528106392.git.h.grohne@intenta.de>
References: <cover.1528106392.git.h.grohne@intenta.de>
Message-ID: <5fbc35e1a4285e149cc0db3b1d989932260a8386.1528106392.git.h.grohne@intenta.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bit mask changes in commit 6e14f7c1f2c2 ("tty: xuartps: Improve
startup function") doesn't do what the commit message advertises. The
original behaviour was clearing the RX_DIS bit, but due to missing ~,
that bit is now the only bit kept.

Currently, the regression is harmless, because the previous write to the
control register sets it to TXRST | RXRST. Thus the RX_DIS bit is
previously cleared. The *RST bits are cleared by the hardware, so this
commit does not currently change behaviour, but makes future changes
less risky.

Link: https://www.spinics.net/lists/linux-serial/msg23157.html
Signed-off-by: Helmut Grohne <h.grohne@intenta.de>
Fixes: 6e14f7c1f2c2 ("tty: xuartps: Improve startup function")
Reviewed-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index bd72dd843338..e4b2d8102a04 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -829,7 +829,7 @@ static int cdns_uart_startup(struct uart_port *port)
 	 * the receiver.
 	 */
 	status = readl(port->membase + CDNS_UART_CR);
-	status &= CDNS_UART_CR_RX_DIS;
+	status &= ~CDNS_UART_CR_RX_DIS;
 	status |= CDNS_UART_CR_RX_EN;
 	writel(status, port->membase + CDNS_UART_CR);
 
-- 
2.11.0
