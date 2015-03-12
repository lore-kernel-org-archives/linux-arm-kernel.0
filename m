From: stefan@agner.ch (Stefan Agner)
Date: Fri, 13 Mar 2015 00:36:19 +0100
Subject: [PATCH v3 11/12] ARM: dts: add support for Vybrid running on Cortex-M4
In-Reply-To: <1426203380-7155-1-git-send-email-stefan@agner.ch>
References: <1426203380-7155-1-git-send-email-stefan@agner.ch>
Message-ID: <1426203380-7155-12-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds an initial device tree to run Linux on the Cortex-M4 on
the Vybrid based Colibri VF61 module.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/Makefile            |  1 +
 arch/arm/boot/dts/vf610m4-colibri.dts | 98 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/vf610m4.dtsi        | 50 ++++++++++++++++++
 3 files changed, 149 insertions(+)
 create mode 100644 arch/arm/boot/dts/vf610m4-colibri.dts
 create mode 100644 arch/arm/boot/dts/vf610m4.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index a1c776b..3a6ff9f 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -309,6 +309,7 @@ dtb-$(CONFIG_SOC_LS1021A) += \
 dtb-$(CONFIG_SOC_VF610) += \
 	vf500-colibri-eval-v3.dtb \
 	vf610-colibri-eval-v3.dtb \
+	vf610m4-colibri.dtb \
 	vf610-cosmic.dtb \
 	vf610-twr.dtb
 dtb-$(CONFIG_ARCH_MXS) += \
diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
new file mode 100644
index 0000000..acd6cb5
--- /dev/null
+++ b/arch/arm/boot/dts/vf610m4-colibri.dts
@@ -0,0 +1,98 @@
+/*
+ * Device tree for Colibri VF61 Cortex-M4 support
+ *
+ * Copyright (C) 2015 Stefan Agner
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+#include "vf610m4.dtsi"
+
+/ {
+	model = "VF610 Cortex-M4";
+	compatible = "fsl,vf610m4";
+
+	chosen {
+		bootargs = "console=ttyLP2,115200 clk_ignore_unused init=/linuxrc rw";
+	};
+
+	memory {
+		reg = <0x8c000000 0x3000000>;
+	};
+};
+
+&gpio0 {
+	status = "disabled";
+};
+
+&gpio1 {
+	status = "disabled";
+};
+
+&gpio2 {
+	status = "disabled";
+};
+
+&gpio3 {
+	status = "disabled";
+};
+
+&gpio4 {
+	status = "disabled";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
+};
+
+&iomuxc {
+	vf610-colibri {
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				VF610_PAD_PTD0__UART2_TX		0x21a2
+				VF610_PAD_PTD1__UART2_RX		0x21a1
+				VF610_PAD_PTD2__UART2_RTS		0x21a2
+				VF610_PAD_PTD3__UART2_CTS		0x21a1
+			>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/vf610m4.dtsi b/arch/arm/boot/dts/vf610m4.dtsi
new file mode 100644
index 0000000..9ffe2eb
--- /dev/null
+++ b/arch/arm/boot/dts/vf610m4.dtsi
@@ -0,0 +1,50 @@
+/*
+ * Device tree for VF6xx Cortex-M4 support
+ *
+ * Copyright (C) 2015 Stefan Agner
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "armv7-m.dtsi"
+#include "vfxxx.dtsi"
+
+&mscm_ir {
+	interrupt-parent = <&nvic>;
+};
-- 
2.3.1
