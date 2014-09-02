From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue,  2 Sep 2014 14:00:49 +0100
Subject: [PATCH v11 15/19] serial: amba-pl011: Pass FIQ information to KGDB.
In-Reply-To: <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
References: <1408466769-20004-1-git-send-email-daniel.thompson@linaro.org>
 <1409662853-29313-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1409662853-29313-16-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Speculatively register a FIQ resource with KGDB. KGDB will only
accept it if the kgdb/fiq feature is enabled (both with compile time and
runtime switches) and the interrupt controller supports FIQ.

By providing this information to KGDB the serial driver offers
"permission" for KGDB to route the UART interrupt signal from the
drivers own handler to KGDBs FIQ handler (which will eventually use the
UART's polled I/O callbacks to interact with the user). This permission
also implies the amba-pl011 driver has already unmasked RX interrupts
(otherwise the FIQ handler will never trigger).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial at vger.kernel.org
---
 drivers/tty/serial/amba-pl011.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 0b06dcf..63c67b0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -58,6 +58,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/sizes.h>
 #include <linux/io.h>
+#include <linux/kgdb.h>
 
 #define UART_NR			14
 
@@ -1466,6 +1467,18 @@ static int pl011_hwinit(struct uart_port *port)
 
 #ifdef CONFIG_CONSOLE_POLL
 
+static int pl011_poll_init(struct uart_port *port)
+{
+	int retval = pl011_hwinit(port);
+
+#ifdef CONFIG_KGDB_FIQ
+	if (retval == 0)
+		kgdb_register_fiq(port->irq);
+#endif
+
+	return retval;
+}
+
 static void pl011_quiesce_irqs(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -1905,7 +1918,7 @@ static struct uart_ops amba_pl011_pops = {
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
-	.poll_init     = pl011_hwinit,
+	.poll_init     = pl011_poll_init,
 	.poll_get_char = pl011_get_poll_char,
 	.poll_put_char = pl011_put_poll_char,
 #endif
-- 
1.9.3
