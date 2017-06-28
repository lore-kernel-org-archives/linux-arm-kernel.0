From: romain.perier@collabora.com (Romain Perier)
Date: Wed, 28 Jun 2017 15:59:36 +0200
Subject: [PATCH RESEND] serial: imx: Enable RTSD only when needed
Message-ID: <20170628135936.30537-1-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nandor Han <nandor.han@ge.com>

Currently, this IRQ is always enabled. Some devices might mux these pins
to other I/Os, like I2C. This could lead to spurious interrupts.

This commit makes this IRQ optional, by using the field have_rtscts.

Signed-off-by: Nandor Han <nandor.han@ge.com>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 drivers/tty/serial/imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7327477..5437b34 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1302,7 +1302,9 @@ static int imx_startup(struct uart_port *port)
 		imx_enable_dma(sport);
 
 	temp = readl(sport->port.membase + UCR1);
-	temp |= UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN;
+	temp |= UCR1_RRDYEN | UCR1_UARTEN;
+	if (sport->have_rtscts)
+			temp |= UCR1_RTSDEN;
 
 	writel(temp, sport->port.membase + UCR1);
 
-- 
1.8.3.1
