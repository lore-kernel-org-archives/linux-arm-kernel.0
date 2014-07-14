From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Mon, 14 Jul 2014 17:07:16 +0530
Subject: [PATCH 1/3] serial: samsung: get fifosize via device tree
In-Reply-To: <1405337838-30335-1-git-send-email-ch.naveen@samsung.com>
References: <1405337838-30335-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1405337838-30335-2-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

UART modules on some SoCs only differ in the fifosize of each
UART channel. Its useless to duplicate the drv_data structure
or create a compatible name for such a change.

We can get fifosize via the device tree nodes (not mandating it).

Also updates the documentation.

Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: gregkh at linuxfoundation.org
---
 .../devicetree/bindings/serial/samsung_uart.txt    |    4 ++++
 drivers/tty/serial/samsung.c                       |   12 +++++++++---
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/samsung_uart.txt b/Documentation/devicetree/bindings/serial/samsung_uart.txt
index 85e8ee2..e85f37e 100644
--- a/Documentation/devicetree/bindings/serial/samsung_uart.txt
+++ b/Documentation/devicetree/bindings/serial/samsung_uart.txt
@@ -29,6 +29,9 @@ Required properties:
 [1] Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
 [2] Documentation/devicetree/bindings/clock/clock-bindings.txt
 
+Optional properties:
+- samsung,uart-fifosize: The fifo size supported by the UART channel
+
 Note: Each Samsung UART should have an alias correctly numbered in the
 "aliases" node, according to serialN format, where N is the port number
 (non-negative decimal integer) as specified by User's Manual of respective
@@ -51,4 +54,5 @@ Example:
 				"clk_uart_baud3";
 		clocks = <&clocks PCLK_UART1>, <&clocks PCLK_UART1>,
 				<&clocks SCLK_UART>;
+		samsung,uart-fifosize = <16>;
 	};
diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index 6be852d..e49a945 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1295,9 +1295,15 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 			dev_get_platdata(&pdev->dev) :
 			ourport->drv_data->def_cfg;
 
-	ourport->port.fifosize = (ourport->info->fifosize) ?
-		ourport->info->fifosize :
-		ourport->drv_data->fifosize[index];
+	if (pdev->dev.of_node)
+		of_property_read_u32(pdev->dev.of_node,
+			"samsung,uart-fifosize", &ourport->port.fifosize);
+
+	if (!ourport->port.fifosize) {
+		ourport->port.fifosize = (ourport->info->fifosize) ?
+			ourport->info->fifosize :
+			ourport->drv_data->fifosize[index];
+	}
 
 	probe_index++;
 
-- 
1.7.9.5
