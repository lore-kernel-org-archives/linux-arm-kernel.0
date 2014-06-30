From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 30 Jun 2014 11:07:24 +0200
Subject: [PATCH resend v3 1/2] dt: bindings: mmc: Add sdio function subnode
 documentation
In-Reply-To: <1404119245-5839-1-git-send-email-hdegoede@redhat.com>
References: <1404119245-5839-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1404119245-5839-2-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sascha Hauer <s.hauer@pengutronix.de>

While SDIO devices are runtime probable they sometimes need nonprobable
additional information on embedded systems, like an additional gpio
interrupt or a clock. This binding describes how to add child nodes to the
devicetree to supply this information.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
[hdegoede at redhat.com: Documented the need for #address- and #size-cells]
[hdegoede at redhat.com: Added a real world example]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/devicetree/bindings/mmc/mmc.txt | 48 ++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
index 3c18001..2f362c4 100644
--- a/Documentation/devicetree/bindings/mmc/mmc.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc.txt
@@ -62,7 +62,31 @@ Optional SDIO properties:
 - keep-power-in-suspend: Preserves card power during a suspend/resume cycle
 - enable-sdio-wakeup: Enables wake up of host system on SDIO IRQ assertion
 
-Example:
+
+Use of Function subnodes
+------------------------
+
+On embedded systems the cards connected to a host may need additional
+properties. These can be specified in subnodes to the host controller node.
+The subnodes are identified by the standard 'reg' property.
+Which information exactly can be specified depends on the bindings for the
+SDIO function driver for the subnode, as specified by the compatible string.
+
+Required host node properties when using function subnodes:
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
+Examples
+--------
+
+Basic example:
 
 sdhci at ab000000 {
 	compatible = "sdhci";
@@ -76,3 +100,25 @@ sdhci at ab000000 {
 	keep-power-in-suspend;
 	enable-sdio-wakeup;
 }
+
+Example with sdio function subnode:
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
+	brcmf: bcrmf at 1 {
+		reg = <1>;
+		compatible = "brcm,bcm43xx-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <10 8>; /* PH10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
+};
-- 
2.0.0
