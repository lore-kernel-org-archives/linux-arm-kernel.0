From: hector.palacios@digi.com (Hector Palacios)
Date: Fri, 29 Nov 2013 17:35:26 +0100
Subject: [PATCH 2/3] serial: mxs-auart: check BUSY flag on tx_empty hook
In-Reply-To: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
References: <1385742927-11358-1-git-send-email-hector.palacios@digi.com>
Message-ID: <1385742927-11358-3-git-send-email-hector.palacios@digi.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure AUART is not busy before returning tx empty.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/tty/serial/mxs-auart.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index d9bf6e103f65..e5540c89dd48 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -776,10 +776,13 @@ static void mxs_auart_shutdown(struct uart_port *u)
 
 static unsigned int mxs_auart_tx_empty(struct uart_port *u)
 {
-	if (readl(u->membase + AUART_STAT) & AUART_STAT_TXFE)
+	unsigned long stat;
+
+	stat = readl(u->membase + AUART_STAT);
+	if ((stat & (AUART_STAT_BUSY | AUART_STAT_TXFE)) == AUART_STAT_TXFE)
 		return TIOCSER_TEMT;
-	else
-		return 0;
+
+	return 0;
 }
 
 /*
