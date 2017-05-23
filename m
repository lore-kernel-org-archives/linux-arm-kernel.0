From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Tue, 23 May 2017 21:20:54 +0200
Subject: [PATCH] arm: dts: r7s72100: Add support for GR-Peach
Message-ID: <1495567254-10226-1-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device tree source for Renesas GR-Peach board.
GR-Peach is an RZ/A1H based board with 10MB of on-chip SRAM and 8MB
QSPI flash storage.
Add support for the board, and create a 2MB partition to use as rootfs.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---

v1->v2
- s/grpeach/gr-peach/g
- Use correct part number in bindings documentation (X28A-M01-E/F)
- Geert's comment on v1 addressed

 Documentation/devicetree/bindings/arm/shmobile.txt |  2 +
 arch/arm/boot/dts/Makefile                         |  1 +
 arch/arm/boot/dts/r7s72100-gr-peach.dts            | 66 ++++++++++++++++++++++
 3 files changed, 69 insertions(+)
 create mode 100644 arch/arm/boot/dts/r7s72100-gr-peach.dts

diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
index c950263..b7ab3bd 100644
--- a/Documentation/devicetree/bindings/arm/shmobile.txt
+++ b/Documentation/devicetree/bindings/arm/shmobile.txt
@@ -51,6 +51,8 @@ Boards:
     compatible = "renesas,bockw", "renesas,r8a7778"
   - Genmai (RTK772100BC00000BR)
     compatible = "renesas,genmai", "renesas,r7s72100"
+  - GR-Peach (X28A-M01-E/F)
+    compatible = "renesas,gr-peach", "renesas,r7s72100"
   - Gose (RTP0RC7793SEB00010S)
     compatible = "renesas,gose", "renesas,r8a7793"
   - H3ULCB (R-Car Starter Kit Premier, RTP0RC7795SKB00010S)
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 0118084..10cd690 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -716,6 +716,7 @@ dtb-$(CONFIG_ARCH_S5PV210) += \
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	emev2-kzm9d.dtb \
 	r7s72100-genmai.dtb \
+	r7s72100-gr-peach.dtb \
 	r7s72100-rskrza1.dtb \
 	r8a73a4-ape6evm.dtb \
 	r8a7740-armadillo800eva.dtb \
diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
new file mode 100644
index 0000000..a1b2aef9
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
2.7.4
