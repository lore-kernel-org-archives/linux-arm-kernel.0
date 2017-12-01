From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri,  1 Dec 2017 10:03:49 +0900
Subject: [PATCH net-next v4 1/2] dt-bindings: net: add DT bindings for
 Socionext UniPhier AVE
In-Reply-To: <1512090230-27594-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1512090230-27594-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1512090230-27594-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT bindings for the AVE ethernet controller found on Socionext's
UniPhier platforms.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/net/socionext,uniphier-ave4.txt       | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt

diff --git a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
new file mode 100644
index 0000000..4700377
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.txt
@@ -0,0 +1,48 @@
+* Socionext AVE ethernet controller
+
+This describes the devicetree bindings for AVE ethernet controller
+implemented on Socionext UniPhier SoCs.
+
+Required properties:
+ - compatible: Should be
+	- "socionext,uniphier-pro4-ave4" : for Pro4 SoC
+	- "socionext,uniphier-pxs2-ave4" : for PXs2 SoC
+	- "socionext,uniphier-ld11-ave4" : for LD11 SoC
+	- "socionext,uniphier-ld20-ave4" : for LD20 SoC
+ - reg: Address where registers are mapped and size of region.
+ - interrupts: Should contain the MAC interrupt.
+ - phy-mode: See ethernet.txt in the same directory. Allow to choose
+	"rgmii", "rmii", or "mii" according to the PHY.
+ - phy-handle: Should point to the external phy device.
+	See ethernet.txt file in the same directory.
+ - clocks: A phandle to the clock for the MAC.
+
+Optional properties:
+ - resets: A phandle to the reset control for the MAC
+ - local-mac-address: See ethernet.txt in the same directory.
+
+Required subnode:
+ - mdio: Device tree subnode with the following required properties:
+	- #address-cells: Must be <1>.
+	- #size-cells: Must be <0>.
+	- reg: phy ID number, usually a small integer.
+
+Example:
+
+	ether: ethernet at 65000000 {
+		compatible = "socionext,uniphier-ld20-ave4";
+		reg = <0x65000000 0x8500>;
+		interrupts = <0 66 4>;
+		phy-mode = "rgmii";
+		phy-handle = <&ethphy>;
+		clocks = <&sys_clk 6>;
+		resets = <&sys_rst 6>;
+		local-mac-address = [00 00 00 00 00 00];
+		mdio {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ethphy: ethphy at 1 {
+				reg = <1>;
+			};
+		};
+	};
-- 
2.7.4
