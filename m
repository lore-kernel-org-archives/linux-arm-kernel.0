From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Sat, 28 Jul 2012 14:58:42 +0800
Subject: [PATCH 6/6] ARM: dts: add pinctrl in PXA DT files
In-Reply-To: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1343458722-17127-7-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 .../bindings/pinctrl/mrvl,pxa3xx-pinctrl.txt       |   35 ++++++++++++++
 arch/arm/boot/dts/mmp2-brownstone.dts              |   51 ++++++++++++++++++++
 arch/arm/boot/dts/mmp2.dtsi                        |    5 ++
 arch/arm/boot/dts/pxa168.dtsi                      |    5 ++
 arch/arm/boot/dts/pxa910-dkb.dts                   |   47 ++++++++++++++++++
 arch/arm/boot/dts/pxa910.dtsi                      |    5 ++
 6 files changed, 148 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/mrvl,pxa3xx-pinctrl.txt

diff --git a/Documentation/devicetree/bindings/pinctrl/mrvl,pxa3xx-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/mrvl,pxa3xx-pinctrl.txt
new file mode 100644
index 0000000..1f516e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pinctrl/mrvl,pxa3xx-pinctrl.txt
@@ -0,0 +1,35 @@
+Marvell Technology Group, PXA3XX pinmux controller
+
+Required properties:
+- compatible	: "marvell,pxa910-pinmux"
+		: "marvell,pxa168-pinmux"
+		: "marvell,mmp2-pinmux"
+- reg		: Address range of the pinctrl registers
+
+PXA3xx's pinmux nodes act as a container for an abitrary number of subnodes.
+Each of these subnodes represents muxing for a pin, a group, or a list of
+pins or groups.
+
+The name of each subnode is not important; all subnodes should be enumerated
+and processed purely based on their content.
+
+Required subnode-properties:
+- marvell,pins	: An array of strings. Each string contains the name of a pin
+		  or group.
+- marvell,function	: A string containing the name of the function to mux to the
+		  pin or group.
+- marvell,drive-strength : An integer value that means the drive strength of a
+                        pin.
+- marvell,pull-up	: The property means a pin is pull up for input.
+- marvell,pull-down : The property means a pin is pull down for input.
+- marvell,lowpower-pull-up : The property means a pin is pull up for input in
+			  sleep state.
+- marvell,lowpower-pull-down : The property means a pin is pull down for input
+			    in sleep state.
+- marvell,lowpower-drive-high : The property means a pin is driving high for
+			     output in sleep state.
+- marvell,lowpower-drive-low : The property means a pin is driving low for
+			    output in sleep state.
+- marvell,lowpower-float : The property means a pin is float in sleep state.
+- marvell,lowpower-zero : The property means a pin is not configured in sleep
+			state.
diff --git a/arch/arm/boot/dts/mmp2-brownstone.dts b/arch/arm/boot/dts/mmp2-brownstone.dts
index c9b4f27..2ae37df 100644
--- a/arch/arm/boot/dts/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/mmp2-brownstone.dts
@@ -24,6 +24,57 @@
 
 	soc {
 		apb at d4000000 {
+			pinmux at d401e000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&state_default>;
+
+				state_default: pinmux {
+					uart1 {
+						marvell,pins = "uart1 2p4";
+						marvell,function = "uart1";
+					};
+					uart2 {
+						marvell,pins = "uart2 2p7";
+						marvell,function = "uart2";
+					};
+					uart3 {
+						marvell,pins = "uart3 2p6";
+						marvell,function = "uart3";
+					};
+					twsi2 {
+						marvell,pins = "twsi2-3";
+						marvell,function = "twsi2";
+					};
+					twsi3 {
+						marvell,pins = "twsi3-1";
+						marvell,function = "twsi3";
+					};
+					twsi4 {
+						marvell,pins = "twsi4";
+						marvell,function = "twsi4";
+					};
+					twsi5 {
+						marvell,pins = "twsi5-3";
+						marvell,function = "twsi5";
+					};
+					twsi6 {
+						marvell,pins = "twsi6-3";
+						marvell,function = "twsi6";
+					};
+					mmc1 {
+						marvell,pins = "mmc1 8p1";
+						marvell,function = "mmc1";
+					};
+					mmc2 {
+						marvell,pins = "mmc2 6p1";
+						marvell,function = "mmc2";
+					};
+					mmc3 {
+						marvell,pins = "mmc3 10p1";
+						marvell,function = "mmc3";
+					};
+				};
+			};
 			uart3: uart at d4018000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/mmp2.dtsi b/arch/arm/boot/dts/mmp2.dtsi
index 80f74e2..cb4ecaf 100644
--- a/arch/arm/boot/dts/mmp2.dtsi
+++ b/arch/arm/boot/dts/mmp2.dtsi
@@ -120,6 +120,11 @@
 			reg = <0xd4000000 0x00200000>;
 			ranges;
 
+			pinmux at d401e000 {
+				compatible = "marvell,mmp2-pinmux";
+				reg = <0xd401e000 0x4000>;
+			};
+
 			timer0: timer at d4014000 {
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4014000 0x100>;
diff --git a/arch/arm/boot/dts/pxa168.dtsi b/arch/arm/boot/dts/pxa168.dtsi
index 31a7186..f15491d 100644
--- a/arch/arm/boot/dts/pxa168.dtsi
+++ b/arch/arm/boot/dts/pxa168.dtsi
@@ -49,6 +49,11 @@
 			reg = <0xd4000000 0x00200000>;
 			ranges;
 
+			pinmux at d401e000 {
+				compatible = "marvell,pxa168-pinmux";
+				reg = <0xd401e000 0x4000>;
+			};
+
 			timer0: timer at d4014000 {
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4014000 0x100>;
diff --git a/arch/arm/boot/dts/pxa910-dkb.dts b/arch/arm/boot/dts/pxa910-dkb.dts
index e92be5a..d3ba948 100644
--- a/arch/arm/boot/dts/pxa910-dkb.dts
+++ b/arch/arm/boot/dts/pxa910-dkb.dts
@@ -24,6 +24,53 @@
 
 	soc {
 		apb at d4000000 {
+			pinmux at d401e000 {
+				pinctrl-names = "default";
+				pinctrl-0 = <&state_default>;
+
+				state_default: pinmux {
+					uart0 { /* BT UART */
+						marvell,pins = "uart0 4p";
+						marvell,function = "uart0";
+					};
+					uart1 {	/* Serial UART */
+						marvell,pins = "uart1 2p1";
+						marvell,function = "uart1";
+					};
+					uart2 { /* GPS UART */
+						marvell,pins = "uart2 2p1";
+						marvell,function = "uart2";
+					};
+					nand {
+						marvell,pins = "nand";
+						marvell,function = "nand";
+					};
+					twsi1 {
+						marvell,pins = "twsi 2p2";
+						marvell,function = "twsi";
+					};
+					mmc1 {
+						marvell,pins = "mmc1 12p";
+						marvell,function = "mmc1";
+					};
+					mmc2 {
+						marvell,pins = "mmc2 6p";
+						marvell,function = "mmc2";
+					};
+					w1 {
+						marvell,pins = "w1-4";
+						marvell,function = "w1";
+					};
+					ssp1 {
+						marvell,pins = "ssp1 4p1";
+						marvell,function = "ssp1";
+					};
+					gssp {
+						marvell,pins = "gssp";
+						marvell,function = "gssp";
+					};
+				};
+			};
 			uart1: uart at d4017000 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/pxa910.dtsi b/arch/arm/boot/dts/pxa910.dtsi
index aebf32d..187041d 100644
--- a/arch/arm/boot/dts/pxa910.dtsi
+++ b/arch/arm/boot/dts/pxa910.dtsi
@@ -49,6 +49,11 @@
 			reg = <0xd4000000 0x00200000>;
 			ranges;
 
+			pinmux at d401e000 {
+				compatible = "marvell,pxa910-pinmux";
+				reg = <0xd401e000 0x4000>;
+			};
+
 			timer0: timer at d4014000 {
 				compatible = "mrvl,mmp-timer";
 				reg = <0xd4014000 0x100>;
-- 
1.7.9.5
