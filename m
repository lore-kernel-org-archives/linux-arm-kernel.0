From: leilei.zhao@atmel.com (Leilei Zhao)
Date: Fri, 27 Feb 2015 16:07:16 +0800
Subject: [PATCH v2 3/5] tty/serial: at91: revise the return type of
 atmel_init_property
In-Reply-To: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
References: <1425024438-31355-1-git-send-email-leilei.zhao@atmel.com>
Message-ID: <1425024438-31355-4-git-send-email-leilei.zhao@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function of atmel_init_property is to set the work manner of
atmel serial ports according to the property in device trees.
If DMA or PDC is not set or something goes wrong in getting property,
the work manner will switch to general PIO mode, thus there will
not be any failure case in this function. It's actually a procedure.
So changing the return type from int to void.

Signed-off-by: Leilei Zhao <leilei.zhao@atmel.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 drivers/tty/serial/atmel_serial.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index a99d89e..2667656 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -1534,7 +1534,7 @@ static void atmel_tasklet_func(unsigned long data)
 	spin_unlock(&port->lock);
 }
 
-static int atmel_init_property(struct atmel_uart_port *atmel_port,
+static void atmel_init_property(struct atmel_uart_port *atmel_port,
 				struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -1575,7 +1575,6 @@ static int atmel_init_property(struct atmel_uart_port *atmel_port,
 		atmel_port->use_dma_tx  = false;
 	}
 
-	return 0;
 }
 
 static void atmel_init_rs485(struct uart_port *port,
@@ -2235,8 +2234,8 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
 	struct uart_port *port = &atmel_port->uart;
 	struct atmel_uart_data *pdata = dev_get_platdata(&pdev->dev);
 
-	if (!atmel_init_property(atmel_port, pdev))
-		atmel_set_ops(port);
+	atmel_init_property(atmel_port, pdev);
+	atmel_set_ops(port);
 
 	atmel_init_rs485(port, pdev);
 
-- 
1.7.9.5
