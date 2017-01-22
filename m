From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 22 Jan 2017 19:17:14 +0100
Subject: [PATCH v4 3/3] ARM64: dts: meson: meson-gx: add the SAR ADC
In-Reply-To: <20170122181714.6259-1-martin.blumenstingl@googlemail.com>
References: <20170122181714.6259-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170122181714.6259-4-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the SAR ADC to meson-gxbb.dtsi and meson-gxl.dtsi. GXBB provides a
10-bit ADC while GXL and GXM provide a 12-bit ADC.
Some boards use resistor ladder buttons connected through one of the ADC
channels. On newer devices (GXL and GXM) some boards use pull-ups/downs
to change the resistance (and thus the ADC value) on one of the ADC
channels to indicate the board revision.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Tested-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   |  8 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 10 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 10 ++++++++++
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi  |  4 ++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index df10d4507ca9..c76a690967f8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -237,6 +237,14 @@
 				status = "disabled";
 			};
 
+			saradc: adc at 8680 {
+				compatible = "amlogic,meson-saradc";
+				reg = <0x0 0x8680 0x0 0x34>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
+				status = "disabled";
+			};
+
 			pwm_ef: pwm at 86c0 {
 				compatible = "amlogic,meson-gx-pwm", "amlogic,meson-gxbb-pwm";
 				reg = <0x0 0x086c0 0x0 0x10>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 5c22c794ed95..3f70cfcb9682 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -490,6 +490,16 @@
 	};
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
index afa74455e1de..b0070489e179 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -340,6 +340,16 @@
 	};
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
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index 78a004d13236..fba3c76c78a6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -117,6 +117,10 @@
 	};
 };
 
+&saradc {
+	compatible = "amlogic,meson-gxm-saradc", "amlogic,meson-saradc";
+};
+
 &scpi_dvfs {
 	clock-indices = <0 1>;
 	clock-output-names = "vbig", "vlittle";
-- 
2.11.0
