From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 16 Nov 2015 17:40:15 +0000
Subject: [PATCH 03/12] tty: amba-pl011: add helper to detect split LCRH
 register
In-Reply-To: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
References: <20151116173935.GQ8644@n2100.arm.linux.org.uk>
Message-ID: <E1ZyNlH-0003jU-Lb@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a helper to detect the split LCRH register found on ST variants.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 0e7f045b8f4f..c9ae0a144f10 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1576,10 +1576,15 @@ static int pl011_hwinit(struct uart_port *port)
 	return 0;
 }
 
+static bool pl011_split_lcrh(const struct uart_amba_port *uap)
+{
+	return uap->lcrh_rx != uap->lcrh_tx;
+}
+
 static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 {
 	pl011_write(lcr_h, uap, uap->lcrh_rx);
-	if (uap->lcrh_rx != uap->lcrh_tx) {
+	if (pl011_split_lcrh(uap)) {
 		int i;
 		/*
 		 * Wait 10 PCLKs before writing LCRH_TX register,
@@ -1713,7 +1718,7 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
 	 * disable break condition and fifos
 	 */
 	pl011_shutdown_channel(uap, uap->lcrh_rx);
-	if (uap->lcrh_rx != uap->lcrh_tx)
+	if (pl011_split_lcrh(uap))
 		pl011_shutdown_channel(uap, uap->lcrh_tx);
 }
 
-- 
2.1.0
