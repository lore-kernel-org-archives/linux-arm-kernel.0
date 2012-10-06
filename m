From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sat, 06 Oct 2012 13:43:25 +0100
Subject: [RFC 13/24] SERIAL: omap: configure xon/xoff before setting modem
 control lines
In-Reply-To: <20121006123803.GD15246@n2100.arm.linux.org.uk>
References: <20121006123803.GD15246@n2100.arm.linux.org.uk>
Message-ID: <E1TKTj3-0002nG-9h@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index ab5a5e0..cc1a907 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -956,10 +956,11 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_out(up, UART_LCR, cval);
 	}
 
-	serial_omap_set_mctrl(&up->port, up->port.mctrl);
 	/* Software Flow Control Configuration */
 	serial_omap_configure_xonxoff(up, termios);
 
+	serial_omap_set_mctrl(&up->port, up->port.mctrl);
+
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	pm_runtime_put(&up->pdev->dev);
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->port.line);
-- 
1.7.4.4
