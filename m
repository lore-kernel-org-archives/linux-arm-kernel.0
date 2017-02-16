From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 16 Feb 2017 21:50:36 +1300
Subject: [PATCH v3 2/6] ARM: dts: armada-xp-98dx3236: combine dfx server nodes
In-Reply-To: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
References: <20170216085041.28337-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20170216085041.28337-3-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than having a separate node for the dfx server add a reg property
to the parent node. This give some compatibility with the Marvell
supplied SDK.

As no upstream driver currently exists for this block and support for
this SoC is still quite fresh in the kernel it should not be necessary
to retain a backwards compatible binding.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v2:
    - none
    Changes in v3:
    - update commit message to indicate backwards incompatible change and
      why it's OK
    - retain dfx-server compatible string

 Documentation/devicetree/bindings/net/marvell,prestera.txt | 13 +++++--------
 arch/arm/boot/dts/armada-xp-98dx3236.dtsi                  | 10 +++-------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/marvell,prestera.txt b/Documentation/devicetree/bindings/net/marvell,prestera.txt
index 5fbab29718e8..c329608fa887 100644
--- a/Documentation/devicetree/bindings/net/marvell,prestera.txt
+++ b/Documentation/devicetree/bindings/net/marvell,prestera.txt
@@ -32,19 +32,16 @@ DFX Server bindings
 -------------------
 
 Required properties:
-- compatible: must be "marvell,dfx-server"
+- compatible: must be "marvell,dfx-server", "simple-bus"
+- ranges: describes the address mapping of a memory-mapped bus.
 - reg: address and length of the register set for the device.
 
 Example:
 
-dfx-registers {
-	compatible = "simple-bus";
+dfx-server {
+	compatible = "marvell,dfx-server", "simple-bus";
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges = <0 MBUS_ID(0x08, 0x00) 0 0x100000>;
-
-	dfx: dfx at 0 {
-		compatible = "marvell,dfx-server";
-		reg = <0 0x100000>;
-	};
+	reg = <MBUS_ID(0x08, 0x00) 0 0x100000>;
 };
diff --git a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
index f6a03dcee5ef..7eaa7da84770 100644
--- a/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
+++ b/arch/arm/boot/dts/armada-xp-98dx3236.dtsi
@@ -195,11 +195,12 @@
 			};
 		};
 
-		dfxr: dfx-registers at ac000000 {
-			compatible = "simple-bus";
+		dfx: dfx-server at ac000000 {
+			compatible = "marvell,dfx-server", "simple-bus";
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges = <0 MBUS_ID(0x08, 0x00) 0 0x100000>;
+			reg = <MBUS_ID(0x08, 0x00) 0 0x100000>;
 
 			dfx_coredivclk: corediv-clock at f8268 {
 				compatible = "marvell,mv98dx3236-corediv-clock";
@@ -208,11 +209,6 @@
 				clocks = <&mainpll>;
 				clock-output-names = "nand";
 			};
-
-			dfx: dfx at 0 {
-				compatible = "marvell,dfx-server";
-				reg = <0 0x100000>;
-			};
 		};
 
 		switch: switch at a8000000 {
-- 
2.11.0.24.ge6920cf
