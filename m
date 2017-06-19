From: jbrunet@baylibre.com (Jerome Brunet)
Date: Mon, 19 Jun 2017 11:04:40 +0200
Subject: [PATCH v2 3/3] ARM64: dts: meson-gxl: Add Libre Technology CC support
In-Reply-To: <20170619090440.27099-1-jbrunet@baylibre.com>
References: <20170619090440.27099-1-jbrunet@baylibre.com>
Message-ID: <20170619090440.27099-4-jbrunet@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the CC  board from Shenzhen Libre Technology
More information about the board are available here:

https://libre.computer/blog/

Cc: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/Makefile               |  1 +
 .../dts/amlogic/meson-gxl-s905x-libretech-cc.dts   | 92 ++++++++++++++++++++++
 2 files changed, 93 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts

diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
index 8a0e09250978..7a9f48c27b1f 100644
--- a/arch/arm64/boot/dts/amlogic/Makefile
+++ b/arch/arm64/boot/dts/amlogic/Makefile
@@ -10,6 +10,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-hub.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-wetek-play2.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-hwacom-amazetv.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-khadas-vim.dtb
+dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-libretech-cc.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-nexbox-a95x.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905x-p212.dtb
 dtb-$(CONFIG_ARCH_MESON) += meson-gxl-s905d-p230.dtb
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
new file mode 100644
index 000000000000..890821d6e52b
--- /dev/null
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -0,0 +1,92 @@
+/*
+ * Copyright (c) 2017 BayLibre, SAS.
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+
+#include "meson-gxl-s905x-p212.dtsi"
+
+/ {
+	compatible = "libretech,cc", "amlogic,s905x", "amlogic,meson-gxl";
+	model = "Libre Technology CC";
+
+	cvbs-connector {
+		compatible = "composite-video-connector";
+
+		port {
+			cvbs_connector_in: endpoint {
+				remote-endpoint = <&cvbs_vdac_out>;
+			};
+		};
+	};
+
+	hdmi-connector {
+		compatible = "hdmi-connector";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_tmds_out>;
+			};
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		system {
+			label = "librecomputer:system-status";
+			gpios = <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			panic-indicator;
+		};
+
+		blue {
+			label = "librecomputer:blue";
+			gpios = <&gpio_ao GPIOAO_2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&cvbs_vdac_port {
+	cvbs_vdac_out: endpoint {
+		remote-endpoint = <&cvbs_connector_in>;
+	};
+};
+
+&hdmi_tx {
+	status = "okay";
+	pinctrl-0 = <&hdmi_hpd_pins>, <&hdmi_i2c_pins>;
+	pinctrl-names = "default";
+};
+
+&hdmi_tx_tmds_port {
+	hdmi_tx_tmds_out: endpoint {
+		remote-endpoint = <&hdmi_connector_in>;
+	};
+};
+
+/*
+ * The following devices exists but are exposed on the general
+ * purpose GPIO header. End user may well decide to use those pins
+ * for another purpose
+ */
+
+&sd_emmc_a {
+	status = "disabled";
+};
+
+&uart_A {
+	status = "disabled";
+};
+
+&wifi32k {
+	status = "disabled";
+};
-- 
2.9.4
