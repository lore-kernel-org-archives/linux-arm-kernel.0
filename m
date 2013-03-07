From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  7 Mar 2013 23:14:15 +0100
Subject: [PATCH 1/6] serial: 8250_dw: add support for clocks property when
 using DeviceTree
In-Reply-To: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1362694460-1919-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1362694460-1919-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Emilio L?pez <emilio@elopez.com.ar>

This commit implements support for using the "clocks" DT property, instead
of having to use clock-frequency.

Signed-off-by: Emilio L?pez <emilio@elopez.com.ar>
---
 drivers/tty/serial/8250/8250_dw.c |   32 ++++++++++++++++++++++----------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index db0e66f..8f03800 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
 
 #include "8250.h"
 
@@ -55,8 +56,9 @@
 
 
 struct dw8250_data {
-	int	last_lcr;
-	int	line;
+	int		last_lcr;
+	int		line;
+	struct clk	*clk;
 };
 
 static void dw8250_serial_out(struct uart_port *p, int offset, int value)
@@ -116,6 +118,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 static int dw8250_probe_of(struct uart_port *p)
 {
 	struct device_node	*np = p->dev->of_node;
+	struct dw8250_data	*data = p->private_data;
 	u32			val;
 
 	if (!of_property_read_u32(np, "reg-io-width", &val)) {
@@ -137,8 +140,15 @@ static int dw8250_probe_of(struct uart_port *p)
 		p->regshift = val;
 
 	if (of_property_read_u32(np, "clock-frequency", &val)) {
-		dev_err(p->dev, "no clock-frequency property set\n");
-		return -EINVAL;
+		/* Get clk rate through clk driver if present */
+		data->clk = clk_get(p->dev, NULL);
+		if (IS_ERR(data->clk)) {
+			dev_err(p->dev, "clk or clock-frequency not defined\n");
+			return -EINVAL;
+		}
+
+		clk_prepare_enable(data->clk);
+		val = clk_get_rate(data->clk);
 	}
 	p->uartclk = val;
 
@@ -300,6 +310,12 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	dw8250_setup_port(&uart);
 
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	uart.port.private_data = data;
+
 	if (pdev->dev.of_node) {
 		err = dw8250_probe_of(&uart.port);
 		if (err)
@@ -312,12 +328,6 @@ static int dw8250_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	uart.port.private_data = data;
-
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0)
 		return data->line;
@@ -333,6 +343,8 @@ static int dw8250_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(data->line);
 
+	clk_disable_unprepare(data->clk);
+
 	return 0;
 }
 
-- 
1.7.10.4
