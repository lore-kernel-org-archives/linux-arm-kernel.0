From: ttynkkynen@nvidia.com (Tuomas Tynkkynen)
Date: Fri, 11 Jul 2014 00:42:45 +0300
Subject: [PATCH 09/13] ARM: tegra: Add the DFLL to Tegra124 device tree
In-Reply-To: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com>
Message-ID: <1405028569-14253-10-git-send-email-ttynkkynen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The DFLL clocksource is a separate IP block from the usual
clock-and-reset controller, so it gets its own device tree node.

Signed-off-by: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 7cc535b..582a0e2 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -534,6 +534,28 @@
 		status = "disabled";
 	};
 
+	dfll: dfll at 0,70110000 {
+		compatible = "nvidia,tegra124-dfll";
+		reg = <0 0x70110000 0 0x100>, /* DFLL control */
+		      <0 0x70110000 0 0x100>, /* I2C output control */
+		      <0 0x70110100 0 0x100>, /* Integrated I2C controller */
+		      <0 0x70110200 0 0x100>; /* Look-up table RAM */
+		interrupts = <GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_DFLL_SOC>,
+			 <&tegra_car TEGRA124_CLK_DFLL_REF>,
+			 <&tegra_car TEGRA124_CLK_I2C5>;
+		clock-names = "soc", "ref", "i2c";
+		#clock-cells = <0>;
+		clock-output-names = "dfllCPU_out";
+		nvidia,sample-rate = <12500>;
+		nvidia,droop-ctrl = <0x00000f00>;
+		nvidia,force-mode = <1>;
+		nvidia,cf = <10>;
+		nvidia,ci = <0>;
+		nvidia,cg = <2>;
+		status = "disabled";
+	};
+
 	ahub at 0,70300000 {
 		compatible = "nvidia,tegra124-ahub";
 		reg = <0x0 0x70300000 0x0 0x200>,
-- 
1.8.1.5
