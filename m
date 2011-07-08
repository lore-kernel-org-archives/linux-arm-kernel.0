From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  8 Jul 2011 18:20:21 +0800
Subject: [PATCH] tty: serial: support device tree in pxa
In-Reply-To: <1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
References: <1310120428-22700-1-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-2-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-3-git-send-email-haojian.zhuang@marvell.com>
	<1310120428-22700-4-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1310120428-22700-5-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Support both normal platform driver and device tree driver in serial pxa.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 drivers/tty/serial/Kconfig     |    4 +-
 drivers/tty/serial/of_serial.c |   12 +++++
 drivers/tty/serial/pxa.c       |   91 ++++++++++++++++++++++++++++++++++------
 include/linux/serial_pxa.h     |   17 +++++++
 4 files changed, 110 insertions(+), 14 deletions(-)
 create mode 100644 include/linux/serial_pxa.h

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 636144c..3f75e0d 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -663,6 +663,8 @@ config SERIAL_MPSC_CONSOLE
 config SERIAL_PXA
 	bool "PXA serial port support"
 	depends on ARCH_PXA || ARCH_MMP
+	select SERIAL_OF_PLATFORM
+	select SERIAL_CORE_CONSOLE
 	select SERIAL_CORE
 	help
 	  If you have a machine based on an Intel XScale PXA2xx CPU you
@@ -1340,7 +1342,7 @@ config SERIAL_NETX_CONSOLE
 config SERIAL_OF_PLATFORM
 	tristate "Serial port on Open Firmware platform bus"
 	depends on OF
-	depends on SERIAL_8250 || SERIAL_OF_PLATFORM_NWPSERIAL
+	depends on SERIAL_8250 || SERIAL_OF_PLATFORM_NWPSERIAL || SERIAL_PXA
 	help
 	  If you have a PowerPC based system that has serial ports
 	  on a platform specific bus, you should enable this option.
diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index e65f1e8..383bff3 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/serial_core.h>
 #include <linux/serial_8250.h>
+#include <linux/serial_pxa.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
@@ -126,6 +127,11 @@ static int __devinit of_platform_serial_probe(struct platform_device *ofdev)
 		ret = nwpserial_register_port(&port);
 		break;
 #endif
+#ifdef CONFIG_SERIAL_PXA
+	case PORT_PXA:
+		ret = serial_pxa_register_port(&port);
+		break;
+#endif
 	default:
 		/* need to add code for these */
 	case PORT_UNKNOWN:
@@ -163,6 +169,11 @@ static int of_platform_serial_remove(struct platform_device *ofdev)
 		nwpserial_unregister_port(info->line);
 		break;
 #endif
+#ifdef CONFIG_SERIAL_PXA
+	case PORT_PXA:
+		serial_pxa_unregister_port(info->line);
+		break;
+#endif
 	default:
 		/* need to add code for these */
 		break;
@@ -186,6 +197,7 @@ static struct of_device_id __devinitdata of_platform_serial_table[] = {
 	{ .compatible = "ibm,qpace-nwp-serial",
 		.data = (void *)PORT_NWPSERIAL, },
 #endif
+	{ .compatible = "pxa,serial", .data = (void *)PORT_PXA, },
 	{ .type = "serial",         .data = (void *)PORT_UNKNOWN, },
 	{ /* end of list */ },
 };
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 4302e6e..fb80fb3 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -36,10 +36,12 @@
 #include <linux/circ_buf.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/serial_core.h>
+#include <linux/serial_pxa.h>
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/slab.h>
@@ -51,9 +53,14 @@ struct uart_pxa_port {
 	unsigned char           mcr;
 	unsigned int            lsr_break_flag;
 	struct clk		*clk;
-	char			*name;
+	char			name[32];
+	int			id;
 };
 
+#define PXA_SERIAL_NR		4
+
+static DEFINE_MUTEX(serial_pxa_mutex);
+
 static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
 {
 	offset <<= 2;
@@ -346,8 +353,6 @@ static int serial_pxa_startup(struct uart_port *port)
 	else
 		up->mcr = 0;
 
-	up->port.uartclk = clk_get_rate(up->clk);
-
 	/*
 	 * Allocate the IRQ
 	 */
@@ -593,7 +598,7 @@ serial_pxa_type(struct uart_port *port)
 	return up->name;
 }
 
-static struct uart_pxa_port *serial_pxa_ports[4];
+static struct uart_pxa_port serial_pxa_ports[PXA_SERIAL_NR];
 static struct uart_driver serial_pxa_reg;
 
 #ifdef CONFIG_SERIAL_PXA_CONSOLE
