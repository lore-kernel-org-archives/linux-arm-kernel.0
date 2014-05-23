From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 23 May 2014 15:51:04 +0800
Subject: [PATCH 01/22] serial: 8250_dw: Add optional reset control support
In-Reply-To: <1400831485-28576-1-git-send-email-wens@csie.org>
References: <1400831485-28576-1-git-send-email-wens@csie.org>
Message-ID: <1400831485-28576-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Allwinner A31 and A23 SoCs have a reset controller
maintaining the UART in reset by default.

This patch adds optional reset support to the driver.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt |  1 +
 drivers/tty/serial/8250/8250_dw.c                             | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
index f13f1c5..cb9af84 100644
--- a/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
+++ b/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.txt
@@ -7,6 +7,7 @@ Required properties:
 - clock-frequency : the input clock frequency for the UART.
 
 Optional properties:
+- resets : phandle to the parent reset controller.
 - reg-shift : quantity to shift the register offsets by.  If this property is
   not present then the register offsets are not shifted.
 - reg-io-width : the size (in bytes) of the IO accesses that should be
diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index ed31135..d0c6d080 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -26,6 +26,7 @@
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/pm_runtime.h>
 
 #include <asm/byteorder.h>
@@ -59,6 +60,7 @@ struct dw8250_data {
 	int			last_mcr;
 	int			line;
 	struct clk		*clk;
+	struct reset_control	*rst;
 	struct uart_8250_dma	dma;
 };
 
@@ -259,6 +261,8 @@ static int dw8250_probe_of(struct uart_port *p,
 	if (!of_property_read_u32(np, "reg-shift", &val))
 		p->regshift = val;
 
+	data->rst = devm_reset_control_get_optional(p->dev, NULL);
+
 	/* clock got configured through clk api, all done */
 	if (p->uartclk)
 		return 0;
@@ -362,6 +366,9 @@ static int dw8250_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
+	if (!IS_ERR_OR_NULL(data->rst))
+		reset_control_deassert(data->rst);
+
 	data->line = serial8250_register_8250_port(&uart);
 	if (data->line < 0)
 		return data->line;
@@ -382,6 +389,9 @@ static int dw8250_remove(struct platform_device *pdev)
 
 	serial8250_unregister_port(data->line);
 
+	if (!IS_ERR_OR_NULL(data->rst))
+		reset_control_assert(data->rst);
+
 	if (!IS_ERR(data->clk))
 		clk_disable_unprepare(data->clk);
 
-- 
2.0.0.rc2
