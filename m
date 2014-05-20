From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Tue, 20 May 2014 11:04:33 +0200
Subject: [PATCH v4 5/7] Documentation: bindings: document the sub-nodes AHCI
 bindings
In-Reply-To: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
References: <1400576675-25265-1-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <1400576675-25265-6-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The libahci now allows to use multiple PHYs and to represent each port
as a sub-node. Add these bindings to the documentation.

Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
---
 .../devicetree/bindings/ata/ahci-platform.txt      | 38 +++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.txt b/Documentation/devicetree/bindings/ata/ahci-platform.txt
index 48b285ffa3a6..5e4f006a018d 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.txt
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.txt
@@ -3,11 +3,16 @@
 SATA nodes are defined to describe on-chip Serial ATA controllers.
 Each SATA controller should have its own node.
 
+It is possible, but not required, to represent each port as a sub-node.
+It allows to enable each port independently when dealing with multiple
+PHYs.
+
 Required properties:
 - compatible        : compatible list, one of "snps,spear-ahci",
                       "snps,exynos5440-ahci", "ibm,476gtr-ahci",
                       "allwinner,sun4i-a10-ahci", "fsl,imx53-ahci"
-                      "fsl,imx6q-ahci" or "snps,dwc-ahci"
+                      "fsl,imx6q-ahci", "snps,dwc-ahci" or
+                      "marvell,berlin-ahci"
 - interrupts        : <interrupt mapping for SATA IRQ>
 - reg               : <registers mapping>
 
@@ -15,11 +20,23 @@ Optional properties:
 - dma-coherent      : Present if dma operations are coherent
 - clocks            : a list of phandle + clock specifier pairs
 - target-supply     : regulator for SATA target power
+- phys              : reference to the SATA PHY node
+- phy-names         : must be "sata-phy"
 
 "fsl,imx53-ahci", "fsl,imx6q-ahci" required properties:
 - clocks            : must contain the sata, sata_ref and ahb clocks
 - clock-names       : must contain "ahb" for the ahb clock
 
+Required properties when using sub-nodes:
+- #address-cells    : number of cells to encode an address
+- #size-cells       : number of cells representing the size of an address
+
+
+Sub-nodes required properties:
+- reg               : the port number
+- phys              : reference to the SATA PHY node
+
+
 Examples:
         sata at ffe08000 {
 		compatible = "snps,spear-ahci";
@@ -34,3 +51,22 @@ Examples:
 		clocks = <&pll6 0>, <&ahb_gates 25>;
 		target-supply = <&reg_ahci_5v>;
 	};
+
+With sub-nodes:
+	sata at f7e90000 {
+		compatible = "marvell,berlin-ahci";
+		reg = <0xe90000 0x1000>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
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
