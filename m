From: eddie.huang@mediatek.com (Eddie Huang)
Date: Wed, 22 Oct 2014 21:12:07 +0800
Subject: [PATCH 1/3] tty: serial: Fix mediatek UART driver setting baudrate
 issue
In-Reply-To: <1413983529-21887-1-git-send-email-eddie.huang@mediatek.com>
References: <1413983529-21887-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1413983529-21887-2-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In mtk8250_set_termios function, calculating quot value can not be zero,
otherwise, using DIV_ROUND_CLOSEST(port->uartclk, quot * baud) will fail due to
divisor is zero.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/tty/serial/8250/8250_mtk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_mtk.c b/drivers/tty/serial/8250/8250_mtk.c
index 8f37d57..6f93123 100644
--- a/drivers/tty/serial/8250/8250_mtk.c
+++ b/drivers/tty/serial/8250/8250_mtk.c
@@ -74,14 +74,14 @@ mtk8250_set_termios(struct uart_port *port, struct ktermios *termios,
 		/* Set to next lower baudrate supported */
 		if ((baud == 500000) || (baud == 576000))
 			baud = 460800;
-		quot = DIV_ROUND_CLOSEST(port->uartclk, 4 * baud);
+		quot = DIV_ROUND_UP(port->uartclk, 4 * baud);
 	} else {
 		serial_port_out(port, UART_MTK_HIGHS, 0x3);
 
 		/* Set to highest baudrate supported */
 		if (baud >= 1152000)
 			baud = 921600;
-		quot = DIV_ROUND_CLOSEST(port->uartclk, 256 * baud);
+		quot = DIV_ROUND_UP(port->uartclk, 256 * baud);
 	}
 
 	/*
-- 
1.8.1.1.dirty
