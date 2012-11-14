From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 Nov 2012 16:47:01 +0100
Subject: [PATCH 1/2] arm: mvebu: support for the PlatHome OpenBlocks AX3-4
 board
In-Reply-To: <1352908022-32628-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1352908022-32628-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1352908022-32628-2-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform, available in Japan from PlatHome, has a dual-core
Armada XP, the MV78260. For now, only the two serial ports and the
three front LEDs are supported. Support for SMP, network, SATA, USB
and other peripherals will be added as drivers for them become
available for Armada XP in mainline.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Tested-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

---
This is 3.8 material.

Changes since v2:

 * Renamed the .dts file to armada-xp-openblocks-ax3-4.dts

 * Removed the compatible string from armada-370-xp.c (which now only
   lists the common SoC compatible string)

Changes since v1:

 * Renamed the board to OpenBlocks AX3-4, since there is a variant
   called AX3-2 which has less RAM, and no mini PCIe port. Requested
   by Andrew Lunn.

 * Fix the amount of memory to 3 GB. In fact, the board has 1 GB
   soldered, and 2 GB in a SODIMM slot (which is therefore
   removable). But as the board is delivered as is, we'll assume it
   has 3 GB of memory by default.
---
 arch/arm/boot/dts/Makefile                       |    3 +-
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |   69 ++++++++++++++++++++++
 2 files changed, 71 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f37cf9f..718584d 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -44,7 +44,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
 dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 	msm8960-cdp.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
-	armada-xp-db.dtb
+	armada-xp-db.dtb \
+	armada-xp-openblocks-ax3-4.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
 	imx53-ard.dtb \
 	imx53-evk.dtb \
diff --git a/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
new file mode 100644
index 0000000..cb86853
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts
@@ -0,0 +1,69 @@
+/*
+ * Device Tree file for OpenBlocks AX3-4 board
+ *
+ * Copyright (C) 2012 Marvell
+ *
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "armada-xp-mv78260.dtsi"
+
+/ {
+	model = "PlatHome OpenBlocks AX3-4 board";
+	compatible = "plathome,openblocks-ax3-4", "marvell,armadaxp-mv78260", "marvell,armadaxp", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0xC0000000>; /* 3 GB */
+	};
+
+	soc {
+		serial at d0012000 {
+			clock-frequency = <250000000>;
+			status = "okay";
+		};
+		serial at d0012100 {
+			clock-frequency = <250000000>;
+			status = "okay";
+		};
+		pinctrl {
+			led_pins: led-pins-0 {
+				marvell,pins = "mpp49", "mpp51", "mpp53";
+				marvell,function = "gpio";
+			};
+		};
+		leds {
+			compatible = "gpio-leds";
+			pinctrl-names = "default";
+			pinctrl-0 = <&led_pins>;
+
+			red_led {
+				label = "red_led";
+				gpios = <&gpio1 17 1>;
+				default-state = "off";
+			};
+
+			yellow_led {
+				label = "yellow_led";
+				gpios = <&gpio1 19 1>;
+				default-state = "off";
+			};
+
+			green_led {
+				label = "green_led";
+				gpios = <&gpio1 21 1>;
+				default-state = "off";
+				linux,default-trigger = "heartbeat";
+			};
+		};
+	};
+};
-- 
1.7.9.5
