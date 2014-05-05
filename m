From: gabriel.fernandez@st.com (Gabriel FERNANDEZ)
Date: Mon,  5 May 2014 17:38:37 +0200
Subject: [PATCH 1/4] ARM: STi: DT: add keyscan for stih415
In-Reply-To: <1399304320-18197-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1399304320-18197-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1399304320-18197-2-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add keyscan support for stih415.
It is put disabled by default because it is not enabled on all boards
Also there are PIOs conflict with already claimed lines.

Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih415-pinctrl.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/stih415.dtsi         | 12 ++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/stih415-pinctrl.dtsi b/arch/arm/boot/dts/stih415-pinctrl.dtsi
index 81df870..8509a03 100644
--- a/arch/arm/boot/dts/stih415-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih415-pinctrl.dtsi
@@ -102,6 +102,22 @@
 				};
 			};
 
+			keyscan {
+				pinctrl_keyscan: keyscan {
+					st,pins {
+						keyin0 = <&PIO0 2 ALT2 IN>;
+						keyin1 = <&PIO0 3 ALT2 IN>;
+						keyin2 = <&PIO0 4 ALT2 IN>;
+						keyin3 = <&PIO2 6 ALT2 IN>;
+
+						keyout0 = <&PIO1 6 ALT2 OUT>;
+						keyout1 = <&PIO1 7 ALT2 OUT>;
+						keyout2 = <&PIO0 6 ALT2 OUT>;
+						keyout3 = <&PIO2 7 ALT2 OUT>;
+					};
+				};
+			};
+
 			sbc_i2c0 {
 				pinctrl_sbc_i2c0_default: sbc_i2c0-default {
 					st,pins {
diff --git a/arch/arm/boot/dts/stih415.dtsi b/arch/arm/boot/dts/stih415.dtsi
index d89064c..ba0905c 100644
--- a/arch/arm/boot/dts/stih415.dtsi
+++ b/arch/arm/boot/dts/stih415.dtsi
@@ -206,5 +206,17 @@
 			pinctrl-0	= <&pinctrl_ir>;
 			resets		= <&softreset STIH415_IRB_SOFTRESET>;
 		};
+
+		keyscan: keyscan at fe4b0000 {
+			compatible = "st,sti-keyscan";
+			status = "disabled";
+			reg = <0xfe4b0000 0x2000>;
+			interrupts = <GIC_SPI 212 IRQ_TYPE_NONE>;
+			clocks = <&CLK_SYSIN>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_keyscan>;
+			resets	= <&powerdown STIH415_KEYSCAN_POWERDOWN>,
+				  <&softreset STIH415_KEYSCAN_SOFTRESET>;
+		};
 	};
 };
-- 
1.9.1
