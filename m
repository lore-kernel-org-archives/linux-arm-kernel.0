From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu,  3 Oct 2013 16:35:26 +0200
Subject: [PATCH] arm: mvebu: add support for the Armada XP Matrix board
Message-ID: <1380810926-32248-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP Matrix board is the mother board of a more complex
system. The mother board uses an Armada XP MV78460, 4 serial ports, 2
SATA ports, one Ethernet connection, a PCIe port and a USB port. All
those devices are enabled in the Device Tree added by this patch.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/Makefile             |  1 +
 arch/arm/boot/dts/armada-xp-matrix.dts | 75 ++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-matrix.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index e95af3f..ad561d2 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -110,6 +110,7 @@ dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-xp-axpwifiap.dtb \
 	armada-xp-db.dtb \
 	armada-xp-gp.dtb \
+	armada-xp-matrix.dtb \
 	armada-xp-openblocks-ax3-4.dtb
 dtb-$(CONFIG_ARCH_MXC) += \
 	imx25-karo-tx25.dtb \
diff --git a/arch/arm/boot/dts/armada-xp-matrix.dts b/arch/arm/boot/dts/armada-xp-matrix.dts
new file mode 100644
index 0000000..e47c49e
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-matrix.dts
@@ -0,0 +1,75 @@
+/*
+ * Device Tree file for Marvell Armada XP Matrix board
+ *
+ * Copyright (C) 2013 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+#include "armada-xp-mv78460.dtsi"
+
+/ {
+	model = "Marvell Armada XP Matrix Board";
+	compatible = "marvell,axp-matrix", "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0 0x00000000 0 0x80000000>; /* 2 GB */
+	};
+
+	soc {
+		ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
+			  MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000>;
+
+		internal-regs {
+			serial at 12000 {
+				clock-frequency = <250000000>;
+				status = "okay";
+			};
+			serial at 12100 {
+				clock-frequency = <250000000>;
+				status = "okay";
+			};
+			serial at 12200 {
+				clock-frequency = <250000000>;
+				status = "okay";
+			};
+			serial at 12300 {
+				clock-frequency = <250000000>;
+				status = "okay";
+			};
+
+			sata at a0000 {
+				nr-ports = <2>;
+				status = "okay";
+			};
+
+			ethernet at 30000 {
+				status = "okay";
+				phy-mode = "sgmii";
+			};
+
+			pcie-controller {
+				status = "okay";
+
+				pcie at 1,0 {
+					/* Port 0, Lane 0 */
+					status = "okay";
+				};
+			};
+
+			usb at 50000 {
+				status = "okay";
+			};
+		};
+	};
+};
-- 
1.8.1.2
