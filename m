From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 25 Feb 2014 12:47:42 +0100
Subject: [PATCH v8 4/6] ARM: rockchip: add sram dt nodes and documentation
In-Reply-To: <21117503.1c6iOkvYSr@phil>
References: <21117503.1c6iOkvYSr@phil>
Message-ID: <4021819.DsUjhG2Ihi@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dt-nodes for the sram on rk3066 and rk3188 including the reserved section
needed for smp bringup.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Ulrich Prinz <ulrich.prinz@googlemail.com>
---
 .../devicetree/bindings/arm/rockchip/smp-sram.txt  | 30 ++++++++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi                     | 13 ++++++++++
 arch/arm/boot/dts/rk3188.dtsi                      | 13 ++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt

diff --git a/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt b/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
new file mode 100644
index 0000000..d9416fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/rockchip/smp-sram.txt
@@ -0,0 +1,30 @@
+Rockchip SRAM for smp bringup:
+------------------------------
+
+Rockchip's smp-capable SoCs use the first part of the sram for the bringup
+of the cores. Once the core gets powered up it executes the code that is
+residing at the very beginning of the sram.
+
+Therefore a reserved section sub-node has to be added to the mmio-sram
+declaration.
+
+Required sub-node properties:
+- compatible : should be "rockchip,rk3066-smp-sram"
+
+The rest of the properties should follow the generic mmio-sram discription
+found in ../../misc/sram.txt
+
+Example:
+
+	sram: sram at 10080000 {
+		compatible = "mmio-sram";
+		reg = <0x10080000 0x10000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		smp-sram at 10080000 {
+			compatible = "rockchip,rk3066-smp-sram";
+			reg = <0x10080000 0x50>;
+		};
+	};
diff --git a/arch/arm/boot/dts/rk3066a.dtsi b/arch/arm/boot/dts/rk3066a.dtsi
index be5d2b0..37d0768 100644
--- a/arch/arm/boot/dts/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rk3066a.dtsi
@@ -64,6 +64,19 @@
 			clock-names = "timer", "pclk";
 		};
 
+		sram: sram at 10080000 {
+			compatible = "mmio-sram";
+			reg = <0x10080000 0x10000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			smp-sram at 10080000 {
+				compatible = "rockchip,rk3066-smp-sram";
+				reg = <0x10080000 0x50>;
+			};
+		};
+
 		pinctrl at 20008000 {
 			compatible = "rockchip,rk3066a-pinctrl";
 			reg = <0x20008000 0x150>;
diff --git a/arch/arm/boot/dts/rk3188.dtsi b/arch/arm/boot/dts/rk3188.dtsi
index 1a26b03..412f4d0 100644
--- a/arch/arm/boot/dts/rk3188.dtsi
+++ b/arch/arm/boot/dts/rk3188.dtsi
@@ -60,6 +60,19 @@
 			interrupts = <GIC_PPI 13 0xf04>;
 		};
 
+		sram: sram at 10080000 {
+			compatible = "mmio-sram";
+			reg = <0x10080000 0x8000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges;
+
+			smp-sram at 10080000 {
+				compatible = "rockchip,rk3066-smp-sram";
+				reg = <0x10080000 0x50>;
+			};
+		};
+
 		pinctrl at 20008000 {
 			compatible = "rockchip,rk3188-pinctrl";
 			reg = <0x20008000 0xa0>,
-- 
1.8.5.3