@@ -645,7 +650,7 @@ static void serial_pxa_console_putchar(struct uart_port *port, int ch)
 static void
 serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 {
-	struct uart_pxa_port *up = serial_pxa_ports[co->index];
+	struct uart_pxa_port *up = &serial_pxa_ports[co->index];
 	unsigned int ier;
 
 	clk_enable(up->clk);
@@ -679,7 +684,7 @@ serial_pxa_console_setup(struct console *co, char *options)
 
 	if (co->index == -1 || co->index >= serial_pxa_reg.nr)
 		co->index = 0;
-	up = serial_pxa_ports[co->index];
+	up = &serial_pxa_ports[co->index];
 	if (!up)
 		return -ENODEV;
 
@@ -761,6 +766,68 @@ static const struct dev_pm_ops serial_pxa_pm_ops = {
 };
 #endif
 
+static int serial_pxa_port_size(struct uart_pxa_port *sport)
+{
+	return 8 << sport->port.regshift;
+}
+
+int serial_pxa_register_port(struct uart_port *port)
+{
+	struct uart_pxa_port *sport = NULL;
+	char name[32];
+	int i, ret;
+
+	mutex_lock(&serial_pxa_mutex);
+	for (i = 0; i < PXA_SERIAL_NR; i++) {
+		if (serial_pxa_ports[i].id == 0) {
+			sport = &serial_pxa_ports[i];
+			sprintf(sport->name, "UART%d", i);
+			sport->id = i + 1;
+			break;
+		}
+	}
+	sprintf(name, "pxa2xx-uart.%d", i);
+	sport->clk = clk_get_sys(name, NULL);
+	if (IS_ERR(sport->clk)) {
+		ret = PTR_ERR(sport->clk);
+		goto out;
+	}
+	memcpy(&sport->port, port, sizeof(struct uart_port));
+	sport->port.line = i;
+	sport->port.fifosize = 64;
+	sport->port.ops = &serial_pxa_pops;
+
+	sport->port.membase = ioremap(sport->port.mapbase,
+				serial_pxa_port_size(sport));
+	if (!sport->port.membase) {
+		ret = -ENOMEM;
+		goto out_membase;
+	}
+
+	uart_add_one_port(&serial_pxa_reg, &sport->port);
+	mutex_unlock(&serial_pxa_mutex);
+
+	return sport->port.line;
+
+out_membase:
+	clk_put(sport->clk);
+out:
+	mutex_unlock(&serial_pxa_mutex);
+	return ret;
+}
+EXPORT_SYMBOL(serial_pxa_register_port);
+
+void serial_pxa_unregister_port(int line)
+{
+	struct uart_pxa_port *sport = &serial_pxa_ports[line];
+
+	mutex_lock(&serial_pxa_mutex);
+	uart_remove_one_port(&serial_pxa_reg, &sport->port);
+	sport->port.type = PORT_UNKNOWN;
+	clk_put(sport->clk);
+	mutex_unlock(&serial_pxa_mutex);
+}
+
 static int serial_pxa_probe(struct platform_device *dev)
 {
 	struct uart_pxa_port *sport;
@@ -794,12 +861,12 @@ static int serial_pxa_probe(struct platform_device *dev)
 	sport->port.uartclk = clk_get_rate(sport->clk);
 
 	switch (dev->id) {
-	case 0: sport->name = "FFUART"; break;
-	case 1: sport->name = "BTUART"; break;
-	case 2: sport->name = "STUART"; break;
-	case 3: sport->name = "HWUART"; break;
+	case 0: strcpy(sport->name, "FFUART"); break;
+	case 1: strcpy(sport->name, "BTUART"); break;
+	case 2: strcpy(sport->name, "STUART"); break;
+	case 3: strcpy(sport->name, "HWUART"); break;
 	default:
-		sport->name = "???";
+		strcpy(sport->name, "???");
 		break;
 	}
 
@@ -809,8 +876,6 @@ static int serial_pxa_probe(struct platform_device *dev)
 		goto err_clk;
 	}
 
-	serial_pxa_ports[dev->id] = sport;
-
 	uart_add_one_port(&serial_pxa_reg, &sport->port);
 	platform_set_drvdata(dev, sport);
 
diff --git a/include/linux/serial_pxa.h b/include/linux/serial_pxa.h
new file mode 100644
index 0000000..565e510
--- /dev/null
+++ b/include/linux/serial_pxa.h
@@ -0,0 +1,17 @@
+/*
+ *  linux/include/linux/serial_8250.h
+ *
+ *  Marvell Semiconductor Inc.
+ *  Copyright (C) 2011
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+#ifndef _LINUX_SERIAL_PXA_H
+#define _LINUX_SERIAL_PXA_H
+
+extern int serial_pxa_register_port(struct uart_port *);
+extern void serial_pxa_unregister_port(int);
+#endif
-- 
1.5.6.5
