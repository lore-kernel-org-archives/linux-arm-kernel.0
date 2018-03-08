From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 08 Mar 2018 17:25:59 +0100
Subject: [PATCH v2 4/4] ARM: dts: Enable HDMI audio on Snow Chromebook
In-Reply-To: <20180307172711.15697-4-s.nawrocki@samsung.com>
References: <20180307172711.15697-4-s.nawrocki@samsung.com>
 <CGME20180308162609epcas1p45458c1671c38b389e047f17804690eb9@epcas1p4.samsung.com>
Message-ID: <20180308162559.391-1-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds new cpu, codec subnodes according to the updated
"google,snow-audio-max98095" DT bindings and the I2S clock tree
configuration so sound on the HDMI interface can also be supported.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
Changes since v2:
 - changed order of codec phandles in codec/cpu-dai property
   to match the DT bindings documentation.
---
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 4 ++++
 arch/arm/boot/dts/exynos5250-snow.dts         | 8 ++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index bdf59dd3654b..932a00cfd716 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -9,6 +9,7 @@
 #include <dt-bindings/clock/maxim,max77686.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/input/input.h>
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5250.dtsi"

 / {
@@ -523,6 +524,9 @@
 };

 &i2s0 {
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>;
+	assigned-clock-parents = <&clock_audss EXYNOS_I2S_BUS>;
+	#clock-cells = <1>;
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

--
2.14.2
