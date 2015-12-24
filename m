From: timur@codeaurora.org (Timur Tabi)
Date: Thu, 24 Dec 2015 09:49:48 -0600
Subject: [PATCH 1/2] tty: amba-pl011: fix earlycon register offsets
Message-ID: <1450972189-22639-1-git-send-email-timur@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The REG_x macros are indices into a table, not register offsets.  Since
earlycon does not have access to the vendor data, we can currently only
support standard ARM PL011 devices.

Signed-off-by: Timur Tabi <timur@codeaurora.org>
---
 drivers/tty/serial/amba-pl011.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index f6ad383..06f827a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2302,10 +2302,10 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
-	while (readl(port->membase + REG_FR) & UART01x_FR_TXFF)
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		;
-	writeb(c, port->membase + REG_DR);
-	while (readl(port->membase + REG_FR) & UART01x_FR_BUSY)
+	writeb(c, port->membase + UART01x_DR);
+	while (readl(port->membase + UART01x_FR) & UART011_FR_BUSY)
 		;
 }
 
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
