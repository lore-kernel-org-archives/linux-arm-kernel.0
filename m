From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue,  3 Dec 2013 11:26:39 -0700
Subject: [PATCH V2] ARM: tegra: add MMC controllers to Tegra124 DT
Message-ID: <1386095199-24336-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Tegra124 has 4 MMC controllers just like previous versions of the SoC.
Note that there are some non-backwards-compatible HW differences, and
hence a new DT compatible value must be used to describe the HW.

Also enable the relevant controllers in the Venice2 board DT.

power-gpios property suggested by Thierry Reding.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
v2: Add power-gpios to SD card node, suggested by Thierry.
---
 arch/arm/boot/dts/tegra124-venice2.dts | 12 ++++++++++
 arch/arm/boot/dts/tegra124.dtsi        | 40 ++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index a0b028384658..098d0b2081bf 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -25,6 +25,18 @@
 		nvidia,sys-clock-req-active-high;
 	};
 
+	sdhci at 700b0400 {
+		cd-gpios = <&gpio TEGRA_GPIO(V, 2) GPIO_ACTIVE_HIGH>;
+		power-gpios = <&gpio TEGRA_GPIO(R, 0) GPIO_ACTIVE_HIGH>;
+		status = "okay";
+		bus-width = <4>;
+	};
+
+	sdhci at 700b0600 {
+		status = "okay";
+		bus-width = <8>;
+	};
+
 	clocks {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 96e051e13f76..200373236aaa 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -190,6 +190,46 @@
 		clock-names = "pclk", "clk32k_in";
 	};
 
+	sdhci at 700b0000 {
+		compatible = "nvidia,tegra124-sdhci";
+		reg = <0x700b0000 0x200>;
+		interrupts = <GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_SDMMC1>;
+		resets = <&tegra_car 14>;
+		reset-names = "sdhci";
+		status = "disable";
+	};
+
+	sdhci at 700b0200 {
+		compatible = "nvidia,tegra124-sdhci";
+		reg = <0x700b0200 0x200>;
+		interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_SDMMC2>;
+		resets = <&tegra_car 9>;
+		reset-names = "sdhci";
+		status = "disable";
+	};
+
+	sdhci at 700b0400 {
+		compatible = "nvidia,tegra124-sdhci";
+		reg = <0x700b0400 0x200>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_SDMMC3>;
+		resets = <&tegra_car 69>;
+		reset-names = "sdhci";
+		status = "disable";
+	};
+
+	sdhci at 700b0600 {
+		compatible = "nvidia,tegra124-sdhci";
+		reg = <0x700b0600 0x200>;
+		interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&tegra_car TEGRA124_CLK_SDMMC4>;
+		resets = <&tegra_car 15>;
+		reset-names = "sdhci";
+		status = "disable";
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
1.8.1.5
