From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 16 Jun 2016 16:48:52 +0200
Subject: [PATCH] serial: mvebu-uart: free the IRQ in ->shutdown()
Message-ID: <1466088532-17093-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As suggested by the serial port infrastructure documentation, the IRQ is
requested in ->startup(). However, it is never freed in the ->shutdown()
hook.

With simple systems that open the serial port once for all and always
have at least one process that keep the serial port opened, there was no
problem. But with a more complicated system (*cough* systemd *cough*),
the serial port is opened/closed many times, which at some point no
processes having the serial port open at all. Due to this ->startup()
gets called again, tries to request_irq() again, which fails.

Fixes: 30530791a7a0 ("serial: mvebu-uart: initial support for Armada-3700 serial port")
Cc: <stable@vger.kernel.org>
Cc: Ofer Heifetz <oferh@marvell.com>
Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index ce362bd..45b57c2 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -300,6 +300,8 @@ static int mvebu_uart_startup(struct uart_port *port)
 static void mvebu_uart_shutdown(struct uart_port *port)
 {
 	writel(0, port->membase + UART_CTRL);
+
+	free_irq(port->irq, port);
 }
 
 static void mvebu_uart_set_termios(struct uart_port *port,
-- 
2.7.4
