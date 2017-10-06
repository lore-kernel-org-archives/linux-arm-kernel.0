From: fabrizio.castro@bp.renesas.com (Fabrizio Castro)
Date: Fri,  6 Oct 2017 18:59:53 +0100
Subject: [PATCH v2 2/2] ARM: dts: iwg20d-q7-dbcm-ca: Add device trees for
 camera DB
In-Reply-To: <1507312793-6877-1-git-send-email-fabrizio.castro@bp.renesas.com>
References: <CAMuHMdW-Y7tK28YAGBRMqdgZK7vVqnUcud1FtzQd6wLrKii_AA@mail.gmail.com>
 <1507312793-6877-1-git-send-email-fabrizio.castro@bp.renesas.com>
Message-ID: <1507312793-6877-3-git-send-email-fabrizio.castro@bp.renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a .dtsi that describes the camera daughter board
and a .dts to describe the HW made of iWave's RZ/G1M SoM, iWave's
RZ/G1M/G1N Qseven carrier board, and the camera daughter board.
The camera daughter board .dtsi adds support for ttySC[14].

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
* Reodered nodes alphabetically

 arch/arm/boot/dts/Makefile                      |  1 +
 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi        | 43 +++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts | 19 +++++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
 create mode 100644 arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e87f311..8c34d06 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -724,6 +724,7 @@ dtb-$(CONFIG_ARCH_RENESAS) += \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
 	r8a7743-iwg20d-q7.dtb \
+	r8a7743-iwg20d-q7-dbcm-ca.dtb \
 	r8a7743-sk-rzg1m.dtb \
 	r8a7745-iwg22d-sodimm.dtb \
 	r8a7745-sk-rzg1e.dtb \
diff --git a/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
new file mode 100644
index 0000000..31fab5f
--- /dev/null
+++ b/arch/arm/boot/dts/iwg20d-q7-dbcm-ca.dtsi
@@ -0,0 +1,43 @@
+/*
+ * Device Tree Source for the iWave-RZ-G1M/N Daughter Board Camera Module
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/ {
+	aliases {
+		serial1 = &scif1;
+		serial4 = &hscif1;
+	};
+};
+
+&hscif1 {
+	pinctrl-0 = <&hscif1_pins>;
+	pinctrl-names = "default";
+
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&pfc {
+	hscif1_pins: hscif1 {
+		groups = "hscif1_data_c", "hscif1_ctrl_c";
+		function = "hscif1";
+	};
+
+	scif1_pins: scif1 {
+		groups = "scif1_data_d";
+		function = "scif1";
+	};
+};
+
+&scif1 {
+	pinctrl-0 = <&scif1_pins>;
+	pinctrl-names = "default";
+
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
new file mode 100644
index 0000000..d90eb84
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7-dbcm-ca.dts
@@ -0,0 +1,19 @@
+/*
+ * Device Tree Source for the iWave-RZ/G1M Qseven board + camera daughter board
+ *
+ * Copyright (C) 2017 Renesas Electronics Corp.
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7743-iwg20m.dtsi"
+#include "iwg20d-q7-common.dtsi"
+#include "iwg20d-q7-dbcm-ca.dtsi"
+
+/ {
+	model = "iW-RainboW-G20D-Q7 RZ/G1M based plus camera daughter board";
+	compatible = "iwave,g20d", "iwave,g20m", "renesas,r8a7743";
+};
-- 
2.7.4
