From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 27 Mar 2012 12:22:49 +0400
Subject: [PATCH] ARM: clps711x: serial driver hungs are a result of call
 disable_irq within ISR
Message-ID: <1332836569-11726-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 2.6.30-rc1 clps711x serial driver hungs system. This is a result
of call disable_irq from ISR. synchronize_irq waits for end of interrupt
and goes to infinite loop. This patch fix this problem.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/tty/serial/clps711x.c |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index e6c3dbd..836fe273 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -154,10 +154,9 @@ static irqreturn_t clps711xuart_int_tx(int irq, void *dev_id)
 		port->x_char = 0;
 		return IRQ_HANDLED;
 	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		clps711xuart_stop_tx(port);
-		return IRQ_HANDLED;
-	}
+
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
+		goto disable_tx_irq;
 
 	count = port->fifosize >> 1;
 	do {
@@ -171,8 +170,11 @@ static irqreturn_t clps711xuart_int_tx(int irq, void *dev_id)
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
-	if (uart_circ_empty(xmit))
-		clps711xuart_stop_tx(port);
+	if (uart_circ_empty(xmit)) {
+	disable_tx_irq:
+		disable_irq_nosync(TX_IRQ(port));
+		tx_enabled(port) = 0;
+	}
 
 	return IRQ_HANDLED;
 }
-- 
1.7.3.4
