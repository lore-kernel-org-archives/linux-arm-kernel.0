From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 10 Jul 2015 15:37:10 +0900
Subject: [PATCH 02/11] ARM: shmobile: r8a7793: add minimal Gose board device
 tree
In-Reply-To: <cover.1436509954.git.horms+renesas@verge.net.au>
References: <cover.1436509954.git.horms+renesas@verge.net.au>
Message-ID: <b8af4591db5bb0529b7f56d25b2e7db3eb71fdf6.1436509954.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Minimal DT description and Makefile entry for the Gose eval board.
Support for console, timer, and Ethernet.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile         |  1 +
 arch/arm/boot/dts/r8a7793-gose.dts | 63 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 arch/arm/boot/dts/r8a7793-gose.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 246473a244f6..679d7cc2f57c 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -516,6 +516,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += \
 	r8a7790-lager.dtb \
 	r8a7791-henninger.dtb \
 	r8a7791-koelsch.dtb \
+	r8a7793-gose.dtb \
 	r8a7794-alt.dtb \
 	sh73a0-kzm9g.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += \
diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
new file mode 100644
index 000000000000..96443ec5f6ab
--- /dev/null
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -0,0 +1,63 @@
+/*
+ * Device Tree Source for the Gose board
+ *
+ * Copyright (C) 2014-2015 Renesas Electronics Corporation
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2.  This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "r8a7793.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Gose";
+	compatible = "renesas,gose", "renesas,r8a7793";
+
+	aliases {
+		serial0 = &scif0;
+		serial1 = &scif1;
+	};
+
+	chosen {
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
+		stdout-path = &scif0;
+	};
+
+	memory at 40000000 {
+		device_type = "memory";
+		reg = <0 0x40000000 0 0x40000000>;
+	};
+};
+
+&extal_clk {
+	clock-frequency = <20000000>;
+};
+
+&ether {
+	phy-handle = <&phy1>;
+	renesas,ether-link-active-low;
+	status = "okay";
+
+	phy1: ethernet-phy at 1 {
+		reg = <1>;
+		interrupt-parent = <&irqc0>;
+		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		micrel,led-mode = <1>;
+	};
+};
+
+&cmt0 {
+	status = "okay";
+};
+
+&scif0 {
+	status = "okay";
+};
+
+&scif1 {
+	status = "okay";
+};
-- 
2.1.4
