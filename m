From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 19 Dec 2013 16:59:28 +0100
Subject: [PATCH 04/10] ARM: tegra: Add host1x,
 DC and HDMI to Tegra114 device tree
In-Reply-To: <1387468774-14216-1-git-send-email-treding@nvidia.com>
References: <1387468774-14216-1-git-send-email-treding@nvidia.com>
Message-ID: <1387468774-14216-5-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Add host1x, DC (display controller) and HDMI devices to Tegra114
device tree.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra114.dtsi | 57 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
index 9a40a3fc37ec..65e34e7fe6f2 100644
--- a/arch/arm/boot/dts/tegra114.dtsi
+++ b/arch/arm/boot/dts/tegra114.dtsi
@@ -16,6 +16,63 @@
 		serial3 = &uartd;
 	};
 
+	host1x at 50000000 {
+		compatible = "nvidia,tegra114-host1x", "simple-bus";
+		reg = <0x50000000 0x00028000>;
+		interrupts = <GIC_SPI 65 IRQ_TYPE_LEVEL_HIGH>, /* syncpt */
+			     <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>; /* general */
+		clocks = <&tegra_car TEGRA114_CLK_HOST1X>;
+		resets = <&tegra_car 28>;
+		reset-names = "host1x";
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		ranges = <0x54000000 0x54000000 0x01000000>;
+
+		dc at 54200000 {
+			compatible = "nvidia,tegra114-dc", "nvidia,tegra20-dc";
+			reg = <0x54200000 0x00040000>;
+			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA114_CLK_DISP1>,
+				 <&tegra_car TEGRA114_CLK_PLL_P>;
+			clock-names = "dc", "parent";
+			resets = <&tegra_car 27>;
+			reset-names = "dc";
+
+			rgb {
+				status = "disabled";
+			};
+		};
+
+		dc at 54240000 {
+			compatible = "nvidia,tegra114-dc", "nvidia,tegra20-dc";
+			reg = <0x54240000 0x00040000>;
+			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA114_CLK_DISP2>,
+				 <&tegra_car TEGRA114_CLK_PLL_P>;
+			clock-names = "dc", "parent";
+			resets = <&tegra_car 26>;
+			reset-names = "dc";
+
+			rgb {
+				status = "disabled";
+			};
+		};
+
+		hdmi at 54280000 {
+			compatible = "nvidia,tegra114-hdmi";
+			reg = <0x54280000 0x00040000>;
+			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA114_CLK_HDMI>,
+				 <&tegra_car TEGRA114_CLK_PLL_D2_OUT0>;
+			clock-names = "hdmi", "parent";
+			resets = <&tegra_car 51>;
+			reset-names = "hdmi";
+			status = "disabled";
+		};
+	};
+
 	gic: interrupt-controller at 50041000 {
 		compatible = "arm,cortex-a15-gic";
 		#interrupt-cells = <3>;
-- 
1.8.4.2
