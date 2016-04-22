From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 22 Apr 2016 17:22:20 +0200
Subject: [PATCH v2 1/5] doc: DT: Add Generic Serial Device Tree Bindings
In-Reply-To: <1461338544-29568-1-git-send-email-geert+renesas@glider.be>
References: <1461338544-29568-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461338544-29568-2-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document a set of generic properties for describing UARTs in a
device tree:
  1. The GPIO modem control properties are currently duplicated across
     hardware-specific binding documentation,
  2. The property for dedicated RTS/CTS hardware flow control lines is
     already supported by several drivers, albeit with a vendor-specific
     prefix, hence make it generic.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Rob Herring <rob@kernel.org>
---
v2:
  - Add Acked-by,
  - Drop out[12]-gpios.
---
 .../devicetree/bindings/serial/serial.txt          | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/serial.txt

diff --git a/Documentation/devicetree/bindings/serial/serial.txt b/Documentation/devicetree/bindings/serial/serial.txt
new file mode 100644
index 0000000000000000..fd970f76a7b8ef0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/serial.txt
@@ -0,0 +1,57 @@
+Generic Serial DT Bindings
+
+This document lists a set of generic properties for describing UARTs in a
+device tree.  Whether these properties apply to a particular device depends on
+the DT bindings for the actual device.
+
+Optional properties:
+  - cts-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's CTS line.
+  - dcd-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's DCD line.
+  - dsr-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's DSR line.
+  - dtr-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's DTR line.
+  - rng-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's RNG line.
+  - rts-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
+    used as the UART's RTS line.
+
+  - uart-has-rtscts: The presence of this property indicates that the
+    UART has dedicated lines for RTS/CTS hardware flow control, and that
+    they are available for use (wired and enabled by pinmux configuration).
+    This depends on both the UART hardware and the board wiring.
+    Note that this property is mutually-exclusive with "cts-gpios" and
+    "rts-gpios" above.
+
+
+Examples:
+
+	uart1: serial at 48022000 {
+		compatible = "ti,am3352-uart", "ti,omap3-uart";
+		ti,hwmods = "uart2";
+		clock-frequency = <48000000>;
+		reg = <0x48022000 0x2000>;
+		interrupts = <73>;
+		dmas = <&edma 28 0>, <&edma 29 0>;
+		dma-names = "tx", "rx";
+		dtr-gpios = <&gpio2 22 GPIO_ACTIVE_LOW>;
+		dsr-gpios = <&gpio2 23 GPIO_ACTIVE_LOW>;
+		dcd-gpios = <&gpio2 24 GPIO_ACTIVE_LOW>;
+		rng-gpios = <&gpio2 25 GPIO_ACTIVE_LOW>;
+		cts-gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+		rts-gpios = <&gpio0 13 GPIO_ACTIVE_LOW>;
+		status = "okay";
+	};
+
+	scifa4: serial at e6c80000 {
+		compatible = "renesas,scifa-sh73a0", "renesas,scifa";
+		reg = <0xe6c80000 0x100>;
+		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp2_clks SH73A0_CLK_SCIFA4>;
+		clock-names = "fck";
+		power-domains = <&pd_a3sp>;
+		uart-has-rtscts;
+		status = "okay";
+	};
-- 
1.9.1
