From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Tue, 16 Oct 2012 12:00:26 +0100
Subject: [PATCH 08/11] SERIAL: omap: no need to re-read EFR
In-Reply-To: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
References: <20121016101458.GZ21164@n2100.arm.linux.org.uk>
Message-ID: <E1TO4ss-0000WR-0l@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to re-read EFR after we've recently written it; the
register is a configuration register which doesn't change its value
without us writing to it.  The last value which was written to this
register was up->efr.

Removing this re-reading avoids the possibility that we end up with
up->efr having unintended bits set, which should only be temporarily
set when accessing the enhanced features.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/omap-serial.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 71db4e6..c8a0425 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -873,8 +873,6 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_out(up, UART_OMAP_MDR1, up->mdr1);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
-
-	up->efr = serial_in(up, UART_EFR);
 	serial_out(up, UART_EFR, up->efr | UART_EFR_ECB);
 
 	serial_out(up, UART_LCR, 0);
-- 
1.7.4.4
