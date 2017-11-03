From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 03 Nov 2017 17:43:14 +0100
Subject: [PATCH 2/2] ARM: dts: exynos: Add sound support for Odroid XU4
In-Reply-To: <20171103164314.14919-1-s.nawrocki@samsung.com>
References: <20171103164314.14919-1-s.nawrocki@samsung.com>
 <CGME20171103164455epcas2p44ec77c21dd25ad37cb088d5d92a4331a@epcas2p4.samsung.com>
Message-ID: <20171103164314.14919-3-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for Odroid XU4 audio. The main difference
comparing to Odroid XU3 is a missing on-board audio CODEC, only
HDMI output is supported on Odroid XU4. External CODEC could be
optionally connected to the I2S port connector.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu4-audio.dtsi | 67 +++++++++++++++++++++++
 arch/arm/boot/dts/exynos5422-odroidxu4.dts        |  1 +
 2 files changed, 68 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5422-odroidxu4-audio.dtsi

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu4-audio.dtsi
new file mode 100644
index 000000000000..1d190d3378a8
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4-audio.dtsi
@@ -0,0 +1,67 @@
+/*
+ * Hardkernel Odroid XU4 audio subsystem device tree source
+ *
+ * Copyright (c) 2017 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#include <dt-bindings/sound/samsung-i2s.h>
+
+/ {
+	sound: sound {
+		compatible = "samsung,odroid-xu3-audio";
+		model = "Odroid-XU4";
+
+		cpu {
+			sound-dai = <&i2s0 0>;
+		};
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
+};
+
+&sound {
+	assigned-clocks = <&i2s0 CLK_I2S_RCLK_SRC>,
+			<&clock CLK_MOUT_EPLL>,
+			<&clock CLK_MOUT_MAU_EPLL>,
+			<&clock CLK_MOUT_USER_MAU_EPLL>,
+			<&clock_audss EXYNOS_MOUT_AUDSS>,
+			<&clock_audss EXYNOS_MOUT_I2S>,
+			<&clock_audss EXYNOS_DOUT_SRP>,
+			<&clock_audss EXYNOS_DOUT_AUD_BUS>,
+			<&clock_audss EXYNOS_DOUT_I2S>;
+
+	assigned-clock-parents = <&clock_audss EXYNOS_SCLK_I2S>,
+			<&clock CLK_FOUT_EPLL>,
+			<&clock CLK_MOUT_EPLL>,
+			<&clock CLK_MOUT_MAU_EPLL>,
+			<&clock CLK_MAU_EPLL>,
+			<&clock_audss EXYNOS_MOUT_AUDSS>;
+
+	assigned-clock-rates = <0>,
+			<0>,
+			<0>,
+			<0>,
+			<0>,
+			<0>,
+			<196608001>,
+		       <(196608002 / 2)>,
+			<196608000>;
+};
+
diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 2faf88627a48..a96853b82861 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -13,6 +13,7 @@
 
 /dts-v1/;
 #include "exynos5422-odroidxu3-common.dtsi"
+#include "exynos5422-odroidxu4-audio.dtsi"
 
 / {
 	model = "Hardkernel Odroid XU4";
-- 
2.14.2
