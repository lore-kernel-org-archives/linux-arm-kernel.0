From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 11 Jan 2017 18:43:34 +0100
Subject: [PATCH 4/4] ARM64: dts: meson: meson-gx: add the SAR ADC
In-Reply-To: <20170111174334.24343-1-martin.blumenstingl@googlemail.com>
References: <20170111174334.24343-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170111174334.24343-5-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SAR ADC to meson-gxbb.dtsi and meson-gxl.dtsi. GXBB provides a
10-bit ADC while GXL (and GXM, which uses the same ADC as GXL) provides
a 12-bit ADC.
Some boards use resistor ladder buttons connected through one of the ADC
channels. On newer devices (GXL and GXM) some boards use pull-ups/downs
to change the resistance (and thus the ADC value) on of the ADC channels
to indicate the board revision.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   |  8 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 10 ++++++++++
 3 files changed, 28 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index cddad8c795ec..ed3bf29eb76a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -237,6 +237,14 @@
 				status = "disabled";
 			};
 
+			saradc: adc at 8680 {
+				compatible = "amlogic,meson-saradc";
+				#io-channel-cells = <1>;
+				status = "disabled";
+				reg = <0x0 0x8680 0x0 0x34>;
+				interrupts = <GIC_SPI 9 IRQ_TYPE_EDGE_RISING>;
+			};
+
 			pwm_ef: pwm at 86c0 {
 				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
 				reg = <0x0 0x086c0 0x0 0x10>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 5d686334f692..114d7e1c9fc0 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -429,6 +429,16 @@
 	clocks = <&clkc CLKID_I2C>;
 };
 
+&saradc {
+	compatible = "amlogic,meson-gxbb-saradc", "amlogic,meson-saradc";
+	clocks = <&xtal>,
+		 <&clkc CLKID_SAR_ADC>,
+		 <&clkc CLKID_SANA>,
+		 <&clkc CLKID_SAR_ADC_CLK>,
+		 <&clkc CLKID_SAR_ADC_SEL>;
+	clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
+};
+
 &sd_emmc_a {
 	clocks = <&clkc CLKID_SD_EMMC_A>,
 		 <&xtal>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index bb2842f8a08f..6b63296b6c60 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -273,6 +273,16 @@
 	clocks = <&clkc CLKID_I2C>;
 };
 
+&saradc {
+	compatible = "amlogic,meson-gxl-saradc", "amlogic,meson-saradc";
+	clocks = <&xtal>,
+		 <&clkc CLKID_SAR_ADC>,
+		 <&clkc CLKID_SANA>,
+		 <&clkc CLKID_SAR_ADC_CLK>,
+		 <&clkc CLKID_SAR_ADC_SEL>;
+	clock-names = "clkin", "core", "sana", "adc_clk", "adc_sel";
+};
+
 &sd_emmc_a {
 	clocks = <&clkc CLKID_SD_EMMC_A>,
 		 <&xtal>,
-- 
2.11.0
