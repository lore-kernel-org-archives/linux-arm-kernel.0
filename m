From: vigneshr@ti.com (Vignesh R)
Date: Wed, 3 Jun 2015 17:21:22 +0530
Subject: [PATCH v2 3/5] ARM: dts: DRA7: Add TBCLK for PWMSS
In-Reply-To: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
References: <1433332284-10766-1-git-send-email-vigneshr@ti.com>
Message-ID: <1433332284-10766-4-git-send-email-vigneshr@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tbclk is used by ehrpwm to generate PWM waveform on DRA7 SoC. Add Linux
clock to control ehrpwm tbclk.
The TRM says, tbclk is derived from SYSCLKOUT. SYSCLKOUT is nothing but
ehrpwm functional clock derived from the gateable interface and
functional clock of PWMSS(l4_root_clk_div).
Refer AM57x TRM SPRUHZ6[1], October 2014, Table 29-4 and Section 29.2.2.1,
Table 29-19 and the NOTE at the end of the table.

[1] www.ti.com/lit/ug/spruhz6/spruhz6.pdf

Signed-off-by: Vignesh R <vigneshr@ti.com>
---

v2:
 * add TRM references.

 arch/arm/boot/dts/dra7.dtsi          |  5 +++++
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 26 ++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index f03a091cd076..387c76ca41f9 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -131,6 +131,11 @@
 							regulator-max-microvolt = <3000000>;
 						};
 					};
+
+					scm_conf_clocks: clocks {
+						#address-cells = <1>;
+						#size-cells = <0>;
+					};
 				};
 
 				dra7_pmx_core: pinmux at 1400 {
diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index 3b933f74d000..92452d61cf58 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -2136,3 +2136,29 @@
 		clocks = <&dpll_usb_ck>;
 	};
 };
+
+&scm_conf_clocks {
+       ehrpwm0_tbclk: ehrpwm0_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <20>;
+		reg = <0x0558>;
+	};
+
+	ehrpwm1_tbclk: ehrpwm1_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <21>;
+		reg = <0x0558>;
+	};
+
+	ehrpwm2_tbclk: ehrpwm2_tbclk {
+		#clock-cells = <0>;
+		compatible = "ti,gate-clock";
+		clocks = <&l4_root_clk_div>;
+		ti,bit-shift = <22>;
+		reg = <0x0558>;
+	};
+};
-- 
2.4.1
