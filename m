From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Thu, 3 Jul 2014 16:39:59 +0300
Subject: [PATCH 3/4] arm/dts: am43x EPOS HDMI support
In-Reply-To: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
References: <1404394800-18138-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1404394800-18138-4-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AM43x EPOS board has both LCD and HDMI outputs. The active display is
selected with a GPIO, which affects video and audio signal routing, and
LCD backlight.

Managing the gpio dynamically has proven rather difficult, so the
approach taken here is just to have two separate .dts files for LCD/HDMI
use cases. The HDMI dts file includes the base file, which has LCD
support, and overrides and adds the necessary items.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/Makefile                |  3 +-
 arch/arm/boot/dts/am43x-epos-evm-hdmi.dts | 83 +++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/am43x-epos-evm-hdmi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5986ff63b901..5a1fba6d10b5 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -301,7 +301,8 @@ dtb-$(CONFIG_ARCH_OMAP4) += omap4-duovero-parlor.dtb \
 	omap4-var-dvk-om44.dtb \
 	omap4-var-stk-om44.dtb
 dtb-$(CONFIG_SOC_AM43XX) += am43x-epos-evm.dtb \
-	am437x-gp-evm.dtb
+	am437x-gp-evm.dtb \
+	am43x-epos-evm-hdmi.dtb
 dtb-$(CONFIG_SOC_OMAP5) += omap5-cm-t54.dtb \
 	omap5-sbc-t54.dtb \
 	omap5-uevm.dtb
diff --git a/arch/arm/boot/dts/am43x-epos-evm-hdmi.dts b/arch/arm/boot/dts/am43x-epos-evm-hdmi.dts
new file mode 100644
index 000000000000..9e52b220084d
--- /dev/null
+++ b/arch/arm/boot/dts/am43x-epos-evm-hdmi.dts
@@ -0,0 +1,83 @@
+/*
+ * Copyright (C) 2014 Texas Instruments Incorporated - http://www.ti.com/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/* AM43x EPOS EVM with HDMI output */
+
+#include "am43x-epos-evm.dts"
+
+/ {
+	aliases {
+		display0 = &hdmi;
+	};
+
+	hdmi: connector {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+
+		type = "b";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
+};
+
+&am43xx_pinmux {
+	sii9022_pins: sii9022_pins {
+		pinctrl-single,pins = <
+			0x48 (PIN_INPUT | MUX_MODE7)	/* gpmc_a2.gpio1_18 */
+		>;
+	};
+};
+
+&i2c2 {
+	sii9022 at 3b {
+		compatible = "sil,sii9022";
+		reg = <0x3b>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&sii9022_pins>;
+
+		reset-gpio = <&gpio2 1 GPIO_ACTIVE_LOW>;/* 65'SelLCDorHDMI' Gpio, LOW to select HDMI */
+
+		interrupt-parent = <&gpio1>;
+		interrupts = <18 IRQ_TYPE_LEVEL_LOW>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi_out>;
+				};
+			};
+
+			port at 1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+};
+
+&dss {
+	port {
+		dpi_out: endpoint at 0 {
+			remote-endpoint = <&sii9022_in>;
+			data-lines = <24>;
+		};
+	};
+};
-- 
1.9.1
