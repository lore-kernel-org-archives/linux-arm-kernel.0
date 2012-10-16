From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Oct 2012 11:59:24 +0100
Subject: [PATCH 05/11] SERIAL: omap: allow hardware assisted rts/cts modes to
 be disabled
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Message-ID: <E1TO4rs-0000WD-Mx@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is nothing which clears the auto RTS/CTS bits, so once hardware
flow control gets enabled, there's no possibility to disable it.
So, clear these bits when CRTSCTS is cleared.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 6ede6fd..c55af63 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -921,6 +921,13 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
 		serial_out(up, UART_MCR, up->mcr | UART_MCR_RTS);
 		serial_out(up, UART_LCR, cval);
+	} else {
+		/* Disable AUTORTS and AUTOCTS */
+		up->efr &= ~(UART_EFR_CTS | UART_EFR_RTS);
+
+		serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
+		serial_out(up, UART_EFR, up->efr);
+		serial_out(up, UART_LCR, cval);
 	}
 
 	serial_omap_set_mctrl(&up->port, up->port.mctrl);
-- 
1.7.4.4
