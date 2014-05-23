From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Fri, 23 May 2014 14:57:58 +0100
Subject: [RFC v2 10/10] serial: asc: Add support for KGDB's FIQ/NMI mode
In-Reply-To: <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
References: <1400083125-1464-1-git-send-email-daniel.thompson@linaro.org>
 <1400853478-5824-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1400853478-5824-11-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the platform bus has provided the st-asc with a FIQ resource (i.e. a
second IRQ) then speculatively register it with KGDB when the polling
driver is initialized.

By providing this information to KGDB the serial driver offers
"permission" for KGDB to route the UART interrupt signal from the
drivers own handler to KGDBs FIQ handler (which will eventually use the
UART's polled I/O callbacks to interact with the user). This permission
also implies the st-asc driver has already unmasked RX interrupts
(otherwise the FIQ handler will never trigger). This unmask is copied
from similar code in amba-pl011.c .

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@gmail.com>
Cc: Maxime Coquelin <maxime.coquelin@st.com>
Cc: Patrice Chotard <patrice.chotard@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: kernel at stlinux.com
Cc: linux-serial at vger.kernel.org
---
 drivers/tty/serial/st-asc.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index c7f61ac..328720f 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -30,6 +30,7 @@
 #include <linux/of_platform.h>
 #include <linux/serial_core.h>
 #include <linux/clk.h>
+#include <linux/kgdb.h>
 
 #define DRIVER_NAME "st-asc"
 #define ASC_SERIAL_NAME "ttyAS"
@@ -39,6 +40,7 @@
 struct asc_port {
 	struct uart_port port;
 	struct clk *clk;
+	int fiq;
 	unsigned int hw_flow_control:1;
 	unsigned int force_m1:1;
 };
@@ -613,6 +615,26 @@ asc_verify_port(struct uart_port *port, struct serial_struct *ser)
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
+	if (ascport->fiq >= 0)
+		kgdb_register_fiq(ascport->fiq);
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
@@ -656,11 +678,15 @@ static struct uart_ops asc_uart_ops = {
 	.verify_port	= asc_verify_port,
 	.pm		= asc_pm,
 #ifdef CONFIG_CONSOLE_POLL
+#ifdef CONFIG_KGDB_FIQ
+	.poll_init     = asc_poll_init,
+#endif /* CONFIG_KGDB_FIQ */
 	.poll_get_char = asc_get_poll_char,
 	.poll_put_char = asc_put_poll_char,
 #endif /* CONFIG_CONSOLE_POLL */
 };
 
+
 static int asc_init_port(struct asc_port *ascport,
 			  struct platform_device *pdev)
 {
@@ -673,6 +699,7 @@ static int asc_init_port(struct asc_port *ascport,
 	port->fifosize	= ASC_FIFO_SIZE;
 	port->dev	= &pdev->dev;
 	port->irq	= platform_get_irq(pdev, 0);
+	ascport->fiq    = platform_get_irq(pdev, 1);
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	port->membase = devm_ioremap_resource(&pdev->dev, res);
-- 
1.9.0
