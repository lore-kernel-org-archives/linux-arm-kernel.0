From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 26 Jan 2017 16:47:28 -0800
Subject: [PATCH 5/5] arm64: dts: qcom: Collapse usb support into one node
In-Reply-To: <20170127004728.22490-1-stephen.boyd@linaro.org>
References: <20170127004728.22490-1-stephen.boyd@linaro.org>
Message-ID: <20170127004728.22490-6-stephen.boyd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We currently have three device nodes for the same USB hardware
block, as evident by the reuse of the same reg address multiple
times. Now that the chipidea driver fully supports OTG with the
MSM wrapper we can collapse all these nodes into one USB device
node, reflecting the true nature of the hardware.

Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi | 34 +++++++++--------
 arch/arm64/boot/dts/qcom/msm8916.dtsi     | 62 +++++++++++++++----------------
 2 files changed, 47 insertions(+), 49 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 08bd5ebafb4e..a9506619dfff 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -201,22 +201,16 @@
 		usb at 78d9000 {
 			extcon = <&usb_id>, <&usb_id>;
 			status = "okay";
-		};
-
-		ehci at 78d9000 {
-			status = "okay";
-		};
-
-		phy at 78d9000 {
-			v1p8-supply = <&pm8916_l7>;
-			v3p3-supply = <&pm8916_l13>;
-			vddcx-supply = <&pm8916_s1>;
-			extcon = <&usb_id>, <&usb_id>;
-			dr_mode = "otg";
-			status = "okay";
-			switch-gpio = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>;
-			pinctrl-names = "default";
-			pinctrl-0 = <&usb_sw_sel_pm>;
+			adp-disable;
+			hnp-disable;
+			srp-disable;
+			ulpi {
+				phy {
+					v1p8-supply = <&pm8916_l7>;
+					v3p3-supply = <&pm8916_l13>;
+					extcon = <&usb_id>;
+				};
+			};
 		};
 
 		lpass at 07708000 {
@@ -321,6 +315,14 @@
 		pinctrl-0 = <&usb_id_default>;
 	};
 
+	usb-switch {
+		compatible = "toshiba,tc7usb40mu";
+		switch-gpios = <&pm8916_gpios 4 GPIO_ACTIVE_HIGH>;
+		extcon = <&usb_id>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb_sw_sel_pm>;
+	};
+
 	hdmi-out {
 		compatible = "hdmi-connector";
 		type = "a";
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index f8ff327667c5..5066fb23ed98 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -545,44 +545,40 @@
 			status = "disabled";
 		};
 
-		usb_dev: usb at 78d9000 {
+		otg: usb at 78d9000 {
 			compatible = "qcom,ci-hdrc";
-			reg = <0x78d9000 0x400>;
-			dr_mode = "peripheral";
-			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
-			usb-phy = <&usb_otg>;
-			status = "disabled";
-		};
-
-		usb_host: ehci at 78d9000 {
-			compatible = "qcom,ehci-host";
-			reg = <0x78d9000 0x400>;
-			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>;
-			usb-phy = <&usb_otg>;
-			status = "disabled";
-		};
-
-		usb_otg: phy at 78d9000 {
-			compatible = "qcom,usb-otg-snps";
-			reg = <0x78d9000 0x400>;
+			reg = <0x78d9000 0x200>,
+			      <0x78d9200 0x200>;
 			interrupts = <GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
-
-			qcom,vdd-levels = <500000 1000000 1320000>;
-			qcom,phy-init-sequence = <0x44 0x6B 0x24 0x13>;
-			dr_mode = "peripheral";
-			qcom,otg-control = <2>; // PMIC
-			qcom,manual-pullup;
-
 			clocks = <&gcc GCC_USB_HS_AHB_CLK>,
-				 <&gcc GCC_USB_HS_SYSTEM_CLK>,
-				 <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
-			clock-names = "iface", "core", "sleep";
-
-			resets = <&gcc GCC_USB2A_PHY_BCR>,
-				 <&gcc GCC_USB_HS_BCR>;
-			reset-names = "phy", "link";
+				 <&gcc GCC_USB_HS_SYSTEM_CLK>;
+			clock-names = "iface", "core";
+			assigned-clocks = <&gcc GCC_USB_HS_SYSTEM_CLK>;
+			assigned-clock-rates = <80000000>;
+			resets = <&gcc GCC_USB_HS_BCR>;
+			reset-names = "core";
+			phy_type = "ulpi";
+			dr_mode = "otg";
+			ahb-burst-config = <0>;
+			phy-names = "usb-phy";
+			phys = <&usb_hs_phy>;
 			status = "disabled";
+			#reset-cells = <1>;
+
+			ulpi {
+				usb_hs_phy: phy {
+					compatible = "qcom,usb-hs-phy-msm8916",
+						     "qcom,usb-hs-phy";
+					#phy-cells = <0>;
+					clocks = <&xo_board>, <&gcc GCC_USB2A_PHY_SLEEP_CLK>;
+					clock-names = "ref", "sleep";
+					resets = <&gcc GCC_USB2A_PHY_BCR>, <&otg 0>;
+					reset-names = "phy", "por";
+					qcom,init-seq = /bits/ 8 <0x0 0x44
+						0x1 0x6b 0x2 0x24 0x3 0x13>;
+				};
+			};
 		};
 
 		intc: interrupt-controller at b000000 {
-- 
2.10.0.297.gf6727b0
