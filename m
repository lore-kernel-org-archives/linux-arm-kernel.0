From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed,  9 Feb 2011 14:26:13 +0100
Subject: [PATCH] atmel_serial: enable PPS support
Message-ID: <1297257973-11173-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Viktar Palstsiuk <viktar.palstsiuk@promwad.com>

Enables PPS support in atmel serial driver to make PPS API working.

Signed-off-by: Viktar Palstsiuk <viktar.palstsiuk@promwad.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/tty/serial/atmel_serial.c |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 2a1d52f..4caf017 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1240,6 +1240,21 @@ static void atmel_set_termios(struct uart_port *port, struct ktermios *termios,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+static void atmel_set_ldisc(struct uart_port *port)
+{
+	int line = port->line;
+
+	if (line >= port->state->port.tty->driver->num)
+		return;
+
+	if (port->state->port.tty->ldisc->ops->num == N_PPS) {
+		port->flags |= UPF_HARDPPS_CD;
+		atmel_enable_ms(port);
+	} else {
+		port->flags &= ~UPF_HARDPPS_CD;
+	}
+}
+
 /*
  * Return string describing the specified port
  */
@@ -1380,6 +1395,7 @@ static struct uart_ops atmel_pops = {
 	.shutdown	= atmel_shutdown,
 	.flush_buffer	= atmel_flush_buffer,
 	.set_termios	= atmel_set_termios,
+	.set_ldisc	= atmel_set_ldisc,
 	.type		= atmel_type,
 	.release_port	= atmel_release_port,
 	.request_port	= atmel_request_port,
-- 
1.7.2.3
