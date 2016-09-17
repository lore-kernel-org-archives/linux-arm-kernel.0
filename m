From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 17 Sep 2016 14:14:38 +0800
Subject: [PATCH] tty: amba-pl011: uart_amba_port is not available with
 earlycon function
Message-ID: <1474092878-30034-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0e125a5facf8 ("tty: amba-pl011: define flag register bits for ZTE
device") changes earlycon function pl011_putc() to use a pointer to
uart_amba_port.  This causes a regression when earlycon is enabled,
because uart_amba_port is not available yet at earlycon time.  Let's
revert the change on pl011_putc() to fix the regression.

The earlycon support for ZTE device can probably be added later by
declaring a new earlycon setup function with a vendor specific
compatible.

Reported-by: Sudeep Holla <sudeep.holla@arm.com>
Fixes: 0e125a5facf8 ("tty: amba-pl011: define flag register bits for ZTE device")
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 0b78b04e895e..2d9ffab16ffe 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2330,16 +2330,13 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
-	struct uart_amba_port *uap =
-		container_of(port, struct uart_amba_port, port);
-
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		cpu_relax();
 	if (port->iotype == UPIO_MEM32)
 		writel(c, port->membase + UART01x_DR);
 	else
 		writeb(c, port->membase + UART01x_DR);
-	while (readl(port->membase + UART01x_FR) & uap->vendor->fr_busy)
+	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
 		cpu_relax();
 }
 
-- 
1.9.1
