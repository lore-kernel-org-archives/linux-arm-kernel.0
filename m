From: balbi@ti.com (Felipe Balbi)
Date: Thu,  6 Sep 2012 15:45:34 +0300
Subject: [PATCH v4 15/21] serial: omap: unlock the port lock
In-Reply-To: <1346935540-1792-1-git-send-email-balbi@ti.com>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
Message-ID: <1346935540-1792-16-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ruchika Kharwar <ruchika@ti.com>

This patch unlocks the port lock before calling a serial_core API
and re-acquires the port lock after calling it.
This patch fixes a system freeze issue seen when the serial_core
API uart_write_wakeup() eventually attempts to acquire the port lock
already acquired by omap serial interrupt handler.

Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
Signed-off-by: Ruchika Kharwar <ruchika@ti.com>
Signed-off-by: Pavan Savoy <pavan_savoy@ti.com>
Signed-off-by: Vijay Badawadagi <bvijay@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/tty/serial/omap-serial.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index d244163..9e4419c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -224,8 +224,11 @@ static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
 			break;
 	} while (--count > 0);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
+		spin_unlock(&up->port.lock);
 		uart_write_wakeup(&up->port);
+		spin_lock(&up->port.lock);
+	}
 
 	if (uart_circ_empty(xmit))
 		serial_omap_stop_tx(&up->port);
-- 
1.7.12.rc3
