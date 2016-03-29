From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Mon, 28 Mar 2016 20:37:05 -0700
Subject: [PATCH v2 9/9] ARM: dts: qcom: apq8064: Introduce wcnss remoteproc
In-Reply-To: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
Message-ID: <1459222625-11440-10-git-send-email-bjorn.andersson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v1:
- Added dts patches

 .../arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts |  4 ++
 arch/arm/boot/dts/qcom-apq8064.dtsi                | 57 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
index 06b3c76c3e41..276f529383e8 100644
--- a/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
+++ b/arch/arm/boot/dts/qcom-apq8064-sony-xperia-yuga.dts
@@ -432,5 +432,9 @@
 				pinctrl-0 = <&sdcc3_pin_a>, <&sdcc3_cd_pin_a>;
 			};
 		};
+
+		wcnss at 3204000 {
+			status = "okay";
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index ad7bc3c2aad1..2c213ce80acc 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -20,6 +20,11 @@
 			reg = <0x80000000 0x200000>;
 			no-map;
 		};
+
+		wcnss_mem: wcnss at 8f000000 {
+			reg = <0x8f000000 0x700000>;
+			no-map;
+		};
 	};
 
 	cpus {
@@ -231,6 +236,26 @@
 
 			pinctrl-names = "default";
 			pinctrl-0 = <&ps_hold>;
+
+			wcnss_pin_a: wcnss-pins-active {
+				fm {
+					pins = "gpio14", "gpio15";
+					function = "riva_fm";
+				};
+
+				bt {
+					pins = "gpio16", "gpio17";
+					function = "riva_bt";
+				};
+
+				wlan {
+					pins = "gpio64", "gpio65", "gpio66", "gpio67", "gpio68";
+					function = "riva_wlan";
+
+					drive-strength = <6>;
+					bias-pull-down;
+				};
+			};
 		};
 
 		sfpb_wrapper_mutex: syscon at 1200000 {
@@ -916,6 +941,38 @@
 			reset-names = "axi", "ahb", "por", "pci", "phy";
 			status = "disabled";
 		};
+
+		wcnss at 3204000 {
+			compatible = "qcom,riva-pil";
+			reg = <0x03204000 0x100>;
+
+			interrupts-extended = <&intc 0 199 IRQ_TYPE_EDGE_RISING>,
+					      <&wcnss_smsm 6 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal";
+
+			memory-region = <&wcnss_mem>;
+
+			vddcx-supply = <&pm8921_s3>;
+			vddmx-supply = <&pm8921_lvs7>;
+			vddpx-supply = <&pm8921_s4>;
+
+			pinctrl-names = "default";
+			pinctrl-0 = <&wcnss_pin_a>;
+
+			status = "disabled";
+
+			iris {
+				compatible = "qcom,wcn3660";
+
+				clocks = <&rpmcc 2>;
+				clock-names = "xo";
+
+				vddxo-supply = <&pm8921_l4>;
+				vddrfa-supply = <&pm8921_s2>;
+				vddpa-supply = <&pm8921_l10>;
+				vdddig-supply = <&pm8921_lvs2>;
+			};
+		};
 	};
 };
 #include "qcom-apq8064-pins.dtsi"
-- 
2.5.0
