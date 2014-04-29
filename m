From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 30 Apr 2014 00:10:20 +0200
Subject: [PATCH 7/8] dt-bindings: adapt rockchip-pinctrl doc to changed
 bindings
In-Reply-To: <1414506.B4e2jZujVm@diego>
References: <1414506.B4e2jZujVm@diego>
Message-ID: <1818696.uDrb10uCpI@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce the syscons for grf and pmu and deprecate the previous register
areas.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 .../bindings/pinctrl/rockchip,pinctrl.txt          | 28 +++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
index 78dafc9..cefef74 100644
--- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.txt
@@ -21,15 +21,23 @@ defined as gpio sub-nodes of the pinmux controller.
 Required properties for iomux controller:
   - compatible: one of "rockchip,rk2928-pinctrl", "rockchip,rk3066a-pinctrl"
 		       "rockchip,rk3066b-pinctrl", "rockchip,rk3188-pinctrl"
+  - rockchip,grf: phandle referencing a syscon providing the
+	 "general register files"
+
+Optional properties for iomux controller:
+  - rockchip,pmu: phandle referencing a syscon providing the pmu registers
+	 as some SoCs carry parts of the iomux controller registers there.
+	 Required for at least rk3188 and rk3288.
+
+Deprecated properties for iomux controller:
   - reg: first element is the general register space of the iomux controller
 	 It should be large enough to contain also separate pull registers.
-	 Deprecated:
-	 second element is the separate pull register space of the rk3188
+	 second element is the separate pull register space of the rk3188.
+	 Use rockchip,grf and rockchip,pmu described above instead.
 
 Required properties for gpio sub nodes:
   - compatible: "rockchip,gpio-bank", "rockchip,rk3188-gpio-bank0"
   - reg: register of the gpio bank (different than the iomux registerset)
-         second element: separate pull register for rk3188 bank0
   - interrupts: base interrupt of the gpio bank in the interrupt controller
   - clocks: clock that drives this bank
   - gpio-controller: identifies the node as a gpio controller and pin bank.
@@ -41,6 +49,10 @@ Required properties for gpio sub nodes:
     cells should use the standard two-cell scheme described in
     bindings/interrupt-controller/interrupts.txt
 
+Deprecated properties for gpio sub nodes:
+  - reg: second element: separate pull register for rk3188 bank0, use
+	 rockchip,pmu described above instead
+
 Required properties for pin configuration node:
   - rockchip,pins: 3 integers array, represents a group of pins mux and config
     setting. The format is rockchip,pins = <PIN_BANK PIN_BANK_IDX MUX &phandle>.
@@ -56,7 +68,8 @@ Examples:
 
 pinctrl at 20008000 {
 	compatible = "rockchip,rk3066a-pinctrl";
-	reg = <0x20008000 0x150>;
+	rockchip,grf = <&grf>;
+
 	#address-cells = <1>;
 	#size-cells = <1>;
 	ranges;
@@ -105,16 +118,15 @@ Example for rk3188:
 
 	pinctrl at 20008000 {
 		compatible = "rockchip,rk3188-pinctrl";
-		reg = <0x20008000 0xa0>,
-		      <0x20008164 0x1a0>;
+		rockchip,grf = <&grf>;
+		rockchip,pmu = <&pmu>;
 		#address-cells = <1>;
 		#size-cells = <1>;
 		ranges;
 
 		gpio0: gpio0 at 0x2000a000 {
 			compatible = "rockchip,rk3188-gpio-bank0";
-			reg = <0x2000a000 0x100>,
-			      <0x20004064 0x8>;
+			reg = <0x2000a000 0x100>;
 			interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clk_gates8 9>;
 
-- 
1.9.0
