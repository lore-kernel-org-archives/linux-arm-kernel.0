From: eddie.huang@mediatek.com (Eddie Huang)
Date: Tue, 28 Apr 2015 21:40:32 +0800
Subject: [PATCH v3 1/3] tty: serial: 8250: export early_serial8250_setup
 function
In-Reply-To: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
References: <1430228434-31779-1-git-send-email-eddie.huang@mediatek.com>
Message-ID: <1430228434-31779-2-git-send-email-eddie.huang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

8250-like uart driver may call early_serial8250_setup to
reuse 8250_early.c character output function.

Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
---
 drivers/tty/serial/8250/8250_early.c | 2 +-
 include/linux/serial_8250.h          | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/8250/8250_early.c
index 6c0fd8b..771dda2 100644
--- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -131,7 +131,7 @@ static void __init init_port(struct earlycon_device *device)
 	serial8250_early_out(port, UART_LCR, c & ~UART_LCR_DLAB);
 }
 
-static int __init early_serial8250_setup(struct earlycon_device *device,
+int __init early_serial8250_setup(struct earlycon_device *device,
 					 const char *options)
 {
 	if (!(device->port.membase || device->port.iobase))
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 78097e7..f0c68d8 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -137,6 +137,8 @@ extern int early_serial_setup(struct uart_port *port);
 
 extern unsigned int serial8250_early_in(struct uart_port *port, int offset);
 extern void serial8250_early_out(struct uart_port *port, int offset, int value);
+extern int early_serial8250_setup(struct earlycon_device *device,
+					 const char *options);
 extern void serial8250_do_set_termios(struct uart_port *port,
 		struct ktermios *termios, struct ktermios *old);
 extern int serial8250_do_startup(struct uart_port *port);
-- 
1.8.1.1.dirty
