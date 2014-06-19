From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 19 Jun 2014 14:50:37 +0300
Subject: [RFC 2/5] ARM: tegra: Add soctherm and thermal zones to Tegra124
 device tree
In-Reply-To: <1403178640-16052-1-git-send-email-mperttunen@nvidia.com>
References: <1403178640-16052-1-git-send-email-mperttunen@nvidia.com>
Message-ID: <1403178640-16052-3-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the soctherm thermal sensing and management unit to the
Tegra124 device tree along with the four thermal zones it exports.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 47 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index d675186..ca884e8 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -724,6 +724,53 @@
 		status = "disabled";
 	};
 
+	thermal-zones {
+		cpu {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&soctherm 0>;
+		};
+
+		mem {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&soctherm 1>;
+		};
+
+		gpu {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&soctherm 2>;
+		};
+
+		pllx {
+			polling-delay-passive = <1000>;
+			polling-delay = <1000>;
+
+			thermal-sensors = <&soctherm 3>;
+		};
+	};
+
+	soctherm: soctherm at 0,700e2000 {
+		compatible = "nvidia,tegra124-soctherm";
+		reg = <0x0 0x700e2000 0x0 0x1000>;
+		interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_TSENSOR>,
+			<&tegra_car TEGRA124_CLK_SOC_THERM>;
+		clock-names = "tsensor", "soc-therm";
+		resets = <&tegra_car 78>;
+		reset-names = "soc-therm";
+
+		nvidia,thermtrip-threshold-cpu = <105>;
+		nvidia,thermtrip-threshold-gpu-mem = <105>;
+		nvidia,thermtrip-threshold-tsense = <105>;
+
+		#thermal-sensor-cells = <1>;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.1.5
