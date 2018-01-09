From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  9 Jan 2018 23:10:52 +0100
Subject: [PATCH net-next 1/2 v10] net: ethernet: Add DT bindings for the
 Gemini ethernet
Message-ID: <20180109221053.927-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the device tree bindings for the Gemini ethernet
controller. It is pretty straight-forward, using standard
bindings and modelling the two child ports as child devices
under the parent ethernet controller device.

Cc: devicetree at vger.kernel.org
Cc: Tobias Waldvogel <tobias.waldvogel@gmail.com>
Cc: Micha? Miros?aw <mirq-linux@rere.qmqm.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v9->v10:
- Resend with the driver.
ChangeLog v8->v9:
- Collect Rob's ACK.
ChangeLog v7->v8:
- Use ethernet-port at 0 and ethernet-port at 1 with unit names
  and following OF graph requirements.
---
 .../bindings/net/cortina,gemini-ethernet.txt       | 92 ++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt

diff --git a/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt b/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
new file mode 100644
index 000000000000..6c559981d110
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/cortina,gemini-ethernet.txt
@@ -0,0 +1,92 @@
+Cortina Systems Gemini Ethernet Controller
+==========================================
+
+This ethernet controller is found in the Gemini SoC family:
+StorLink SL3512 and SL3516, also known as Cortina Systems
+CS3512 and CS3516.
+
+Required properties:
+- compatible: must be "cortina,gemini-ethernet"
+- reg: must contain the global registers and the V-bit and A-bit
+  memory areas, in total three register sets.
+- syscon: a phandle to the system controller
+- #address-cells: must be specified, must be <1>
+- #size-cells: must be specified, must be <1>
+- ranges: should be state like this giving a 1:1 address translation
+  for the subnodes
+
+The subnodes represents the two ethernet ports in this device.
+They are not independent of each other since they share resources
+in the parent node, and are thus children.
+
+Required subnodes:
+- port0: contains the resources for ethernet port 0
+- port1: contains the resources for ethernet port 1
+
+Required subnode properties:
+- compatible: must be "cortina,gemini-ethernet-port"
+- reg: must contain two register areas: the DMA/TOE memory and
+  the GMAC memory area of the port
+- interrupts: should contain the interrupt line of the port.
+  this is nominally a level interrupt active high.
+- resets: this must provide an SoC-integrated reset line for
+  the port.
+- clocks: this should contain a handle to the PCLK clock for
+  clocking the silicon in this port
+- clock-names: must be "PCLK"
+
+Optional subnode properties:
+- phy-mode: see ethernet.txt
+- phy-handle: see ethernet.txt
+
+Example:
+
+mdio-bus {
+	(...)
+	phy0: ethernet-phy at 1 {
+		reg = <1>;
+		device_type = "ethernet-phy";
+	};
+	phy1: ethernet-phy at 3 {
+		reg = <3>;
+		device_type = "ethernet-phy";
+	};
+};
+
+
+ethernet at 60000000 {
+	compatible = "cortina,gemini-ethernet";
+	reg = <0x60000000 0x4000>, /* Global registers, queue */
+	      <0x60004000 0x2000>, /* V-bit */
+	      <0x60006000 0x2000>; /* A-bit */
+	syscon = <&syscon>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+	ranges;
+
+	gmac0: ethernet-port at 0 {
+		compatible = "cortina,gemini-ethernet-port";
+		reg = <0x60008000 0x2000>, /* Port 0 DMA/TOE */
+		      <0x6000a000 0x2000>; /* Port 0 GMAC */
+		interrupt-parent = <&intcon>;
+		interrupts = <1 IRQ_TYPE_LEVEL_HIGH>;
+		resets = <&syscon GEMINI_RESET_GMAC0>;
+		clocks = <&syscon GEMINI_CLK_GATE_GMAC0>;
+		clock-names = "PCLK";
+		phy-mode = "rgmii";
+		phy-handle = <&phy0>;
+	};
+
+	gmac1: ethernet-port at 1 {
+		compatible = "cortina,gemini-ethernet-port";
+		reg = <0x6000c000 0x2000>, /* Port 1 DMA/TOE */
+		      <0x6000e000 0x2000>; /* Port 1 GMAC */
+		interrupt-parent = <&intcon>;
+		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+		resets = <&syscon GEMINI_RESET_GMAC1>;
+		clocks = <&syscon GEMINI_CLK_GATE_GMAC1>;
+		clock-names = "PCLK";
+		phy-mode = "rgmii";
+		phy-handle = <&phy1>;
+	};
+};
-- 
2.14.3
