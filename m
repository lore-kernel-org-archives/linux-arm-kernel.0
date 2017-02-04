From: marex@denx.de (Marek Vasut)
Date: Sat,  4 Feb 2017 22:39:31 +0100
Subject: [PATCH] serial: imx: Only enable UART DMA on i.MX6Q and i.MX53
Message-ID: <20170204213931.3566-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kai Ruhnau <kai.ruhnau@target-sg.com>

In 1c06bde6 with the introduction of DMA support for the i.MX53 platform,
DMA was enabled for all platforms instead. On an i.MX6SX (which is a
IMX21_UART), this breaks gpsd talking to an UART module with

 imx-uart 21f4000.serial: DMA transaction error.

This patch makes sure, UART DMA is only activated for i.MX53 and i.MX6Q.

Signed-off-by: Kai Ruhnau <kai.ruhnau@target-sg.com>
Reviewed-by: Marek Vasut <marex@denx.de>
Fixes: 1c06bde643d0 ("Allowing UART DMA to be configured on i.MX53")
Cc: <stable@vger.kernel.org> # 4.9+
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Martyn Welch <martyn.welch@collabora.co.uk>
Cc: Shawn Guo <shawnguo@kernel.org>
---
 drivers/tty/serial/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a70356d..8e2b5f2 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1269,7 +1269,8 @@ static int imx_startup(struct uart_port *port)
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
 
 	/* Can we enable the DMA support? */
-	if (!uart_console(port) && !sport->dma_is_inited)
+	if ((is_imx6q_uart(sport)  || is_imx53_uart(sport)) &&
+	    !uart_console(port) && !sport->dma_is_inited)
 		imx_uart_dma_init(sport);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
-- 
2.10.2
