From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 May 2017 15:59:08 +0200
Subject: [PATCH 35/35] arm64: dts: r8a7795: salvator-x: Add support for R-Car
 H3 ES2.0
In-Reply-To: <cover.1495457812.git.horms+renesas@verge.net.au>
References: <cover.1495457812.git.horms+renesas@verge.net.au>
Message-ID: <0b03c32db03d63de695c1e0ab1950eb12b135fa7.1495457812.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Split off support for Salvator-X boards with the ES1.x revision of the
R-Car H3 SoC into a separate file.  The main r8a7795-salvator-x.dts file
now corresponds to Salvator-X with R-Car H3 ES2.0 or later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/Makefile               |   1 +
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    | 115 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |   4 +-
 3 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 1618e0a3c81d..b6c723d8f687 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -1,4 +1,5 @@
 dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
+dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-salvator-x.dtb
 dtb-$(CONFIG_ARCH_R8A7796) += r8a7796-salvator-x.dtb r8a7796-m3ulcb.dtb
 
 always		:= $(dtb-y)
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
new file mode 100644
index 000000000000..b84c156ed696
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
@@ -0,0 +1,115 @@
+/*
+ * Device Tree Source for the Salvator-X board
+ *
+ * Copyright (C) 2015 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
+
+/dts-v1/;
+#include "r8a7795-es1.dtsi"
+#include "salvator-x.dtsi"
+
+/ {
+	model = "Renesas Salvator-X board based on r8a7795 ES1.x";
+	compatible = "renesas,salvator-x", "renesas,r8a7795";
+
+	memory at 48000000 {
+		device_type = "memory";
+		/* first 128MB is reserved for secure area. */
+		reg = <0x0 0x48000000 0x0 0x38000000>;
+	};
+
+	memory at 500000000 {
+		device_type = "memory";
+		reg = <0x5 0x00000000 0x0 0x40000000>;
+	};
+
+	memory at 600000000 {
+		device_type = "memory";
+		reg = <0x6 0x00000000 0x0 0x40000000>;
+	};
+
+	memory at 700000000 {
+		device_type = "memory";
+		reg = <0x7 0x00000000 0x0 0x40000000>;
+	};
+};
+
+&du {
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&cpg CPG_MOD 722>,
+		 <&cpg CPG_MOD 721>,
+		 <&cpg CPG_MOD 727>,
+		 <&versaclock5 1>,
+		 <&x21_clk>,
+		 <&x22_clk>,
+		 <&versaclock5 2>;
+	clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&hdmi0 {
+	status = "okay";
+
+	ports {
+		port at 1 {
+			reg = <1>;
+			rcar_dw_hdmi0_out: endpoint {
+				remote-endpoint = <&hdmi0_con>;
+			};
+		};
+	};
+};
+
+&hdmi0_con {
+	remote-endpoint = <&rcar_dw_hdmi0_out>;
+};
+
+&hdmi1 {
+	status = "okay";
+
+	ports {
+		port at 1 {
+			reg = <1>;
+			rcar_dw_hdmi1_out: endpoint {
+				remote-endpoint = <&hdmi1_con>;
+			};
+		};
+	};
+};
+
+&hdmi1_con {
+	remote-endpoint = <&rcar_dw_hdmi1_out>;
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&pfc {
+	usb2_pins: usb2 {
+		groups = "usb2";
+		function = "usb2";
+	};
+};
+
+&sata {
+	status = "okay";
+};
+
+&usb2_phy2 {
+	pinctrl-0 = <&usb2_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index b84c156ed696..684fb3b9d154 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -11,11 +11,11 @@
 #define CPG_AUDIO_CLK_I		R8A7795_CLK_S0D4
 
 /dts-v1/;
-#include "r8a7795-es1.dtsi"
+#include "r8a7795.dtsi"
 #include "salvator-x.dtsi"
 
 / {
-	model = "Renesas Salvator-X board based on r8a7795 ES1.x";
+	model = "Renesas Salvator-X board based on r8a7795 ES2.0+";
 	compatible = "renesas,salvator-x", "renesas,r8a7795";
 
 	memory at 48000000 {
-- 
2.1.4
