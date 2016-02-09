From: linux@roeck-us.net (Guenter Roeck)
Date: Tue,  9 Feb 2016 07:06:47 -0800
Subject: [PATCH] serial: clps711x: Fix bad usage of IS_ERR_VALUE
Message-ID: <1455030407-9075-1-git-send-email-linux@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IS_ERR_VALUE() assumes that its parameter is an unsigned long.
It can not be used to check if an unsigned int reflects an error.
Doing so can result in the following build warning.

drivers/tty/serial/clps711x.c: In function ?uart_clps711x_probe?:
include/linux/err.h:21:38: warning:
	comparison is always false due to limited range of data type
drivers/tty/serial/clps711x.c:471:6: note: in expansion of macro ?IS_ERR_VALUE?

If that warning is seen, an error return from platform_get_irq() is missed.

Use a temporary variable to check for errors from platform_get_irq().
Also don't use IS_ERR_VALUE() to check if an integer variable is < 0.
The variable can be checked directly in that case.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/tty/serial/clps711x.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/clps711x.c b/drivers/tty/serial/clps711x.c
index b3a4e0cdddaa..5beafd2d2218 100644
--- a/drivers/tty/serial/clps711x.c
+++ b/drivers/tty/serial/clps711x.c
@@ -450,6 +450,7 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	struct clps711x_port *s;
 	struct resource *res;
 	struct clk *uart_clk;
+	int irq;
 
 	if (index < 0 || index >= UART_CLPS711X_NR)
 		return -EINVAL;
@@ -467,12 +468,13 @@ static int uart_clps711x_probe(struct platform_device *pdev)
 	if (IS_ERR(s->port.membase))
 		return PTR_ERR(s->port.membase);
 
-	s->port.irq = platform_get_irq(pdev, 0);
-	if (IS_ERR_VALUE(s->port.irq))
-		return s->port.irq;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+	s->port.irq = irq;
 
 	s->rx_irq = platform_get_irq(pdev, 1);
-	if (IS_ERR_VALUE(s->rx_irq))
+	if (s->rx_irq < 0)
 		return s->rx_irq;
 
 	if (!np) {
-- 
2.5.0
