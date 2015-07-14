From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 14 Jul 2015 15:39:52 +0200
Subject: [PATCH 17/17] ARM: dts: add DT for CIAA LPC4337 industrial computer
In-Reply-To: <1436881192-23930-1-git-send-email-manabian@gmail.com>
References: <1436881192-23930-1-git-send-email-manabian@gmail.com>
Message-ID: <1436881192-23930-18-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Add basic support for CIAA (Argentine Open Industrial Computer)
LPC4337 board. This commit enables the following peripherals:
  * UART
  * SSP
  * Ethernet

Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---
 arch/arm/boot/dts/Makefile         |   1 +
 arch/arm/boot/dts/lpc4337-ciaa.dts | 187 +++++++++++++++++++++++++++++++++++++
 2 files changed, 188 insertions(+)
 create mode 100644 arch/arm/boot/dts/lpc4337-ciaa.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 246473a244f6..d43f55034eed 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -211,6 +211,7 @@ dtb-$(CONFIG_MACH_KIRKWOOD) += \
 	kirkwood-ts419-6281.dtb \
 	kirkwood-ts419-6282.dtb
 dtb-$(CONFIG_ARCH_LPC18XX) += \
+	lpc4337-ciaa.dtb \
 	lpc4350-hitex-eval.dtb \
 	lpc4357-ea4357-devkit.dtb
 dtb-$(CONFIG_ARCH_LPC32XX) += \
diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/lpc4337-ciaa.dts
new file mode 100644
index 000000000000..5f500c1ad89c
--- /dev/null
+++ b/arch/arm/boot/dts/lpc4337-ciaa.dts
@@ -0,0 +1,187 @@
+/*
+ * CIAA NXP LPC4337 (http://www.proyecto-ciaa.com.ar)
+ *
+ * Copyright (C) 2015 VanguardiaSur - www.vanguardiasur.com.ar
+ *
+ * This code is released using a dual license strategy: BSD/GPL
+ * You can choose the licence that better fits your requirements.
+ *
+ * Released under the terms of 3-clause BSD License
+ * Released under the terms of GNU General Public License Version 2.0
+ */
+/dts-v1/;
+
+#include "lpc18xx.dtsi"
+#include "lpc4357.dtsi"
+
+#include "dt-bindings/gpio/gpio.h"
+
+/ {
+	model = "CIAA NXP LPC4337";
+	compatible = "ciaa,lpc4337", "nxp,lpc4337", "nxp,lpc4350";
+
+	aliases {
+		serial0 = &uart2;
+		serial1 = &uart3;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+		stdout-path = &uart2;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x28000000 0x0800000>; /* 8 MB */
+	};
+};
+
+&pinctrl {
+	enet_rmii_pins: enet-rmii-pins {
+		enet_rmii_rxd_cfg {
+			pins = "p1_15", "p0_0";
+			function = "enet";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_rmii_txd_cfg {
+			pins = "p1_18", "p1_20";
+			function = "enet";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_rmii_rx_dv_cfg {
+			pins = "p1_16";
+			function = "enet";
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_rmii_tx_en_cfg {
+			pins = "p0_1";
+			function = "enet";
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_ref_clk_cfg {
+			pins = "p1_19";
+			function = "enet";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_mdio_cfg {
+			pins = "p1_17";
+			function = "enet";
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		enet_mdc_cfg {
+			pins = "p7_7";
+			function = "enet";
+			slew-rate = <1>;
+			bias-disable;
+			input-enable;
+			input-schmitt-disable;
+		};
+	};
+
+	ssp_pins: ssp-pins {
+		ssp1_cs {
+			pins = "p6_7";
+			function = "gpio";
+			bias-pull-up;
+			bias-disable;
+		};
+
+		ssp1_miso_mosi {
+			pins = "p1_3", "p1_4";
+			function = "ssp1";
+			slew-rate = <1>;
+			bias-pull-down;
+			input-enable;
+			input-schmitt-disable;
+		};
+
+		ssp1_sck {
+			pins = "pf_4";
+			function = "ssp1";
+			slew-rate = <1>;
+			bias-disable;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		uart2_rx_cfg {
+			pins = "p7_2";
+			function = "uart2";
+			bias-disable;
+			input-enable;
+		};
+
+		uart2_tx_cfg {
+			pins = "p7_1";
+			function = "uart2";
+			bias-disable;
+		};
+	};
+
+	uart3_pins: uart3-pins {
+		uart3_rx_cfg {
+			pins = "p2_4";
+			function = "uart3";
+			bias-disable;
+			input-enable;
+		};
+
+		uart3_tx_cfg {
+			pins = "p2_3";
+			function = "uart3";
+			bias-disable;
+		};
+	};
+};
+
+&enet_tx_clk {
+	clock-frequency = <50000000>;
+};
+
+&mac {
+	status = "okay";
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&enet_rmii_pins>;
+};
+
+&ssp1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&ssp_pins>;
+	cs-gpios = <&gpio LPC_GPIO(5,15) GPIO_ACTIVE_HIGH>;
+	num-cs = <1>;
+};
+
+&uart2 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+};
+
+&uart3 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+};
-- 
1.8.0
