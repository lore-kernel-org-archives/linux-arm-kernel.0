From: nikita@compulab.co.il (Nikita Kiryanov)
Date: Tue,  1 Dec 2015 15:55:07 +0200
Subject: [PATCH V2 12/14] ARM: dts: sb-som: introduce SB-SOM baseboard
In-Reply-To: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
References: <1448978109-5614-1-git-send-email-nikita@compulab.co.il>
Message-ID: <1448978109-5614-13-git-send-email-nikita@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CompuLab SB-SOM baseboard is a carrier board for multiple arm-based SoMs.
It currently supports (with minor adjustments to assembly) CM-T43, CM-T54,
and CM-QS600 modules. It is a building block in the SBC-T43 single board
computer, which consists of cm-t43 on top of sb-som-t43.

Signed-off-by: Nikita Kiryanov <nikita@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <bcousson@baylibre.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
---
Changes in V2:
	- Renamed file startek,startek-kd050c to startek,startek-kd050c.txt.
	- s/QS-600/CM-QS600 in file compulab-boards.txt

 .../devicetree/bindings/arm/compulab-boards.txt    |  5 +++
 .../display/panel/startek,startek-kd050c.txt       |  4 +++
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm/boot/dts/compulab-sb-som.dtsi             | 42 ++++++++++++++++++++++
 4 files changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/compulab-boards.txt
 create mode 100644 Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt
 create mode 100644 arch/arm/boot/dts/compulab-sb-som.dtsi

diff --git a/Documentation/devicetree/bindings/arm/compulab-boards.txt b/Documentation/devicetree/bindings/arm/compulab-boards.txt
new file mode 100644
index 0000000..71172d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/compulab-boards.txt
@@ -0,0 +1,5 @@
+CompuLab SB-SOM is a multi-module baseboard capable of carrying CM-T43, CM-T54,
+and CM-QS600 modules with minor modifications to the SB-SOM assembly.
+
+Required root node properties:
+    - compatible = should be "compulab,sb-som"
diff --git a/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt
new file mode 100644
index 0000000..70cd8d1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/startek,startek-kd050c.txt
@@ -0,0 +1,4 @@
+Startek Electronic Technology Co. KD050C 5.0" WVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "startek,startek-kd050c"
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d4..409b134 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -218,6 +218,7 @@ sony	Sony Corporation
 spansion	Spansion Inc.
 sprd	Spreadtrum Communications Inc.
 st	STMicroelectronics
+startek	Startek
 ste	ST-Ericsson
 stericsson	ST-Ericsson
 synology	Synology, Inc.
diff --git a/arch/arm/boot/dts/compulab-sb-som.dtsi b/arch/arm/boot/dts/compulab-sb-som.dtsi
new file mode 100644
index 0000000..402a143
--- /dev/null
+++ b/arch/arm/boot/dts/compulab-sb-som.dtsi
@@ -0,0 +1,42 @@
+/*
+ * Copyright (C) 2015 CompuLab, Ltd. - http://www.compulab.co.il/
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	model = "CompuLab SB-SOM";
+	compatible = "compulab,sb-som";
+
+	vsb_3v3: fixedregulator-v3_3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vsb_3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+		enable-active-high;
+	};
+
+	lcd0: display {
+		compatible = "startek,startek-kd050c", "panel-dpi";
+		label = "lcd";
+
+		panel-timing {
+			clock-frequency = <33000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <40>;
+			hback-porch = <40>;
+			hsync-len = <43>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			vsync-len = <3>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+	};
+};
-- 
1.9.1
