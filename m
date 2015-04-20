From: ivan.ivanov@linaro.org (Ivan T. Ivanov)
Date: Mon, 20 Apr 2015 10:45:39 +0300
Subject: [PATCH v2 5/7] arm64: dts: qcom: Add 8x16 chipset SPMI PMIC's nodes
In-Reply-To: <1429515941-15334-1-git-send-email-ivan.ivanov@linaro.org>
References: <1429515941-15334-1-git-send-email-ivan.ivanov@linaro.org>
Message-ID: <1429515941-15334-6-git-send-email-ivan.ivanov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM9816 has 2 SPMI devices per physical package. Add PMIC configuration
nodes including sub-function device nodes and include them in boards,
which are using 8x16 based chipset.

PM9816 sub-function devices include:

* GPIO block, with 4 pins
* MPP block, with 4 pins
* Volatage ADC (VADC), with multiple inputs
* Thermal sensor device, which is using on chip VADC
  channel report PMIC die temperature.
* Power key device, which is responsible for clean system
  reboot or shutdown
* RTC device

Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi |  1 +
 arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi |  1 +
 arch/arm64/boot/dts/qcom/pm8916.dtsi      | 99 +++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8916.dtsi

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
index 703a4f1..58f0055f 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dtsi
@@ -12,6 +12,7 @@
  */

 #include "msm8916.dtsi"
+#include "pm8916.dtsi"

 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
index bea871b..a1aa0b2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-mtp.dtsi
@@ -12,6 +12,7 @@
  */

 #include "msm8916.dtsi"
+#include "pm8916.dtsi"

 / {
 	aliases {
diff --git a/arch/arm64/boot/dts/qcom/pm8916.dtsi b/arch/arm64/boot/dts/qcom/pm8916.dtsi
new file mode 100644
index 0000000..b222ece
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8916.dtsi
@@ -0,0 +1,99 @@
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+
+	usid0: pm8916 at 0 {
+		compatible = "qcom,spmi-pmic";
+		reg = <0x0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc at 6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000 0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pwrkey at 800 {
+			compatible = "qcom,pm8941-pwrkey";
+			reg = <0x800>;
+			interrupts = <0x0 0x8 0 IRQ_TYPE_EDGE_BOTH>;
+			debounce = <15625>;
+			bias-pull-up;
+		};
+
+		pm8916_gpios: gpios at c000 {
+			compatible = "qcom,pm8916-gpio";
+			reg = <0xc000 0x400>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xc0 0 IRQ_TYPE_NONE>,
+				     <0 0xc1 0 IRQ_TYPE_NONE>,
+				     <0 0xc2 0 IRQ_TYPE_NONE>,
+				     <0 0xc3 0 IRQ_TYPE_NONE>;
+		};
+
+		pm8916_mpps: mpps at a000 {
+			compatible = "qcom,pm8916-mpp";
+			reg = <0xa000 0x400>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupts = <0 0xa0 0 IRQ_TYPE_NONE>,
+				     <0 0xa1 0 IRQ_TYPE_NONE>,
+				     <0 0xa2 0 IRQ_TYPE_NONE>,
+				     <0 0xa3 0 IRQ_TYPE_NONE>;
+		};
+
+		pm8916_temp: temp-alarm at 2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400 0x100>;
+			interrupts = <0 0x24 0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm8916_vadc VADC_DIE_TEMP>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8916_vadc: vadc at 3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100 0x100>;
+			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			usb_in {
+				reg = <VADC_USBIN>;
+				qcom,pre-scaling = <1 10>;
+			};
+			vph_pwr {
+				reg = <VADC_VSYS>;
+				qcom,pre-scaling = <1 3>;
+			};
+			die_temp {
+				reg = <VADC_DIE_TEMP>;
+			};
+			ref_625mv {
+				reg = <VADC_REF_625MV>;
+			};
+			ref_1250v {
+				reg = <VADC_REF_1250MV>;
+			};
+			ref_gnd {
+				reg = <VADC_GND_REF>;
+			};
+			ref_vdd {
+				reg = <VADC_VDD_VADC>;
+			};
+		};
+	};
+
+	usid1: pm8916 at 1 {
+		compatible = "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
--
1.9.1
