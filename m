From: shawnguo@kernel.org (Shawn Guo)
Date: Wed,  9 Aug 2017 14:30:51 +0800
Subject: [PATCH 10/10] arm64: dts: zte: add initial zx296718-pcbox board
 support
In-Reply-To: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
References: <1502260251-6316-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1502260251-6316-11-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

It adds the initial zx296718-pcbox board support with devices like
storage, audio and VGA output enabled.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm64/boot/dts/zte/Makefile           |   1 +
 arch/arm64/boot/dts/zte/zx296718-pcbox.dts | 143 +++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)
 create mode 100644 arch/arm64/boot/dts/zte/zx296718-pcbox.dts

diff --git a/arch/arm64/boot/dts/zte/Makefile b/arch/arm64/boot/dts/zte/Makefile
index 667806620f59..d86c4def6bc9 100644
--- a/arch/arm64/boot/dts/zte/Makefile
+++ b/arch/arm64/boot/dts/zte/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_ZX) += zx296718-evb.dtb
+dtb-$(CONFIG_ARCH_ZX) += zx296718-pcbox.dtb
 
 always		:= $(dtb-y)
 subdir-y	:= $(dts-dirs)
diff --git a/arch/arm64/boot/dts/zte/zx296718-pcbox.dts b/arch/arm64/boot/dts/zte/zx296718-pcbox.dts
new file mode 100644
index 000000000000..e02509f7082b
--- /dev/null
+++ b/arch/arm64/boot/dts/zte/zx296718-pcbox.dts
@@ -0,0 +1,143 @@
+/*
+ * Copyright (C) 2017 Sanechips Technology Co., Ltd.
+ * Copyright 2017 Linaro Ltd.
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+#include "zx296718.dtsi"
+#include <dt-bindings/pwm/pwm.h>
+
+/ {
+	model = "ZTE ZX296718 PCBOX Board";
+	compatible = "zte,zx296718-pcbox", "zte,zx296718";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x80000000>;
+	};
+
+	a53_vdd0v9: regulator-a53 {
+		compatible = "pwm-regulator";
+		pwms = <&pwm 3 1250 PWM_POLARITY_INVERTED>;
+		regulator-name = "A53_VDD0V9";
+		regulator-min-microvolt = <855000>;
+		regulator-max-microvolt = <1183000>;
+		pwm-dutycycle-unit = <100>;
+		pwm-dutycycle-range = <0 100>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	sound-spdif0 {
+		compatible = "audio-graph-card";
+		dais = <&spdif0_port>;
+	};
+
+	sound-i2s0 {
+		compatible = "audio-graph-card";
+		dais = <&i2s0_port>;
+	};
+};
+
+&aud96p22 {
+	port {
+		aud96p22_endpoint: endpoint {
+			remote-endpoint = <&i2s0_endpoint>;
+		};
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&a53_vdd0v9>;
+};
+
+&emmc {
+	status = "okay";
+};
+
+&hdmi {
+	status = "disabled";
+
+	port {
+		hdmi_endpoint: endpoint {
+			remote-endpoint = <&spdif0_endpoint>;
+		};
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2s0 {
+	status = "okay";
+
+	i2s0_port: port {
+		i2s0_endpoint: endpoint {
+			remote-endpoint = <&aud96p22_endpoint>;
+			dai-format = "i2s";
+			frame-master;
+			bitclock-master;
+		};
+	};
+};
+
+&irdec {
+	status = "okay";
+};
+
+&pmm {
+	pwm3_pins: pwm3 {
+		pins = "KEY_ROW2";
+		function = "PWM";
+	};
+
+	vga_pins: vga {
+		pins = "KEY_COL1", "KEY_COL2", "VGA_HS", "VGA_VS";
+		function = "VGA";
+	};
+};
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm3_pins>;
+	status = "okay";
+};
+
+&sd0 {
+	status = "okay";
+};
+
+&sd1 {
+	status = "okay";
+};
+
+&spdif0 {
+	status = "okay";
+
+	spdif0_port: port {
+		spdif0_endpoint: endpoint {
+			remote-endpoint = <&hdmi_endpoint>;
+		};
+	};
+};
+
+&tvenc {
+	status = "disabled";
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&vga {
+	pinctrl-names = "default";
+	pinctrl-0 = <&vga_pins>;
+	status = "okay";
+};
-- 
1.9.1
