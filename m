From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 31 May 2014 21:03:32 +0200
Subject: [PATCH v2 2/4] dt: bindings: mmc: Add sdio function subnode
 documentation
In-Reply-To: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
References: <1401563014-13856-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1401563014-13856-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

While SDIO devices are runtime probable they sometimes need nonprobable
additional information on embedded systems, like an additional gpio
interrupt or a clock. This binding describes how to add child nodes to the
devicetree to supply this information.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
[hdegoede at redhat.com: Updated the bindings to put the sdio functions inside
 slot subnodes]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 49 +++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 44c9e53..2903775 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -81,6 +81,27 @@ if a property is specified at both the host and the slot level the slot
 level takes precedence.
 
 
+Use of Function subnodes
+------------------------
+
+On embedded systems the cards connected to a host may need additional
+properties. These can be specified in subnodes to the slot subnodes, with
+the card / SDIO-function identified by the standard 'reg' property.
+Note that the use of slot subnodes is mandatory in this case.
+Which information exactly can be specified depends on the bindings for the
+SDIO function driver for the node, as specified by the compatible string.
+
+Required slot subnode properties when using function subnodes:
+- #address-cells: should be one. The cell is the slot id.
+- #size-cells: should be zero.
+
+Required function subnode properties:
+- compatible: name of SDIO function following generic names recommended practice
+- reg: Must contain the SDIO function number of the function this subnode
+       describes. A value of 0 denotes the memory SD function, values from
+       1 to 7 denote the SDIO functions.
+
+
 Examples
 --------
 
@@ -118,3 +139,31 @@ mmc0: mmc at f0008000 {
 		bus-width = <4>;
 	};
 };
+
+Example with sdio function subnodes:
+
+mmc3: mmc at 01c12000 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc3_pins_a>;
+	vmmc-supply = <&reg_vmmc3>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	mmc3_slot0: mmc3_slot at 0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0>;
+
+		brcmf: bcrmf at 1 {
+			reg = <1>;
+			compatible = "brcm,bcm43xx-fmac";
+			interrupt-parent = <&pio>;
+			interrupts = <10 8>; /* PH10 / EINT10 */
+			interrupt-names = "host-wake";
+		};
+	};
+};
-- 
2.0.0
