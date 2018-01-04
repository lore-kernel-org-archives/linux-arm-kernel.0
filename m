From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 4 Jan 2018 17:40:55 +0800
Subject: [PATCH 05/12] arm64: dts: mt7622: add PMIC MT6380 related nodes
In-Reply-To: <cover.1515057696.git.sean.wang@mediatek.com>
References: <cover.1515057696.git.sean.wang@mediatek.com>
Message-ID: <0109846a8a501ca3cae33acfceb919960fddfcbf.1515057696.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Enable pwrap and MT6380 on mt7622-rfb1 board. Also add all mt6380
regulator nodes in an alone file to allow similar boards using MT6380
able to resue the configuration.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6380.dtsi     | 91 ++++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts |  8 +++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     | 12 ++++
 3 files changed, 111 insertions(+)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt6380.dtsi

diff --git a/arch/arm64/boot/dts/mediatek/mt6380.dtsi b/arch/arm64/boot/dts/mediatek/mt6380.dtsi
new file mode 100644
index 0000000..7eb7dc2
--- /dev/null
+++ b/arch/arm64/boot/dts/mediatek/mt6380.dtsi
@@ -0,0 +1,91 @@
+/*
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Chenglin Xu <chenglin.xu@mediatek.com>
+ *	   Sean Wang <sean.wang@mediatek.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+&pwrap {
+	regulators {
+		compatible = "mediatek,mt6380-regulator";
+
+		mt6380_vcpu_reg: buck-vcore1 {
+			regulator-name = "vcore1";
+			regulator-min-microvolt = < 600000>;
+			regulator-max-microvolt = <1393750>;
+			regulator-ramp-delay = <6250>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vcore_reg: buck-vcore {
+			regulator-name = "vcore";
+			regulator-min-microvolt = <600000>;
+			regulator-max-microvolt = <1393750>;
+			regulator-ramp-delay = <6250>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vrf_reg: buck-vrf {
+			regulator-name = "vrf";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1575000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vm_reg: ldo-vm {
+			regulator-name = "vm";
+			regulator-min-microvolt = <1050000>;
+			regulator-max-microvolt = <1400000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_va_reg: ldo-va {
+			regulator-name = "va";
+			regulator-min-microvolt = <2200000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vphy_reg: ldo-vphy {
+			regulator-name = "vphy";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vddr_reg: ldo-vddr {
+			regulator-name = "vddr";
+			regulator-min-microvolt = <1240000>;
+			regulator-max-microvolt = <1840000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+
+		mt6380_vt_reg: ldo-vt {
+			regulator-name = "vt";
+			regulator-min-microvolt = <2200000>;
+			regulator-max-microvolt = <3300000>;
+			regulator-ramp-delay = <0>;
+			regulator-always-on;
+			regulator-boot-on;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index c77e77a..f72f1f5 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -10,6 +10,7 @@
 #include <dt-bindings/input/input.h>
 
 #include "mt7622.dtsi"
+#include "mt6380.dtsi"
 
 / {
 	model = "MediaTek MT7622 RFB1 board";
@@ -222,6 +223,13 @@
 	};
 };
 
+&pwrap {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pmic_bus_pins>;
+
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index a531278..5b7f0a3 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -102,6 +102,18 @@
 		#reset-cells = <1>;
 	};
 
+	pwrap: pwrap at 10001000 {
+		compatible = "mediatek,mt7622-pwrap";
+		reg = <0 0x10001000 0 0x250>;
+		reg-names = "pwrap";
+		clocks = <&infracfg CLK_INFRA_PMIC_PD>,<&pwrap_clk>;
+		clock-names = "spi","wrap";
+		resets = <&infracfg MT7622_INFRA_PMIC_WRAP_RST>;
+		reset-names = "pwrap";
+		interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH>;
+		status = "disabled";
+	};
+
 	pericfg: pericfg at 10002000 {
 		compatible = "mediatek,mt7622-pericfg",
 			     "syscon";
-- 
2.7.4
