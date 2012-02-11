From: hs1218.kang@samsung.com (Huisung Kang)
Date: Sat, 11 Feb 2012 12:12:33 +0900
Subject: [PATCH] serial: samsung: disable irq before calling free_irq
Message-ID: <018301cce86a$ff609980$fe21cc80$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kisang Lee <kisang80.lee@samsung.com>

Pending UART irq may trigger spurious handling and may lead to
softlockup. This patch will fix following softlockup.

Signed-off-by: Kisang Lee <kisang80.lee@samsung.com>
Signed-off-by: Huisung Kang <hs1218.kang@samsung.com>
---
 drivers/tty/serial/samsung.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index c55e5fb..9067299 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -425,15 +425,19 @@ static void s3c24xx_serial_shutdown(struct uart_port *port)
 	struct s3c24xx_uart_port *ourport = to_ourport(port);
 
 	if (ourport->tx_claimed) {
-		if (!s3c24xx_serial_has_interrupt_mask(port))
+		if (!s3c24xx_serial_has_interrupt_mask(port)) {
+			disable_irq(ourport->tx_irq);
 			free_irq(ourport->tx_irq, ourport);
+		}
 		tx_enabled(port) = 0;
 		ourport->tx_claimed = 0;
 	}
 
 	if (ourport->rx_claimed) {
-		if (!s3c24xx_serial_has_interrupt_mask(port))
+		if (!s3c24xx_serial_has_interrupt_mask(port)) {
+			disable_irq(ourport->rx_irq);
 			free_irq(ourport->rx_irq, ourport);
+		}
 		ourport->rx_claimed = 0;
 		rx_enabled(port) = 0;
 	}
-- 
1.7.1
