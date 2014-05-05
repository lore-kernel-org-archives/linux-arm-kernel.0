From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 05 May 2014 14:00:38 +0200
Subject: [PATCH v2 8/8] ARM: dts: rockchip: convert pinctrl nodes to new
 bindings
In-Reply-To: <11862890.WUjscWaP3U@diego>
References: <11862890.WUjscWaP3U@diego>
Message-ID: <1719309.HLoKcrQoNG@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce the grf syscon and convert the pinctrl drivers for rk3066 and rk3188
to use it, instead of mapping the grf registers themselfs.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Max Schwarz <max.schwarz@online.de>
---
 arch/arm/boot/dts/rk3066a.dtsi | 2 +-
 arch/arm/boot/dts/rk3188.dtsi  | 9 ++++-----
 arch/arm/boot/dts/rk3xxx.dtsi  | 9 +++++++--
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index 4d4dfbb..048c5de 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -79,7 +79,7 @@
 
 		pinctrl at 20008000 {
 			compatible = "rockchip,rk3066a-pinctrl";
-			reg = <0x20008000 0x150>;
+			rockchip,grf = <&grf>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index ed9a70a..a494fb0 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -75,17 +75,16 @@
 
 		pinctrl at 20008000 {
 			compatible = "rockchip,rk3188-pinctrl";
-			reg = <0x20008000 0xa0>,
-			      <0x20008164 0x1a0>;
-			reg-names = "base", "pull";
+			rockchip,grf = <&grf>;
+			rockchip,pmu = <&pmu>;
+
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
 
 			gpio0: gpio0 at 0x2000a000 {
 				compatible = "rockchip,rk3188-gpio-bank0";
-				reg = <0x2000a000 0x100>,
-				      <0x20004064 0x8>;
+				reg = <0x2000a000 0x100>;
 				interrupts = <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk_gates8 9>;
 
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 26e5a96..2adf1cc9e 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -31,11 +31,16 @@
 			reg = <0x1013c000 0x100>;
 		};
 
-		pmu at 20004000 {
-			compatible = "rockchip,rk3066-pmu";
+		pmu: pmu at 20004000 {
+			compatible = "rockchip,rk3066-pmu", "syscon";
 			reg = <0x20004000 0x100>;
 		};
 
+		grf: grf at 20008000 {
+			compatible = "syscon";
+			reg = <0x20008000 0x200>;
+		};
+
 		gic: interrupt-controller at 1013d000 {
 			compatible = "arm,cortex-a9-gic";
 			interrupt-controller;
-- 
1.9.0
