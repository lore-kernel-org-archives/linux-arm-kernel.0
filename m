From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Mon, 15 Dec 2014 17:15:52 +0100
Subject: [PATCH 5/5] tty: serial: atmel: request IRQ with IRQF_SUSPEND_NOACTION
In-Reply-To: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1418660152-17185-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1418660152-17185-6-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The IRQ line connected to the DBGU UART is often shared with a timer device
which request the IRQ with IRQF_NO_SUSPEND.
Since the UART driver is correctly disabling IRQs when entering suspend
we can safely request the IRQ with IRQF_SUSPEND_NOACTION so that irq core
can suspend this specific handler.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 drivers/tty/serial/atmel_serial.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 4d848a2..0c252ff 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1725,7 +1725,8 @@ static int atmel_startup(struct uart_port *port)
 	/*
 	 * Allocate the IRQ
 	 */
-	retval = request_irq(port->irq, atmel_interrupt, IRQF_SHARED,
+	retval = request_irq(port->irq, atmel_interrupt,
+			IRQF_SHARED | IRQF_SUSPEND_NOACTION,
 			tty ? tty->name : "atmel_serial", port);
 	if (retval) {
 		dev_err(port->dev, "atmel_startup - Can't get irq\n");
-- 
1.9.1
