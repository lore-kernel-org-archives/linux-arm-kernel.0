From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 12 Jul 2017 14:29:28 +0800
Subject: [PATCH 2/4] arm64: dts: rockchip: add ARM Mali GPU node for RK3399
 SoCs
In-Reply-To: <1499840971-20392-1-git-send-email-wxt@rock-chips.com>
References: <1499840971-20392-1-git-send-email-wxt@rock-chips.com>
Message-ID: <1499840971-20392-3-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Mali GPU device tree node for the RK3399 SoCs, with devfreq
opp table.

RK3399 and RK3399-OP1 SoCs have a different recommendation table with
gpu opp. As the ARM's mali driver found on
https://developer.arm.com/products/software/mali-drivers/midgard-kernel.

Signed-off-by: Caesar Wang <wxt@rock-chips.com>
---

 arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi | 33 ++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi     | 33 ++++++++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi         | 16 ++++++++++++
 3 files changed, 82 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
index be7fe63..d8a120f 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-op1-opp.dtsi
@@ -118,6 +118,35 @@
 			opp-microvolt = <1250000>;
 		};
 	};
+
+	gpu_opp_table: opp-table2 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <800000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <297000000>;
+			opp-microvolt = <800000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <825000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <850000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <925000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1075000>;
+		};
+	};
 };
 
 &cpu_l0 {
@@ -143,3 +172,7 @@
 &cpu_b1 {
 	operating-points-v2 = <&cluster1_opp>;
 };
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
index c83460d..81617bc 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-opp.dtsi
@@ -110,6 +110,35 @@
 			opp-microvolt = <1200000>;
 		};
 	};
+
+	gpu_opp_table: opp-table2 {
+		compatible = "operating-points-v2";
+
+		opp00 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <800000>;
+		};
+		opp01 {
+			opp-hz = /bits/ 64 <297000000>;
+			opp-microvolt = <800000>;
+		};
+		opp02 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <825000>;
+		};
+		opp03 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <875000>;
+		};
+		opp04 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <925000>;
+		};
+		opp05 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1100000>;
+		};
+	};
 };
 
 &cpu_l0 {
@@ -135,3 +164,7 @@
 &cpu_b1 {
 	operating-points-v2 = <&cluster1_opp>;
 };
+
+&gpu {
+	operating-points-v2 = <&gpu_opp_table>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 1cbd7a2..8c6438b 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -1443,6 +1443,22 @@
 		status = "disabled";
 	};
 
+	gpu: gpu at ff9a0000 {
+		compatible = "arm,rk3399-mali",
+			     "arm,malit860",
+			     "arm,malit86x",
+			     "arm,malit8xx";
+		reg = <0x0 0xff9a0000 0x0 0x10000>;
+		interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH 0>,
+			     <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH 0>;
+		interrupt-names = "GPU", "JOB", "MMU";
+		clocks = <&cru ACLK_GPU>;
+		clock-names = "clk_mali";
+		power-domains = <&power RK3399_PD_GPU>;
+		status = "disabled";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3399-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.7.4
