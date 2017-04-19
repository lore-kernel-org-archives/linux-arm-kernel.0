From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Wed, 19 Apr 2017 09:06:18 +0100
Subject: [PATCH v3 2/5] ARM: dts: rockchip: add ARM Mali GPU node for rk3288
In-Reply-To: <cover.1492588180.git.guillaume.tucker@collabora.com>
References: <cover.1492588180.git.guillaume.tucker@collabora.com>
Message-ID: <f6f127efb44fb1012f18c483fa522918f8f82d7c.1492588180.git.guillaume.tucker@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Mali GPU device tree node for the rk3288 SoC, with devfreq
opp table.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
---
 arch/arm/boot/dts/rk3288.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index df8a0dbe9d91..187eed528f83 100644
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
@@ -227,6 +228,27 @@
 		ports = <&vopl_out>, <&vopb_out>;
 	};
 
+	gpu: mali at ffa30000 {
+		compatible = "arm,mali-t760", "arm,mali-midgard";
+		reg = <0xffa30000 0x10000>;
+		interrupts = <GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-names = "job", "mmu", "gpu";
+		clocks = <&cru ACLK_GPU>;
+		operating-points = <
+			/* KHz uV */
+			100000 950000
+			200000 950000
+			300000 1000000
+			400000 1100000
+			500000 1200000
+			600000 1250000
+		>;
+		power-domains = <&power RK3288_PD_GPU>;
+		status = "disabled";
+	};
+
 	sdmmc: dwmmc at ff0c0000 {
 		compatible = "rockchip,rk3288-dw-mshc";
 		max-frequency = <150000000>;
-- 
2.11.0
