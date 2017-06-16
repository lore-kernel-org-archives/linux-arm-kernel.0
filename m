From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:42 +0200
Subject: [PATCH 2/6] ARM: dts: r7s72100: Add support for GR-Peach
In-Reply-To: <cover.1497618353.git.horms+renesas@verge.net.au>
References: <cover.1497618353.git.horms+renesas@verge.net.au>
Message-ID: <b879d674e03fccb42b0e79f21b2105ad6a824229.1497618353.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jacopo Mondi <jacopo+renesas@jmondi.org>

Add device tree source for Renesas GR-Peach board.
GR-Peach is an RZ/A1H based board with 10MB of on-chip SRAM and 8MB
QSPI flash storage.
Add support for the board, and create a 2MB partition to use as rootfs.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/r7s72100-gr-peach.dts            | 66 ++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 arch/arm/boot/dts/r7s72100-gr-peach.dts

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index 170fe0562c63..4b60ce21f4f3 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -55,6 +55,8 @@ Boards:
     compatible = "renesas,bockw", "renesas,r8a7778"
   - Genmai (RTK772100BC00000BR)
     compatible = "renesas,genmai", "renesas,r7s72100"
+  - GR-Peach (X28A-M01-E/F)
+    compatible = "renesas,gr-peach", "renesas,r7s72100"
   - Gose (RTP0RC7793SEB00010S)
     compatible = "renesas,gose", "renesas,r8a7793"
   - H3ULCB (R-Car Starter Kit Premier, RTP0RC7795SKB00010S)
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9c5e1d944d1c..9d64197f3e91 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -701,6 +701,7 @@ dtb-$(CONFIG_ARCH_REALVIEW) += \
 dtb-$(CONFIG_ARCH_RENESAS) += \
 	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
+	r7s72100-gr-peach.dtb \
 	r7s72100-rskrza1.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
new file mode 100644
index 000000000000..a1b2aef984f6
--- /dev/null
+++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
@@ -0,0 +1,66 @@
+/*
+ * Device Tree Source for the GR-Peach board
+ *
+ * Copyright (C) 2017 Jacopo Mondi <jacopo+renesas@jmondi.org>
+ * Copyright (C) 2016 Renesas Electronics
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r7s72100.dtsi"
+
+/ {
+	model = "GR-Peach";
+	compatible = "renesas,gr-peach", "renesas,r7s72100";
+
+	aliases {
+		serial0 = &scif2;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/mtdblock0";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory at 20000000 {
+		device_type = "memory";
+		reg = <0x20000000 0x00a00000>;
+
+	};
+
+	lbsc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	flash at 18000000 {
+		compatible = "mtd-rom";
+		probe-type = "map_rom";
+		reg = <0x18000000 0x00800000>;
+		bank-width = <4>;
+		device-width = <1>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		rootfs at 600000 {
+			label = "rootfs";
+			reg = <0x00600000 0x00200000>;
+		};
+	};
+};
+
+&extal_clk {
+	clock-frequency = <13333000>;
+};
+
+&usb_x1_clk {
+	clock-frequency = <48000000>;
+};
+
+&scif2 {
+	status = "okay";
+};
-- 
2.1.4
