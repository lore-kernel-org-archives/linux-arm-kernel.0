From: b32955@freescale.com (Huang Shijie)
Date: Wed, 21 May 2014 09:09:47 +0800
Subject: [PATCH 2/2 v2] serial: imx: remove the redundant code
In-Reply-To: <1400633789-31979-2-git-send-email-b32955@freescale.com>
References: <1400633789-31979-2-git-send-email-b32955@freescale.com>
Message-ID: <1400634587-513-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the imx_startup(), we will reset the uart port which will reset all
the FIFOs, including the URXD.

So the code to clear the RX FIFO is redundant. Just remove it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
fix the typo.
---
 drivers/tty/serial/imx.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 64901d0..febf400 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1161,15 +1161,6 @@ static int imx_startup(struct uart_port *port)
 		temp |= UCR2_IRTS;
 	writel(temp, sport->port.membase + UCR2);
 
-	if (USE_IRDA(sport)) {
-		/* clear RX-FIFO */
-		int i = 64;
-		while ((--i > 0) &&
-			(readl(sport->port.membase + URXD0) & URXD_CHARRDY)) {
-			barrier();
-		}
-	}
-
 	if (!is_imx1_uart(sport)) {
 		temp = readl(sport->port.membase + UCR3);
 		temp |= IMX21_UCR3_RXDMUXSEL;
-- 
1.7.8
