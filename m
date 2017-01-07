From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Sat, 07 Jan 2017 11:28:30 +0000
Subject: [PATCH RFC 3/4] dt-bindings: correct marvell orion MDIO binding
 document
In-Reply-To: <20170107112656.GL14217@n2100.armlinux.org.uk>
References: <20170107112656.GL14217@n2100.armlinux.org.uk>
Message-ID: <E1cPpAk-0005uJ-TM@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct the Marvell Orion MDIO binding document to properly reflect the
cases where an interrupt is present.  Augment the examples to show this.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 .../devicetree/bindings/net/marvell-orion-mdio.txt      | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt b/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
index 9417e54c26c0..ca733ff68ab9 100644
--- a/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
+++ b/Documentation/devicetree/bindings/net/marvell-orion-mdio.txt
@@ -7,7 +7,10 @@ interface.
 
 Required properties:
 - compatible: "marvell,orion-mdio"
-- reg: address and length of the SMI register
+- reg: address and length of the MDIO registers.  When an interrupt is
+  not present, the length is the size of the SMI register (4 bytes)
+  otherwise it must be 0x84 bytes to cover the interrupt control
+  registers.
 
 Optional properties:
 - interrupts: interrupt line number for the SMI error/done interrupt
@@ -17,7 +20,7 @@ The child nodes of the MDIO driver are the individual PHY devices
 connected to this MDIO bus. They must have a "reg" property given the
 PHY address on the MDIO bus.
 
-Example at the SoC level:
+Example at the SoC level without an interrupt property:
 
 mdio {
 	#address-cells = <1>;
@@ -26,6 +29,16 @@ mdio {
 	reg = <0xd0072004 0x4>;
 };
 
+Example with an interrupt property:
+
+mdio {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	compatible = "marvell,orion-mdio";
+	reg = <0xd0072004 0x84>;
+	interrupts = <30>;
+};
+
 And at the board level:
 
 mdio {
-- 
2.7.4
