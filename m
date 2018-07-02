From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 2 Jul 2018 22:25:15 +0000
Subject: [PATCH v2] ARM64: dts: meson-axg: add saradc support
Message-ID: <20180702222515.13924-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Add the DT info for SAR ADC of the Amlogic's Meson-AXG SoC.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
Hi kevin
  I just re-send this patch which rebased to your khilman/v4.18/integ branch
  Thanks
Yixun

nothing changed since patch v1 [1]:
 -

[1] https://lkml.kernel.org/r/20180326092117.208416-1-yixun.lan at amlogic.com

---
 .../arm64/boot/dts/amlogic/meson-axg-s400.dts |  5 +++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi    | 21 +++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 4b3331fbfe39..6041f68b32ae 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -153,3 +153,8 @@
 		compatible = "brcm,bcm4329-fmac";
 	};
 };
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 67d7115e4eff..52678a69dbf8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -91,6 +91,13 @@
 		method = "smc";
 	};
 
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupts = <GIC_PPI 13
@@ -1194,6 +1201,20 @@
 				interrupts = <GIC_SPI 196 IRQ_TYPE_EDGE_RISING>;
 				status = "disabled";
 			};
+
+			saradc: adc at 9000 {
+				compatible = "amlogic,meson-axg-saradc",
+					"amlogic,meson-saradc";
+				reg = <0x0 0x9000 0x0 0x38>;
+				#io-channel-cells = <1>;
+				interrupts = <GIC_SPI 73 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>,
+					<&clkc_AO CLKID_AO_SAR_ADC>,
+					<&clkc_AO CLKID_AO_SAR_ADC_CLK>,
+					<&clkc_AO CLKID_AO_SAR_ADC_SEL>;
+				clock-names = "clkin", "core", "adc_clk", "adc_sel";
+				status = "disabled";
+			};
 		};
 	};
 };
-- 
2.18.0
