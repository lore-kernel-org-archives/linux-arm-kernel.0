From: linux@roeck-us.net (Guenter Roeck)
Date: Tue,  9 Feb 2016 07:08:59 -0800
Subject: [PATCH] tty/serial: digicolor: Fix bad usage of IS_ERR_VALUE
Message-ID: <1455030539-10798-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IS_ERR_VALUE() assumes that its parameter is an unsigned long.
It can not be used to check if an unsigned int reflects an error.
Doing so can result in the following build warning.

drivers/tty/serial/digicolor-usart.c: In function ?digicolor_uart_probe?:
include/linux/err.h:21:38: warning:
	comparison is always false due to limited range of data type
drivers/tty/serial/digicolor-usart.c:485:6: note:
	in expansion of macro ?IS_ERR_VALUE?

If that warning is seen, an error return from platform_get_irq() is missed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/serial/digicolor-usart.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index a80cdad114f3..02ad6953b167 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -453,7 +453,7 @@ static struct uart_driver digicolor_uart = {
 static int digicolor_uart_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	int ret, index;
+	int irq, ret, index;
 	struct digicolor_port *dp;
 	struct resource *res;
 	struct clk *uart_clk;
@@ -481,9 +481,10 @@ static int digicolor_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(dp->port.membase))
 		return PTR_ERR(dp->port.membase);
 
-	dp->port.irq = platform_get_irq(pdev, 0);
-	if (IS_ERR_VALUE(dp->port.irq))
-		return dp->port.irq;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+	dp->port.irq = irq;
 
 	dp->port.iotype = UPIO_MEM;
 	dp->port.uartclk = clk_get_rate(uart_clk);
-- 
2.5.0
