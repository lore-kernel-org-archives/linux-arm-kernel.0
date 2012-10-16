From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Oct 2012 11:59:45 +0100
Subject: [PATCH 06/11] SERIAL: omap: allow hardware assisted IXANY mode to be
 disabled
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Message-ID: <E1TO4sD-0000WI-4v@rmk-PC.arm.linux.org.uk>
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
index c55af63..7c313c2 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -698,6 +698,8 @@ serial_omap_configure_xonxoff
 	 */
 	if (termios->c_iflag & IXANY)
 		up->mcr |= UART_MCR_XONANY;
+	else
+		up->mcr &= ~UART_MCR_XONANY;
 
 	serial_out(up, UART_MCR, up->mcr | UART_MCR_TCRTLR);
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-- 
1.7.4.4
