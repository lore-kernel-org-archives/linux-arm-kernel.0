From: frans.klaver@xsens.com (Frans Klaver)
Date: Mon, 15 Sep 2014 16:00:08 +0200
Subject: [PATCH 2/4] tty: omap-serial: prevent division by zero
In-Reply-To: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com>
References: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com>
Message-ID: <1410789610-23059-3-git-send-email-frans.klaver@xsens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the chosen baud rate is large enough (e.g. 3.5 megabaud), the
calculated n values in calculate_baud_abs_diff may become 0. This causes
a division by zero when calculating the difference between calculated
and desired baud rates. To prevent this, cap n on 1.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 drivers/tty/serial/omap-serial.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ae935ce..7d3f557 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -246,8 +246,12 @@ static inline int calculate_baud_abs_diff(struct uart_port *port,
 				unsigned int baud, unsigned int mode)
 {
 	unsigned int n = port->uartclk / (mode * baud);
-	int abs_diff = baud - (port->uartclk / (mode * n));
+	int abs_diff;
 
+	if (n == 0)
+		n = 1;
+
+	abs_diff = baud - (port->uartclk / (mode * n));
 	if (abs_diff < 0)
 		abs_diff = -abs_diff;
 
-- 
2.1.0
