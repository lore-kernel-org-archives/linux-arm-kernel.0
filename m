From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 14 Jun 2017 10:29:14 +0200
Subject: [PATCH v5 1/4] dt-bindings: serial: Add bindings for the Amlogic
 Meson UARTs
In-Reply-To: <1497428957-19942-1-git-send-email-narmstrong@baylibre.com>
References: <1497428957-19942-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1497428957-19942-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Helmut Klein <hgkr.klein@gmail.com>

Add the documentation for the device tree binding of Amlogic Meson Serial UART.

Signed-off-by: Helmut Klein <hgkr.klein@gmail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../bindings/serial/amlogic,meson-uart.txt         | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt

diff --git a/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
new file mode 100644
index 0000000..8ff65fa
--- /dev/null
+++ b/Documentation/devicetree/bindings/serial/amlogic,meson-uart.txt
@@ -0,0 +1,38 @@
+Amlogic Meson SoC UART Serial Interface
+=======================================
+
+The Amlogic Meson SoC UART Serial Interface is present on a large range
+of SoCs, and can be present either in the "Always-On" power domain or the
+"Everything-Else" power domain.
+
+The particularity of the "Always-On" Serial Interface is that the hardware
+is active since power-on and does not need any clock gating and is usable
+as very early serial console.
+
+Required properties:
+- compatible : compatible: value should be different for each SoC family as :
+	- Meson6 : "amlogic,meson6-uart"
+	- Meson8 : "amlogic,meson8-uart"
+	- Meson8b : "amlogic,meson8b-uart"
+	- GX (GXBB, GXL, GXM) : "amlogic,meson-gx-uart"
+	eventually followed by : "amlogic,meson-ao-uart" if this UART interface
+	is in the "Always-On" power domain.
+- reg : offset and length of the register set for the device.
+- interrupts : identifier to the device interrupt
+- clocks : a list of phandle + clock-specifier pairs, one for each
+	   entry in clock names.
+- clocks-names :
+   * "xtal" for external xtal clock identifier
+   * "pclk" for the bus core clock, either the clk81 clock or the gate clock
+   * "baud" for the source of the baudrate generator, can be either the xtal
+	or the pclk.
+
+e.g.
+uart_A: serial at 84c0 {
+	compatible = "amlogic,meson-gx-uart";
+	reg = <0x0 0x84c0 0x0 0x14>;
+	interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
+	/* Use xtal as baud rate clock source */
+	clocks = <&xtal>, <&clkc CLKID_UART0>, <&xtal>;
+	clock-names = "xtal", "pclk", "baud";
+};
-- 
1.9.1
