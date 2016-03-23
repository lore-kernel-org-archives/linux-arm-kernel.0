From: mmcclint@codeaurora.org (Matthew McClintock)
Date: Wed, 23 Mar 2016 17:05:07 -0500
Subject: [PATCH 12/17] qcom: ipq4019: add spi node to ipq4019 SoC and DK01
 device tree
In-Reply-To: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
References: <1458770712-10880-1-git-send-email-mmcclint@codeaurora.org>
Message-ID: <1458770712-10880-13-git-send-email-mmcclint@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will allow boards to enable the SPI bus

Signed-off-by: Matthew McClintock <mmcclint@codeaurora.org>
---
 arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi | 37 +++++++++++++++++++++++++++
 arch/arm/boot/dts/qcom-ipq4019.dtsi           | 18 +++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
index 223da1a..21032a8 100644
--- a/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019-ap.dk01.1.dtsi
@@ -48,6 +48,43 @@
 					bias-disable;
 				};
 			};
+
+			spi_0_pins: spi_0_pinmux {
+				pinmux {
+					function = "blsp_spi0";
+					pins = "gpio55", "gpio56", "gpio57";
+				};
+				pinmux_cs {
+					function = "gpio";
+					pins = "gpio54";
+				};
+				pinconf {
+					pins = "gpio55", "gpio56", "gpio57";
+					drive-strength = <12>;
+					bias-disable;
+				};
+				pinconf_cs {
+					pins = "gpio54";
+					drive-strength = <2>;
+					bias-disable;
+					output-high;
+				};
+			};
+		};
+
+		spi_0: spi at 78b5000 {
+			pinctrl-0 = <&spi_0_pins>;
+			pinctrl-names = "default";
+			status = "ok";
+			cs-gpios = <&tlmm 54 0>;
+
+			mx25l25635e at 0 {
+				#address-cells = <1>;
+				#size-cells = <1>;
+				reg = <0>;
+				compatible = "mx25l25635e";
+				spi-max-frequency = <24000000>;
+			};
 		};
 
 		serial at 78af000 {
diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index acb851d..99e64f4 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -15,12 +15,18 @@
 
 #include "skeleton.dtsi"
 #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
 
 / {
 	model = "Qualcomm Technologies, Inc. IPQ4019";
 	compatible = "qcom,ipq4019";
 	interrupt-parent = <&intc>;
 
+	aliases {
+		spi0 = &spi_0;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -108,6 +114,18 @@
 			interrupts = <0 208 0>;
 		};
 
+		spi_0: spi at 78b5000 {
+			compatible = "qcom,spi-qup-v2.2.1";
+			reg = <0x78b5000 0x600>;
+			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
+				 <&gcc GCC_BLSP1_AHB_CLK>;
+			clock-names = "core", "iface";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
+
                 acc0: clock-controller at b088000 {
                         compatible = "qcom,kpss-acc-v1";
                         reg = <0x0b088000 0x1000>, <0xb008000 0x1000>;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
