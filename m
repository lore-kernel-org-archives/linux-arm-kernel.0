From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 19 Jun 2014 11:38:20 +0100
Subject: [PATCH v4 10/13] serial: asc: Add support for KGDB's FIQ/NMI mode
In-Reply-To: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1403174303-25456-11-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a .poll_init() function that enables UART RX and registers the
UART's irq with KGDB. By providing this information to KGDB the serial
driver offers "permission" for KGDB to route the UART interrupt signal
from the drivers own handler to KGDBs FIQ handler (which will eventually
use the UART's polled I/O callbacks to interact with the user).

Note that the RX is not only enabled but also unmasked. This is required
because otherwise the FIQ handler could never trigger. This unmask is
copied from similar code in amba-pl011.c .

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: kernel at stlinux.com
Cc: linux-serial at vger.kernel.org
---
 drivers/tty/serial/st-asc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c7f61ac..4f376d8 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
 #include <linux/clk.h>
+#include <linux/kgdb.h>
 
 #define DRIVER_NAME "st-asc"
 #define ASC_SERIAL_NAME "ttyAS"
@@ -613,6 +614,25 @@ asc_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
+
+#ifdef CONFIG_KGDB_FIQ
+/*
+ * Prepare the UART to be used from kgdb's NMI support.
+ */
+static int asc_poll_init(struct uart_port *port)
+{
+	struct asc_port *ascport = container_of(port, struct asc_port, port);
+
+	/* register the FIQ with kgdb */
+	kgdb_register_fiq(ascport->port.irq);
+
+	/* enable RX interrupts in case the interrupt is used for NMI entry. */
+	asc_enable_rx_interrupts(port);
+
+	return 0;
+}
+#endif /* CONFIG_KGDB_FIQ */
+
 /*
  * Console polling routines for writing and reading from the uart while
  * in an interrupt or debug context (i.e. kgdb).
@@ -656,6 +676,9 @@ static struct uart_ops asc_uart_ops = {
 	.verify_port	= asc_verify_port,
 	.pm		= asc_pm,
 #ifdef CONFIG_CONSOLE_POLL
+#ifdef CONFIG_KGDB_FIQ
+	.poll_init     = asc_poll_init,
+#endif /* CONFIG_KGDB_FIQ */
 	.poll_get_char = asc_get_poll_char,
 	.poll_put_char = asc_put_poll_char,
 #endif /* CONFIG_CONSOLE_POLL */
-- 
1.9.3
