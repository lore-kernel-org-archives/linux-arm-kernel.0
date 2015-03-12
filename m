From: vinceh@nvidia.com (Vince Hsu)
Date: Thu, 12 Mar 2015 20:15:11 +0800
Subject: [PATCH v2 10/17] ARM: tegra: add PM domain device nodes to Tegra124 DT
In-Reply-To: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
References: <1426162518-7405-1-git-send-email-vinceh@nvidia.com>
Message-ID: <1426162518-7405-11-git-send-email-vinceh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also bind the PM domain provider and consumer together.

Signed-off-by: Vince Hsu <vinceh@nvidia.com>
---
 arch/arm/boot/dts/tegra124.dtsi | 86 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 4be06c6ea0c8..0ef15136d829 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -3,6 +3,7 @@
 #include <dt-bindings/memory/tegra124-mc.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra.h>
 #include <dt-bindings/pinctrl/pinctrl-tegra-xusb.h>
+#include <dt-bindings/power/tegra-powergate.h>
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/thermal/tegra124-soctherm.h>
 
@@ -39,6 +40,8 @@
 			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefetchable memory (208 MiB) */
 			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchable memory (512 MiB) */
 
+		power-domains = <&pmc TEGRA_POWERGATE_PCIE>;
+
 		clocks = <&tegra_car TEGRA124_CLK_PCIE>,
 			 <&tegra_car TEGRA124_CLK_AFI>,
 			 <&tegra_car TEGRA124_CLK_PLL_E>,
@@ -98,6 +101,7 @@
 			compatible = "nvidia,tegra124-dc";
 			reg = <0x0 0x54200000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pmc TEGRA_POWERGATE_DIS>;
 			clocks = <&tegra_car TEGRA124_CLK_DISP1>,
 				 <&tegra_car TEGRA124_CLK_PLL_P>;
 			clock-names = "dc", "parent";
@@ -113,6 +117,7 @@
 			compatible = "nvidia,tegra124-dc";
 			reg = <0x0 0x54240000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pmc TEGRA_POWERGATE_DISB>;
 			clocks = <&tegra_car TEGRA124_CLK_DISP2>,
 				 <&tegra_car TEGRA124_CLK_PLL_P>;
 			clock-names = "dc", "parent";
@@ -140,6 +145,7 @@
 			compatible = "nvidia,tegra124-sor";
 			reg = <0x0 0x54540000 0x0 0x00040000>;
 			interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
+			power-domains = <&pmc TEGRA_POWERGATE_SOR>;
 			clocks = <&tegra_car TEGRA124_CLK_SOR0>,
 				 <&tegra_car TEGRA124_CLK_PLL_D_OUT0>,
 				 <&tegra_car TEGRA124_CLK_PLL_DP>,
@@ -182,6 +188,7 @@
 		interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
 		interrupt-names = "stall", "nonstall";
+		power-domains = <&pmc TEGRA_POWERGATE_3D>;
 		clocks = <&tegra_car TEGRA124_CLK_GPU>,
 			 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>;
 		clock-names = "gpu", "pwr";
@@ -542,11 +549,86 @@
 		clocks = <&tegra_car TEGRA124_CLK_RTC>;
 	};
 
-	pmc at 0,7000e400 {
+	pmc: pmc at 0,7000e400 {
 		compatible = "nvidia,tegra124-pmc";
 		reg = <0x0 0x7000e400 0x0 0x400>;
 		clocks = <&tegra_car TEGRA124_CLK_PCLK>, <&clk32k_in>;
 		clock-names = "pclk", "clk32k_in";
+		#power-domain-cells = <1>;
+	};
+
+	dcpd: dc-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "dc-power-domain";
+		domain = <TEGRA_POWERGATE_DIS>;
+		clocks = <&tegra_car TEGRA124_CLK_DISP1>;
+		resets = <&tegra_car 27>;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_DC>;
+		depend-on = <&sorpd>;
+	};
+
+	dcb-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "dcb-power-domain";
+		domain = <TEGRA_POWERGATE_DISB>;
+		clocks = <&tegra_car TEGRA124_CLK_DISP2>;
+		resets = <&tegra_car 26>;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_DCB>;
+		depend-on = <&dcpd>;
+	};
+
+	pcie-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "pcie-power-domain";
+		domain = <TEGRA_POWERGATE_PCIE>;
+		clocks = <&tegra_car TEGRA124_CLK_PCIE>,
+			 <&tegra_car TEGRA124_CLK_AFI>,
+			 <&tegra_car TEGRA124_CLK_CML0>;
+		resets = <&tegra_car 70>,
+			 <&tegra_car 72>,
+			 <&tegra_car 74>;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_AFI>;
+	};
+
+	sorpd: sor-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "sor-power-domain";
+		domain = <TEGRA_POWERGATE_SOR>;
+		clocks = <&tegra_car TEGRA124_CLK_SOR0>,
+			 <&tegra_car TEGRA124_CLK_DSIA>,
+			 <&tegra_car TEGRA124_CLK_DSIB>,
+			 <&tegra_car TEGRA124_CLK_HDMI>,
+			 <&tegra_car TEGRA124_CLK_MIPI_CAL>,
+			 <&tegra_car TEGRA124_CLK_DPAUX>;
+		resets = <&tegra_car 182>,
+			<&tegra_car 48>,
+			<&tegra_car 82>,
+			<&tegra_car 51>,
+			<&tegra_car 56>;
+	};
+
+	gpu-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "gpu-power-domain";
+		domain = <TEGRA_POWERGATE_3D>;
+		clocks = <&tegra_car TEGRA124_CLK_GPU>,
+			 <&tegra_car TEGRA124_CLK_PLL_P_OUT5>;
+		resets = <&tegra_car 184>;
+		external-power-rail;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_GPU>;
+	};
+
+	sata-power-domain {
+		compatible = "nvidia,power-domains";
+		name = "sata-power-domain";
+		domain = <TEGRA_POWERGATE_SATA>;
+		clocks = <&tegra_car TEGRA124_CLK_SATA>,
+			<&tegra_car TEGRA124_CLK_SATA_OOB>,
+			<&tegra_car TEGRA124_CLK_CML1>;
+		resets = <&tegra_car 124>,
+			<&tegra_car 123>,
+			<&tegra_car 129>;
+		nvidia,swgroup = <&mc TEGRA_SWGROUP_SATA>;
 	};
 
 	fuse at 0,7000f800 {
@@ -588,6 +670,8 @@
 			<&tegra_car 129>;
 		reset-names = "sata", "sata-oob", "sata-cold";
 
+		power-domains = <&pmc TEGRA_POWERGATE_SATA>;
+
 		phys = <&padctl TEGRA_XUSB_PADCTL_SATA>;
 		phy-names = "sata-phy";
 
-- 
2.1.4
