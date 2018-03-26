From: yixun.lan@amlogic.com (Yixun Lan)
Date: Mon, 26 Mar 2018 17:21:17 +0800
Subject: [PATCH] ARM64: dts: meson-axg: add saradc support
Message-ID: <20180326092117.208416-1-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Xingyu Chen <xingyu.chen@amlogic.com>

Add the DT info for SAR ADC of the Amlogic's Meson-AXG SoC.

Signed-off-by: Xingyu Chen <xingyu.chen@amlogic.com>
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>

---
Hi Kevin:

  Please note, the saradc driver in Meson-AXG platfrom actually
depend on the AO clock driver [0] & saradc patch itself [1].
  And I've rebased this patch on top of your v4.17/dt64 branch

[0] https://lkml.kernel.org/r/20180323143816.200573-1-yixun.lan at amlogic.com
[1] https://lkml.kernel.org/r/20180326084629.100070-1-yixun.lan at amlogic.com

Yixun
---
 arch/arm64/boot/dts/amlogic/meson-axg-s400.dts |  5 +++++
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi     | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
index 57eedced5a51..bbb88debbc04 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-axg-s400.dts
@@ -47,3 +47,8 @@
 	pinctrl-0 = <&i2c1_z_pins>;
 	pinctrl-names = "default";
 };
+
+&saradc {
+	status = "okay";
+	vref-supply = <&vddio_ao18>;
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index 40ca49fb94a6..105884efc033 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -818,6 +818,27 @@
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
+
+	vddio_ao18: regulator-vddio_ao18 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDDIO_AO18";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
 };
-- 
2.15.1
