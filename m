From: jaz@semihalf.com (Grzegorz Jaszczyk)
Date: Thu,  4 Aug 2016 12:14:16 +0200
Subject: [PATCH v2 13/17] ARM: dts: mvebu: armada-395: add support for the
 Armada 395 SoC family
In-Reply-To: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
References: <1470305660-6601-1-git-send-email-jaz@semihalf.com>
Message-ID: <1470305660-6601-14-git-send-email-jaz@semihalf.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Beside interfaces described in the armada-39x.dtsi, the Armada 395 SoC
family supports: 2 x SATA3 (2 ports in one unit) and the USB3.0

Signed-off-by: Grzegorz Jaszczyk <jaz@semihalf.com>
---
 .../devicetree/bindings/arm/marvell/armada-39x.txt | 11 +++-
 arch/arm/boot/dts/armada-395.dtsi                  | 76 ++++++++++++++++++++++
 2 files changed, 85 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-395.dtsi

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt b/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
index 53d4ff9..2d92212 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-39x.txt
@@ -8,8 +8,15 @@ Required root node property:
 
  - compatible: must contain "marvell,armada390"
 
-In addition, boards using the Marvell Armada 398 SoC shall have the
-following property before the previous one:
+In addition, boards using the Marvell Armada 395 SoC shall have the
+following property before the common "marvell,armada390" one:
+
+Required root node property:
+
+compatible: must contain "marvell,armada395"
+
+Boards using the Marvell Armada 398 SoC shall have the following
+property before the common "marvell,armada390" one:
 
 Required root node property:
 
diff --git a/arch/arm/boot/dts/armada-395.dtsi b/arch/arm/boot/dts/armada-395.dtsi
new file mode 100644
index 0000000..ab5dc49
--- /dev/null
+++ b/arch/arm/boot/dts/armada-395.dtsi
@@ -0,0 +1,76 @@
+/*
+ * Device Tree Include file for Marvell Armada 395 SoC.
+ *
+ * Copyright (C) 2016 Marvell
+ *
+ * Grzegorz Jaszczyk <jaz@semihalf.com>
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
+#include "armada-39x.dtsi"
+
+/ {
+	compatible = "marvell,armada395", "marvell,armada390";
+
+	soc {
+		internal-regs {
+			pinctrl at 18000 {
+				compatible = "marvell,mv88f6925-pinctrl";
+				reg = <0x18000 0x20>;
+			};
+
+			sata at a8000 {
+				compatible = "marvell,armada-380-ahci";
+				reg = <0xa8000 0x2000>;
+				interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 15>;
+				status = "disabled";
+			};
+
+			usb3 at f0000 {
+				compatible = "marvell,armada-380-xhci";
+				reg = <0xf0000 0x4000>,<0xf4000 0x4000>;
+				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&gateclk 9>;
+				status = "disabled";
+			};
+		};
+	};
+};
-- 
1.8.3.1
