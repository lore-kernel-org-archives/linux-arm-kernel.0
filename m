From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 21:59:23 +0100
Subject: [PATCH] serial/omap: mark wait_for_xmitr as __maybe_unused
Message-ID: <4282250.XA5neaP6kR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The wait_for_xmitr() function is only used if CONFIG_CONSOLE_POLL
or CONFIG_SERIAL_OMAP_CONSOLE are set, but when both are disabled,
the compiler warns about it being unused:

drivers/tty/serial/omap-serial.c:1168:13: warning: 'wait_for_xmitr' defined but not used [-Wunused-func

We could add more #ifdefs to work around it, but adding __maybe_unused
seems nicer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 2172076d2399 ("serial/omap-serial: Deinline wait_for_xmitr, save 165 bytes")

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index b645f9228ed7..1434c7febc99 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1165,7 +1165,7 @@ serial_omap_type(struct uart_port *port)
 
 #define BOTH_EMPTY (UART_LSR_TEMT | UART_LSR_THRE)
 
-static void wait_for_xmitr(struct uart_omap_port *up)
+static void __maybe_unused wait_for_xmitr(struct uart_omap_port *up)
 {
 	unsigned int status, tmout = 10000;
 
