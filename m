From: lkundrak@v3.sk (Lubomir Rintel)
Date: Wed, 10 Oct 2018 19:22:48 +0200
Subject: [PATCH 03/15] dt-bindings: olpc,
 xo1.75-ec: Add OLPC XO-1.75 EC bindings
In-Reply-To: <20181010172300.317643-1-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
Message-ID: <20181010172300.317643-4-lkundrak@v3.sk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The OLPC XO-1.75 Embedded Controller is a SPI master that uses extra
signals for handshaking. It needs to know when is the slave (Linux)
side's TX FIFO ready for transfer (the ready-gpio signal on the SPI
controller node) and when does it wish to respond with a command (the
cmd-gpio property).

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../bindings/misc/olpc,xo1.75-ec.txt          | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt

diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
new file mode 100644
index 000000000000..14385fee65d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
@@ -0,0 +1,24 @@
+OLPC XO-1.75 Embedded Controller
+
+Required properties:
+- compatible: Should be "olpc,xo1.75-ec".
+- cmd-gpio: gpio specifier of the CMD pin
+
+The embedded controller requires the SPI controller driver to signal readiness
+to receive a transfer (that is, when TX FIFO contains the response data) by
+strobing the ACK pin with the ready signal. See the "ready-gpio" property of the
+SSP binding as documented in:
+<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
+
+Example:
+	&ssp3 {
+		spi-slave;
+		status = "okay";
+		ready-gpio = <&gpio 125 GPIO_ACTIVE_HIGH>;
+
+		slave {
+			compatible = "olpc,xo1.75-ec";
+			spi-cpha;
+			cmd-gpio = <&gpio 155 GPIO_ACTIVE_HIGH>;
+		};
+	};
-- 
2.19.0
