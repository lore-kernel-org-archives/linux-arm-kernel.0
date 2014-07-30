From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 30 Jul 2014 19:05:00 +0200
Subject: [PATCH v13 6/8] Documentation: bindings: document the sub-nodes AHCI
 bindings
In-Reply-To: <1406739902-26311-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1406739902-26311-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1406739902-26311-7-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The libahci now allows to use multiple PHYs and to represent each port
as a sub-node. Add these bindings to the documentation.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/ata/ahci-platform.txt      | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 549ceb8cb93b..4ab09f2202d4 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -3,6 +3,10 @@
 SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
+It is possible, but not required, to represent each port as a sub-node.
+It allows to enable each port independently when dealing with multiple
+PHYs.
+
 Required properties:
 - compatible        : compatible string, one of:
   - "allwinner,sun4i-a10-ahci"
@@ -12,13 +16,30 @@ Required properties:
   - "snps,dwc-ahci"
   - "snps,exynos5440-ahci"
   - "snps,spear-ahci"
+  - "generic-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 
+Please note that when using "generic-ahci" you must also specify a SoC specific
+compatible:
+	compatible = "manufacturer,soc-model-ahci", "generic-ahci";
+
 Optional properties:
 - dma-coherent      : Present if dma operations are coherent
 - clocks            : a list of phandle + clock specifier pairs
 - target-supply     : regulator for SATA target power
+- phys              : reference to the SATA PHY node
+- phy-names         : must be "sata-phy"
+
+Required properties when using sub-nodes:
+- #address-cells    : number of cells to encode an address
+- #size-cells       : number of cells representing the size of an address
+
+
+Sub-nodes required properties:
+- reg               : the port number
+- phys              : reference to the SATA PHY node
+
 
 Examples:
         sata at ffe08000 {
@@ -34,3 +55,23 @@ Examples:
 		clocks = <&pll6 0>, <&ahb_gates 25>;
 		target-supply = <&reg_ahci_5v>;
 	};
+
+With sub-nodes:
+	sata at f7e90000 {
+		compatible = "marvell,berlin2q-achi", "generic-ahci";
+		reg = <0xe90000 0x1000>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&chip CLKID_SATA>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		sata0: sata-port at 0 {
+			reg = <0>;
+			phys = <&sata_phy 0>;
+		};
+
+		sata1: sata-port at 1 {
+			reg = <1>;
+			phys = <&sata_phy 1>;
+		};
+	};
-- 
1.9.1
