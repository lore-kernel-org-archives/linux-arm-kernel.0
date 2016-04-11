From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Mon, 11 Apr 2016 12:57:54 +0900
Subject: [PATCH v9 16/20] ARM: dts: Add bus nodes using VDD_MIF for Exynos4210
In-Reply-To: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
References: <1460347078-15175-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1460347078-15175-17-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the bus nodes for Exynos4210 SoC. Exynos4210 SoC has
one power line for all buses to translate data between DRAM and sub-blocks.

Following list specifies the detailed relation between DRAM and sub-blocks:
- DMC/ACP clock for DMC (Dynamic Memory Controller)
- ACLK200 clock for LCD0
- ACLK100 clock for PERIL/PERIR/MFC(PCLK)
- ACLK160 clock for CAM/TV/LCD0/LCD1
- ACLK133 clock for FSYS/GPS
- GDL/GDR clock for LEFTBUS/RIGHTBUS
- SCLK_MFC clock for MFC

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 arch/arm/boot/dts/exynos4210.dtsi | 159 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index c1cb8df6da07..2d9b02967105 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -257,6 +257,165 @@
 		power-domains = <&pd_lcd1>;
 		#iommu-cells = <0>;
 	};
+
+	bus_dmc: bus_dmc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_DMC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_dmc_opp_table>;
+		status = "disabled";
+	};
+
+	bus_acp: bus_acp {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_ACP>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_acp_opp_table>;
+		status = "disabled";
+	};
+
+	bus_peri: bus_peri {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK100>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_peri_opp_table>;
+		status = "disabled";
+	};
+
+	bus_fsys: bus_fsys {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK133>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_fsys_opp_table>;
+		status = "disabled";
+	};
+
+	bus_display: bus_display {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK160>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_display_opp_table>;
+		status = "disabled";
+	};
+
+	bus_lcd0: bus_lcd0 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_ACLK200>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_leftbus: bus_leftbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_rightbus: bus_rightbus {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_DIV_GDR>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_mfc: bus_mfc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&clock CLK_SCLK_MFC>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_leftbus_opp_table>;
+		status = "disabled";
+	};
+
+	bus_dmc_opp_table: opp_table1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp at 267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+			opp-microvolt = <1050000>;
+		};
+		opp at 400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1150000>;
+		};
+	};
+
+	bus_acp_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+		opp at 160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+		};
+		opp at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+	};
+
+	bus_peri_opp_table: opp_table3 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 5000000 {
+			opp-hz = /bits/ 64 <5000000>;
+		};
+		opp at 100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+	};
+
+	bus_fsys_opp_table: opp_table4 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 10000000 {
+			opp-hz = /bits/ 64 <10000000>;
+		};
+		opp at 134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+	};
+
+	bus_display_opp_table: opp_table5 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp at 134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+		opp at 160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+		};
+	};
+
+	bus_leftbus_opp_table: opp_table6 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+		opp at 160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+		};
+		opp at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+	};
 };
 
 &gic {
-- 
1.9.1
