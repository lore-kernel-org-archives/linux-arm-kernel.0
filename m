From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Fri, 12 Jan 2018 17:21:04 +1100
Subject: [PATCH 1/2 v2] ARM: dts: Add Aspeed SoC USB controllers to device-tree
Message-ID: <1515738064.31850.100.camel@kernel.crashing.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the USB controllers to the DT template of the
AST24xx and AST25xx SoCs.

This patch doesn't enable them by default on any board specific
.dts yet. This will be done when we have the necessary clock/reset
and pinmux support. In the meantime though, this will work if
u-boot configures things properly.

For the AST2400 I only added pinmux definition for port 1
which is dual USB1/USB2. There are additional USB1 only ports
that might require more work but I don't have HW to test at
hand so I'm leaving that to whoever cares.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2: Previous patch was missing actually adding the nodes
    (which was an old patch in my tree I had forgotten to
    merge).

 arch/arm/boot/dts/aspeed-g4.dtsi | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/aspeed-g5.dtsi | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
index b0d8431a3700..e55f2ad5de59 100644
--- a/arch/arm/boot/dts/aspeed-g4.dtsi
+++ b/arch/arm/boot/dts/aspeed-g4.dtsi
@@ -103,6 +103,23 @@
 			status = "disabled";
 		};
 
+		ehci0: usb at 1e6a1000 {
+			compatible = "aspeed,ast2400-ehci", "generic-ehci";
+			reg = <0x1e6a1000 0x100>;
+			interrupts = <5>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			status = "disabled";
+		};
+
+		uhci: usb at 1e6b0000 {
+			compatible = "aspeed,ast2400-uhci", "generic-uhci";
+			reg = <0x1e6b0000 0x100>;
+			interrupts = <14>;
+			#ports = <3>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
+			status = "disabled";
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -1227,6 +1244,16 @@
 		groups = "USBCKI";
 	};
 
+	pinctrl_usb2h_default: usb2h_default {
+		function = "USB2H1";
+		groups = "USB2H1";
+	};
+
+	pinctrl_usb2d_default: usb2d_default {
+		function = "USB2D1";
+		groups = "USB2D1";
+	};
+
 	pinctrl_vgabios_rom_default: vgabios_rom_default {
 		function = "VGABIOS_ROM";
 		groups = "VGABIOS_ROM";
diff --git a/arch/arm/boot/dts/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed-g5.dtsi
index 40de3b66c33f..655258edee24 100644
--- a/arch/arm/boot/dts/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed-g5.dtsi
@@ -138,6 +138,31 @@
 			status = "disabled";
 		};
 
+		ehci0: usb at 1e6a1000 {
+			compatible = "aspeed,ast2500-ehci", "generic-ehci";
+			reg = <0x1e6a1000 0x100>;
+			interrupts = <5>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
+			status = "disabled";
+		};
+
+		ehci1: usb at 1e6a3000 {
+			compatible = "aspeed,ast2500-ehci", "generic-ehci";
+			reg = <0x1e6a3000 0x100>;
+			interrupts = <13>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
+			status = "disabled";
+		};
+
+		uhci: usb at 1e6b0000 {
+			compatible = "aspeed,ast2500-uhci", "generic-uhci";
+			reg = <0x1e6b0000 0x100>;
+			interrupts = <14>;
+			#ports = <2>;
+			clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
+			status = "disabled";
+		};
+
 		apb {
 			compatible = "simple-bus";
 			#address-cells = <1>;
@@ -1358,6 +1383,21 @@
 		groups = "USBCKI";
 	};
 
+	pinctrl_usb2ah_default: usb2ah_default {
+		function = "USB2AH";
+		groups = "USB2AH";
+	};
+
+	pinctrl_usb11bhid_default: usb11bhid_default {
+		function = "USB11BHID";
+		groups = "USB11BHID";
+	};
+
+	pinctrl_usb2bh_default: usb2bh_default {
+		function = "USB2BH";
+		groups = "USB2BH";
+	};
+
 	pinctrl_vgabiosrom_default: vgabiosrom_default {
 		function = "VGABIOSROM";
 		groups = "VGABIOSROM";
