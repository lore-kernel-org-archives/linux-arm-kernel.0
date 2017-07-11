From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Tue, 11 Jul 2017 18:13:10 +0200
Subject: [PATCH 2/2] ARM: dts: stm32: enable ADC on stm32h743i-eval board
In-Reply-To: <1499789590-13021-1-git-send-email-fabrice.gasnier@st.com>
References: <1499789590-13021-1-git-send-email-fabrice.gasnier@st.com>
Message-ID: <1499789590-13021-3-git-send-email-fabrice.gasnier@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a potentiometer connected to ADC1 and ADC2 in0 on
stm32h743i-eval board.
- Add fixed-voltage 'vdda' regulator that supplies 'vref' pin.
  It's used as voltage reference for ADC and/or DAC.
- Enable ADC1 in0 input (arbitrary choice: could be ADC2 as well).
Note: No pinctrl is needed to use in0 dedicated analog input pin
(e.g. ADC12_INP0).

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 arch/arm/boot/dts/stm32h743i-eval.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/stm32h743i-eval.dts b/arch/arm/boot/dts/stm32h743i-eval.dts
index c6effbb..6c07786 100644
--- a/arch/arm/boot/dts/stm32h743i-eval.dts
+++ b/arch/arm/boot/dts/stm32h743i-eval.dts
@@ -60,6 +60,24 @@
 	aliases {
 		serial0 = &usart1;
 	};
+
+	vdda: regulator-vdda {
+		compatible = "regulator-fixed";
+		regulator-name = "vdda";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+};
+
+&adc_12 {
+	vref-supply = <&vdda>;
+	status = "okay";
+	adc1: adc at 0 {
+		/* potentiometer */
+		st,adc-channels = <0>;
+		status = "okay";
+	};
 };
 
 &clk_hse {
-- 
1.9.1
