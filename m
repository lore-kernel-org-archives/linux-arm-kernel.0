From: shijie8@gmail.com (Huang Shijie)
Date: Thu,  6 Sep 2012 22:38:40 -0400
Subject: [PATCH 1/2] serial: mxs-auart: fix the wrong setting order
Message-ID: <1346985521-2248-1-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After set the AUART_CTRL0_CLKGATE, the UART will gate all the clocks off.
So the following line will not take effect.
       ................................................................
 	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
 			u->membase + AUART_INTR_CLR);
       ................................................................

To fix this issue, the patch moves this gate-off line to
the end of setting registers.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 drivers/tty/serial/mxs-auart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index dafeef2..ea5f888 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -457,11 +457,11 @@ static void mxs_auart_shutdown(struct uart_port *u)
 
 	writel(AUART_CTRL2_UARTEN, u->membase + AUART_CTRL2_CLR);
 
-	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_SET);
-
 	writel(AUART_INTR_RXIEN | AUART_INTR_RTIEN | AUART_INTR_CTSMIEN,
 			u->membase + AUART_INTR_CLR);
 
+	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_SET);
+
 	clk_disable_unprepare(s->clk);
 }
 
-- 
1.7.4.4
