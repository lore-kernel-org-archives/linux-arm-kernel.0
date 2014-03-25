From: dinguyen@altera.com (dinguyen at altera.com)
Date: Tue, 25 Mar 2014 18:34:42 -0500
Subject: [PATCH 3/3] dts: documentation: Update documentation for the stmmac
 ethernet controller
In-Reply-To: <1395790482-3957-1-git-send-email-dinguyen@altera.com>
References: <1395790482-3957-1-git-send-email-dinguyen@altera.com>
Message-ID: <1395790482-3957-4-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

* Add optional clocks and clock-names property into the base stmmac document.
* Update socfpga-dwmac.txt with new compatible string and example binding.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
---
 .../devicetree/bindings/net/socfpga-dwmac.txt      |   38 ++++++++------------
 Documentation/devicetree/bindings/net/stmmac.txt   |    6 ++++
 2 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
index d53d376..1ef6db7 100644
--- a/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
+++ b/Documentation/devicetree/bindings/net/socfpga-dwmac.txt
@@ -1,35 +1,27 @@
 Altera SOCFPGA SoC DWMAC controller
 
-The device node has following properties.
+This is a variant of the dwmac/stmmac driver an inherits all descriptions
+present in Documentation/devicetree/bindings/net/stmmac.txt.
+
+The device node has additional properties:
 
 Required properties:
- - compatible	: Should contain "altr,socfpga-stmmac"
+ - compatible	: Should contain "altr,socfpga-stmmac" along with
+		  "snps,dwmac" and any applicable more detailed
+		  designware version numbers documented in stmmac.txt
  - altr,sysmgr-syscon : Should be the phandle to the system manager node that
    encompasses the glue register, and the register offset.
 
-Sub-nodes:
-The dwmac core should be added as subnode to SOCFPGA dwmac glue.
-- dwmac :	The binding details of dwmac can be found in
-  Documentation/devicetree/bindings/net/stmmac.txt
-
 Example:
 
-ethernet0: ethernet0 {
-	#address-cells = <1>;
-	#size-cells = <1>;
-
-	compatible = "altr,socfpga-stmmac";
+gmac0: ethernet at ff700000 {
+	compatible = "altr,socfpga-stmmac", "snps,dwmac-3.70a", "snps,dwmac";
 	altr,sysmgr-syscon = <&sysmgr 0x60>;
 	status = "disabled";
-	ranges;
-
-	gmac0: gmac0 at ff700000 {
-		compatible = "snps,dwmac-3.70a", "snps,dwmac";
-		reg = <0xff700000 0x2000>;
-		interrupts = <0 115 4>;
-		interrupt-names = "macirq";
-		mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
-		clocks = <&emac0_clk>;
-		clock-names = "stmmaceth";
-	};
+	reg = <0xff700000 0x2000>;
+	interrupts = <0 115 4>;
+	interrupt-names = "macirq";
+	mac-address = [00 00 00 00 00 00];/* Filled in by U-Boot */
+	clocks = <&emac0_clk>;
+	clocks-names = "stmmaceth";
 };
diff --git a/Documentation/devicetree/bindings/net/stmmac.txt b/Documentation/devicetree/bindings/net/stmmac.txt
index 9d92d42..9a0c1b7 100644
--- a/Documentation/devicetree/bindings/net/stmmac.txt
+++ b/Documentation/devicetree/bindings/net/stmmac.txt
@@ -34,6 +34,10 @@ Optional properties:
 	reset phandle is given
 - max-frame-size:	Maximum Transfer Unit (IEEE defined MTU), rather
 			than the maximum frame size.
+- clocks: If present, the first clock should be the GMAC main clock,
+  further clocks may be specified in derived bindings.
+- clocks-names: One name for each entry in the clocks property, the
+  first one should be "stmmaceth".
 
 Examples:
 
@@ -46,4 +50,6 @@ Examples:
 		mac-address = [000000000000]; /* Filled in by U-Boot */
 		max-frame-size = <3800>;
 		phy-mode = "gmii";
+		clocks = <&clock>;
+		clock-names = "stmmaceth">;
 	};
-- 
1.7.9.5
