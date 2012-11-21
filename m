From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 21 Nov 2012 16:57:08 +0100
Subject: [PATCH 4/4] tty: Atmel serial: add linux,stdout-path support
In-Reply-To: <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
References: <20121121155312.GX4398@game.jcrosoft.org>
 <1353513428-25697-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1353513428-25697-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-serial at vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: kernel at pengutronix.de
Cc: Alan Cox <alan@linux.intel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 5608b6b..f62a3c3 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1427,6 +1427,7 @@ static struct uart_ops atmel_pops = {
 static void __devinit atmel_of_init_port(struct atmel_uart_port *atmel_port,
 					 struct device_node *np)
 {
+	char *option = NULL;
 	u32 rs485_delay[2];
 
 	/* DMA/PDC usage specification */
@@ -1453,6 +1454,10 @@ static void __devinit atmel_of_init_port(struct atmel_uart_port *atmel_port,
 
 		if (of_get_property(np, "linux,rs485-enabled-at-boot-time", NULL))
 			rs485conf->flags |= SER_RS485_ENABLED;
+	} else if (of_device_is_stdout_path(np, &option)) {
+		pr_info("add preferred console %s%d option=%s\n",
+			ATMEL_DEVICENAME, atmel_port->uart.line, option);
+		add_preferred_console(ATMEL_DEVICENAME, atmel_port->uart.line, option);
 	}
 }
 
-- 
1.7.10.4
