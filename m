From: jonas.gorski@gmail.com (Jonas Gorski)
Date: Wed,  2 Aug 2017 11:34:25 +0200
Subject: [PATCH 4/8] tty/bcm63xx_uart: allow naming clock in device tree
In-Reply-To: <20170802093429.12572-1-jonas.gorski@gmail.com>
References: <20170802093429.12572-1-jonas.gorski@gmail.com>
Message-ID: <20170802093429.12572-5-jonas.gorski@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Codify using a named clock for the refclk of the uart. This makes it
easier if we might need to add a gating clock (like present on the
BCM6345).

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt | 6 ++++++
 drivers/tty/serial/bcm63xx_uart.c                              | 6 ++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
index 5c52e5eef16d..8b2b0460259a 100644
--- a/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
+++ b/Documentation/devicetree/bindings/serial/brcm,bcm6345-uart.txt
@@ -11,6 +11,11 @@ Required properties:
 - clocks: Clock driving the hardware; used to figure out the baud rate
   divisor.
 
+
+Optional properties:
+
+- clock-names: Should be "refclk".
+
 Example:
 
 	uart0: serial at 14e00520 {
@@ -19,6 +24,7 @@ Example:
 		interrupt-parent = <&periph_intc>;
 		interrupts = <2>;
 		clocks = <&periph_clk>;
+		clock-names = "refclk";
 	};
 
 	clocks {
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index a2b9376ec861..f227eff28d3a 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -841,8 +841,10 @@ static int bcm_uart_probe(struct platform_device *pdev)
 	if (!res_irq)
 		return -ENODEV;
 
-	clk = pdev->dev.of_node ? of_clk_get(pdev->dev.of_node, 0) :
-				  clk_get(&pdev->dev, "refclk");
+	clk = clk_get(&pdev->dev, "refclk");
+	if (IS_ERR(clk) && pdev->dev.of_node)
+		clk = of_clk_get(pdev->dev.of_node, 0);
+
 	if (IS_ERR(clk))
 		return -ENODEV;
 
-- 
2.13.2
