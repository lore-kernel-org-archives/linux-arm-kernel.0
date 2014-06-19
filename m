From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Thu, 19 Jun 2014 11:38:19 +0100
Subject: [PATCH v4 09/13] serial: amba-pl011: Pass FIQ information to KGDB.
In-Reply-To: <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
References: <1401961994-18033-1-git-send-email-daniel.thompson@linaro.org>
 <1403174303-25456-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1403174303-25456-10-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the AMBA bus has provided the pl011 with a FIQ resource (i.e. a
second IRQ) then speculatively register it with KGDB when the polling
driver is initialized.

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
 drivers/tty/serial/amba-pl011.c | 99 ++++++++++++++++++++++++-----------------
 1 file changed, 58 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 908a6e3..00ba4b6 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -58,6 +58,7 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/sizes.h>
 #include <linux/io.h>
+#include <linux/kgdb.h>
 
 #define UART_NR			14
 
@@ -1416,8 +1417,63 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 	spin_unlock_irqrestore(&uap->port.lock, flags);
 }
 
+static int pl011_hwinit(struct uart_port *port)
+{
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
+	int retval;
+
+	/* Optionaly enable pins to be muxed in and configured */
+	pinctrl_pm_select_default_state(port->dev);
+
+	/*
+	 * Try to enable the clock producer.
+	 */
+	retval = clk_prepare_enable(uap->clk);
+	if (retval)
+		goto out;
+
+	uap->port.uartclk = clk_get_rate(uap->clk);
+
+	/* Clear pending error and receive interrupts */
+	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
+	       UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
+
+	/*
+	 * Save interrupts enable mask, and enable RX interrupts in case if
+	 * the interrupt is used for NMI entry.
+	 */
+	uap->im = readw(uap->port.membase + UART011_IMSC);
+	writew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
+
+	if (dev_get_platdata(uap->port.dev)) {
+		struct amba_pl011_data *plat;
+
+		plat = dev_get_platdata(uap->port.dev);
+		if (plat->init)
+			plat->init();
+	}
+	return 0;
+ out:
+	return retval;
+}
+
 #ifdef CONFIG_CONSOLE_POLL
 
+static int pl011_poll_init(struct uart_port *port)
+{
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
+	int retval;
+
+	retval = pl011_hwinit(port);
+
+#ifdef CONFIG_KGDB_FIQ
+	if (retval == 0)
+		kgdb_register_fiq(uap->port.irq);
+#endif
+
+	return retval;
+}
+
 static void pl011_quiesce_irqs(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
@@ -1471,46 +1527,6 @@ static void pl011_put_poll_char(struct uart_port *port,
 
 #endif /* CONFIG_CONSOLE_POLL */
 
-static int pl011_hwinit(struct uart_port *port)
-{
-	struct uart_amba_port *uap = (struct uart_amba_port *)port;
-	int retval;
-
-	/* Optionaly enable pins to be muxed in and configured */
-	pinctrl_pm_select_default_state(port->dev);
-
-	/*
-	 * Try to enable the clock producer.
-	 */
-	retval = clk_prepare_enable(uap->clk);
-	if (retval)
-		goto out;
-
-	uap->port.uartclk = clk_get_rate(uap->clk);
-
-	/* Clear pending error and receive interrupts */
-	writew(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS |
-	       UART011_RTIS | UART011_RXIS, uap->port.membase + UART011_ICR);
-
-	/*
-	 * Save interrupts enable mask, and enable RX interrupts in case if
-	 * the interrupt is used for NMI entry.
-	 */
-	uap->im = readw(uap->port.membase + UART011_IMSC);
-	writew(UART011_RTIM | UART011_RXIM, uap->port.membase + UART011_IMSC);
-
-	if (dev_get_platdata(uap->port.dev)) {
-		struct amba_pl011_data *plat;
-
-		plat = dev_get_platdata(uap->port.dev);
-		if (plat->init)
-			plat->init();
-	}
-	return 0;
- out:
-	return retval;
-}
-
 static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 {
 	writew(lcr_h, uap->port.membase + uap->lcrh_rx);
@@ -1890,7 +1906,7 @@ static struct uart_ops amba_pl011_pops = {
 	.config_port	= pl011_config_port,
 	.verify_port	= pl011_verify_port,
 #ifdef CONFIG_CONSOLE_POLL
-	.poll_init     = pl011_hwinit,
+	.poll_init     = pl011_poll_init,
 	.poll_get_char = pl011_get_poll_char,
 	.poll_put_char = pl011_put_poll_char,
 #endif
@@ -2198,6 +2214,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		uart_unregister_driver(&amba_reg);
 		pl011_dma_remove(uap);
 	}
+
  out:
 	return ret;
 }
-- 
1.9.3
