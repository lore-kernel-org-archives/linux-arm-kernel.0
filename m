From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 14 May 2014 16:58:43 +0100
Subject: [RFC 6/8] serial: asc: Add support for KGDB's FIQ/NMI mode
In-Reply-To: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1400083125-1464-7-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For a serial driver to support FIQ/NMI debugging it must enable the RX
interrupt when a polling client attaches itself (otherwise the FIQ signal
will never be asserted). This concept is copied from similar code in
amba-pl011.c .

It must also register the appropriate FIQ number with kgdb. kgdb will use
this to make calls to enable_fiq/disable_fiq/eoi_fiq. The FIQ number must
be supplied via the devices bus (in this case platform bus).

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 drivers/tty/serial/st-asc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c7f61ac..e93803f 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
 #include <linux/clk.h>
+#include <linux/kgdb.h>
 
 #define DRIVER_NAME "st-asc"
 #define ASC_SERIAL_NAME "ttyAS"
@@ -613,6 +614,14 @@ asc_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
+static int asc_poll_init(struct uart_port *port)
+{
+	/* enable RX interrupts in case the interrupt is used for NMI entry. */
+	asc_enable_rx_interrupts(port);
+
+	return 0;
+}
+
 /*
  * Console polling routines for writing and reading from the uart while
  * in an interrupt or debug context (i.e. kgdb).
@@ -656,11 +665,25 @@ static struct uart_ops asc_uart_ops = {
 	.verify_port	= asc_verify_port,
 	.pm		= asc_pm,
 #ifdef CONFIG_CONSOLE_POLL
+	.poll_init     = asc_poll_init,
 	.poll_get_char = asc_get_poll_char,
 	.poll_put_char = asc_put_poll_char,
 #endif /* CONFIG_CONSOLE_POLL */
 };
 
+#ifdef CONFIG_KGDB_FIQ
+/* Register with KGDB if there is a FIQ linked to this device */
+static void asc_register_fiq(struct platform_device *pdev)
+{
+	int fiq = platform_get_irq(pdev, 1);
+	if (fiq >= 0)
+		kgdb_register_fiq(fiq);
+}
+#else
+static void asc_register_fiq(struct platform_device *pdev) {}
+#endif
+
+
 static int asc_init_port(struct asc_port *ascport,
 			  struct platform_device *pdev)
 {
@@ -692,6 +715,8 @@ static int asc_init_port(struct asc_port *ascport,
 	WARN_ON(ascport->port.uartclk == 0);
 	clk_disable_unprepare(ascport->clk);
 
+	asc_register_fiq(pdev);
+
 	return 0;
 }
 
-- 
1.9.0
