From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 14 Apr 2016 14:13:23 +0200
Subject: [PATCH 5/5] serial: sirf: Use generic uart-has-rtscts DT property
In-Reply-To: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1460636003-3011-6-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the SiRF UART driver from using the vendor-specific
"sirf,uart-has-rtscts" to the generic "uart-has-rtscts" DT property, as
documented by the Generic Serial DT Bindings.

The old vendor-specific property is still recognized by the driver for
backwards compatibility, but deprecated.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/serial/sirf-uart.txt | 8 ++++----
 drivers/tty/serial/sirfsoc_uart.c                      | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/sirf-uart.txt b/Documentation/devicetree/bindings/serial/sirf-uart.txt
index 67e2a0aeb0429572..1e48bbbeecc6dd27 100644
--- a/Documentation/devicetree/bindings/serial/sirf-uart.txt
+++ b/Documentation/devicetree/bindings/serial/sirf-uart.txt
@@ -9,9 +9,9 @@ Required properties:
 - clocks : Should contain uart clock number
 
 Optional properties:
-- sirf,uart-has-rtscts: we have hardware flow controller pins in hardware
-- rts-gpios: RTS pin for USP-based UART if sirf,uart-has-rtscts is true
-- cts-gpios: CTS pin for USP-based UART if sirf,uart-has-rtscts is true
+- uart-has-rtscts: we have hardware flow controller pins in hardware
+- rts-gpios: RTS pin for USP-based UART if uart-has-rtscts is true
+- cts-gpios: CTS pin for USP-based UART if uart-has-rtscts is true
 
 Example:
 
@@ -28,7 +28,7 @@ On the board-specific dts, we can put rts-gpios and cts-gpios like
 
 usp at b0090000 {
 	compatible = "sirf,prima2-usp-uart";
-	sirf,uart-has-rtscts;
+	uart-has-rtscts;
 	rts-gpios = <&gpio 15 0>;
 	cts-gpios = <&gpio 46 0>;
 };
diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 1d1c0b9857ff6900..b186c9c4f850cc16 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1293,7 +1293,8 @@ static int sirfsoc_uart_probe(struct platform_device *pdev)
 	sirfport->uart_reg = (struct sirfsoc_uart_register *)match->data;
 
 	sirfport->hw_flow_ctrl =
-		of_property_read_bool(np, "sirf,uart-has-rtscts");
+		of_property_read_bool(np, "uart-has-rtscts") ||
+		of_property_read_bool(np, "sirf,uart-has-rtscts") /* deprecated */;
 	if (of_device_is_compatible(np, "sirf,prima2-uart") ||
 		of_device_is_compatible(np, "sirf,atlas7-uart"))
 		sirfport->uart_reg->uart_type = SIRF_REAL_UART;
-- 
1.9.1
