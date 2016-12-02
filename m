From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 02 Dec 2016 16:18:06 +0900
Subject: [PATCH 4/5] arm64: dts: exynos5433: Add bus dt node using VDD_INT for
 Exynos5433
In-Reply-To: <1480663087-4590-1-git-send-email-cw00.choi@samsung.com>
References: <1480663087-4590-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1480663087-4590-5-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the bus nodes using VDD_INT for Exynos5433 SoC.
Exynos5433 has the following AMBA AXI buses to translate data
between DRAM and sub-blocks.

Following list specify the detailed correlation between sub-block and clock:
- CLK_ACLK_G2D_{400|266}  : Bus clock for G2D
- CLK_ACLK_MSCL_400       : Bus clock for MSCL (Mobile Scaler)
- CLK_ACLK_GSCL_333       : Bus clock for GSCL (General Scaler)
- CLK_SCLK_JPEG_MSCL      : Bus clock for JPEG
- CLK_ACLK_MFC_400        : Bus clock for MFC (Multi Format Codec)
- CLK_ACLK_HEVC_400       : Bus clock for HEVC (High Effective Video Codec)
- CLK_ACLK_BUS0_400       : NoC(Network On Chip)'s bus clock for PERIC/PERIS/FSYS/MSCL
- CLK_ACLK_BUS1_400       : NoC's bus clock for MFC/HEVC/G3D
- CLK_ACLK_BUS2_400       : NoC's bus clock for GSCL/DISP/G2D/CAM0/CAM1/ISP

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi | 208 +++++++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos5433.dtsi     |   1 +
 2 files changed, 209 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
new file mode 100644
index 000000000000..b1e1d9c622e1
--- /dev/null
+++ b/arch/arm64/boot/dts/exynos/exynos5433-bus.dtsi
@@ -0,0 +1,208 @@
+/*
+ * Samsung's Exynos5433 SoC Memory interface and AMBA bus device tree source
+ *
+ * Copyright (c) 2016 Samsung Electronics Co., Ltd.
+ * Chanwoo Choi <cw00.choi@samsung.com>
+ *
+ * Samsung's Exynos5433 SoC Memory interface and AMBA buses are listed
+ * as device tree nodes are listed in this file.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	/* INT (Internal) block using VDD_INT */
+	bus_g2d_400: bus_g2d_400 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_top CLK_ACLK_G2D_400>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_g2d_400_opp_table>;
+		status ="disable";
+	};
+
+	bus_mscl: bus_mscl {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_top CLK_ACLK_MSCL_400>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_g2d_400_opp_table>;
+		status ="disable";
+	};
+
+	bus_jpeg: bus_jpeg {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_top CLK_SCLK_JPEG_MSCL>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_g2d_400_opp_table>;
+		status ="disable";
+	};
+
+	bus_mfc: bus_mfc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_top CLK_ACLK_MFC_400>;
+
+		clock-names = "bus";
+		operating-points-v2 = <&bus_g2d_400_opp_table>;
+		status ="disable";
+	};
+
+	bus_g2d_266: bus_g2d_266 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_top CLK_ACLK_G2D_266>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_g2d_266_opp_table>;
+		status ="disable";
+	};
+
+	bus_gscl: bus_gscl {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_top CLK_ACLK_GSCL_333>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_gscl_opp_table>;
+		status ="disable";
+	};
+
+	bus_hevc: bus_hevc {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_top CLK_ACLK_HEVC_400>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_hevc_opp_table>;
+		status ="disable";
+	};
+
+	bus_bus0: bus_bus0 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_top CLK_ACLK_BUS0_400>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_hevc_opp_table>;
+		status ="disable";
+	};
+
+	bus_bus1: bus_bus1 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_top CLK_ACLK_BUS1_400>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_hevc_opp_table>;
+		status ="disable";
+	};
+
+	bus_bus2: bus_bus2 {
+		compatible = "samsung,exynos-bus";
+		clocks = <&cmu_mif CLK_ACLK_BUS2_400>;
+		clock-names = "bus";
+		operating-points-v2 = <&bus_bus2_opp_table>;
+		status ="disable";
+	};
+
+	bus_g2d_400_opp_table: opp_table2 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1075000>;
+		};
+		opp at 267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <975000>;
+		};
+		opp at 160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <962500>;
+		};
+		opp at 134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <950000>;
+		};
+		opp at 100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <937500>;
+		};
+	};
+
+	bus_g2d_266_opp_table: opp_table3 {
+		compatible = "operating-points-v2";
+
+		opp at 267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+		};
+		opp at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp at 160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+		};
+		opp at 134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+		opp at 100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+	};
+
+	bus_gscl_opp_table: opp_table4 {
+		compatible = "operating-points-v2";
+
+		opp at 333000000 {
+			opp-hz = /bits/ 64 <333000000>;
+		};
+		opp at 222000000 {
+			opp-hz = /bits/ 64 <222000000>;
+		};
+		opp at 166500000 {
+			opp-hz = /bits/ 64 <166500000>;
+		};
+	};
+
+	bus_hevc_opp_table: opp_table5 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp at 400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1075000>;
+		};
+		opp at 267000000 {
+			opp-hz = /bits/ 64 <267000000>;
+			opp-microvolt = <1075000>;
+		};
+		opp at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <1075000>;
+		};
+		opp at 160000000 {
+			opp-hz = /bits/ 64 <160000000>;
+			opp-microvolt = <1075000>;
+		};
+		opp at 134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+			opp-microvolt = <1075000>;
+		};
+		opp at 100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <1075000>;
+		};
+	};
+
+	bus_bus2_opp_table: opp_table6 {
+		compatible = "operating-points-v2";
+
+		opp at 400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+		};
+		opp at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+		};
+		opp at 134000000 {
+			opp-hz = /bits/ 64 <134000000>;
+		};
+		opp at 100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 8c4ee84d5232..68f764e5851c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1482,5 +1482,6 @@
 	};
 };
 
+#include "exynos5433-bus.dtsi"
 #include "exynos5433-pinctrl.dtsi"
 #include "exynos5433-tmu.dtsi"
-- 
1.9.1
