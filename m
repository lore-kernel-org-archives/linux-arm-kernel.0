From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon,  4 Feb 2013 18:21:08 +0100
Subject: [PATCH v4 2/2] arm: mvebu: support for the new Armada XP development
 board(DB-MV784MP-GP)
In-Reply-To: <1359998469-28133-1-git-send-email-gregory.clement@free-electrons.com>
References: <1359998469-28133-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1359998469-28133-3-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is the new Armada XP evaluation board from Marvell. It comes with
a RS232 port over USB, a SATA link, an internal SSD, 4 Ethernet
Gigabit links.

Support for USB (Host and device), SDIO, PCIe will be added as drivers
when they become available for Armada XP in mainline.

Tested-by: Simon Guinot <simon.guinot@sequanux.org>
Tested-by: Florian Fainelli <florian@openwrt.org>
Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/boot/dts/Makefile         |    1 +
 arch/arm/boot/dts/armada-xp-gp.dts |  101 ++++++++++++++++++++++++++++++++++++
 2 files changed, 102 insertions(+)
 create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 5ebb44f..51aab4b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
 dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
 	armada-370-mirabox.dtb \
 	armada-xp-db.dtb \
+	armada-xp-gp.dtb \
 	armada-xp-openblocks-ax3-4.dtb
 dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
 	imx53-ard.dtb \
diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
new file mode 100644
index 0000000..872ed04
--- /dev/null
+++ b/arch/arm/boot/dts/armada-xp-gp.dts
@@ -0,0 +1,101 @@
+/*
+ * Device Tree file for Marvell Armada XP development board
+ * (DB-MV784MP-GP)
+ *
+ * Copyright (C) 2013 Marvell
+ *
+ * Lior Amsalem <alior@marvell.com>
+ * Gregory CLEMENT <gregory.clement@free-electrons.com>
+ * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2.  This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+/dts-v1/;
+/include/ "armada-xp-mv78460.dtsi"
+
+/ {
+	model = "Marvell Armada XP Development Board DB-MV784MP-GP";
+	compatible = "marvell,axp-gp", "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
+
+	chosen {
+		bootargs = "console=ttyS0,115200 earlyprintk";
+	};
+
+	memory {
+		device_type = "memory";
+
+		/*
+		 * 4 GB of plug-in RAM modules by default.The amount
+		 * of memory available can be changed by the
+		 * bootloader according the size of the module
+		 * actually plugged
+		 */
+		reg = <0x00000000 0xD0000000>;
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
+		serial at d0012200 {
+			clock-frequency = <250000000>;
+			status = "okay";
+		};
+		serial at d0012300 {
+			clock-frequency = <250000000>;
+			status = "okay";
+		};
+
+		sata at d00a0000 {
+			nr-ports = <2>;
+			status = "okay";
+		};
+
+		mdio {
+			phy0: ethernet-phy at 0 {
+				reg = <16>;
+			};
+
+			phy1: ethernet-phy at 1 {
+				reg = <17>;
+			};
+
+			phy2: ethernet-phy at 2 {
+				reg = <18>;
+			};
+
+			phy3: ethernet-phy at 3 {
+				reg = <19>;
+			};
+		};
+
+		ethernet at d0070000 {
+			status = "okay";
+			phy = <&phy0>;
+			phy-mode = "rgmii-id";
+		};
+		ethernet at d0074000 {
+			status = "okay";
+			phy = <&phy1>;
+			phy-mode = "rgmii-id";
+		};
+		ethernet at d0030000 {
+			status = "okay";
+			phy = <&phy2>;
+			phy-mode = "rgmii-id";
+		};
+		ethernet at d0034000 {
+			status = "okay";
+			phy = <&phy3>;
+			phy-mode = "rgmii-id";
+		};
+	};
+};
-- 
1.7.9.5
