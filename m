From: manabian@gmail.com (Joachim Eastwood)
Date: Fri, 29 May 2015 19:50:16 +0200
Subject: [PATCH 2/2] doc: dt: add documentation for nxp,lpc1773-spifi
In-Reply-To: <1432921816-10765-1-git-send-email-manabian@gmail.com>
References: <1432921816-10765-1-git-send-email-manabian@gmail.com>
Message-ID: <1432921816-10765-3-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree binding documentation for the SPI Flash Interface
(SPIFI) found on NXP LPC18xx and LPC43xx devies.

Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 .../devicetree/bindings/mtd/nxp-spifi.txt          | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/nxp-spifi.txt

diff --git a/Documentation/devicetree/bindings/mtd/nxp-spifi.txt b/Documentation/devicetree/bindings/mtd/nxp-spifi.txt
new file mode 100644
index 000000000000..fc071fa2d798
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/nxp-spifi.txt
@@ -0,0 +1,56 @@
+* NXP SPI Flash Interface (SPIFI)
+
+NXP SPIFI is a specialized SPI interface for serial Flash devices.
+It supports one Flash device with 1-, 2- and 4-bits width in SPI
+mode 0 or 3. The controller operates in either command or memory
+mode. In memory mode the Flash is accessible from the CPU as
+normal memory.
+
+Required properties:
+  - compatible : Should be "nxp,lpc1773-spifi"
+  - reg : the first contains the register location and length,
+          the second contains the memory mapping address and length
+  - reg-names: Should contain the reg names "spifi" and "flash"
+  - interrupts : Should contain the interrupt for the device
+  - clocks : The clocks needed by the SPIFI controller
+  - clock-names : Should contain the clock names "spifi" and "reg"
+
+Optional properties:
+ - resets : phandle + reset specifier
+
+The SPI Flash must be a child of the SPIFI node and can contain
+the following properties.
+ - spi-cpol : Controller only supports mode 0 and 3 so either
+              both spi-cpol and spi-cpha should be present or
+              none of them
+ - spi-cpha : See above
+ - spi-rx-bus-width : Used to select how many pins that are used
+                      for input on the controller
+
+See bindings/spi/spi-bus.txt for more information.
+
+Example:
+spifi: spifi at 40003000 {
+	compatible = "nxp,lpc1773-spifi";
+	reg = <0x40003000 0x1000>, <0x14000000 0x4000000>;
+	reg-names = "spifi", "flash";
+	interrupts = <30>;
+	clocks = <&ccu1 CLK_SPIFI>, <&ccu1 CLK_CPU_SPIFI>;
+	clock-names = "spifi", "reg";
+	resets = <&rgu 53>;
+
+	flash at 0 {
+		compatible = "spansion,s25fl016k", "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		spi-rx-bus-width = <4>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition at 0 {
+			label = "data";
+			reg = <0 0x200000>;
+		};
+	};
+};
+
-- 
1.8.0
