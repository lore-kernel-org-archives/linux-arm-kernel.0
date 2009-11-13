From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Fri, 13 Nov 2009 09:02:34 +0100
Subject: [PATCH] serial21285: fix disable_irq-from-interrupt-handler deadlock
Message-ID: <20091113090234.7d028820@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The console hangs during bootup when disable_irq is called from the
transmit interrupt handler (it will wait forever for it's "own"
interrupt in synchronize_irq). Fix by using disable_irq_nosync()
instead.

Signed-off-by: Simon Kagstrom <simon.kagstrom@netinsight.net>
---
Russell: This patch is a bit of RFC since I'm not quite sure that it's the correct
solution. It unbreaks booting on our footbridge-based platform. Let me
know if I should look at other solutions!

 drivers/serial/21285.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/serial/21285.c b/drivers/serial/21285.c
index 1e3d193..8681f13 100644
--- a/drivers/serial/21285.c
+++ b/drivers/serial/21285.c
@@ -58,7 +58,7 @@ static const char serial21285_name[] = "Footbridge UART";
 static void serial21285_stop_tx(struct uart_port *port)
 {
 	if (tx_enabled(port)) {
-		disable_irq(IRQ_CONTX);
+		disable_irq_nosync(IRQ_CONTX);
 		tx_enabled(port) = 0;
 	}
 }
@@ -74,7 +74,7 @@ static void serial21285_start_tx(struct uart_port *port)
 static void serial21285_stop_rx(struct uart_port *port)
 {
 	if (rx_enabled(port)) {
-		disable_irq(IRQ_CONRX);
+		disable_irq_nosync(IRQ_CONRX);
 		rx_enabled(port) = 0;
 	}
 }
-- 
1.6.0.4
