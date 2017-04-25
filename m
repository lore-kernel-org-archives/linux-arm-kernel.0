From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Tue, 25 Apr 2017 14:16:17 +0100
Subject: [PATCH v4 2/5] ARM: dts: rockchip: add ARM Mali GPU node for rk3288
In-Reply-To: <cover.1493125299.git.guillaume.tucker@collabora.com>
References: <cover.1493125299.git.guillaume.tucker@collabora.com>
Message-ID: <a63b581014030f635835109901c29a86041cd766.1493125299.git.guillaume.tucker@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Mali GPU device tree node for the rk3288 SoC, with devfreq
opp table.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index df8a0dbe9d91..35969041eae2 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -43,6 +43,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/pinctrl/rockchip.h>
 #include <dt-bindings/clock/rk3288-cru.h>
+#include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/thermal/thermal.h>
 #include <dt-bindings/power/rk3288-power.h>
 #include <dt-bindings/soc/rockchip,boot-mode.h>
@@ -1117,6 +1118,48 @@
 		};
 	};
 
+	gpu: mali at ffa30000 {
+		compatible = "rockchip,rk3288-mali", "arm,mali-t760", "arm,mali-midgard";
+		reg = <0xffa30000 0x10000>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "job", "mmu", "gpu";
+		clocks = <&cru ACLK_GPU>;
+		operating-points-v2 = <&gpu_opp_table>;
+		power-domains = <&power RK3288_PD_GPU>;
+		status = "disabled";
+	};
+
+	gpu_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+
+		opp at 100000000 {
+			opp-hz = /bits/ 64 <100000000>;
+			opp-microvolt = <950000>;
+		};
+		opp at 200000000 {
+			opp-hz = /bits/ 64 <200000000>;
+			opp-microvolt = <950000>;
+		};
+		opp at 300000000 {
+			opp-hz = /bits/ 64 <300000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp at 400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1100000>;
+		};
+		opp at 500000000 {
+			opp-hz = /bits/ 64 <500000000>;
+			opp-microvolt = <1200000>;
+		};
+		opp at 600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1250000>;
+		};
+	};
+
 	qos_gpu_r: qos at ffaa0000 {
 		compatible = "syscon";
 		reg = <0xffaa0000 0x20>;
-- 
2.11.0
