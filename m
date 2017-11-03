From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 03 Nov 2017 17:54:46 +0100
Subject: [PATCH v2 2/2] ARM: dts: exynos: Add sound support for Odroid XU4
In-Reply-To: <20171103165446.15438-1-s.nawrocki@samsung.com>
References: <20171103165446.15438-1-s.nawrocki@samsung.com>
 <CGME20171103165612epcas2p38df1787630b2dfbf1d0d0e3ef1b93a49@epcas2p3.samsung.com>
Message-ID: <20171103165446.15438-3-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Odroid XU4 audio. The main difference
comparing to Odroid XU3 is a missing on-board audio CODEC, only
HDMI output is supported on Odroid XU4. External CODEC could be
optionally connected to the I2S port connector.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu4.dts | 52 ++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 2faf88627a48..0c2f1ef8a552 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -12,6 +12,7 @@
 */
 
 /dts-v1/;
+#include <dt-bindings/sound/samsung-i2s.h>
 #include "exynos5422-odroidxu3-common.dtsi"
 
 / {
@@ -30,6 +31,57 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	sound: sound {
+		compatible = "samsung,odroid-xu3-audio";
+		model = "Odroid-XU4";
+
+		assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>,
+				<&clock CLK_MOUT_EPLL>,
+				<&clock CLK_MOUT_MAU_EPLL>,
+				<&clock CLK_MOUT_USER_MAU_EPLL>,
+				<&clock_audss EXYNOS_MOUT_AUDSS>,
+				<&clock_audss EXYNOS_MOUT_I2S>,
+				<&clock_audss EXYNOS_DOUT_SRP>,
+				<&clock_audss EXYNOS_DOUT_AUD_BUS>,
+				<&clock_audss EXYNOS_DOUT_I2S>;
+
+		assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>,
+				<&clock CLK_FOUT_EPLL>,
+				<&clock CLK_MOUT_EPLL>,
+				<&clock CLK_MOUT_MAU_EPLL>,
+				<&clock CLK_MAU_EPLL>,
+				<&clock_audss EXYNOS_MOUT_AUDSS>;
+
+		assigned-clock-rates = <0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<0>,
+				<196608001>,
+				<(196608002 / 2)>,
+				<196608000>;
+
+		cpu {
+			sound-dai = <&i2s0 0>;
+		};
+
+		codec {
+			sound-dai = <&hdmi>;
+		};
+	};
+};
+
+&clock_audss {
+	assigned-clocks = <&clock_audss EXYNOS_DOUT_SRP>,
+			  <&clock CLK_FOUT_EPLL>;
+	assigned-clock-rates = <(196608000 / 256)>,
+			       <196608000>;
+};
+
+&i2s0 {
+	status = "okay";
 };
 
 &pwm {
-- 
2.14.2
