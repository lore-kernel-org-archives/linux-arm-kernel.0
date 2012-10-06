From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 06 Oct 2012 13:41:23 +0100
Subject: [RFC 07/24] SERIAL: omap: allow hardware assisted IXANY mode to be
 disabled
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Message-ID: <E1TKTh5-0002mn-37@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nothing was clearing the UART_MCR_XONANY bit, so once the ixany
mode gets set, there's no possibility to disable it.  Clear this
bit when IXANY mode is cleared.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index f2535fe..6314827 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -696,6 +696,8 @@ serial_omap_configure_xonxoff
 	 */
 	if (termios->c_iflag & IXANY)
 		up->mcr |= UART_MCR_XONANY;
+	else
+		up->mcr &= ~UART_MCR_XONANY;
 
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-- 
1.7.4.4
