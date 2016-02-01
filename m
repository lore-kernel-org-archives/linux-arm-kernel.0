From: andre.przywara@arm.com (Andre Przywara)
Date: Mon,  1 Feb 2016 17:39:30 +0000
Subject: [PATCH 11/11] arm64: dts: add Pine64 support
In-Reply-To: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
References: <1454348370-3816-1-git-send-email-andre.przywara@arm.com>
Message-ID: <1454348370-3816-12-git-send-email-andre.przywara@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Pine64 is a cost-efficient development board based on the
Allwinner A64 SoC.
There are three models: the basic version with Fast Ethernet and
512 MB of DRAM (Pine64) and two Pine64+ versions, which both
feature Gigabit Ethernet and additional connectors for touchscreens
and a camera. Or as my son put it: "Those are smaller and these are
missing." ;-)
The two Pine64+ models just differ in the amount of DRAM
(1GB vs. 2GB). Since U-Boot will figure out the right size for us and
patches the DT accordingly we just need to provide one DT for the
Pine64+.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm64/boot/dts/Makefile                       |  1 +
 arch/arm64/boot/dts/allwinner/Makefile             |  5 ++
 arch/arm64/boot/dts/allwinner/pine64.dts           | 58 +++++++++++++++++
 arch/arm64/boot/dts/allwinner/pine64_common.dtsi   | 76 ++++++++++++++++++++++
 arch/arm64/boot/dts/allwinner/pine64_plus.dts      | 59 +++++++++++++++++
 6 files changed, 200 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/Makefile
 create mode 100644 arch/arm64/boot/dts/allwinner/pine64.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/pine64_common.dtsi
 create mode 100644 arch/arm64/boot/dts/allwinner/pine64_plus.dts

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 72e2c5a..0c22fa9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -175,6 +175,7 @@ parade	Parade Technologies Inc.
 pericom	Pericom Technology Inc.
 phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
+pine64	Pine64
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
 pixcir  PIXCIR MICROELECTRONICS Co., Ltd
diff --git a/arch/arm64/boot/dts/Makefile b/arch/arm64/boot/dts/Makefile
index f832b8a..3b7428a 100644
--- a/arch/arm64/boot/dts/Makefile
+++ b/arch/arm64/boot/dts/Makefile
@@ -1,3 +1,4 @@
+dts-dirs += allwinner
 dts-dirs += altera
 dts-dirs += amd
 dts-dirs += apm
diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
new file mode 100644
index 0000000..65f4e24
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/Makefile
@@ -0,0 +1,5 @@
+dtb-$(CONFIG_ARCH_SUNXI) += pine64_plus.dtb pine64.dtb
+
+always		:= $(dtb-y)
+subdir-y	:= $(dts-dirs)
+clean-files	:= *.dtb
diff --git a/arch/arm64/boot/dts/allwinner/pine64.dts b/arch/arm64/boot/dts/allwinner/pine64.dts
new file mode 100644
index 0000000..ebea5dd
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/pine64.dts
@@ -0,0 +1,58 @@
+/*
+ * Copyright (c) 2016 ARM Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "pine64_common.dtsi"
+
+/ {
+	model = "Pine64";
+	compatible = "pine64,pine64", "allwinner,a64", "allwinner,sunxi";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		reg = <0x40000000 0x20000000>;
+	};
+};
diff --git a/arch/arm64/boot/dts/allwinner/pine64_common.dtsi b/arch/arm64/boot/dts/allwinner/pine64_common.dtsi
new file mode 100644
index 0000000..d968d76
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/pine64_common.dtsi
@@ -0,0 +1,76 @@
+/*
+ * Copyright (c) 2016 ARM Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "a64.dtsi"
+
+&mmc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc0_pins>, <&mmc0_default_cd_pin>;
+	vmmc-supply = <&reg_vcc3v3>;
+	cd-gpios = <&pio 5 6 0>;
+	cd-inverted;
+	status = "okay";
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart0_pins_a>;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins_a>;
+	status = "okay";
+};
+
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/allwinner/pine64_plus.dts b/arch/arm64/boot/dts/allwinner/pine64_plus.dts
new file mode 100644
index 0000000..344752e
--- /dev/null
+++ b/arch/arm64/boot/dts/allwinner/pine64_plus.dts
@@ -0,0 +1,59 @@
+/*
+ * Copyright (c) 2016 ARM Ltd.
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This library is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This library is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+/dts-v1/;
+
+#include "pine64_common.dtsi"
+
+/ {
+	model = "Pine64+";
+	compatible = "pine64,pine64_plus", "allwinner,a64", "allwinner,sunxi";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	/* There is a model with 2GB of DRAM, but U-Boot fixes this for us. */
+	memory {
+		reg = <0x40000000 0x40000000>;
+	};
+};
-- 
2.6.4
