From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 09 Mar 2018 18:22:48 +0100
Subject: [PATCH v3 4/6] ARM: dts: exynos: Enable HDMI audio on Snow Chromebook
In-Reply-To: <20180309172250.23019-1-s.nawrocki@samsung.com>
References: <20180309172250.23019-1-s.nawrocki@samsung.com>
 <CGME20180309172436epcas2p20e1da46084c1dcc67d6dd6cd1bf24368@epcas2p2.samsung.com>
Message-ID: <20180309172250.23019-4-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new cpu, codec subnodes according to the updated
"google,snow-audio-max98095" DT bindings and the I2S clock tree
configuration so sound on the HDMI interface can also be supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v2:
 - i2s0/#clock-cells property moved to exynos5250.dtsi
 - edited commit summary line.

Changes since v1:
 - changed order of codec in codec/cpu-dai property
   to match the DT bindings documentation.
---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 3 +++
 arch/arm/boot/dts/exynos5250-snow.dts         | 8 ++++++++
 arch/arm/boot/dts/exynos5250.dtsi             | 1 +
 3 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index bdf59dd3654b..fd9226d3b207 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/maxim,max77686.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5250.dtsi"
 
 / {
@@ -523,6 +524,8 @@
 };
 
 &i2s0 {
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index 16e37c337a3f..75fdc5e6d423 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -18,6 +18,14 @@
 
 		samsung,model = "Snow-I2S-MAX98095";
 		samsung,audio-codec = <&max98095>;
+
+		cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		codec {
+			sound-dai = <&max98095 0>, <&hdmi>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index 71d2ede118e3..f6c6c94d3d7d 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -500,6 +500,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2s0_bus>;
 			power-domains = <&pd_mau>;
+			#clock-cells = <1>;
 		};
 
 		i2s1: i2s at 12d60000 {
-- 
2.14.2
