From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 26 Sep 2016 15:55:31 +0200
Subject: [PATCH] serial: imx: Fix DCD reading
Message-ID: <20160926135531.31888-1-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The USR2_DCDIN bit is tested for in register usr1. As the name
suggests the usr2 register should be used instead. This fixes
reading the Carrier detect status.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 0df2b1c..615c027 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -740,12 +740,13 @@ static unsigned int imx_get_hwmctrl(struct imx_port *sport)
 {
 	unsigned int tmp = TIOCM_DSR;
 	unsigned usr1 = readl(sport->port.membase + USR1);
+	unsigned usr2 = readl(sport->port.membase + USR2);
 
 	if (usr1 & USR1_RTSS)
 		tmp |= TIOCM_CTS;
 
 	/* in DCE mode DCDIN is always 0 */
-	if (!(usr1 & USR2_DCDIN))
+	if (!(usr2 & USR2_DCDIN))
 		tmp |= TIOCM_CAR;
 
 	if (sport->dte_mode)
-- 
2.9.3
