From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 30 May 2013 15:47:04 +0200
Subject: [PATCH] serial/imx: disable hardware flow control at startup
Message-ID: <1369921624-5595-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lucas Stach <l.stach@pengutronix.de>

We only want to enable hardware flow control if RTS/CTS pins
are connected.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---

 drivers/tty/serial/imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 147c9e1..8cdfbd3 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -761,6 +761,8 @@ static int imx_startup(struct uart_port *port)
 
 	temp = readl(sport->port.membase + UCR2);
 	temp |= (UCR2_RXEN | UCR2_TXEN);
+	if (!sport->have_rtscts)
+		temp |= UCR2_IRTS;
 	writel(temp, sport->port.membase + UCR2);
 
 	if (USE_IRDA(sport)) {
-- 
1.8.2.1
