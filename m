From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat,  8 Feb 2014 12:53:53 +0100
Subject: [PATCH 2/2] serial: atmel: evaluate linux,stdout-path property
In-Reply-To: <1391860433-5343-1-git-send-email-plagnioj@jcrosoft.com>
References: <1391860433-5343-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1391860433-5343-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

if the driver is built as module skip it as add_preferred_console is not
exported

Cc: linux-serial at vger.kernel.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 drivers/tty/serial/atmel_serial.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a49f10d..2ade64e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -2044,6 +2044,19 @@ static struct uart_ops atmel_pops = {
 #endif
 };
 
+static void atmel_of_preferred_console(struct atmel_uart_port *atmel_port,
+				       struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct uart_port *port = &atmel_port->uart;
+	char* option;
+
+	if (!np || !of_device_is_stdout_path(np, &option))
+		return;
+
+	add_preferred_console(ATMEL_DEVICENAME, port->line, option);
+}
+
 /*
  * Configure the port from the platform device resource info.
  */
@@ -2059,6 +2072,9 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 
 	atmel_init_rs485(atmel_port, pdev);
 
+	if (IS_BUILTIN(CONFIG_SERIAL_ATMEL))
+		atmel_of_preferred_console(atmel_port, pdev);
+
 	port->iotype		= UPIO_MEM;
 	port->flags		= UPF_BOOT_AUTOCONF;
 	port->ops		= &atmel_pops;
-- 
1.9.rc1
